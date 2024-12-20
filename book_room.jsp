<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.xhotel.util.DBUtil" %>
<%
    // 检查用户是否登录
    String userId = (String) session.getAttribute("id");
    String name = (String) session.getAttribute("name");
    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String roomId = request.getParameter("room_id");
    if (roomId == null || roomId.trim().isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }

    // 获取房间信息
    Map<String, Object> room = new HashMap<>();
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM t_room WHERE id = ?")) {
        
        pstmt.setString(1, roomId);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                room.put("id", rs.getString("id"));
                room.put("name", rs.getString("name"));
                room.put("type", rs.getString("type"));
                room.put("price", rs.getDouble("price"));
                room.put("status", rs.getString("book_status"));
                room.put("remark", rs.getString("remark"));
            } else {
                response.sendRedirect("index.jsp");
                return;
            }
        }
    } catch (Exception e) {
        request.setAttribute("message", "获取房间信息失败：" + e.getMessage());
        request.setAttribute("messageType", "error");
    }

    // 处理预订表单提交
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String remark = request.getParameter("remark");
        
        if (startTime == null || endTime == null || 
            startTime.trim().isEmpty() || endTime.trim().isEmpty()) {
            request.setAttribute("message", "请选择入住和退房日期");
            request.setAttribute("messageType", "error");
        } else {
            // 验证日期
            LocalDate checkInDate = LocalDate.parse(startTime);
            LocalDate checkOutDate = LocalDate.parse(endTime);
            LocalDate today = LocalDate.now();
            
            if (checkInDate.isBefore(today)) {
                request.setAttribute("message", "入住日期不能早于今天");
                request.setAttribute("messageType", "error");
            } else if (checkOutDate.isBefore(checkInDate) || checkOutDate.equals(checkInDate)) {
                request.setAttribute("message", "退房日期必须晚于入住日期");
                request.setAttribute("messageType", "error");
            } else {
                // 检查房间在选定日期是否已被预订
                try (Connection conn = DBUtil.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement(
                         "SELECT COUNT(*) as count FROM t_order_room WHERE room_id = ? AND status = 0 AND " +
                         "((start_time <= ? AND end_time >= ?) OR (start_time <= ? AND end_time >= ?) OR (start_time >= ? AND end_time <= ?))")) {
                    
                    pstmt.setString(1, roomId);
                    pstmt.setString(2, startTime);
                    pstmt.setString(3, startTime);
                    pstmt.setString(4, endTime);
                    pstmt.setString(5, endTime);
                    pstmt.setString(6, startTime);
                    pstmt.setString(7, endTime);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        rs.next();
                        
                        if (rs.getInt("count") > 0) {
                            request.setAttribute("message", "该房间在选定日期已被预订");
                            request.setAttribute("messageType", "error");
                        } else {
                            // 生成订单号 (当前时间戳 + 4位随机数)
                            String orderNumber = System.currentTimeMillis() + String.format("%04d", new Random().nextInt(10000));
                            
                            // 开始事务
                            try (Connection transConn = DBUtil.getConnection()) {
                                transConn.setAutoCommit(false);
                                
                                try {
                                    // 创建订单
                                    try (PreparedStatement createStmt = transConn.prepareStatement(
                                        "INSERT INTO t_order_room (id, number, room_id, user_id, start_time, end_time, amount, remark, status) " +
                                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
                                        
                                        createStmt.setString(1, UUID.randomUUID().toString().replace("-", ""));
                                        createStmt.setString(2, orderNumber);
                                        createStmt.setString(3, roomId);
                                        createStmt.setString(4, userId);
                                        createStmt.setString(5, startTime);
                                        createStmt.setString(6, endTime);
                                        createStmt.setDouble(7, (Double)room.get("price"));
                                        createStmt.setString(8, remark != null ? remark : "");
                                        createStmt.setInt(9, 0);
                                        createStmt.executeUpdate();

                                        // 更新房间状态
                                        try (PreparedStatement updateStmt = transConn.prepareStatement(
                                            "UPDATE t_room SET book_status = '已预订' WHERE id = ?")) {
                                            
                                            updateStmt.setString(1, roomId);
                                            updateStmt.executeUpdate();
                                        }

                                        transConn.commit();
                                        response.sendRedirect("order_list.jsp");
                                        return;
                                    }
                                } catch (Exception e) {
                                    transConn.rollback();
                                    e.printStackTrace();
                                    request.setAttribute("message", "预订失败：" + e.getMessage());
                                    request.setAttribute("messageType", "error");
                                }
                            }
                        }
                    }
                } catch (Exception e) {
                    request.setAttribute("message", "系统错误：" + e.getMessage());
                    request.setAttribute("messageType", "error");
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>预订房间 - X-HOTEL</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .booking-form {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .room-preview {
            margin-bottom: 30px;
            text-align: center;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .room-name {
            font-size: 24px;
            margin-bottom: 15px;
            color: #333;
        }
        
        .room-type {
            color: #666;
            margin-bottom: 10px;
        }
        
        .room-price {
            font-size: 28px;
            color: #6f42c1;
            margin: 15px 0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .submit-btn {
            width: 100%;
            padding: 14px;
            background: #6f42c1;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .submit-btn:hover {
            background: #5a32a3;
        }
    </style>
</head>
<body>
    <nav class="nav">
        <div class="container">
            <a href="index.jsp" class="nav-brand">X-HOTEL</a>
            <div class="nav-links">
                <a href="index.jsp">首页</a>
                <a href="order_list.jsp">我的订单</a>
                <% if (session.getAttribute("type") != null && session.getAttribute("type").equals("ADMIN")) { %>
                    <a href="admin/index.jsp">管理后台</a>
                <% } %>
                <a href="logout.jsp">退出</a>
            </div>
        </div>
    </nav>

    <main class="container">
        <% if (request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") != null ? request.getAttribute("messageType") : "info" %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>

        <div class="booking-form">
            <div class="room-preview">
                <h2 class="room-name"><%= room.get("name") %></h2>
                <p class="room-type">类型: <%= room.get("type") %></p>
                <p class="room-price">￥<%= room.get("price") %>/晚</p>
                <p><%= room.get("remark") %></p>
            </div>

            <form method="post" action="book_room.jsp?room_id=<%= room.get("id") %>">
                <div class="form-group">
                    <label for="start_time">入住日期：</label>
                    <input type="date" id="start_time" name="start_time" required 
                           min="<%= LocalDate.now() %>" 
                           value="<%= request.getParameter("start_time") != null ? request.getParameter("start_time") : "" %>">
                </div>

                <div class="form-group">
                    <label for="end_time">退房日期：</label>
                    <input type="date" id="end_time" name="end_time" required 
                           min="<%= LocalDate.now().plusDays(1) %>"
                           value="<%= request.getParameter("end_time") != null ? request.getParameter("end_time") : "" %>">
                </div>

                <div class="form-group">
                    <label for="remark">备注：</label>
                    <textarea id="remark" name="remark" rows="3"><%= request.getParameter("remark") != null ? request.getParameter("remark") : "" %></textarea>
                </div>

                <button type="submit" class="submit-btn">确认预订</button>
            </form>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 X-HOTEL. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // 确保退房日期不早于入住日期
        document.getElementById('start_time').addEventListener('change', function() {
            var checkIn = new Date(this.value);
            var checkOut = document.getElementById('end_time');
            checkOut.min = new Date(checkIn.getTime() + 86400000).toISOString().split('T')[0];
            if (checkOut.value && new Date(checkOut.value) <= checkIn) {
                checkOut.value = checkOut.min;
            }
        });
    </script>
</body>
</html>

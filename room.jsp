<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/check_login.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="/WEB-INF/classes/com/xhotel/common/DBUtil.jsp" %>
<%
    // 获取用户信息
    String username = (String) session.getAttribute("name");
    String userNickname = (String) session.getAttribute("nick_name");
    
    // 如果不是管理员，无权访问房间管理
    if (!"ADMIN".equals(userType)) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // 处理房间操作
    String method = request.getParameter("method");
    if (method != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // 开启事务
            
            if ("delete".equals(method)) {
                // 删除房间
                String roomId = request.getParameter("id");
                if (roomId != null) {
                    // 检查房间是否有关联订单
                    String checkSql = "SELECT COUNT(*) FROM t_order_room WHERE room_id = ?";
                    pstmt = conn.prepareStatement(checkSql);
                    pstmt.setString(1, roomId);
                    ResultSet rs = pstmt.executeQuery();
                    rs.next();
                    
                    if (rs.getInt(1) > 0) {
                        throw new Exception("该房间有关联订单，无法删除");
                    }
                    
                    // 删除房间
                    String sql = "DELETE FROM t_room WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, roomId);
                    
                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        conn.commit();
                        request.setAttribute("message", "房间删除成功");
                        request.setAttribute("messageType", "success");
                    } else {
                        throw new Exception("房间删除失败");
                    }
                }
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
            request.setAttribute("message", "操作失败：" + e.getMessage());
            request.setAttribute("messageType", "error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    DBUtil.releaseConnection(conn);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // 获取房间列表
    List<Map<String, Object>> rooms = new ArrayList<>();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        conn = DBUtil.getConnection();
        
        // 准备SQL语句
        String sql = "SELECT * FROM t_room ORDER BY id";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> room = new HashMap<>();
            room.put("id", rs.getString("id"));
            room.put("name", rs.getString("name"));
            room.put("number", rs.getString("number"));
            room.put("type", rs.getString("type"));
            room.put("price", rs.getDouble("price"));
            room.put("status", rs.getString("book_status"));
            room.put("photo", rs.getString("photo"));
            room.put("description", rs.getString("remark"));
            rooms.add(room);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "获取房间列表失败：" + e.getMessage());
        request.setAttribute("messageType", "error");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) {
                DBUtil.releaseConnection(conn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>房间管理 - X-HOTEL</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .room-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        
        .room-card {
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .room-card:hover {
            transform: translateY(-5px);
        }
        
        .room-content {
            padding: 20px;
        }
        
        .room-name {
            font-size: 20px;
            font-weight: 600;
            margin: 0 0 10px 0;
        }
        
        .room-type {
            color: #666;
            margin-bottom: 10px;
        }
        
        .room-price {
            font-size: 24px;
            color: #6f42c1;
            margin-bottom: 15px;
        }
        
        .room-status {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .status-available {
            background: #d4edda;
            color: #155724;
        }
        
        .status-occupied {
            background: #f8d7da;
            color: #721c24;
        }
        
        .room-description {
            color: #666;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .room-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background 0.3s;
        }
        
        .btn-primary {
            background: #6f42c1;
            color: #fff;
        }
        
        .btn-primary:hover {
            background: #5a32a3;
        }
        
        .btn-danger {
            background: #dc3545;
            color: #fff;
        }
        
        .btn-danger:hover {
            background: #c82333;
        }
        
        .add-room {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: #6f42c1;
            color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            text-decoration: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .add-room:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <nav class="nav">
        <div class="container">
            <a href="index.jsp" class="nav-brand">X-HOTEL</a>
            <div class="nav-links">
                <a href="index.jsp">首页</a>
                <% if (username != null && "ADMIN".equals(userType)) { %>
                    <a href="room.jsp" class="active">房间管理</a>
                    <a href="order.jsp">订单管理</a>
                    <a href="user.jsp">用户管理</a>
                <% } else { %>
                    <a href="order.jsp">我的订单</a>
                <% } %>
                <a href="remark.jsp">留言板</a>
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

        <div class="room-grid">
            <% for (Map<String, Object> room : rooms) { %>
                <div class="room-card">
                    <div class="room-content">
                        <h3 class="room-name"><%= room.get("name") %></h3>
                        <p class="room-type">类型: <%= room.get("type") %></p>
                        <p class="room-price">￥<%= room.get("price") %>/晚</p>
                        <div class="room-status <%= "空闲".equals(room.get("status")) ? "status-available" : "status-occupied" %>">
                            <%= room.get("status") %>
                        </div>
                        <p class="room-description"><%= room.get("description") %></p>
                        
                        <div class="room-actions">
                            <a href="room_edit.jsp?id=<%= room.get("id") %>" class="btn btn-primary">编辑</a>
                            <button class="btn btn-danger" onclick="deleteRoom('<%= room.get("id") %>')">删除</button>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>

        <a href="room_edit.jsp" class="add-room" title="添加房间">+</a>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 X-HOTEL. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/check_login.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.xhotel.util.DBUtil" %>
<%
    // 获取用户信息
    String username = (String) session.getAttribute("name");
    String userNickname = (String) session.getAttribute("nick_name");
    
    // 如果不是管理员，无权访问房间管理
    if (!"ADMIN".equals(userType)) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // 房间数据
    Map<String, Object> room = new HashMap<>();
    boolean isEdit = false;
    
    // 处理表单提交
    if ("POST".equals(request.getMethod())) {
        // 设置请求编码为UTF-8
        request.setCharacterEncoding("UTF-8");
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = null) {
            
            conn.setAutoCommit(false); // 开启事务
            
            String roomId = request.getParameter("id");
            String name = request.getParameter("name");
            String number = request.getParameter("number");
            String type = request.getParameter("type");
            String price = request.getParameter("price");
            String bookStatus = request.getParameter("book_status");
            String remark = request.getParameter("remark");
            String photo = request.getParameter("photo");
            
            // 验证必填字段
            if (name == null || name.trim().isEmpty() ||
                number == null || number.trim().isEmpty() ||
                type == null || type.trim().isEmpty() ||
                price == null || price.trim().isEmpty()) {
                throw new Exception("房间名称、编号、类型和价格为必填项");
            }
            
            // 验证价格格式
            try {
                Double.parseDouble(price);
            } catch (NumberFormatException e) {
                throw new Exception("价格必须是有效的数字");
            }
            
            PreparedStatement statement;
            if (roomId != null && !roomId.trim().isEmpty()) {
                // 更新房间
                String sql = "UPDATE t_room SET name=?, number=?, type=?, price=?, book_status=?, remark=?, photo=?, gmt_modified=NOW() WHERE id=?";
                statement = conn.prepareStatement(sql);
                statement.setString(1, name);
                statement.setString(2, number);
                statement.setString(3, type);
                statement.setDouble(4, Double.parseDouble(price));
                statement.setString(5, bookStatus != null ? bookStatus : "空闲");
                statement.setString(6, remark);
                statement.setString(7, photo != null ? photo : "default.jpg");
                statement.setString(8, roomId);
            } else {
                // 添加房间
                String sql = "INSERT INTO t_room (id, name, number, type, price, book_status, remark, photo, gmt_create, gmt_modified) VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
                statement = conn.prepareStatement(sql);
                statement.setString(1, name);
                statement.setString(2, number);
                statement.setString(3, type);
                statement.setDouble(4, Double.parseDouble(price));
                statement.setString(5, bookStatus != null ? bookStatus : "空闲");
                statement.setString(6, remark);
                statement.setString(7, photo != null ? photo : "default.jpg");
            }
            
            int result = statement.executeUpdate();
            if (result > 0) {
                conn.commit();
                response.sendRedirect("room.jsp");
                return;
            } else {
                throw new Exception("操作失败");
            }
            
        } catch (Exception e) {
            request.setAttribute("message", "操作失败：" + e.getMessage());
            request.setAttribute("messageType", "error");
        }
    }
    
    // 获取房间信息（编辑模式）
    String roomId = request.getParameter("id");
    if (roomId != null && !roomId.trim().isEmpty()) {
        isEdit = true;
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM t_room WHERE id = ?");
             ) {
            
            pstmt.setString(1, roomId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    room.put("id", rs.getString("id"));
                    room.put("name", rs.getString("name"));
                    room.put("number", rs.getString("number"));
                    room.put("type", rs.getString("type"));
                    room.put("price", rs.getDouble("price"));
                    room.put("book_status", rs.getString("book_status"));
                    room.put("remark", rs.getString("remark"));
                    room.put("photo", rs.getString("photo"));
                }
            }
        } catch (Exception e) {
            request.setAttribute("message", "获取房间信息失败：" + e.getMessage());
            request.setAttribute("messageType", "error");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "编辑" : "添加" %>房间 - X-HOTEL</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-header h2 {
            color: #333;
            font-size: 24px;
            margin: 0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input[type="text"]:focus,
        .form-group input[type="number"]:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #6f42c1;
            outline: none;
        }
        
        .form-actions {
            text-align: center;
            margin-top: 30px;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-primary {
            background: #6f42c1;
            color: #fff;
        }
        
        .btn-primary:hover {
            background: #5a32a3;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: #fff;
            margin-left: 10px;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>
    <nav class="nav">
        <div class="container">
            <a href="index.jsp" class="nav-brand">X-HOTEL</a>
            <div class="nav-links">
                <% if (username != null) { %>
                    <span class="nav-text">欢迎，<%= userNickname != null ? userNickname : username %></span>
                    <a href="logout.jsp" class="nav-link">退出</a>
                <% } %>
            </div>
        </div>
    </nav>

    <main class="main">
        <div class="form-container">
            <div class="form-header">
                <h2><%= isEdit ? "编辑" : "添加" %>房间</h2>
            </div>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-<%= request.getAttribute("messageType") %>">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <form method="post" action="room_edit.jsp">
                <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= room.get("id") %>">
                <% } %>
                
                <div class="form-group">
                    <label for="name">房间名称</label>
                    <input type="text" id="name" name="name" value="<%= room.get("name") != null ? room.get("name") : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label for="number">房间编号</label>
                    <input type="text" id="number" name="number" value="<%= room.get("number") != null ? room.get("number") : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label for="type">房间类型</label>
                    <select id="type" name="type" required>
                        <option value="">请选择房间类型</option>
                        <option value="单人" <%= "单人".equals(room.get("type")) ? "selected" : "" %>>单人房</option>
                        <option value="双人" <%= "双人".equals(room.get("type")) ? "selected" : "" %>>双人房</option>
                        <option value="多人" <%= "多人".equals(room.get("type")) ? "selected" : "" %>>多人房</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="price">价格（每晚）</label>
                    <input type="number" id="price" name="price" value="<%= room.get("price") != null ? room.get("price") : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label for="book_status">状态</label>
                    <select id="book_status" name="book_status">
                        <option value="空闲" <%= "空闲".equals(room.get("book_status")) ? "selected" : "" %>>空闲</option>
                        <option value="已预订" <%= "已预订".equals(room.get("book_status")) ? "selected" : "" %>>已预订</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="remark">备注</label>
                    <textarea id="remark" name="remark" rows="4"><%= room.get("remark") != null ? room.get("remark") : "" %></textarea>
                </div>
                
                <div class="form-group">
                    <label for="photo">照片URL</label>
                    <input type="text" id="photo" name="photo" value="<%= room.get("photo") != null ? room.get("photo") : "default.jpg" %>">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <a href="room.jsp" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 X-HOTEL. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>

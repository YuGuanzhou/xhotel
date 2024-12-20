<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="/WEB-INF/classes/com/xhotel/common/DBUtil.jsp" %>
<%
    // 检查用户是否登录
    String name = (String) session.getAttribute("name");
    if (name == null) {
        // 保存当前URL用于登录后重定向
        String currentURL = request.getRequestURL().toString();
        String queryString = request.getQueryString();
        if (queryString != null) {
            currentURL += "?" + queryString;
        }
        session.setAttribute("redirect_url", currentURL);
        response.sendRedirect("login.jsp");
        return;
    }

    // 获取用户信息
    String type = (String) session.getAttribute("type");
    String nickName = (String) session.getAttribute("nick_name");
    
    // 如果是从登录页面重定向过来的，显示成功消息
    String loginMessage = (String) session.getAttribute("loginMessage");
    if (loginMessage != null) {
        request.setAttribute("message", loginMessage);
        request.setAttribute("messageType", "success");
        session.removeAttribute("loginMessage");
    }
    
    // 房间列表数据
    List<Map<String, Object>> rooms = new ArrayList<>();
    int currentPage = 1;
    int totalPages = 1;
    
    // 获取搜索参数
    String searchName = request.getParameter("name");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        conn = DBUtil.getConnection();
        
        // 准备SQL语句
        String sql;
        currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 12; // 每页显示12个房间
        int offset = (currentPage - 1) * pageSize;
        
        // 获取总记录数
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql = "SELECT COUNT(*) FROM t_room WHERE name LIKE ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + searchName + "%");
        } else {
            sql = "SELECT COUNT(*) FROM t_room";
            pstmt = conn.prepareStatement(sql);
        }
        
        rs = pstmt.executeQuery();
        int totalRecords = 0;
        if (rs.next()) {
            totalRecords = rs.getInt(1);
        }
        totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        
        // 获取房间列表
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql = "SELECT * FROM t_room WHERE name LIKE ? ORDER BY id LIMIT ? OFFSET ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + searchName + "%");
            pstmt.setInt(2, pageSize);
            pstmt.setInt(3, offset);
        } else {
            sql = "SELECT * FROM t_room ORDER BY id LIMIT ? OFFSET ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, pageSize);
            pstmt.setInt(2, offset);
        }
        
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> room = new HashMap<>();
            room.put("id", rs.getString("id")); 
            room.put("name", rs.getString("name"));
            room.put("number", rs.getString("number"));
            room.put("type", rs.getString("type"));
            room.put("price", rs.getDouble("price"));
            room.put("status", rs.getString("book_status")); 
            room.put("remark", rs.getString("remark")); 
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
            if (conn != null) DBUtil.releaseConnection(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>X-HOTEL - 首页</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('images/hotel-bg.jpg');
            background-size: cover;
            background-position: center;
            height: 500px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #fff;
            margin-bottom: 40px;
        }
        
        .hero-content {
            max-width: 800px;
            padding: 0 20px;
        }
        
        .hero-title {
            font-size: 48px;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .hero-subtitle {
            font-size: 24px;
            margin-bottom: 30px;
            font-weight: 300;
        }
        
        .search-container {
            background: rgba(255,255,255,0.9);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .search-form {
            display: flex;
            gap: 10px;
        }
        
        .search-input {
            flex: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .search-btn {
            padding: 12px 30px;
            background: #6f42c1;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }
        
        .search-btn:hover {
            background: #5a32a3;
        }
        
        .room-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            padding: 20px;
        }
        
        .room-card {
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            position: relative;
            padding: 20px;
        }
        
        .room-card:hover {
            transform: translateY(-5px);
        }
        
        .room-info {
            padding: 10px 0;
        }
        
        .room-name {
            font-size: 20px;
            margin-bottom: 10px;
            color: #333;
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
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 4px;
            color: #fff;
            font-size: 14px;
        }
        
        .status-available {
            background-color: #28a745;
        }
        
        .status-booked {
            background-color: #dc3545;
        }
        
        .book-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #6f42c1;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            transition: background 0.3s;
        }
        
        .book-btn:hover {
            background: #5a32a3;
        }
        
        .book-btn.disabled {
            background: #6c757d;
            cursor: not-allowed;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 40px 0;
        }
        
        .pagination a {
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .pagination a:hover,
        .pagination a.active {
            background: #6f42c1;
            color: #fff;
            border-color: #6f42c1;
        }
        
        .card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .card-title {
            font-size: 24px;
            font-weight: 700;
            margin: 0;
        }
        
        .room-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .room-card-body {
            padding: 20px;
        }
        
        .room-card-footer {
            padding: 10px;
            border-top: 1px solid #ddd;
        }
        
        .no-data {
            text-align: center;
            padding: 20px;
        }
    </style>
</head>
<body>
    <nav class="nav">
        <div class="container">
            <a href="index.jsp" class="nav-brand">X-HOTEL</a>
            <div class="nav-links">
                <a href="index.jsp" class="active">首页</a>
                <% if (session.getAttribute("name") != null) { %>
                    <% if (session.getAttribute("type") != null && session.getAttribute("type").equals("ADMIN")) { %>
                        <a href="room.jsp">房间管理</a>
                        <a href="order.jsp">订单管理</a>
                        <a href="user.jsp">用户管理</a>
                    <% } else { %>
                        <a href="order.jsp">我的订单</a>
                    <% } %>
                    <a href="remark.jsp">留言板</a>
                    <a href="login.jsp?method=LOGOUT_DO">退出</a>
                <% } else { %>
                    <a href="login.jsp">登录</a>
                    <a href="regist.jsp">注册</a>
                <% } %>
            </div>
        </div>
    </nav>

    <main class="container">
        <% if (request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") != null ? request.getAttribute("messageType") : "info" %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>

        <div class="search-container">
            <form class="search-form" method="get" action="index.jsp">
                <input type="text" name="name" class="search-input" 
                       placeholder="搜索房间名称或类型..." 
                       value="<%= searchName != null ? searchName : "" %>">
                <button type="submit" class="search-btn">搜索</button>
            </form>
        </div>

        <div class="card">
            <div class="card-header">
                <h2 class="card-title">房间列表</h2>
                <% if (session.getAttribute("type") != null && session.getAttribute("type").equals("ADMIN")) { %>
                    <a href="room_edit.jsp" class="btn btn-primary">添加房间</a>
                <% } %>
            </div>
            
            <% if (!rooms.isEmpty()) { %>
                <div class="room-grid">
                    <% for (Map<String, Object> room : rooms) { %>
                        <div class="room-card">
                            <div class="room-status <%= "空闲".equals(room.get("status")) ? "status-available" : "status-booked" %>">
                                <%= room.get("status") %>
                            </div>
                            <div class="room-info">
                                <h3 class="room-name"><%= room.get("name") %></h3>
                                <p class="room-type">类型: <%= room.get("type") %></p>
                                <p class="room-price">￥<%= room.get("price") %>/晚</p>
                                <p><%= room.get("remark") %></p>
                                <% if ("空闲".equals(room.get("status"))) { %>
                                    <a href="book_room.jsp?room_id=<%= room.get("id") %>" class="book-btn">立即预订</a>
                                <% } else { %>
                                    <span class="book-btn disabled">已被预订</span>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                </div>

                <% if (totalPages > 1) { %>
                    <div class="pagination">
                        <% if (currentPage > 1) { %>
                            <a href="?page=<%= currentPage - 1 %><%= searchName != null ? "&name=" + searchName : "" %>">上一页</a>
                        <% } %>
                        
                        <% 
                            int startPage = Math.max(1, currentPage - 2);
                            int endPage = Math.min(totalPages, startPage + 4);
                            startPage = Math.max(1, endPage - 4);
                        %>
                        
                        <% if (startPage > 1) { %>
                            <a href="?page=1<%= searchName != null ? "&name=" + searchName : "" %>">1</a>
                            <% if (startPage > 2) { %>
                                <span>...</span>
                            <% } %>
                        <% } %>
                        
                        <% for (int i = startPage; i <= endPage; i++) { %>
                            <a href="?page=<%= i %><%= searchName != null ? "&name=" + searchName : "" %>" 
                               class="<%= i == currentPage ? "active" : "" %>"><%= i %></a>
                        <% } %>
                        
                        <% if (endPage < totalPages) { %>
                            <% if (endPage < totalPages - 1) { %>
                                <span>...</span>
                            <% } %>
                            <a href="?page=<%= totalPages %><%= searchName != null ? "&name=" + searchName : "" %>"><%= totalPages %></a>
                        <% } %>
                        
                        <% if (currentPage < totalPages) { %>
                            <a href="?page=<%= currentPage + 1 %><%= searchName != null ? "&name=" + searchName : "" %>">下一页</a>
                        <% } %>
                    </div>
                <% } %>
            <% } else { %>
                <p class="no-data">暂无房间信息</p>
            <% } %>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 X-HOTEL. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>

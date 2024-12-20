<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/check_login.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="/WEB-INF/classes/com/xhotel/common/DBUtil.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String currentUserId = (String) session.getAttribute("id");
    String currentUserType = (String) session.getAttribute("type");
    
    // 如果既不是管理员也不是订单所有者，则无权访问
    String orderId = request.getParameter("id");
    if (orderId != null && !isAdmin) {
        Connection checkConn = null;
        PreparedStatement checkPstmt = null;
        ResultSet checkRs = null;
        try {
            checkConn = DBUtil.getConnection();
            String checkSql = "SELECT user_id FROM t_order_room WHERE id = ?";
            checkPstmt = checkConn.prepareStatement(checkSql);
            checkPstmt.setString(1, orderId);
            checkRs = checkPstmt.executeQuery();
            
            if (checkRs.next()) {
                String orderUserId = checkRs.getString("user_id");
                if (!currentUserId.equals(orderUserId)) {
                    response.sendRedirect("error.jsp?message=" + URLEncoder.encode("无权访问", "UTF-8"));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + URLEncoder.encode("系统错误：" + e.getMessage(), "UTF-8"));
            return;
        } finally {
            try { if (checkRs != null) checkRs.close(); } catch (Exception e) { }
            try { if (checkPstmt != null) checkPstmt.close(); } catch (Exception e) { }
            try { if (checkConn != null) DBUtil.releaseConnection(checkConn); } catch (Exception e) { }
        }
    }
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, Object>> orderList = new ArrayList<>();
    
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");
    
    try {
        conn = DBUtil.getConnection();
        conn.setAutoCommit(false); // 开启事务
        
        // 处理订单操作
        if ("POST".equals(request.getMethod())) {
            String method = request.getParameter("method");
            String targetOrderId = request.getParameter("orderId");
            
            if (targetOrderId != null) {
                if ("cancel".equals(method)) {
                    // 取消订单
                    String updateSql = "UPDATE t_order_room SET status = 'CANCELLED', gmt_modified = NOW() WHERE id = ? AND (user_id = ? OR ? = 'ADMIN') AND status = 'ACTIVE'";
                    pstmt = conn.prepareStatement(updateSql);
                    pstmt.setString(1, targetOrderId);
                    pstmt.setString(2, currentUserId);
                    pstmt.setString(3, currentUserType);
                    
                    // 更新房间状态
                    String updateRoomSql = "UPDATE t_room r INNER JOIN t_order_room o ON r.id = o.room_id SET r.status = 'AVAILABLE' WHERE o.id = ?";
                    PreparedStatement pstmt2 = conn.prepareStatement(updateRoomSql);
                    pstmt2.setString(1, targetOrderId);
                    
                    int result = pstmt.executeUpdate();
                    pstmt2.executeUpdate();
                    
                    if (result > 0) {
                        conn.commit();
                        message = "订单已取消";
                        messageType = "success";
                    } else {
                        conn.rollback();
                        message = "取消订单失败";
                        messageType = "error";
                    }
                    pstmt2.close();
                } else if ("complete".equals(method) && isAdmin) {
                    // 完成订单（仅管理员）
                    String updateSql = "UPDATE t_order_room SET status = 'COMPLETED', gmt_modified = NOW() WHERE id = ? AND status = 'ACTIVE'";
                    pstmt = conn.prepareStatement(updateSql);
                    pstmt.setString(1, targetOrderId);
                    
                    // 更新房间状态
                    String updateRoomSql = "UPDATE t_room r INNER JOIN t_order_room o ON r.id = o.room_id SET r.status = 'AVAILABLE' WHERE o.id = ?";
                    PreparedStatement pstmt2 = conn.prepareStatement(updateRoomSql);
                    pstmt2.setString(1, targetOrderId);
                    
                    int result = pstmt.executeUpdate();
                    pstmt2.executeUpdate();
                    
                    if (result > 0) {
                        conn.commit();
                        message = "订单已完成";
                        messageType = "success";
                    } else {
                        conn.rollback();
                        message = "完成订单失败";
                        messageType = "error";
                    }
                    pstmt2.close();
                }
            }
        }
        
        // 获取筛选参数
        String statusFilter = request.getParameter("status");
        String searchQuery = request.getParameter("search");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        
        // 构建查询SQL
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT o.*, r.name as room_name, r.price, r.type as room_type, ");
        sql.append("u.name as user_name, u.nick_name as user_nickname ");
        sql.append("FROM t_order_room o ");
        sql.append("LEFT JOIN t_room r ON o.room_id = r.id ");
        sql.append("LEFT JOIN t_user u ON o.user_id = u.id ");
        sql.append("WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (!isAdmin) {
            sql.append("AND o.user_id = ? ");
            params.add(currentUserId);
        }
        
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
            params.add(statusFilter);
        }
        
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append("AND (r.name LIKE ? OR u.name LIKE ? OR u.nick_name LIKE ?) ");
            String searchPattern = "%" + searchQuery.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        if (startDate != null && !startDate.trim().isEmpty()) {
            sql.append("AND o.start_time >= ? ");
            params.add(startDate);
        }
        
        if (endDate != null && !endDate.trim().isEmpty()) {
            sql.append("AND o.end_time <= ? ");
            params.add(endDate);
        }
        
        sql.append("ORDER BY o.gmt_create DESC");
        
        pstmt = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            pstmt.setObject(i + 1, params.get(i));
        }
        
        rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> order = new HashMap<>();
            order.put("id", rs.getString("id"));
            order.put("roomId", rs.getString("room_id"));
            order.put("roomName", rs.getString("room_name"));
            order.put("roomType", rs.getString("room_type"));
            order.put("price", rs.getDouble("price"));
            order.put("checkIn", rs.getString("start_time"));
            order.put("checkOut", rs.getString("end_time"));
            order.put("status", rs.getString("status"));
            order.put("createTime", rs.getTimestamp("gmt_create"));
            order.put("modifyTime", rs.getTimestamp("gmt_modified"));
            
            if (isAdmin) {
                order.put("userName", rs.getString("user_name"));
                order.put("userNickname", rs.getString("user_nickname"));
            }
            
            orderList.add(order);
        }
        
        conn.commit();
    } catch (Exception e) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        e.printStackTrace();
        message = "系统错误：" + e.getMessage();
        messageType = "error";
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
        if (conn != null) {
            try {
                conn.setAutoCommit(true);
                DBUtil.releaseConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>订单管理 - X-HOTEL</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .order-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .filter-section {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 4px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .filter-group {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .filter-group label {
            color: #666;
            font-size: 14px;
        }
        
        .filter-group input,
        .filter-group select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .search-box {
            flex: 1;
            min-width: 200px;
        }
        
        .search-box input {
            width: 100%;
        }
        
        .order-grid {
            display: grid;
            gap: 20px;
            margin-top: 20px;
        }
        
        .order-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 20px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .order-id {
            font-size: 14px;
            color: #666;
        }
        
        .order-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-active {
            background: #e3f2fd;
            color: #1976d2;
        }
        
        .status-completed {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .status-cancelled {
            background: #fbe9e7;
            color: #d32f2f;
        }
        
        .order-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .detail-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .detail-label {
            font-size: 12px;
            color: #666;
        }
        
        .detail-value {
            font-size: 14px;
            color: #333;
            font-weight: 500;
        }
        
        .order-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .btn-danger {
            background: #ef5350;
            color: white;
        }
        
        .btn-danger:hover {
            background: #e53935;
        }
        
        .btn-success {
            background: #66bb6a;
            color: white;
        }
        
        .btn-success:hover {
            background: #4caf50;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        .message {
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        .message.success {
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }
        
        .message.error {
            background: #fbe9e7;
            color: #d32f2f;
            border: 1px solid #ffcdd2;
        }
        
        @media (max-width: 768px) {
            .order-details {
                grid-template-columns: 1fr;
            }
            
            .filter-section {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filter-group {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
    <nav class="nav">
        <div class="container">
            <a href="index.jsp" class="nav-brand">X-HOTEL</a>
            <div class="nav-links">
                <a href="index.jsp">首页</a>
                <% if (isAdmin) { %>
                    <a href="room.jsp">房间管理</a>
                    <a href="order.jsp" class="active">订单管理</a>
                    <a href="user.jsp">用户管理</a>
                <% } else { %>
                    <a href="room.jsp">预订房间</a>
                    <a href="order.jsp" class="active">我的订单</a>
                <% } %>
                <a href="remark.jsp">留言板</a>
                <div class="user-menu">
                    <span><%= session.getAttribute("nick_name") != null ? session.getAttribute("nick_name") : session.getAttribute("name") %></span>
                    <a href="logout.jsp">退出</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="order-container">
        <% if (message != null) { %>
            <div class="message <%= messageType %>">
                <%= message %>
            </div>
        <% } %>

        <div class="filter-section">
            <div class="search-box filter-group">
                <input type="text" id="searchInput" placeholder="搜索房间号、用户名..." 
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            </div>
            
            <div class="filter-group">
                <label>状态：</label>
                <select id="statusFilter">
                    <option value="">全部</option>
                    <option value="ACTIVE" <%= "ACTIVE".equals(request.getParameter("status")) ? "selected" : "" %>>进行中</option>
                    <option value="COMPLETED" <%= "COMPLETED".equals(request.getParameter("status")) ? "selected" : "" %>>已完成</option>
                    <option value="CANCELLED" <%= "CANCELLED".equals(request.getParameter("status")) ? "selected" : "" %>>已取消</option>
                </select>
            </div>
            
            <div class="filter-group">
                <label>入住日期：</label>
                <input type="date" id="startDate" 
                       value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>">
            </div>
            
            <div class="filter-group">
                <label>退房日期：</label>
                <input type="date" id="endDate"
                       value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>">
            </div>
            
            <button class="btn btn-primary" onclick="applyFilters()">筛选</button>
        </div>

        <div class="order-grid">
            <% if (orderList.isEmpty()) { %>
                <div class="empty-state">
                    <h3>暂无订单记录</h3>
                    <p>您可以去<a href="room.jsp">房间列表</a>预订房间</p>
                </div>
            <% } else { %>
                <% for (Map<String, Object> order : orderList) { %>
                    <div class="order-card">
                        <div class="order-header">
                            <span class="order-id">订单号：<%= order.get("id") %></span>
                            <span class="order-status status-<%= ((String)order.get("status")).toLowerCase() %>">
                                <%= "ACTIVE".equals(order.get("status")) ? "进行中" : 
                                    "COMPLETED".equals(order.get("status")) ? "已完成" : "已取消" %>
                            </span>
                        </div>
                        
                        <div class="order-details">
                            <div class="detail-group">
                                <span class="detail-label">房间信息</span>
                                <span class="detail-value"><%= order.get("roomName") %> (<%= order.get("roomType") %>)</span>
                            </div>
                            
                            <div class="detail-group">
                                <span class="detail-label">订单金额</span>
                                <span class="detail-value">¥<%= String.format("%.2f", order.get("price")) %></span>
                            </div>
                            
                            <div class="detail-group">
                                <span class="detail-label">入住日期</span>
                                <span class="detail-value"><%= order.get("checkIn") %></span>
                            </div>
                            
                            <div class="detail-group">
                                <span class="detail-label">退房日期</span>
                                <span class="detail-value"><%= order.get("checkOut") %></span>
                            </div>
                            
                            <% if (isAdmin) { %>
                                <div class="detail-group">
                                    <span class="detail-label">预订用户</span>
                                    <span class="detail-value">
                                        <%= order.get("userNickname") %> (<%= order.get("userName") %>)
                                    </span>
                                </div>
                                
                                <div class="detail-group">
                                    <span class="detail-label">联系电话</span>
                                    <span class="detail-value"></span>
                                </div>
                            <% } %>
                            
                            <div class="detail-group">
                                <span class="detail-label">创建时间</span>
                                <span class="detail-value"><%= order.get("createTime") %></span>
                            </div>
                        </div>
                        
                        <% if ("ACTIVE".equals(order.get("status"))) { %>
                            <div class="order-actions">
                                <form method="post" action="order.jsp" style="display: inline;">
                                    <input type="hidden" name="method" value="cancel">
                                    <input type="hidden" name="orderId" value="<%= order.get("id") %>">
                                    <button type="submit" class="btn btn-danger" 
                                            onclick="return confirm('确定要取消此订单吗？')">取消订单</button>
                                </form>
                                
                                <% if (isAdmin) { %>
                                    <form method="post" action="order.jsp" style="display: inline;">
                                        <input type="hidden" name="method" value="complete">
                                        <input type="hidden" name="orderId" value="<%= order.get("id") %>">
                                        <button type="submit" class="btn btn-success"
                                                onclick="return confirm('确定要完成此订单吗？')">完成订单</button>
                                    </form>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            <% } %>
        </div>
    </div>

    <script>
        function applyFilters() {
            const searchQuery = document.getElementById('searchInput').value;
            const status = document.getElementById('statusFilter').value;
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            
            let url = 'order.jsp?';
            if (searchQuery) url = url + 'search=' + encodeURIComponent(searchQuery) + '&';
            if (status) url = url + 'status=' + encodeURIComponent(status) + '&';
            if (startDate) url = url + 'startDate=' + encodeURIComponent(startDate) + '&';
            if (endDate) url = url + 'endDate=' + encodeURIComponent(endDate);
            
            window.location.href = url;
        }
        
        // 监听回车键
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                applyFilters();
            }
        });
    </script>
</body>
</html>
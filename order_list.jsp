<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.xhotel.util.DBUtil" %>
<%
    // 检查用户是否登录
    String userId = (String) session.getAttribute("id");
    String name = (String) session.getAttribute("name");
    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 订单列表数据
    List<Map<String, Object>> orders = new ArrayList<>();
    
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement("SELECT o.*, r.name as room_name " +
                    "FROM t_order_room o " +
                    "JOIN t_room r ON o.room_id = r.id " +
                    "WHERE o.user_id = ? " +
                    "ORDER BY o.gmt_create DESC");
         ) {
        
        pstmt.setString(1, userId);
        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("id", rs.getString("id"));
                order.put("number", rs.getString("number"));
                order.put("room_name", rs.getString("room_name"));
                order.put("start_time", rs.getString("start_time"));
                order.put("end_time", rs.getString("end_time"));
                order.put("amount", rs.getDouble("amount"));
                order.put("status", rs.getInt("status"));
                order.put("remark", rs.getString("remark"));
                order.put("create_time", rs.getTimestamp("gmt_create"));
                orders.add(order);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "获取订单列表失败：" + e.getMessage());
        request.setAttribute("messageType", "error");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>我的订单 - X-HOTEL</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .order-list {
            margin: 20px 0;
        }
        
        .order-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            padding: 20px;
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .order-number {
            font-size: 16px;
            color: #333;
        }
        
        .order-status {
            padding: 4px 12px;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .order-status-0 {
            background-color: #28a745;
            color: white;
        }
        
        .order-status-1 {
            background-color: #dc3545;
            color: white;
        }
        
        .order-content {
            margin-bottom: 15px;
        }
        
        .order-details {
            flex: 1;
        }
        
        .room-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .order-info {
            color: #666;
            font-size: 14px;
            margin-bottom: 8px;
        }
        
        .order-amount {
            color: #e74c3c;
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }

        .order-footer {
            margin-top: 15px;
            padding-top: 10px;
            border-top: 1px solid #eee;
            color: #888;
            font-size: 13px;
        }

        .empty-message {
            text-align: center;
            padding: 40px 20px;
            background: #f8f9fa;
            border-radius: 8px;
            color: #666;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 8px 20px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>我的订单</h2>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-<%= request.getAttribute("messageType") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>

        <div class="order-list">
            <% if (orders.isEmpty()) { %>
                <div class="empty-message">
                    <p>暂无订单记录</p>
                </div>
            <% } else { %>
                <% for (Map<String, Object> order : orders) { %>
                    <div class="order-card">
                        <div class="order-header">
                            <span class="order-number">订单号：<%= order.get("number") %></span>
                            <span class="order-status order-status-<%= order.get("status") %>">
                                <%= (Integer)order.get("status") == 0 ? "已预订" : "已取消" %>
                            </span>
                        </div>
                        <div class="order-content">
                            <div class="order-details">
                                <div class="room-name"><%= order.get("room_name") %></div>
                                <div class="order-info">入住时间：<%= order.get("start_time") %></div>
                                <div class="order-info">退房时间：<%= order.get("end_time") %></div>
                                <div class="order-info">备注：<%= order.get("remark") != null ? order.get("remark") : "无" %></div>
                                <div class="order-amount">￥<%= String.format("%.2f", order.get("amount")) %></div>
                            </div>
                        </div>
                        <div class="order-footer">
                            <small>下单时间：<%= order.get("create_time") %></small>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>
        
        <div class="text-center">
            <a href="index.jsp" class="btn-primary">返回首页</a>
        </div>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/check_login.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="/WEB-INF/classes/com/xhotel/common/DBUtil.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    // 获取用户信息
    String currentUserId = (String) session.getAttribute("id");
    String currentUserName = (String) session.getAttribute("name");
    String currentUserNickName = (String) session.getAttribute("nick_name");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, Object>> remarkList = new ArrayList<>();
    
    try {
        conn = DBUtil.getConnection();
        
        // 处理添加留言请求
        if ("POST".equals(request.getMethod())) {
            String method = request.getParameter("method");
            if ("add_do".equals(method)) {
                String remarkContent = request.getParameter("remark");
                if (remarkContent != null && !remarkContent.trim().isEmpty()) {
                    String sql = "INSERT INTO t_remark (id, user_name, remark, status, gmt_create, gmt_modified) VALUES (?, ?, ?, 0, NOW(), NOW())";
                    pstmt = conn.prepareStatement(sql);
                    // 生成UUID作为ID
                    String uuid = UUID.randomUUID().toString().replace("-", "");
                    pstmt.setString(1, uuid);
                    pstmt.setString(2, currentUserNickName != null ? currentUserNickName : currentUserName);
                    pstmt.setString(3, remarkContent);
                    
                    System.out.println("执行SQL: " + sql);
                    System.out.println("参数: [" + uuid + ", " + 
                                     (currentUserNickName != null ? currentUserNickName : currentUserName) + ", " + 
                                     remarkContent + "]");
                    
                    int rows = pstmt.executeUpdate();
                    System.out.println("插入结果: " + rows + " 行受影响");
                    
                    response.sendRedirect("remark.jsp");
                    return;
                }
            }
        }
        
        // 查询所有留言
        String sql = "SELECT * FROM t_remark WHERE status = 0 ORDER BY gmt_create DESC";
        pstmt = conn.prepareStatement(sql);
        System.out.println("执行查询SQL: " + sql);
        
        rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> remark = new HashMap<>();
            remark.put("id", rs.getString("id"));
            remark.put("userName", rs.getString("user_name"));
            remark.put("remark", rs.getString("remark"));
            remark.put("createTime", rs.getTimestamp("gmt_create"));
            remarkList.add(remark);
        }
        
        System.out.println("查询到 " + remarkList.size() + " 条留言");
        
    } catch (Exception e) {
        System.out.println("处理留言时发生错误: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("message", "系统错误：" + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
        try { if (conn != null) DBUtil.releaseConnection(conn); } catch (Exception e) { }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>留言板 - X-HOTEL</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.2.3/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .remark-card {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: transform 0.2s;
            background-color: white;
        }
        .remark-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .remark-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #eee;
            padding: 10px 15px;
            border-radius: 10px 10px 0 0;
        }
        .remark-content {
            padding: 15px;
            font-size: 1.1em;
        }
        .remark-footer {
            padding: 10px 15px;
            background-color: #f8f9fa;
            border-top: 1px solid #eee;
            border-radius: 0 0 10px 10px;
            font-size: 0.9em;
            color: #6c757d;
        }
        .remark-form {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .main-content {
            padding-top: 2rem;
        }
    </style>
</head>
<body class="bg-light">
    <nav class="nav">
        <div class="container">
            <a href="index.jsp" class="nav-brand">X-HOTEL</a>
            <div class="nav-links">
                <a href="index.jsp">首页</a>
                <% if (session.getAttribute("type") != null && session.getAttribute("type").equals("ADMIN")) { %>
                    <a href="room.jsp">房间管理</a>
                    <a href="order.jsp">订单管理</a>
                    <a href="user.jsp">用户管理</a>
                <% } else { %>
                    <a href="order.jsp">我的订单</a>
                <% } %>
                <a href="remark.jsp" class="active">留言板</a>
                <a href="login.jsp?method=LOGOUT_DO">退出</a>
            </div>
        </div>
    </nav>

    <div class="container main-content">
        <!-- 添加留言表单 -->
        <div class="remark-form">
            <h3 class="mb-4">发表留言</h3>
            <form method="post" action="remark.jsp">
                <input type="hidden" name="method" value="add_do">
                <div class="mb-3">
                    <textarea class="form-control" name="remark" rows="3" placeholder="写下你的留言..." required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">发表留言</button>
            </form>
        </div>

        <!-- 留言列表 -->
        <div class="remarks-list">
            <h3 class="mb-4">所有留言</h3>
            <% for (Map<String, Object> remark : remarkList) { %>
                <div class="remark-card">
                    <div class="remark-header">
                        <strong><%= remark.get("userName") %></strong>
                    </div>
                    <div class="remark-content">
                        <%= remark.get("remark") %>
                    </div>
                    <div class="remark-footer">
                        发表于：<%= remark.get("createTime") %>
                    </div>
                </div>
            <% } %>
            
            <% if (remarkList.isEmpty()) { %>
                <div class="alert alert-info">
                    暂无留言，来发表第一条留言吧！
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.2.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>

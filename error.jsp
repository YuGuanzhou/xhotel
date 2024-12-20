<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>X-HOTEL - 操作失败</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="nav">
        <div class="container">
            <a href="index.jsp" class="nav-brand">X-HOTEL</a>
            <div class="nav-links">
                <% if (session.getAttribute("name") == null) { %>
                    <a href="login.jsp">登录</a>
                    <a href="regist.jsp">注册</a>
                <% } else { %>
                    <% if ("ADMIN".equals(session.getAttribute("type"))) { %>
                        <div class="dropdown">
                            <button class="dropbtn">管理员中心</button>
                            <div class="dropdown-content">
                                <a href="user.jsp?view=user&name=<%= session.getAttribute("name") %>">查看酒店信息</a>
                                <a href="user.jsp?view=update&update=info&name=<%= session.getAttribute("name") %>">编辑酒店信息</a>
                                <a href="room.jsp?view=add">添加房间</a>
                                <a href="user.jsp?view=add">添加用户</a>
                                <a href="service.jsp?view=add">添加服务</a>
                                <a href="logout.jsp">退出登录</a>
                            </div>
                        </div>
                    <% } else { %>
                        <div class="dropdown">
                            <button class="dropbtn">个人中心</button>
                            <div class="dropdown-content">
                                <a href="user.jsp?view=user&name=<%= session.getAttribute("name") %>">查看个人信息</a>
                                <a href="user.jsp?view=update&update=info&name=<%= session.getAttribute("name") %>">编辑个人信息</a>
                                <a href="user.jsp?view=update&update=pwd&name=<%= session.getAttribute("name") %>">修改登录密码</a>
                                <a href="user.jsp?view=update&update=pay_pwd&name=<%= session.getAttribute("name") %>">修改支付密码</a>
                                <a href="order.jsp?view=order&user=<%= session.getAttribute("name") %>">查看个人订单</a>
                                <a href="logout.jsp">退出登录</a>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </div>
    </nav>

    <main class="container">
        <div class="message error">
            <h2>操作失败</h2>
            <p><%= request.getAttribute("message") != null ? request.getAttribute("message") : "操作执行失败，请重试" %></p>
            <div class="buttons">
                <a href="<%= request.getAttribute("returnUrl") != null ? request.getAttribute("returnUrl") : "javascript:history.back()" %>" class="btn btn-primary">返回</a>
            </div>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 X-HOTEL. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>

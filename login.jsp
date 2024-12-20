<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.math.BigInteger" %>
<%@ include file="/WEB-INF/classes/com/xhotel/common/DBUtil.jsp" %>
<%!
    // 密码加密方法
    public String encryptPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            String hashedPassword = new BigInteger(1, md.digest()).toString(16);
            while (hashedPassword.length() < 32) {
                hashedPassword = "0" + hashedPassword;
            }
            return hashedPassword;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // 验证输入是否包含SQL注入风险
    public boolean containsSQLInjection(String input) {
        if (input == null) return false;
        
        String[] sqlKeywords = {
            "SELECT", "INSERT", "UPDATE", "DELETE", "DROP", "UNION",
            "WHERE", "HAVING", "GROUP BY", "ORDER BY", "--", "/*", "*/"
        };
        
        String upperInput = input.toUpperCase();
        for (String keyword : sqlKeywords) {
            if (upperInput.contains(keyword)) {
                return true;
            }
        }
        return false;
    }
%>
<%
    // 获取登录失败次数
    Integer loginFailCount = (Integer) session.getAttribute("loginFailCount");
    if (loginFailCount == null) {
        loginFailCount = 0;
    }
    
    // 如果失败次数超过5次，检查是否已经过了15分钟
    if (loginFailCount >= 5) {
        Long lastFailTime = (Long) session.getAttribute("lastFailTime");
        if (lastFailTime != null) {
            long currentTime = System.currentTimeMillis();
            if (currentTime - lastFailTime < 900000) { // 15分钟 = 900000毫秒
                request.setAttribute("message", "登录失败次数过多，请15分钟后再试");
                request.setAttribute("messageType", "error");
                loginFailCount = 0;
                session.setAttribute("loginFailCount", loginFailCount);
            }
        }
    }

    // 处理登出请求
    if ("LOGOUT_DO".equals(request.getParameter("method"))) {
        session.invalidate();
        session = request.getSession(true);
        request.setAttribute("message", "已成功退出登录");
        request.setAttribute("messageType", "success");
    }

    // 处理登录请求
    if ("POST".equals(request.getMethod())) {
        String method = request.getParameter("method");
        
        if ("LOGIN_DO".equals(method)) {
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            
            // 检查SQL注入
            if (containsSQLInjection(name) || containsSQLInjection(password)) {
                request.setAttribute("message", "输入包含非法字符");
                request.setAttribute("messageType", "error");
            } else {
                String encryptedPassword = encryptPassword(password);
                System.out.println("加密后的密码: " + encryptedPassword); // 调试日志
                
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                
                try {
                    conn = DBUtil.getConnection();
                    if (conn == null) {
                        throw new SQLException("无法获取数据库连接");
                    }
                    
                    String checkSql = "SELECT * FROM t_user WHERE name = ?";
                    pstmt = conn.prepareStatement(checkSql);
                    pstmt.setString(1, name);
                    System.out.println("执行SQL查询: " + checkSql + " [参数: " + name + "]");
                    
                    rs = pstmt.executeQuery();
                    
                    if (rs.next()) {
                        String dbPassword = rs.getString("password");
                        System.out.println("数据库中的密码: " + dbPassword);
                        System.out.println("用户输入加密后的密码: " + encryptedPassword);
                        
                        String userType = rs.getString("type");
                        String userId = rs.getString("id");
                        String userNickName = rs.getString("nick_name");
                        
                        if (encryptedPassword.equals(dbPassword)) {
                            // 登录成功，重置失败计数
                            session.setAttribute("loginFailCount", 0);
                            session.removeAttribute("lastFailTime");
                            
                            session.setAttribute("name", name);
                            session.setAttribute("type", userType);
                            session.setAttribute("id", userId);
                            session.setAttribute("nick_name", userNickName);
                            session.setAttribute("loginMessage", "登录成功，欢迎回来！");
                            
                            System.out.println("登录成功，用户: " + name);
                            
                            String redirectUrl = (String) session.getAttribute("redirect_url");
                            if (redirectUrl != null && !redirectUrl.trim().isEmpty() 
                                && !redirectUrl.contains("login.jsp")
                                && (redirectUrl.startsWith("/") || redirectUrl.startsWith("http://localhost") || redirectUrl.startsWith("https://localhost"))) {
                                session.removeAttribute("redirect_url");
                                response.sendRedirect(redirectUrl);
                            } else {
                                response.sendRedirect("index.jsp");
                            }
                            return;
                        } else {
                            System.out.println("密码不匹配，用户: " + name);
                            loginFailCount++;
                            session.setAttribute("loginFailCount", loginFailCount);
                            session.setAttribute("lastFailTime", System.currentTimeMillis());
                            
                            request.setAttribute("message", "密码错误，还剩" + (5 - loginFailCount) + "次尝试机会");
                            request.setAttribute("messageType", "error");
                        }
                    } else {
                        System.out.println("用户不存在: " + name);
                        request.setAttribute("message", "用户不存在");
                        request.setAttribute("messageType", "error");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("登录过程发生错误: " + e.getMessage());
                    request.setAttribute("message", "登录失败：" + e.getMessage());
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
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>登录 - X-HOTEL</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-header h2 {
            color: #333;
            font-size: 24px;
        }
        
        .login-form {
            padding: 0 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }
        
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .btn-primary {
            flex: 1;
            margin-right: 10px;
        }
        
        .btn-success {
            flex: 1;
            margin-left: 10px;
        }
        
        .nav-links {
            text-align: center;
            margin-top: 20px;
        }
        
        .nav-links a {
            color: #666;
            text-decoration: none;
            font-size: 14px;
        }
        
        .nav-links a:hover {
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-header">
                <h2>欢迎登录 X-HOTEL</h2>
            </div>
            
            <div class="login-form">
                <% if (request.getAttribute("message") != null) { %>
                    <div class="message <%= request.getAttribute("messageType") != null ? request.getAttribute("messageType") : "error" %>">
                        <%= request.getAttribute("message") %>
                    </div>
                <% } %>
                
                <form method="post" action="login.jsp">
                    <input type="hidden" name="method" value="LOGIN_DO">
                    <div class="form-group">
                        <label>用户名</label>
                        <input type="text" class="form-control" name="name" required 
                               placeholder="请输入用户名">
                    </div>
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" class="form-control" name="password" required 
                               placeholder="请输入密码">
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">登录</button>
                        <a href="regist.jsp" class="btn btn-success">注册新账号</a>
                    </div>
                </form>
                
                <div class="nav-links">
                    <a href="index.jsp">返回首页</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

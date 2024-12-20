<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/check_login.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="/WEB-INF/classes/com/xhotel/common/DBUtil.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    // 获取用户信息
    String currentUserId = (String) session.getAttribute("id");
    String targetUserId = request.getParameter("id");
    String currentUserType = (String) session.getAttribute("type");
    
    // 如果用户未登录，重定向到登录页面
    if (currentUserId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Map<String, Object> userData = null;
    List<Map<String, Object>> userList = new ArrayList<>();
    
    try {
        conn = DBUtil.getConnection();
        
        // 处理表单提交
        String method = request.getParameter("method");
        if ("update".equals(method)) {
            String userId = request.getParameter("id");
            String updateName = request.getParameter("name");
            String password = request.getParameter("password");
            String nickName = request.getParameter("nick_name");
            String phoneNumber = request.getParameter("phone_number");
            String idNumber = request.getParameter("id_number");
            String type = request.getParameter("type");
            
            // 只有管理员可以修改用户类型，普通用户只能修改自己的基本信息
            if (!"ADMIN".equals(currentUserType) && !userId.equals(currentUserId)) {
                response.sendRedirect("error.jsp?message=" + URLEncoder.encode("无权访问", "UTF-8"));
                return;
            }
            
            StringBuilder sql = new StringBuilder("UPDATE t_user SET ");
            List<Object> params = new ArrayList<>();
            
            if (nickName != null && !nickName.trim().isEmpty()) {
                sql.append("nick_name = ?, ");
                params.add(nickName);
            }
            if ("ADMIN".equals(currentUserType) && type != null && !type.trim().isEmpty()) {
                sql.append("type = ?, ");
                params.add(type);
            }
            if (password != null && !password.trim().isEmpty()) {
                sql.append("password = ?, ");
                params.add(password); // 注意：实际应用中应该对密码进行加密
            }
            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                sql.append("phone_number = ?, ");
                params.add(phoneNumber);
            }
            if (idNumber != null && !idNumber.trim().isEmpty()) {
                sql.append("id_number = ?, ");
                params.add(idNumber);
            }
            
            // 移除最后的逗号和空格
            if (params.size() > 0) {
                sql.setLength(sql.length() - 2);
                sql.append(" WHERE id = ?");
                params.add(userId);
                
                pstmt = conn.prepareStatement(sql.toString());
                for (int i = 0; i < params.size(); i++) {
                    pstmt.setObject(i + 1, params.get(i));
                }
                
                pstmt.executeUpdate();
                response.sendRedirect("user.jsp?message=" + URLEncoder.encode("更新成功", "UTF-8"));
                return;
            }
        }
        
        // 查询用户信息
        if (targetUserId != null) {
            // 查询特定用户
            String sql = "SELECT * FROM t_user WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, targetUserId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                userData = new HashMap<>();
                userData.put("id", rs.getString("id"));
                userData.put("name", rs.getString("name"));
                userData.put("nick_name", rs.getString("nick_name"));
                userData.put("phone_number", rs.getString("phone_number"));
                userData.put("id_number", rs.getString("id_number"));
                userData.put("type", rs.getString("type"));
                userData.put("gmt_create", rs.getTimestamp("gmt_create"));
            }
        } else if ("ADMIN".equals(currentUserType)) {
            // 管理员可以查看所有用户
            String sql = "SELECT * FROM t_user ORDER BY gmt_create DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> user = new HashMap<>();
                user.put("id", rs.getString("id"));
                user.put("name", rs.getString("name"));
                user.put("nick_name", rs.getString("nick_name"));
                user.put("phone_number", rs.getString("phone_number"));
                user.put("id_number", rs.getString("id_number"));
                user.put("type", rs.getString("type"));
                user.put("gmt_create", rs.getTimestamp("gmt_create"));
                userList.add(user);
            }
        } else {
            // 普通用户只能查看自己的信息
            String sql = "SELECT * FROM t_user WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, currentUserId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                userData = new HashMap<>();
                userData.put("id", rs.getString("id"));
                userData.put("name", rs.getString("name"));
                userData.put("nick_name", rs.getString("nick_name"));
                userData.put("phone_number", rs.getString("phone_number"));
                userData.put("id_number", rs.getString("id_number"));
                userData.put("type", rs.getString("type"));
                userData.put("gmt_create", rs.getTimestamp("gmt_create"));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?message=" + URLEncoder.encode("系统错误：" + e.getMessage(), "UTF-8"));
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
        try { if (conn != null) DBUtil.releaseConnection(conn); } catch (Exception e) { }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>个人中心 - X-HOTEL</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .user-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .user-info {
            margin-bottom: 15px;
        }
        
        .user-info label {
            font-weight: bold;
            display: inline-block;
            width: 100px;
        }
        
        .user-actions {
            margin-top: 20px;
        }
        
        .btn {
            display: inline-block;
            padding: 8px 16px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            margin-right: 10px;
        }
        
        .btn:hover {
            background: #0056b3;
        }
        
        .btn-danger {
            background: #dc3545;
        }
        
        .btn-danger:hover {
            background: #c82333;
        }
        
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f8f9fa;
        }
        
        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <nav class="nav">
        <div class="container">
            <a href="index.jsp" class="nav-brand">X-HOTEL</a>
            <div class="nav-links">
                <a href="index.jsp">首页</a>
                <% if ("ADMIN".equals(currentUserType)) { %>
                    <a href="room.jsp">房间管理</a>
                    <a href="order.jsp">订单管理</a>
                    <a href="user.jsp">用户管理</a>
                <% } else { %>
                    <a href="order.jsp">我的订单</a>
                    <a href="user.jsp">个人中心</a>
                <% } %>
                <a href="logout.jsp">退出登录</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <% if (request.getParameter("message") != null) { %>
            <div class="message"><%= request.getParameter("message") %></div>
        <% } %>
        
        <% if ("ADMIN".equals(currentUserType) && userData == null) { %>
            <!-- 管理员查看所有用户列表 -->
            <h2>用户管理</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>昵称</th>
                        <th>手机号码</th>
                        <th>身份证号</th>
                        <th>类型</th>
                        <th>注册时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> user : userList) { %>
                        <tr>
                            <td><%= user.get("id") %></td>
                            <td><%= user.get("name") %></td>
                            <td><%= user.get("nick_name") %></td>
                            <td><%= user.get("phone_number") %></td>
                            <td><%= user.get("id_number") %></td>
                            <td><%= user.get("type") %></td>
                            <td><%= user.get("gmt_create") %></td>
                            <td>
                                <a href="user.jsp?id=<%= user.get("id") %>" class="btn">编辑</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else if (userData != null) { %>
            <!-- 查看/编辑用户信息 -->
            <div class="user-card">
                <h2><%="ADMIN".equals(currentUserType) ? "编辑用户" : "个人信息" %></h2>
                <form action="user.jsp" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="method" value="update">
                    <input type="hidden" name="id" value="<%= userData.get("id") %>">
                    
                    <div class="user-info">
                        <label>用户名：</label>
                        <span><%= userData.get("name") %></span>
                    </div>
                    
                    <div class="user-info">
                        <label>昵称：</label>
                        <input type="text" name="nick_name" value="<%= userData.get("nick_name") %>">
                    </div>
                    
                    <div class="user-info">
                        <label>手机号码：</label>
                        <input type="text" name="phone_number" value="<%= userData.get("phone_number") %>">
                    </div>
                    
                    <div class="user-info">
                        <label>身份证号：</label>
                        <input type="text" name="id_number" value="<%= userData.get("id_number") %>">
                    </div>
                    
                    <% if ("ADMIN".equals(currentUserType)) { %>
                        <div class="user-info">
                            <label>用户类型：</label>
                            <select name="type">
                                <option value="USER" <%= "USER".equals(userData.get("type")) ? "selected" : "" %>>普通用户</option>
                                <option value="ADMIN" <%= "ADMIN".equals(userData.get("type")) ? "selected" : "" %>>管理员</option>
                            </select>
                        </div>
                    <% } %>
                    
                    <div class="user-info">
                        <label>新密码：</label>
                        <input type="password" name="password" placeholder="不修改请留空">
                    </div>
                    
                    <div class="user-actions">
                        <button type="submit" class="btn">保存修改</button>
                        <a href="user.jsp" class="btn btn-danger">返回</a>
                    </div>
                </form>
            </div>
        <% } %>
    </div>

    <script>
        function validateForm() {
            var phoneNumber = document.getElementsByName("phone_number")[0].value;
            var idNumber = document.getElementsByName("id_number")[0].value;
            
            // 验证手机号
            if (phoneNumber && !/^1[3-9]\d{9}$/.test(phoneNumber)) {
                alert("请输入正确的手机号码");
                return false;
            }
            
            // 验证身份证号
            if (idNumber && !/^\d{17}[\dXx]$/.test(idNumber)) {
                alert("请输入正确的身份证号");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>

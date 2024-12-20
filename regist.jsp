<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="com.xhotel.util.DBUtil" %>
<%!
    // 密码加密方法
    public String encryptPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytes = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
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
    
    // 服务器端验证用户名
    public boolean isValidUsername(String username) {
        if (username == null || username.length() < 3 || username.length() > 18) {
            return false;
        }
        return username.matches("^[a-zA-Z0-9_]{3,18}$");
    }
    
    // 服务器端验证密码
    public boolean isValidPassword(String password) {
        if (password == null || password.length() < 3 || password.length() > 18) {
            return false;
        }
        return password.matches("^[a-zA-Z0-9_]{3,18}$");
    }
    
    // 生成JSON响应
    public String jsonResponse(boolean success, String message) {
        return "{\"success\":" + success + ",\"message\":\"" + message + "\"}";
    }
%>
<%
    // 处理表单提交
    if ("POST".equals(request.getMethod())) {
        response.setContentType("application/json;charset=UTF-8");
        
        // 设置请求编码为UTF-8
        request.setCharacterEncoding("UTF-8");
        
        // 获取并打印所有请求参数
        System.out.println("所有请求参数：");
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            System.out.println(paramName + " = " + paramValue);
        }
        
        // 获取表单参数
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String agreement = request.getParameter("agreement");
        
        System.out.println("接收到注册请求：name=" + name + ", agreement=" + agreement);
        
        // 检查参数是否为空
        if (name == null || password == null) {
            out.print(jsonResponse(false, "用户名和密码不能为空"));
            return;
        }
        
        // 验证协议是否同意
        if (!"true".equals(agreement)) {
            out.print(jsonResponse(false, "请阅读并同意用户协议"));
            return;
        }
        
        // 服务器端验证用户名和密码
        if (!isValidUsername(name)) {
            out.print(jsonResponse(false, "用户名必须是3-18位英文字母，数字或下划线"));
            return;
        }
        
        if (!isValidPassword(password)) {
            out.print(jsonResponse(false, "密码必须是3-18位英文字母，数字或下划线"));
            return;
        }
        
        // 检查SQL注入
        if (containsSQLInjection(name) || containsSQLInjection(password)) {
            out.print(jsonResponse(false, "输入包含非法字符"));
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // 开启事务
            
            System.out.println("数据库连接成功，开始检查用户名是否存在");
            
            // 检查用户名是否已存在
            pstmt = conn.prepareStatement("SELECT COUNT(*) FROM t_user WHERE name = ?");
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("用户名已存在：" + name);
                out.print(jsonResponse(false, "用户名已存在"));
                return;
            }
            
            // 加密密码
            String encryptedPassword = encryptPassword(password);
            if (encryptedPassword == null) {
                System.out.println("密码加密失败");
                out.print(jsonResponse(false, "密码加密失败"));
                return;
            }
            
            System.out.println("开始插入新用户");
            
            // 插入新用户
            String sql = "INSERT INTO t_user (id, name, password, type, nick_name, gmt_create, gmt_modified) " +
                        "VALUES (?, ?, ?, 'USER', ?, NOW(), NOW())";
            
            pstmt = conn.prepareStatement(sql);
            String userId = UUID.randomUUID().toString().replace("-", "");
            pstmt.setString(1, userId);
            pstmt.setString(2, name);
            pstmt.setString(3, encryptedPassword);
            pstmt.setString(4, name); // 默认昵称和用户名相同
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                conn.commit(); // 提交事务
                System.out.println("用户注册成功：" + name);
                out.print(jsonResponse(true, "注册成功"));
            } else {
                conn.rollback(); // 回滚事务
                System.out.println("插入用户记录失败");
                out.print(jsonResponse(false, "注册失败"));
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback(); // 发生异常时回滚事务
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
            System.out.println("注册过程发生异常：" + e.getMessage());
            e.printStackTrace();
            out.print(jsonResponse(false, "系统错误：" + e.getMessage()));
        } finally {
            // 关闭资源
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // 恢复自动提交
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>注册 - X-HOTEL</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .register-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .register-header h2 {
            color: #333;
            font-size: 24px;
            margin: 0;
        }
        
        .register-form {
            padding: 0 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }
        
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            border-color: #6f42c1;
            outline: none;
        }
        
        .form-group .error-message {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        
        .form-group.error input {
            border-color: #dc3545;
        }
        
        .form-group.error .error-message {
            display: block;
        }
        
        .agreement {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        
        .agreement input[type="checkbox"] {
            margin-right: 8px;
        }
        
        .btn-register {
            width: 100%;
            padding: 12px;
            background: #6f42c1;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .btn-register:hover {
            background: #5a32a3;
        }
        
        .btn-register:disabled {
            background: #b8a2d9;
            cursor: not-allowed;
        }
        
        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        
        .login-link a {
            color: #6f42c1;
            text-decoration: none;
        }
        
        .login-link a:hover {
            text-decoration: underline;
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
        
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            display: none;
        }
        
        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        
        .alert-error {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <div class="register-header">
                <h2>注册 X-HOTEL</h2>
            </div>
            
            <div class="register-form">
                <div id="alertBox" class="alert"></div>
                
                <form id="registForm" method="post">
                    <div class="form-group">
                        <label>用户名</label>
                        <input type="text" required class="form-control" name="name" id="name"
                               placeholder="请输入用户名(3-18位英文字母，数字或下划线)">
                        <div class="error-message">用户名必须是3-18位英文字母，数字或下划线</div>
                    </div>
                    
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" required class="form-control" name="password" id="password"
                               placeholder="请输入密码(3-18位英文字母，数字或下划线)">
                        <div class="error-message">密码必须是3-18位英文字母，数字或下划线</div>
                    </div>
                    
                    <div class="form-group agreement">
                        <label>
                            <input type="checkbox" name="agreement" id="agreement" value="true" required>
                            我已阅读并同意《XHotel用户协议》
                        </label>
                        <div class="error-message" id="agreementError" style="display: none;">请阅读并同意用户协议</div>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn-register" id="submitBtn">注册</button>
                    </div>
                    
                    <div class="login-link">
                        已有账号？<a href="login.jsp">请登录</a>
                    </div>
                </form>
                
                <div class="nav-links">
                    <a href="index.jsp">返回首页</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        const nameRegex = /^[a-zA-Z0-9_]{3,18}$/;
        const passwordRegex = /^[a-zA-Z0-9_]{3,18}$/;
        const form = document.getElementById('registForm');
        const nameInput = document.getElementById('name');
        const passwordInput = document.getElementById('password');
        const agreementCheckbox = document.getElementById('agreement');
        const submitBtn = document.getElementById('submitBtn');
        const alertBox = document.getElementById('alertBox');
        
        // 显示提示信息
        function showAlert(message, type) {
            alertBox.textContent = message;
            alertBox.className = 'alert alert-' + type;
            alertBox.style.display = 'block';
            
            if (type === 'success') {
                setTimeout(() => {
                    window.location.href = 'login.jsp';
                }, 1500);
            }
        }
        
        // 验证表单字段
        function validateField(input, regex) {
            const formGroup = input.parentElement;
            const valid = regex.test(input.value);
            
            if (valid) {
                formGroup.classList.remove('error');
            } else {
                formGroup.classList.add('error');
            }
            
            return valid;
        }
        
        // 验证整个表单
        function validateForm() {
            const nameValid = validateField(nameInput, nameRegex);
            const passwordValid = validateField(passwordInput, passwordRegex);
            const agreementValid = agreementCheckbox.checked;
            
            // 显示或隐藏协议错误信息
            const agreementError = document.getElementById('agreementError');
            if (!agreementValid) {
                agreementError.style.display = 'block';
            } else {
                agreementError.style.display = 'none';
            }
            
            return nameValid && passwordValid && agreementValid;
        }
        
        // 添加实时验证
        nameInput.addEventListener('input', () => {
            validateField(nameInput, nameRegex);
            updateSubmitButton();
        });
        passwordInput.addEventListener('input', () => {
            validateField(passwordInput, passwordRegex);
            updateSubmitButton();
        });
        agreementCheckbox.addEventListener('change', () => {
            validateForm();
            updateSubmitButton();
        });
        
        // 更新提交按钮状态
        function updateSubmitButton() {
            submitBtn.disabled = !validateForm();
        }
        
        // 处理表单提交
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            if (!validateForm()) {
                return;
            }
            
            submitBtn.disabled = true;
            
            try {
                // 创建表单数据
                const formData = new URLSearchParams();
                formData.append('name', nameInput.value);
                formData.append('password', passwordInput.value);
                formData.append('agreement', agreementCheckbox.checked ? 'true' : 'false');
                
                // 发送请求
                const response = await fetch('regist.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
                    },
                    body: formData.toString()
                });
                
                // 检查响应状态
                if (!response.ok) {
                    throw new Error('网络请求失败');
                }
                
                const result = await response.json();
                console.log('注册响应：', result);
                
                if (result.success) {
                    showAlert('注册成功！正在跳转到登录页面...', 'success');
                } else {
                    showAlert(result.message, 'error');
                    submitBtn.disabled = false;
                }
            } catch (error) {
                console.error('注册错误：', error);
                showAlert('注册失败：' + error.message, 'error');
                submitBtn.disabled = false;
            }
        });
        
        // 初始验证
        updateSubmitButton();
    </script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 检查用户是否已登录
    String userName = (String) session.getAttribute("name");
    String userType = (String) session.getAttribute("type");
    
    // 获取当前请求的URL
    String requestURL = request.getRequestURI();
    String queryString = request.getQueryString();
    String fullURL = requestURL + (queryString != null ? "?" + queryString : "");
    
    // 如果用户未登录且不是登录页面
    if (userName == null && !requestURL.endsWith("login.jsp") && !requestURL.endsWith("regist.jsp")) {
        // 保存当前请求的URL，以便登录后跳转回来
        session.setAttribute("redirect_url", fullURL);
        
        // 设置提示消息
        request.setAttribute("message", "请先登录");
        request.setAttribute("messageType", "info");
        
        // 重定向到登录页面
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // 检查管理员权限（如果需要的话）
    boolean isAdmin = "ADMIN".equals(userType);
    if (requestURL.contains("/admin/") && !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>

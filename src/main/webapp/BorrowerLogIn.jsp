<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="GBK">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/auth.css">
    <title>用户注册</title>
</head>

<body>
<div class="lowin lowin-blue">
    <div class="lowin-brand">
        <img src="images/2.jpg" alt="logo">
    </div>
    <div class="lowin-wrapper">
        <div class="lowin-box lowin-login">
            <div class="lowin-box-inner" >
                <form action="<s:url value="BorrowerLogIn"/>" method="post">
                    <p> 登录窗口</p>
                    <div class="lowin-group" >
                        <label>用户名：</label>
                        <input type="text" name="userName" class="lowin-input">
                    </div>
                    <div class="lowin-group password-group">
                        <label>密码：</label>
                        <input type="password" name="password" autocomplete="current-password" class="lowin-input">
                    </div>
                    <button class="lowin-btn login-btn" type="submit">登录</button>
                    <a href="BorrowerRegister.jsp"><button class="lowin-btn login-btn">注册</button></a>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
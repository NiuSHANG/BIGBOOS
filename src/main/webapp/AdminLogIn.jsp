<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/auth.css">
    <title>管理员登录</title>
    <script src="js/popup.js"></script>
    <script>
        <s:if test="message != null">addEventListener('load', () => initPopup('<s:property value="message"/>'));</s:if>
    </script>
</head>




<body>
<div class="lowin lowin-blue">
    <div class="lowin-brand">
        <img src="images/2.jpg" alt="logo">
    </div>
    <div class="lowin-wrapper">
        <div class="lowin-box lowin-login">
            <div class="lowin-box-inner" >
                <form action="<s:url value="AdminLogIn"/>" method="post">
                    <p> 管理员登录窗口</p>
                    <div class="lowin-group" >
                        <label>管理员用户名： </label>
                        <input type="text" name="adminName" class="lowin-input">
                    </div>
                    <div class="lowin-group password-group">
                        <label>密码：</label>
                        <input type="password" name="password" autocomplete="current-password" class="lowin-input">
                    </div>
                    <button class="lowin-btn login-btn" type="submit">登录</button>
                    <button class="lowin-btn login-btn" type="reset">重置</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
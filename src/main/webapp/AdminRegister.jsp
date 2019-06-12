<%--
  Created by IntelliJ IDEA.
  User: Gresstant
  Date: 2019/5/24
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/auth.css">
    <title>用户注册</title>
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
                <form action="<s:url value="AdminRegister" />" method="post">
                    <p> 管理员注册窗口</p>
                    <div class="lowin-group" >
                        <label>用户名：</label>
                        <input type="text" name="adminName" class="lowin-input">
                    </div>
                    <div class="lowin-group password-group">
                        <label>密码：</label>
                        <input type="password" name="password" autocomplete="current-password" class="lowin-input">
                    </div>
                    <div class="lowin-group password-group">
                        <button class="lowin-btn login-btn" type="submit">注册</button>
                        <button class="lowin-btn login-btn" type="reset">重置</button>
                    </div>
                    <div class="lowin-group password-group">
                        <s:
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>



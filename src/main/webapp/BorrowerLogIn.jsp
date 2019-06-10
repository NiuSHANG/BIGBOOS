<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <!-- Custom Theme files -->
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <!-- Custom Theme files -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />


</head>
<body>
<div class="login">
    <h2>用户登录</h2>
    <div class="login-top">
        <form action="<s:url action="BorrowerLogIn"/>" method="post">
            <table>
                <tr>
                    <td>用户名</td> &nbsp; &nbsp; &nbsp;
                    <td>	<input type="text" name="userName" value="请输入用户名" required = "required"></td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td>	<input type="password" name="password" value="请输入密码" required = "required"></td>
                </tr>
            </table>
            <input type="reset" value="重新填写"/>
            <input type="submit" value="登录" >
        </form>
    </div>
    <div class="login-bottom">
        <h3>新用户 &nbsp;<a href="BorrowerRegister.jsp">注册</a></h3>
    </div>
</div>

</body>
</html>
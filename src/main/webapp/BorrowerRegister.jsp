<%--
  Created by IntelliJ IDEA.
  User: Gresstant
  Date: 2019/5/24
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />

</head>
<body>
<div class="login">
    <h2>用户登录</h2>
    <div class="login-top">
        <form action="<s:url action="BorrowerRegister"/>" method="post">
            <table>
                <tr>
                    <td>用户名</td> &nbsp; &nbsp; &nbsp;
                    <td>	<input type="text" name="username" value="请输入用户名" required = "required"></td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td>	<input type="password" name="password" value="请输入密码" required = "required"></td>
                </tr>
                <tr>
                    <td>用户类型</td> &nbsp; &nbsp; &nbsp;
                    <td>
                        <select name="type">
                            <option value="STUDENT">学生</option>
                            <option value="FACULTY">教师</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <input type="submit" value="注册" >
                    <input type="reset" value="清空"/>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>
</html>
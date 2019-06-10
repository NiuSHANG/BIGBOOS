<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: ZZU
  Date: 2019/6/8
  Time: 20:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="<s:url action="AdminLogIn"/>" method="post">
    <tr>用户名：<input type="text" name="adminName" value="234"> </tr>
    <tr>密码:<input type="password" name="password" value="234"></tr>
    <tr>
        <input type="submit" value="登录"/>
        <input type="reset" value="清空"/>
    </tr>
</form>
</body>
</html>

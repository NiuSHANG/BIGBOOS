<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: ZZU
  Date: 2019/6/10
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="<s:url action="AdminRegister"/>" method="post">
        <tr>用户名：<input type="text" name="adminName"> </tr>
        <tr>密码:<input type="password" name="password"></tr>
        <tr>
            <input type="submit" value="注册"/>
            <input type="reset" value="清空"/>
        </tr>
    </form>
</body>
</html>

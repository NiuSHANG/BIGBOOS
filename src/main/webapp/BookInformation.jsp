<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: ZZU
  Date: 2019/6/8
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书信息</title>
    <meta charset="GBK">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Product example for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <style>body { padding-top: 51px; }</style>
</head>
<body>
<div class="container theme-showcase" role="main">
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="AdminLogIn.jsp">一川芳杰</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="main.jsp"><span class="glyphicon glyphicon-home"></span> 首页</a></li>
                    <li><a href="<s:url action="MyRecord"/>"><span class="glyphicon glyphicon-book"></span> 我的图书
                    </a></li>
                    <li><a href="<s:url action="BorrowerLogOut"/>"><span class="glyphicon glyphicon-user"></span> 登出</a></li>
                </ul>
                <form class="navbar-form navbar-right">
                    <input type="text" class="form-control" placeholder="Search..."><input type="button" class="form-control" value="搜索">
                </form>
            </div>
        </div>
    </nav>
    <div class="row">
        <table class="table table-hover">
            <tbody>
                <s:iterator value="bookInformation" var="book" status="status">
                    <tr><img src="" /> </tr>
                    <tr><s:property value="#book.name"/> </tr>
                    <tr><s:property value="#book.author"/> </tr>
                    <tr><s:property value="#book.summary"/> </tr>
                    <tr><a href="<s:url action="BorrowBook"/>?bookid=<s:property value="#book.isbn"/>">借阅</a></tr>
                </s:iterator>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

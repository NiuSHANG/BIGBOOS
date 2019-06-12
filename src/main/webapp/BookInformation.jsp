<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: ZZU
  Date: 2019/6/8
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>

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
                    <li>
                        <a href="main.jsp">
                            <span class="glyphicon glyphicon-home"></span> 首页
                        </a>
                    </li>
                    <li>
                        <a href="<s:url action="MyRecord"/>">
                            <span class="glyphicon glyphicon-book"></span> 我的图书
                        </a>
                    </li>
                    <li>
                        <a href="<s:url action="BorrowerLogOut"/>">
                            <span class="glyphicon glyphicon-user"></span> 登出
                        </a>
                    </li>
                </ul>
                <form class="navbar-form navbar-right">
                    <input type="text" class="form-control" placeholder="Search..."><input type="button" class="form-control" value="搜索">
                </form>
            </div>
        </div>
    </nav>
    <div class="row">
        <div class="goods-summary clearfix">
            <!-- 商品信息 -->
            <div class="goods-info pull-right">
                <h3 class="goods-title">书号：<s:property value="%{bookInfo.isbn}"/></h3>
                <div class="goods-price clearfix">
                    <strong class="goods-current-price pull-left" ><s:property value="%{bookInfo.name}"/></strong>
                </div>
                <h3 class="goods-title">作者：<s:property value="%{bookInfo.author}"/></h3>
                <h3 class="goods-title">出版日期：<s:property value="%{bookInfo.issueOn}"/></h3>
                <h3 class="goods-title">简介：<s:property value="%{bookInfo.summary}"/></h3>
                <table class="goods-meta">
                    <tbody>
                    <tr class="first-child">
                        <td class="goods-meta-name">库存：</td>
                        <td><s:property value="%{bookInfo.copies.size()}"/></td>
                        <td class="goods-meta-name">已借出：</td>
                        <td><s:property value="%{bookInfo.copies.size() - available}"/></td>
                        <td class="goods-meta-name">未借出：</td>
                        <td><s:property value="%{available}"/></td>
                    </tr>
                    <tr class="last-child">
                    </tr>
                    </tbody>
                </table>
                <div class="showcase-examples l-over l-center">
                    <a href="<s:url action="BorrowBook"/>?bookId=<s:property value="%{bookInfo.isbn}"/>">借阅</a>
                    <a href="<s:url action="ReturnBook"/>?bookId=<s:property value="%{bookInfo.isbn}"/>">归还</a>
                </div>
            </div>
            <!-- 商品图片 -->
            <div class="goods-image pull-left">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <div class="swiper-image">
                                <img width="250" src="<s:url action="Image"/>?isbn=<s:property value="%{bookInfo.isbn}"/>">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>

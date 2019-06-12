<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="GBK">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">


    <title>Product example for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="js/lineClampPolyfill.js"></script>
    <script>
        window.addEventListener("load", () => {
            for (let dom of document.getElementsByClassName("pane-book-name")) {
                webkitLineClamp(dom, 1);
            }
            for (let dom of document.getElementsByClassName("pane-book-summary")) {
                webkitLineClamp(dom, 3);
            }
        })
    </script>

    <style>
        body { padding-top: 51px; }

        .content{
            width:350px;
            height: 350px;
        }

        .panel-heading{
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .panel-title {
            cursor: pointer !important;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
        .thumbnail {
            display: block;
            padding: 4px;
            margin-bottom: 20px;
            line-height: 1.42857143;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            height: 420px;
            -webkit-transition: border .2s ease-in-out;
            -o-transition: border .2s ease-in-out;
            transition: border .2s ease-in-out;
        }

        .pane-book-name {
            font-weight: bold;
        }

        .pane-book-summary {
            color: #666;
            font-size: small;
        }
    </style>
</head>
<body>
<div class="container theme-showcase" role="main">
    <%--nav--%>
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
                    <li><a href="MainFirst.jsp"><span class="glyphicon glyphicon-home"></span> 首页</a></li>


                    <li><a href="<s:url action="MyRecord"/>"><span class="glyphicon glyphicon-book"></span> 我的图书
                    </a></li>

                    <li><a href="<s:url action="BorrowerLogOut"/>">
                        <span class="glyphicon glyphicon-user"></span>
                        <s:if test="#session.userId==null" >登录</s:if>
                        <s:else>登出</s:else>
                    </a>
                    </li>
                </ul>
                <form class="navbar-form navbar-right">
                    <input type="text" class="form-control" placeholder="Search..."><input type="button" class="form-control" value="搜索">

                </form>
            </div>
        </div>
    </nav>
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class=""></li>
            <li data-target="#carousel-example-generic" data-slide-to="1" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2" class=""></li>
        </ol>
        <div class="carousel-inner" role="listbox">
            <div class="item">
                <img data-src="holder.js/1140x500/auto/#777:#555/text:First slide" alt="First slide [1140x500]" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMTE0MCIgaGVpZ2h0PSI1MDAiIHZpZXdCb3g9IjAgMCAxMTQwIDUwMCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvMTE0MHg1MDAvYXV0by8jNzc3OiM1NTUvdGV4dDpGaXJzdCBzbGlkZQpDcmVhdGVkIHdpdGggSG9sZGVyLmpzIDIuNi4wLgpMZWFybiBtb3JlIGF0IGh0dHA6Ly9ob2xkZXJqcy5jb20KKGMpIDIwMTItMjAxNSBJdmFuIE1hbG9waW5za3kgLSBodHRwOi8vaW1za3kuY28KLS0+PGRlZnM+PHN0eWxlIHR5cGU9InRleHQvY3NzIj48IVtDREFUQVsjaG9sZGVyXzE2YWM5ZTNkMzAwIHRleHQgeyBmaWxsOiM1NTU7Zm9udC13ZWlnaHQ6Ym9sZDtmb250LWZhbWlseTpBcmlhbCwgSGVsdmV0aWNhLCBPcGVuIFNhbnMsIHNhbnMtc2VyaWYsIG1vbm9zcGFjZTtmb250LXNpemU6NTdwdCB9IF1dPjwvc3R5bGU+PC9kZWZzPjxnIGlkPSJob2xkZXJfMTZhYzllM2QzMDAiPjxyZWN0IHdpZHRoPSIxMTQwIiBoZWlnaHQ9IjUwMCIgZmlsbD0iIzc3NyIvPjxnPjx0ZXh0IHg9IjM5MC41MDc4MTI1IiB5PSIyNzUuNSI+Rmlyc3Qgc2xpZGU8L3RleHQ+PC9nPjwvZz48L3N2Zz4=" data-holder-rendered="true">
            </div>
            <div class="item active">
                <img data-src="holder.js/1140x500/auto/#666:#444/text:Second slide" alt="Second slide [1140x500]" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMTE0MCIgaGVpZ2h0PSI1MDAiIHZpZXdCb3g9IjAgMCAxMTQwIDUwMCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvMTE0MHg1MDAvYXV0by8jNjY2OiM0NDQvdGV4dDpTZWNvbmQgc2xpZGUKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+PCFbQ0RBVEFbI2hvbGRlcl8xNmFjOWUzN2JjZiB0ZXh0IHsgZmlsbDojNDQ0O2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjU3cHQgfSBdXT48L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE2YWM5ZTM3YmNmIj48cmVjdCB3aWR0aD0iMTE0MCIgaGVpZ2h0PSI1MDAiIGZpbGw9IiM2NjYiLz48Zz48dGV4dCB4PSIzMzUuNjAxNTYyNSIgeT0iMjc1LjUiPlNlY29uZCBzbGlkZTwvdGV4dD48L2c+PC9nPjwvc3ZnPg==" data-holder-rendered="true">
            </div>
            <div class="item">
                <img data-src="holder.js/1140x500/auto/#555:#333/text:Third slide" alt="Third slide [1140x500]" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMTE0MCIgaGVpZ2h0PSI1MDAiIHZpZXdCb3g9IjAgMCAxMTQwIDUwMCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvMTE0MHg1MDAvYXV0by8jNTU1OiMzMzMvdGV4dDpUaGlyZCBzbGlkZQpDcmVhdGVkIHdpdGggSG9sZGVyLmpzIDIuNi4wLgpMZWFybiBtb3JlIGF0IGh0dHA6Ly9ob2xkZXJqcy5jb20KKGMpIDIwMTItMjAxNSBJdmFuIE1hbG9waW5za3kgLSBodHRwOi8vaW1za3kuY28KLS0+PGRlZnM+PHN0eWxlIHR5cGU9InRleHQvY3NzIj48IVtDREFUQVsjaG9sZGVyXzE2YWM5ZTM5NWIxIHRleHQgeyBmaWxsOiMzMzM7Zm9udC13ZWlnaHQ6Ym9sZDtmb250LWZhbWlseTpBcmlhbCwgSGVsdmV0aWNhLCBPcGVuIFNhbnMsIHNhbnMtc2VyaWYsIG1vbm9zcGFjZTtmb250LXNpemU6NTdwdCB9IF1dPjwvc3R5bGU+PC9kZWZzPjxnIGlkPSJob2xkZXJfMTZhYzllMzk1YjEiPjxyZWN0IHdpZHRoPSIxMTQwIiBoZWlnaHQ9IjUwMCIgZmlsbD0iIzU1NSIvPjxnPjx0ZXh0IHg9IjM3Ny44NjcxODc1IiB5PSIyNzUuNSI+VGhpcmQgc2xpZGU8L3RleHQ+PC9nPjwvZz48L3N2Zz4=" data-holder-rendered="true">
            </div>
        </div>
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <hr class="featurette-divider">
    <div class="jumbotron"><h1>Theme example</h1>
        <p>This is a template showcasing the optional theme stylesheet included in Bootstrap. Use it as a starting point to create something more unique by building on or modifying it.</p>
    </div>
    <div class="row">
    </div>
    <hr class="featurette-divider">
    <div class="jumbotron">
        <h1>Theme example</h1>
        <p>This is a template showcasing the optional theme stylesheet included in Bootstrap. Use it as a starting point to create something more unique by building on or modifying it.</p>
    </div>
    <div class="tabbable" id="图书浏览">

        <ul class="nav nav-tabs">
            <s:iterator value="profileByType.entrySet()" var="entry" status="status">
                <li <s:if test="%{currentType == #entry.key or currentType == null and #status.index == 0}">class="active"</s:if>>
                    <a href="#nav-<s:property value="#status.index"/>" data-toggle="tab" aria-expanded="true">
                        <s:property value="%{#entry.key}" />
                    </a>
                </li>
            </s:iterator>
        </ul>
        <div class="tab-content"/>
        <s:iterator value="profileByType.entrySet()" var="entry" status="status">
            <div class="tab-pane<s:if test="%{currentType == #entry.key or currentType == null and #status.index == 0}"> active</s:if>"
                 id="nav-<s:property value="%{#status.index}" />">
                <div class="row">
                    <s:iterator value="%{#entry.value.content}" var="book" status="status">
                        <div class="col-sm-6 col-md-4 clearfix">
                            <div class="thumbnail" >
                                <img width="250" src="<s:url action="Image"/>?isbn=<s:property value="#book.isbn"/>">
                                <div class="caption">
                                    <h4 class="pane-book-name"><s:property value="#book.name"/> </h4>
                                    <p class="pane-book-summary"><s:property value="#book.summary"/></p>
                                    <footer class="q">
                                        <p>
                                            <a href="<s:url action="BorrowBook" />?bookId=<s:property value="#book.isbn"/> " class="btn btn-primary" role="button">借阅图书</a>
                                            <a href="<s:url action="BookInformation"/>?bookId=<s:property value="#book.isbn"/> " class="btn btn-default" role="button">详细信息</a>
                                        </p>
                                    </footer>
                                </div>
                            </div>
                        </div>
                    </s:iterator>
                    <div class="col-sm-12 col-md-12 text-center">

                        <footer class="footer">
                            <ul class="pagination">
                                <li>
                                    <button type="button" class="btn btn-lg btn-default" <s:if test="%{pageOfType[#entry.key] <= 0}">disabled="disabled"</s:if>>
                                        <s:if test="%{pageOfType[#entry.key] > 0}">
                                            <a href="<s:url action="Main" />?pageOfType=<s:property value="%{#entry.key}"/>,<s:property value="%{pageOfType[#entry.key] - 1}" />&currentType=<s:property value="#entry.key"/>">
                                                <span class="glyphicon glyphicon-arrow-left">上一页</span>
                                            </a>
                                        </s:if>
                                        <s:else>
                                            <span class="glyphicon glyphicon-arrow-left">上一页</span>
                                        </s:else>
                                    </button>
                                </li>
                                <li>
                                    <button type="button" class="btn btn-lg btn-default ">
                                        <span class="glyphicon glyphicon-file"><s:property value="%{pageOfType[#entry.key] + 1}" />/<s:property value="%{#entry.value.totalPages}" /></span>
                                    </button>
                                </li>
                                <li>
                                    <button type="button" class="btn btn-lg btn-default " <s:if test="%{pageOfType[#entry.key] >= (#entry.value.totalPages - 1)}">disabled="disabled"</s:if>>
                                        <s:if test="%{pageOfType[#entry.key] < (#entry.value.totalPages - 1)}">
                                            <a href="<s:url action="Main" />?pageOfType=<s:property value="%{#entry.key}"/>,<s:property value="%{pageOfType[#entry.key] + 1}" />&currentType=<s:property value="#entry.key"/>">
                                                <span class="glyphicon glyphicon-arrow-right" >下一页</span>
                                            </a>
                                        </s:if>
                                        <s:else>
                                            <span class="glyphicon glyphicon-arrow-right" >下一页</span>
                                        </s:else>
                                    </button>
                                </li>
                            </ul>
                        </footer>
                    </div>
                </div>
            </div>
        </s:iterator>
    </div>
    </div>

    <hr class="featurette-divider">

    <footer>
        <p class="pull-right"><a href="#">返回顶部</a></p>
        <p>2019</p>
    </footer>


    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->

</body>
</html>
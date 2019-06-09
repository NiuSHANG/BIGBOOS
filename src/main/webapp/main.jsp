<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en"><head>
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
            <div class="col-sm-4">
                <div class="view" style="display: block;">
                    <div class="panel-group" id="fold-1">
                        <div class="panel panel-default">
                            <s:iterator value="%{bookListNovel}" var="book" status="status">
                                <div class="panel-heading">
                                    <a class="panel-title collapsed" aria-expanded="false" contenteditable="true" href="#fold<s:property value="%{#status.index}"/>-1" data-toggle="collapse" data-parent="#fold-1"><s:property value="#book.name"/> </a>
                                </div>
                                <div class="panel-collapse collapse" id="fold<s:property value="%{#status.index}"/>-1" aria-expanded="false" style="height: 0px;">
                                    <div class="panel-body" contenteditable="true">
                                        <div class="thumbnail">
                                            <img alt="300x200" src="v3/default4.jpg">
                                            <div class="caption" contenteditable="true">
                                                <h3>作者：<s:property value="#book.author"/> </h3>
                                                <p>
                                                    <s:property value="#book.summary"/>
                                                </p>
                                                <p>
                                                    <a class="btn btn-primary" href="#">Action</a>
                                                    <a class="btn" href="#">Action</a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </s:iterator>
                        </div>
                    </div>
                </div>
            </div>
        <div class="col-sm-4">
            <div class="view" style="display: block;">
                <div class="panel-group" id="fold-2">
                    <div class="panel panel-default">
                        <s:iterator value="%{bookListSocialScience}" var="book" status="status">
                            <div class="panel-heading">
                                <a class="panel-title collapsed" aria-expanded="false" contenteditable="true" href="#fold<s:property value="%{#status.index}"/>-2" data-toggle="collapse" data-parent="#fold-2"><s:property value="#book.name"/> </a>
                            </div>
                            <div class="panel-collapse collapse" id="fold<s:property value="%{#status.index}"/>-2" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body" contenteditable="true">
                                    <div class="thumbnail">
                                        <img alt="300x200" src="v3/default4.jpg">
                                        <div class="caption" contenteditable="true">
                                            <h3>作者：<s:property value="#book.author"/> </h3>
                                            <p>
                                                <s:property value="#book.summary"/>
                                            </p>
                                            <p>
                                                <a class="btn btn-primary" href="#">Action</a>
                                                <a class="btn" href="#">Action</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </s:iterator>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="view" style="display: block;">
                <div class="panel-group" id="fold-3">
                    <div class="panel panel-default">
                        <s:iterator value="%{bookListTeachingAssistant}" var="book" status="status">
                            <div class="panel-heading">
                                <a class="panel-title collapsed" aria-expanded="false" contenteditable="true" href="#fold<s:property value="%{#status.index}"/>-3" data-toggle="collapse" data-parent="#fold-3"><s:property value="#book.name"/> </a>
                            </div>
                            <div class="panel-collapse collapse" id="fold<s:property value="%{#status.index}"/>-3" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body" contenteditable="true">
                                    <div class="thumbnail">
                                        <img alt="300x200" src="v3/default4.jpg">
                                        <div class="caption" contenteditable="true">
                                            <h3>作者：<s:property value="#book.author"/> </h3>
                                            <p>
                                                <s:property value="#book.summary"/>
                                            </p>
                                            <p>
                                                <a class="btn btn-primary" href="#">Action</a>
                                                <a class="btn" href="#">Action</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </s:iterator>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr class="featurette-divider">
    <div class="jumbotron">
        <h1>Theme example</h1>
        <p>This is a template showcasing the optional theme stylesheet included in Bootstrap. Use it as a starting point to create something more unique by building on or modifying it.</p>
    </div>
    <div class="tabbable" id="tabs-126062">
        <ul class="nav nav-tabs">

            </li>
            <li class="active">
                <a href="#teachingassisdant" data-toggle="tab" aria-expanded="true">教辅</a>
            </li>
            <li class="">
                <a href="#technologe" data-toggle="tab" aria-expanded="false">科技书</a>
            </li>
            <li class="">
                <a href="#novel" data-toggle="tab" aria-expanded="false">小说</a>
            </li>
            <li class="">
                <a href="#socialsciences" data-toggle="tab" aria-expanded="false">社科</a>
            </li>
            <li class="">
                <a href="#philosophicalreligion" data-toggle="tab" aria-expanded="false">哲学宗教</a>
        </ul>
        <div class="tab-pane" id="teachingassident">
            <div class="row">
                <s:iterator value="%{bookListTeachingAssistant}" var="book" status="status">
                    <div class="col-sm-6 col-md-4">
                        <div class="thumbnail">
                            <img src="..." alt="...">
                            <div class="caption">
                                <h3><s:property value="#book.name"/> </h3>
                                <p><s:property value="#book.summary"/></p>
                                <p><a href="<s:url action="BorrowBook" />?bookid=<s:property value="book.isbn"/> " class="btn btn-primary" role="button">借阅图书</a>
                                    <a href="<s:url action="BookInformation"/>?bookid=<s:property value="book.isbn"/> " class="btn btn-default" role="button">详细信息</a></p>
                            </div>
                        </div>
                    </div>
                </s:iterator>
            </div>
        </div>

        <div class="tab-pane" id="technologe">
            <div class="row">


            </div>
        </div>
        <div class="tab-pane" id="novel">
            <div class="row">

            </div>
        </div>
        <div class="tab-pane" id="socialsciences">
            <div class="row">

            </div>
        </div>
    </div>
</div>
    <hr class="featurette-divider">

    <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>? 2016 Company, Inc. · <a href="#">Privacy</a> · <a href="#">Terms</a></p>
    </footer>


    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->

</body>
</html>
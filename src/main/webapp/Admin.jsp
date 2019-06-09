<%--
  Created by IntelliJ IDEA.
  User: ZZU
  Date: 2019/6/6
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ch"><head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <title>图书管理系统</title>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(function() {
            $(".meun-item").click(function() {
                $(".meun-item").removeClass("meun-item-active");
                $(this).addClass("meun-item-active");
                var itmeObj = $(".meun-item").find("img");
                itmeObj.each(function() {
                    var items = $(this).attr("src");
                    items = items.replace("_grey.png", ".png");
                    items = items.replace(".png", "_grey.png")
                    $(this).attr("src", items);
                });
                var attrObj = $(this).find("img").attr("src");
                ;
                attrObj = attrObj.replace("_grey.png", ".png");
                $(this).find("img").attr("src", attrObj);
            });
            $("#topAD").click(function() {
                $("#topA").toggleClass(" glyphicon-triangle-right");
                $("#topA").toggleClass(" glyphicon-triangle-bottom");
            });
            $("#topBD").click(function() {
                $("#topB").toggleClass(" glyphicon-triangle-right");
                $("#topB").toggleClass(" glyphicon-triangle-bottom");
            });
            $("#topCD").click(function() {
                $("#topC").toggleClass(" glyphicon-triangle-right");
                $("#topC").toggleClass(" glyphicon-triangle-bottom");
            });
            $(".toggle-btn").click(function() {
                $("#leftMeun").toggleClass("show");
                $("#rightContent").toggleClass("pd0px");
            })
        })
    </script>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/common.css">
    <link rel="stylesheet" type="text/css" href="css/slide.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/flat-ui.min.css">
    <link rel="stylesheet" type="text/css" href="css/jquery.nouislider.css">
</head>

<body>
<div id="wrap">
    <!-- 左侧菜单栏目块 -->
    <div class="leftMeun" id="leftMeun">
        <div id="logoDiv">
            <p>图书管理系统管理员页</p>
        </div>
        <div id="personInfor">
            <p>一川芳杰</p>
            <p>
                <a <s:action name="BorrowerLogOut"/>>退出登录</a>
            </p>
        </div>
        <div class="meun-title">用户管理</div>
        <div class="meun-item" href="#user" aria-controls="user" role="tab" data-toggle="tab"><img src="images/icon_card_grey.png">用户管理</div>
        <div class="meun-item" href="#chan" aria-controls="chan" role="tab" data-toggle="tab"><img src="images/icon_change_grey.png">修改密码</div>
        <div class="meun-title">图书管理</div>
        <div class="meun-item" href="#scho" aria-controls="scho" role="tab" data-toggle="tab"><img src="images/icon_source.png">图书管理</div>
        <div class="meun-item" href="#regu" aria-controls="regu" role="tab" data-toggle="tab"><img src="images/icon_user_grey.png">借阅记录管理</div>
    </div>
    <!-- 右侧具体内容栏目 -->
    <div id="rightContent">
        <a class="toggle-btn" id="nimei">
            <i class="glyphicon glyphicon-align-justify"></i>
        </a>
        <!-- Tab panes -->
        <div class="tab-content">
            <!--用户管理模块-->
            <div role="tabpanel" class="tab-pane" id="user">
                <div class="check-div form-inline">
                    <div class="col-xs-3">
                        <button class="btn btn-yellow btn-xs" data-toggle="modal" data-target="#addUser">添加用户 </button>
                    </div>
                    <div class="col-xs-4">
                        <input type="text" class="form-control input-sm" placeholder="输入文字搜索">
                        <button class="btn btn-white btn-xs ">查 询 </button>
                    </div>
                </div>
                <div class="data-div">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th class="text-center">
                                学号
                            </th>
                            <th class="text-center">
                                用户名

                            </th>
                            <th class="text-center">
                                密码

                            </th>
                            <th class="text-center">
                                身份
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <s:iterator value="%{userInformation}" var="ui" status="status" >
                        <tr class="default">
                            <td width="10% " class="text-center">
                                <s:property value="#ui.id"/>
                            </td>
                            <td width="20%" class="text-center">
                                <s:property value="#ui.name"/>
                            </td>
                            <td width="20%" class="text-center">
                                <s:property value="#ui.password"/>
                            </td>
                            <td width="20%" class="text-center">
                                <s:property value="#ui.type"/>
                            </td>
                            <td width="5%" class="text-center">
                                <button class="btn btn-success btn-xs" data-toggle="modal" data-target="#reviseUser-<s:property value="#ui.id"/>">修改</button>
                            </td>
                            <td width="5% " class="text-center">
                                <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#deleteUser-<s:property value="#ui.id"/>">删除</button>
                            </td>
                        </tr>
                        </s:iterator>
                        </tbody>
                        </table>
                    </div>

                <!--页码块-->
                <footer class="footer">
                    <ul class="pagination">
                        <li>
                            <select>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                                <option>6</option>
                                <option>7</option>
                                <option>8</option>
                                <option>9</option>
                                <option>10</option>
                            </select>
                            页
                        </li>
                        <li class="gray">
                            共20页
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-menu-left">
                            </i>
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-menu-right">
                            </i>
                        </li>
                    </ul>
                </footer>
                <!--弹出添加用户窗口-->
                    <div class="modal fade" id="addUser" role="dialog" aria-labelledby="gridSystemModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gridSystemModalLabel">添加用户</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        <form class="form-horizontal" action="AdminAddUser" method="post">
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">学号：</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" class="form-control input-sm duiqi"  name="userid" placeholder="">
                                                </div>
                                            </div>
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">用户名：</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" class="form-control input-sm duiqi"  name="username" placeholder="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">密码：</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" class="form-control input-sm duiqi" name="password" placeholder="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">身份：</label>
                                                <div class="col-xs-8">
                                                    <select name="type" class=" form-control select-duiqi">
                                                        <option selected="selected" value="FACULTY" >教职工</option>
                                                        <option value="STUDENT">学生</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group text-right">
                                            <div class="col-xs-offset-4 col-xs-5" style="margin-left: 169px;">
                                                <input type="submit" value="提交"/>
                                                <input type="reset" value="清空"/>
                                            </div>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- /.modal -->


                <!--弹出修改用户窗口-->
                <s:iterator value="%{userInformation}" var="ui" status="status" >
                    <div class="modal fade" id="reviseUser-<s:property value="#ui.id"/>" role="dialog" aria-labelledby="gridSystemModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gridSystemModalLabel">修改用户</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        <form class="form-horizontal" <s:action name="AdminUpdateUser"/>>
                                            <input type="hidden" name="userid" value="<s:property value="#ui.id"/> " />
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">用户名：</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" name="username" class="form-control input-sm duiqi" placeholder="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">密码</label>
                                                <div class="col-xs-8 ">
                                                    <input type="password" name="password" class="form-control input-sm duiqi" placeholder="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">身份：</label>
                                                <div class="col-xs-8">
                                                    <select name="type" class=" form-control select-duiqi">
                                                        <option value="">TEACHER</option>
                                                        <option value="">STUDENT</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group text-right">
                                                <div class="col-xs-offset-4 col-xs-5" style="margin-left: 169px;">
                                                    <button type="submit" class="btn btn-xs btn-green">保存</button>
                                                    <button type="reset" class="btn btn-xs btn-white">取消</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- /.modal -->
                </s:iterator>

                <!--弹出删除用户警告窗口-->
                <s:iterator value="%{userInformation}" var="ui" status="status" >
                    <div class="modal fade" id="deleteUser-<s:property value="#ui.id"/>" role="dialog" aria-labelledby="gridSystemModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gridSystemModalLabel">提示</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        确定要删除该用户？删除后不可恢复！
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
                                    <a type="button" class="btn  btn-xs btn-danger" href="<s:url value="RemoveUser"/>?userid=<s:property value="#ui.id"/> ">确认删除</a>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- /.modal -->
                </s:iterator>

            </div>
            <!-- 修改密码模块 -->
            <div role="tabpanel" class="tab-pane" id="chan">
                <div class="check-div">
                    原始密码为12312313
                </div>
                <div style="padding: 50px 0;margin-top: 50px;background-color: #fff; text-align: right;width: 420px;margin: 50px auto;">
                    <form class="form-horizontal" <s:action name="UpdateAdmin"/> >
                        <div class="form-group">
                            <label class="col-xs-4 control-label">原密码：</label>
                            <div class="col-xs-5">
                                <input type="password" class="form-control input-sm duiqi" name="password" placeholder="" style="margin-top: 7px;">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-4 control-label">新密码：</label>
                            <div class="col-xs-5">
                                <input type="password" class="form-control input-sm duiqi" name="newpassword" placeholder="" style="margin-top: 7px;">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-4 control-label">重复密码：</label>
                            <div class="col-xs-5">
                                <input type="password" class="form-control input-sm duiqi" placeholder="" style="margin-top: 7px;">
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <div class="col-xs-offset-4 col-xs-5" style="margin-left: 169px;">
                                <button type="submit" class="btn btn-xs btn-green">保存</button>
                                <button type="reset" class="btn btn-xs btn-white">取消</button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>














            <!--图书管理模块-->
            <div role="tabpanel" class="tab-pane" id="scho">

                <div class="check-div form-inline">
                    <div class="col-xs-3">
                        <button class="btn btn-yellow btn-xs" data-toggle="modal" data-target="#addBook">添加图书 </button>
                    </div>
                    <div class="col-lg-4 col-xs-5">
                        <input type="text" class=" form-control input-sm " placeholder="输入文字搜索">
                        <button class="btn btn-white btn-xs ">查 询 </button>
                    </div>
                    <div class="col-lg-3 col-lg-offset-1 col-xs-3" style="padding-right: 40px;text-align: right;float: right;">
                        <label>排序:&nbsp;</label>
                        <select class="form-control">
                            <option>地区</option>
                            <option>排名</option>
                        </select>
                    </div>
                </div>
                <div class="data-div">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th class="text-center">
                                ISBN
                            </th>
                            <th class="text-center">
                                名称
                            </th>
                            <th class="text-center">
                                作者
                            </th>
                            <th class="text-center">
                                价格
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <s:iterator value="%{bookInformation}" var="book" status="status">
                            <tr class="default">
                                <td width="10% " class="text-center">
                                    <s:property value="#book.isbn"/>
                                </td>
                                <td width="20%" class="text-center">
                                    <s:property value="#book.name"/>
                                </td>
                                <td width="20%" class="text-center">
                                    <s:property value="#book.author"/>
                                </td>
                                <td width="20%" class="text-center">
                                    <s:property value="#book.price"/>
                                </td>
                                <td width="5%" class="text-center">
                                    <button class="btn btn-success btn-xs" data-toggle="modal" data-target="#reviseBook-<s:property value="#book.isbn"/> ">修改</button>
                                </td>
                                <td width="5% " class="text-center">
                                    <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#deleteBook-<s:property value="#book.isbn"/> ">删除</button>
                                </td>
                            </tr>
                        </s:iterator>
                        </tbody>
                    </table>
                </div>
                <!--页码块-->
                <footer class="footer">
                    <ul class="pagination">
                        <li>
                            <select>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                                <option>6</option>
                                <option>7</option>
                                <option>8</option>
                                <option>9</option>
                                <option>10</option>
                            </select>
                            页
                        </li>
                        <li class="gray">.
                            共20页
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-menu-left">
                            </i>
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-menu-right">
                            </i>
                        </li>
                    </ul>
                </footer>

                <!--弹出添加图书窗口-->
                <div class="modal fade" id="addBook" role="dialog" aria-labelledby="gridSystemModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="gridSystemModalLabelincrease">添加图书</h4>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    <form class="form-horizontal" <s:action name="AddBook"/> >
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">ISBN：</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="id" class="form-control input-sm duiqi" placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">图书名称：</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" class="form-control input-sm duiqi" name="bookname" placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">作者</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="author" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">类型</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="type" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">简介</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="summary" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">价格</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="price" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label  class="col-xs-3 control-label">数量</label>
                                            <div class="col-xs-8">
                                                <input type="text" name="number" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-xs btn-green">保存</button>
                                            <button type="reset" class="btn btn-xs btn-white">取消</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->


                <!--弹出修改图书窗口-->
                <s:iterator value="%{bookInformation}" status="status" var="book">
                <div class="modal fade" id="reviseBook-<s:property value="#book.isbn"/>" role="dialog" aria-labelledby="gridSystemModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="gridSystemModalLabelalter">修改图书信息</h4>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    <form class="form-horizontal" <s:action name="UpdateBook"/> method="post">
                                        <input type="hidden" name="bookid" value="<s:property value="#book.isbn"/> ">
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">图书名称：</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" class="form-control input-sm duiqi" name="bookname" placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">作者</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="author" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">出版日期</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="date" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">类型</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="type" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">简介</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="summary" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label  class="col-xs-3 control-label">价格</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="price" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label  class="col-xs-3 control-label">数量</label>
                                            <div class="col-xs-8">
                                                <input type="text" name="number" class="form-control input-sm duiqi"  placeholder="">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-xs btn-green">保存</button>
                                            <button type="reset" class="btn btn-xs btn-white">取消</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
                </s:iterator>
                <!--弹出删除图书警告窗口-->
                <s:iterator value="%{bookInformation}" status="status" var="book">
                <div class="modal fade" id="deleteBook-<s:property value="#book.isbn"/>" role="dialog" aria-labelledby="gridSystemModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="gridSystemModalLabeldelete">提示</h4>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    确定要删除该地区？删除后不可恢复！
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
                                <a type="button" class="btn  btn-xs btn-danger" href="<s:url value="RemoveBookRrofil"/>?bookid=<s:property value="#book.isbn"/> ">确认删除</a>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                    <!-- /.modal -->
                </s:iterator>

            </div>
            <!--借阅记录管理模块-->
            <div role="tabpanel" class="tab-pane" id="regu">
                <div class="data-div">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th class="text-center">
                                记录编号
                            </th>
                            <th class="text-center">
                                读者号
                            </th>
                            <th class="text-center">
                                图书号
                            </th>
                            <th class="text-center">
                                借书时间
                            </th>
                            <th class="text-center">
                                截止时间
                            </th>
                            <th class="text-center">
                                还书时间
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <s:iterator value="%{recordInformation}" var="record" status="status">
                            <tr class="default">
                                <td width="10% " class="text-center">
                                    <s:property value="#record.id"/>
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.borrower_id"/>
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.target_id"/>
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.since"/>
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.deadline"/>
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.until"/>
                                </td>
                                <td width="5% " class="text-center">
                                    <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#deleteRecord-<s:property value="#record.id"/> ">删除</button>
                                </td>
                            </tr>
                        </s:iterator>
                        </tbody>
                    </table>
                    </div>

                </div>
                <!--页码块-->
                <footer class="footer">
                    <ul class="pagination">
                        <li>
                            <select>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                                <option>6</option>
                                <option>7</option>
                                <option>8</option>
                                <option>9</option>
                                <option>10</option>
                            </select>
                            页
                        </li>
                        <li class="gray">
                            共20页
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-menu-left">
                            </i>
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-menu-right">
                            </i>
                        </li>
                    </ul>
                </footer>



                <!--弹出删除记录警告窗口-->
            <s:iterator value="recordInformation" var="record" status="status">
                <div class="modal fade" id="deleteRecord-<s:property value="#record.id"/> " role="dialog" aria-labelledby="gridSystemModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="gridSystemModalLabeldeleterecord">提示</h4>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    确定要删除该记录？删除后不可恢复！
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a type="button" class="btn  btn-xs btn-danger" href="<s:url value="RemoveRecord"/>?recordid=<s:property value="#record.id"/> ">确认删除</a>
                                <%--removerecord没有实现--%>
                                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
            </s:iterator>
            </div>
            </div>
        </div>
    </div>




<script src="js/jquery.nouislider.js"></script>


<script>
    //min/max slider
    function huadong(my, unit, def, max) {
        $(my).noUiSlider({
            range: [0, max],
            start: [def],
            handles: 1,
            connect: 'upper',
            slide: function() {
                var val = Math.floor($(this).val());
                $(this).find(".noUi-handle").text(
                    val + unit
                );
                console.log($(this).find(".noUi-handle").parent().parent().html());
            },
            set: function() {
                var val = Math.floor($(this).val());
                $(this).find(".noUi-handle").text(
                    val + unit
                );
            }
        });
        $(my).val(def, true);
    }
    huadong('.slider-minmax1', "分钟", "5", 30);
    huadong('.slider-minmax2', "分钟", "6", 15);
    huadong('.slider-minmax3', "分钟", "10", 60);
    huadong('.slider-minmax4', "次", "2", 10);
    huadong('.slider-minmax5', "天", "3", 7);
    huadong('.slider-minmax6', "天", "8", 10);
</script>


</body>
</html>
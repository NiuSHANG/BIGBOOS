<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ch">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <title>图书管理系统</title>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/popup.js"></script>
    <script>
        <s:if test="%{message != null}">addEventListener('load', () => initPopup('<s:property value="message"/>'));</s:if>
    </script>
    <script>
        {
            let tabSwitches = {};
            let tabPanels = {};

            function switchToTab(tabName) {
                for (let key in tabSwitches) {
                    if (!tabSwitches.hasOwnProperty(key)) continue;

                    let value = tabSwitches[key];
                    if (value.classList.contains(tabName)) {
                        for (let img of tabSwitches[key].getElementsByTagName('img'))
                            img.src = img.src.replace('_grey.png', '.png');
                        value.classList.add('nav-switch-active');
                    } else {
                        for (let img of tabSwitches[key].getElementsByTagName('img'))
                            img.src = img.src.replace('_grey.png', '.png').replace('.png', '_grey.png');
                        value.classList.remove('nav-switch-active');
                    }
                }

                for (let key in tabPanels) {
                    if (!tabPanels.hasOwnProperty(key)) continue;
                    let value = tabPanels[key];
                    value.classList[value.classList.contains(tabName) ? 'add' : 'remove']('active');
                }

                if (location.hash !== '#' + tabName) {
                    location.hash = '#' + tabName;
                }
            }

            addEventListener('load', () => {
                for (let dom of document.getElementsByClassName('nav-switch')) {
                    dom.classList.forEach(className => {
                        if (className.startsWith('mode-')) {
                            tabSwitches[className] = dom;
                            dom.addEventListener('click', () => switchToTab(className));
                        }
                    });
                }

                for (let dom of document.getElementsByClassName('nav-panel')) {
                    dom.classList.forEach(className => {
                        if (className.startsWith('mode-'))
                            tabPanels[className] = dom;
                    });
                }

                if (location.hash && location.hash.startsWith('#mode-'))
                    switchToTab(location.hash.substring(1));
            });

            addEventListener('hashchange', () => {
                if (location.hash.startsWith('#mode-'))
                    switchToTab(location.hash.substring(1));
            });
        }
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
            <a href="AdminRegister.jsp">一川芳杰</a>
            <p>
                <a href="<s:url action="BorrowerLogOut"/>">退出登录</a>
            </p>
        </div>
        <div class="nav-group">用户管理</div>
        <div class="nav-switch mode-user">
            <img src="images/icon_card_grey.png">用户管理
        </div>
        <div class="nav-switch mode-pwd">
            <img src="images/icon_change_grey.png">修改密码
        </div>
        <div class="nav-group">图书管理</div>
        <div class="nav-switch mode-book">
            <img src="images/icon_source.png">图书管理
        </div>
        <div class="nav-switch mode-record">
            <img src="images/icon_user_grey.png">借阅记录管理
        </div>
    </div>
    <!-- 右侧具体内容栏目 -->
    <div id="rightContent">
        <div class="col-md-12 column">
            <div class="row clearfix">
                <div class="col-md-2 column">
                </div>
                <div class="col-md-6 column">
                    <s:actionmessage />
                    <s:actionerror />
                </div>
                <div class="col-md-4 column">
                </div>
            </div>
        </div>
        <!-- Tab panes -->
        <div class="tab-content">
            <!--用户管理模块-->
            <div role="tabpanel" class="nav-panel mode-user tab-pane" id="user">
                <div class="check-div form-inline">
                    <div class="col-xs-3">
                        <button class="btn btn-yellow btn-xs" data-toggle="modal" data-target="#addUser">添加用户</button>
                    </div>
                    <div class="col-xs-4">
                        <input type="text" class="form-control input-sm" placeholder="输入文字搜索">
                        <button class="btn btn-white btn-xs ">查 询</button>
                    </div>
                </div>
                <div class="data-div">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th class="text-center">学号</th>
                            <th class="text-center">用户名</th>
                            <th class="text-center">密码</th>
                            <th class="text-center">身份</th>
                        </tr>
                        </thead>
                        <tbody>
                        <s:iterator value="%{userInformation}" var="ui" status="status">
                            <tr class="default">
                                <td width="10%" class="text-center">
                                    <s:property value="#ui.id" />
                                </td>
                                <td width="20%" class="text-center">
                                    <s:property value="#ui.name" />
                                </td>
                                <td width="20%" class="text-center">
                                    <s:property value="#ui.password" />
                                </td>
                                <td width="20%" class="text-center">
                                    <s:property value="%{#ui.type.toString() == 'FACULTY' ? '教职工' : '学生'}" />
                                </td>
                                <td width="5%" class="text-center">
                                    <button class="btn btn-success btn-xs" data-toggle="modal"
                                            data-target="#reviseUser-<s:property value="#ui.id"/>">修改
                                    </button>
                                </td>
                                <td width="5%" class="text-center">
                                    <button class="btn btn-danger btn-xs" data-toggle="modal"
                                            data-target="#deleteUser-<s:property value="#ui.id"/>">删除
                                    </button>
                                </td>
                            </tr>
                        </s:iterator>
                        </tbody>
                    </table>
                </div>

                <!--弹出添加用户窗口-->
                <div class="modal fade" id="addUser" role="dialog" aria-labelledby="gridSystemModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">×</span></button>
                                <h4 class="modal-title">添加用户</h4>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    <form class="form-horizontal" action="<s:url value="AdminAddUser" />" method="post">
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">学号：</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" class="form-control input-sm duiqi" name="userId"
                                                       placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">用户名：</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" class="form-control input-sm duiqi" name="userName"
                                                       placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-3 control-label">密码：</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" class="form-control input-sm duiqi" name="password"
                                                       placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-3 control-label">身份：</label>
                                            <div class="col-xs-8">
                                                <select name="userType" class=" form-control select-duiqi">
                                                    <option selected="selected" value="FACULTY">教职工</option>
                                                    <option value="STUDENT">学生</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group text-right">
                                            <div class="col-xs-offset-4 col-xs-5" style="margin-left: 169px;">
                                                <input type="submit" value="提交" />
                                                <input type="reset" value="清空" />
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
                <s:iterator value="%{userInformation}" var="ui" status="status">
                    <div class="modal fade" id="reviseUser-<s:property value="#ui.id"/>" role="dialog"
                         aria-labelledby="gridSystemModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">×</span></button>
                                    <h4 class="modal-title">修改用户</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        <form class="form-horizontal" action="<s:url action="AdminUpdateUser" />">
                                            <input type="hidden" name="userId" value="<s:property value="#ui.id"/>" />
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">用户名：</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" name="username"
                                                           class="form-control input-sm duiqi"
                                                           value="<s:property value="%{#ui.name}"/>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">密码</label>
                                                <div class="col-xs-8 ">
                                                    <input type="password" name="password"
                                                           class="form-control input-sm duiqi"
                                                           value="<s:property value="%{#ui.password}"/>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">身份：</label>
                                                <div class="col-xs-8">
                                                    <select name="userType" class="form-control select-duiqi">
                                                        <option value="FACULTY"
                                                                <s:if test="%{#ui.type.toString() == 'FACULTY'}">selected</s:if>>
                                                            教职工
                                                        </option>
                                                        <option value="STUDENT"
                                                                <s:if test="%{#ui.type.toString() == 'STUDENT'}">selected</s:if>>
                                                            学生
                                                        </option>
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
                <s:iterator value="%{userInformation}" var="ui" status="status">
                    <div class="modal fade" id="deleteUser-<s:property value="#ui.id"/>" role="dialog"
                         aria-labelledby="gridSystemModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gridSystemModalLabel">提示</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        确定要删除该用户？删除后不可恢复！
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
                                    <a type="button" class="btn  btn-xs btn-danger"
                                       href="<s:url value="RemoveUser"/>?userId=<s:property value="#ui.id"/>">确认删除</a>
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
            <div role="tabpanel" class="nav-panel mode-pwd tab-pane" id="chan">
                <div class="check-div">
                    原始密码为12312313
                </div>
                <div style="padding: 50px 0;margin-top: 50px;background-color: #fff; text-align: right;width: 420px;margin: 50px auto;">
                    <form class="form-horizontal" action="<s:url action="UpdateAdmin" />">
                        <div class="form-group">
                            <label class="col-xs-4 control-label">原密码：</label>
                            <div class="col-xs-5">
                                <input type="password" class="form-control input-sm duiqi" name="password"
                                       placeholder="" style="margin-top: 7px;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-4 control-label">新密码：</label>
                            <div class="col-xs-5">
                                <input type="password" class="form-control input-sm duiqi" name="newPassword"
                                       placeholder="" style="margin-top: 7px;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-4 control-label">重复密码：</label>
                            <div class="col-xs-5">
                                <input type="password" name="rePassword" class="form-control input-sm duiqi"
                                       placeholder="" style="margin-top: 7px;" />
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
            <div role="tabpanel" class="nav-panel mode-book tab-pane" id="scho">
                <div class="check-div form-inline">
                    <div class="col-xs-3">
                        <button class="btn btn-yellow btn-xs" data-toggle="modal" data-target="#addBook">添加图书</button>
                    </div>
                    <div class="col-lg-4 col-xs-5">
                        <input type="text" class=" form-control input-sm " placeholder="输入文字搜索" />
                        <button class="btn btn-white btn-xs ">查 询</button>
                    </div>
                    <div class="col-lg-3 col-lg-offset-1 col-xs-3"
                         style="padding-right: 40px;text-align: right;float: right;">
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
                            <th class="text-center">ISBN</th>
                            <th class="text-center">名称</th>
                            <th class="text-center">作者</th>
                            <th class="text-center">价格</th>
                            <th class="text-center">库存总量</th>
                            <th class="text-center">已借出</th>
                            <th class="text-center">剩余</th>
                        </tr>
                        </thead>
                        <tbody class="text-center">
                        <s:iterator value="%{bookInformation}" var="book" status="status">
                            <tr class="default">
                                <td width="10%">
                                    <s:property value="#book.isbn" />
                                </td>
                                <td width="20%">
                                    <s:property value="#book.name" />
                                </td>
                                <td width="10%">
                                    <s:property value="#book.author" />
                                </td>
                                <td width="10%">
                                    <s:property value="#book.price" />
                                </td>
                                <td width="5%">
                                    <s:property value="#book.copies.size()" />
                                </td>
                                <td width="5%">
                                    <s:property value="%{unavailableProfilesOfIsbn[#book.isbn].size()}" />
                                </td>
                                <td width="5%">
                                    <s:property value="%{availableProfilesOfIsbn[#book.isbn].size()}" />
                                </td>
                                <td width="10%">
                                    <button class="btn btn-success btn-xs" data-toggle="modal"
                                            data-target="#manageStock-<s:property value="#book.isbn"/> ">编辑库存
                                    </button>
                                    <button class="btn btn-success btn-xs" data-toggle="modal"
                                            data-target="#reviseBook-<s:property value="#book.isbn"/> ">修改
                                    </button>
                                    <button class="btn btn-danger btn-xs" data-toggle="modal"
                                            data-target="#deleteBook-<s:property value="#book.isbn"/> ">删除
                                    </button>
                                </td>
                            </tr>
                        </s:iterator>
                        </tbody>
                    </table>
                </div>


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
                                    <form class="form-horizontal" action="<s:url action="AddBook" />" method="post" enctype="multipart/form-data">
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">ISBN：</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="id" class="form-control input-sm duiqi" placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">图书名称：</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="bookName" class="form-control input-sm duiqi" placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-3 control-label">封面图片</label>
                                            <div class="col-xs-8">
                                                <input type="file" name="img" />
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">作者</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="author" class="form-control input-sm duiqi"
                                                       placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">类型</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="type" class="form-control input-sm duiqi"
                                                       placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">简介</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="summary" class="form-control input-sm duiqi"
                                                       placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group ">
                                            <label class="col-xs-3 control-label">价格</label>
                                            <div class="col-xs-8 ">
                                                <input type="text" name="price" class="form-control input-sm duiqi"
                                                       placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-3 control-label">数量</label>
                                            <div class="col-xs-8">
                                                <input type="text" name="number" class="form-control input-sm duiqi"
                                                       placeholder="">
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
                    <div class="modal fade" id="reviseBook-<s:property value="#book.isbn"/>" role="dialog"
                         aria-labelledby="gridSystemModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gridSystemModalLabelalter">修改图书信息</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        <form class="form-horizontal" action="<s:url action="UpdateBook" />"
                                              method="post" enctype="multipart/form-data">
                                            <input type="hidden" name="bookId" value="<s:property value="#book.isbn"/>">
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">ISBN：</label>
                                                <div class="col-xs-8 ">
                                                    <s:property value="#book.isbn" />
                                                </div>
                                            </div>
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">图书名称：</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" name="bookName"
                                                           class="form-control input-sm duiqi"
                                                           value="<s:property value="#book.name"/>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">封面图片</label>
                                                <div class="col-xs-8">
                                                    <input type="file" name="img" />
                                                </div>
                                            </div>
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">作者</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" name="author" class="form-control input-sm duiqi"
                                                           value="<s:property value="#book.author"/>">
                                                </div>
                                            </div>
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">出版日期</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" name="issueOn"
                                                           class="form-control input-sm duiqi"
                                                           value="<s:property value="#book.issueOn"/>">
                                                </div>
                                            </div>
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">类型</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" name="type" class="form-control input-sm duiqi"
                                                           value="<s:property value="#book.type"/>">
                                                </div>
                                            </div>
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">简介</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" name="summary"
                                                           class="form-control input-sm duiqi"
                                                           value="<s:property value="#book.summary"/>">
                                                </div>
                                            </div>
                                            <div class="form-group ">
                                                <label class="col-xs-3 control-label">价格</label>
                                                <div class="col-xs-8 ">
                                                    <input type="text" name="price" class="form-control input-sm duiqi"
                                                           value="<s:property value="#book.price"/>">
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
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gridSystemModalLabeldelete">提示</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        确定要删除？删除后不可恢复！
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
                                    <a type="button" class="btn  btn-xs btn-danger"
                                       href="<s:url value="RemoveBookProfile"/>?bookId=<s:property value="#book.isbn"/>#scho">确认删除</a>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- /.modal -->
                </s:iterator>
                <!--编辑库存窗口-->
                <s:iterator value="%{bookInformation}" status="status" var="book">
                    <div class="modal fade" id="manageStock-<s:property value="#book.isbn"/>" role="dialog"
                         aria-labelledby="gridSystemModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">

                                <form class="form-horizontal" action="<s:url action="ManageStock" />" method="post">
                                    <input type="hidden" value="<s:property value="%{#book.isbn}" />" name="isbn" />
                                    <div class="form-group ">
                                        <label class="col-xs-3 control-label">添加图书数量：</label>
                                        <div class="col-xs-8 ">
                                            <input type="text" name="addCopies" />
                                        </div>
                                    </div>
                                    <div class="form-group ">
                                        <label class="col-xs-3 control-label">减少图书数量：</label>
                                        <div class="col-xs-8 ">
                                            <input type="text" name="subCopies"
                                                   placeholder="剩余 <s:property value="availableProfilesOfIsbn[#book.isbn].size()"/> 本" />
                                        </div>
                                    </div>
                                    <div class="form-group ">
                                        <div class="col-xs-8 ">
                                            <input type="submit" value="修改" />
                                            <input type="reset" value="重填" />
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- /.modal -->
                </s:iterator>

            </div>
            <!--借阅记录管理模块-->
            <div role="tabpanel" class="nav-panel mode-record tab-pane" id="regu">
                <div class="data-div">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th class="text-center">
                                记录编号
                            </th>
                            <th class="text-center">
                                读者名
                            </th>
                            <th class="text-center">
                                图书名
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
                                    <s:property value="#record.id" />
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.borrower.name" />
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.target.profile.name" />
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.since" />
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.deadline" />
                                </td>
                                <td width="15%" class="text-center">
                                    <s:property value="#record.until" />
                                </td>
                                <td width="5% " class="text-center">
                                    <button class="btn btn-danger btn-xs" data-toggle="modal"
                                            data-target="#deleteRecord-<s:property value="#record.id"/> ">删除
                                    </button>
                                </td>
                            </tr>
                        </s:iterator>
                        </tbody>
                    </table>
                </div>
            </div>

            <!--弹出删除记录警告窗口-->
            <%--            <s:iterator value="recordInformation" var="record" status="status">--%>
            <%--                <div class="modal fade" id="deleteRecord-<s:property value="#record.id"/> " role="dialog" aria-labelledby="gridSystemModalLabel">--%>
            <%--                    <div class="modal-dialog" role="document">--%>
            <%--                        <div class="modal-content">--%>
            <%--                            <div class="modal-header">--%>
            <%--                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>--%>
            <%--                                <h4 class="modal-title" id="gridSystemModalLabeldeleterecord">提示</h4>--%>
            <%--                            </div>--%>
            <%--                            <div class="modal-body">--%>
            <%--                                <div class="container-fluid">--%>
            <%--                                    确定要删除该记录？删除后不可恢复！--%>
            <%--                                </div>--%>
            <%--                            </div>--%>
            <%--                            <div class="modal-footer">--%>
            <%--                                <a type="button" class="btn  btn-xs btn-danger" href="<s:url value="RemoveRecord"/>?recordid=<s:property value="#record.id"/>#">确认删除</a>--%>
            <%--                                &lt;%&ndash;removerecord没有实现&ndash;%&gt;--%>
            <%--                                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>--%>
            <%--                            </div>--%>
            <%--                        </div>--%>
            <%--                        <!-- /.modal-content -->--%>
            <%--                    </div>--%>
            <%--                    <!-- /.modal-dialog -->--%>
            <%--                </div>--%>
            <%--                <!-- /.modal -->--%>
            <%--            </s:iterator>--%>
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
            slide: function () {
                var val = Math.floor($(this).val());
                $(this).find(".noUi-handle").text(
                    val + unit
                );
                console.log($(this).find(".noUi-handle").parent().parent().html());
            },
            set: function () {
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
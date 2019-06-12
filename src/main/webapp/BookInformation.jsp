<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>书籍详情</title>
    <link rel="stylesheet" href="css/button(1).css">
    <link rel="shortcut icon" href="https://b.yzcdn.cn/v2/image/yz_fc.ico" />
    <link rel="stylesheet" href="https://b.yzcdn.cn/v2/build_css/stylesheets/www/pages/pc/detail_777100baa3.css" onerror="_cdnFallback(this)" media="screen">  <script>
    var _global = {"kdt_id":19299658,"user_id":0,"run_mode":"online","debug":false,"project":"default","online_debug":false,"js":{"js_compress":true,"css_compress":true,"use_js_cdn":true,"use_css_cdn":true,"message_report":true,"checkbrowser":true,"hide_wx_nav":true,"qn_public":"kdt_img","qn_private":"kdt-private"},"query_path":"\/show\/goods","query_key":"alias=26z37xjj0gq7u","real_query_path":"get:\/show\/goods\/index.html","module":"show","controller":"Show_Goods_Controller","action":"index","full_action":"getIndexHtml","method":"get","format":"html","mp_changed":false,"is_owner_team":false,"team_certificate":true,"hide_shopping_cart":0,"wxpay_env":true,"wxaddress_env":true,"alipay_env":false,"fans_id":null,"is_fans":null,"mp_id":0,"mp_data":[],"is_mobile":false,"spm":{"logType":"pcg","logId":349415925},"url":{"base":"\/\/www.youzan.com","bbs":"http:\/\/bbs.youzan.com","cdn":"\/\/b.yzcdn.cn","cdn_static":"https:\/\/b.yzcdn.cn\/v2","daxue":"http:\/\/xuetang.youzan.com","fenxiao":"\/\/fx.youzan.com","fuwu":"https:\/\/fuwu.youzan.com","img":"\/\/img.youzan.com","imgqn":"https:\/\/img.yzcdn.cn","login":"\/\/login.youzan.com","open":"\/\/open.youzan.com","static":"https:\/\/static.youzan.com\/v2","trade":"https:\/\/trade.koudaitong.com","trade_youzan":"https:\/\/trade.youzan.com","v1":"https:\/\/www.youzan.com\/v1","v1_static":"\/\/b.yzcdn.cn\/v1","v2":"\/\/www.youzan.com\/v2","wap":"https:\/\/h5.youzan.com\/v2","ws":"ws:\/\/s.im.youzan.com:83","www":"\/\/www.youzan.com\/v2","youzan":"\/\/www.youzan.com","cloud":"https:\/\/dl.yzcdn.cn","pf":"https:\/\/pifa.youzan.com","uic":"https:\/\/uic.youzan.com","store":"\/\/store.youzan.com","market":"https:\/\/pfmarket.youzan.com","im":"https:\/\/b-im.youzan.com","help":"\/\/help.youzan.com","materials":"\/\/materials.youzan.com"}};  </script>
</head>
<body>
<div class="header" style="background-color: #0a4551">
    <div class="container">

        <a href="AdminLogIn.jsp" class="js-hover logo" style="font-size:30px;font-family:楷体" data-target="js-shop-info">
            一川芳杰
            <span class="smaller-title"></span>
        </a>
        <ul class="nav" style="font-size:25px;float:right;font-family:楷体" >
            <li class="separate">|</li>



            <li>
                <a href="<s:url value="Main"/>">
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
    </div>


</div>

<div class="shop-info shop-info-fixed js-shop-info">
    <div class="container clearfix" style="height: 100px;">
        <div class="js-async shop-qrcode pull-left" data-url="https://detail.youzan.com/show/goods/teamurl.json"></div>
        <div class="shop-desc pull-left" style="margin-left: 50px;font-family:楷体">
            <dl>
                <dt>
                    他说的“让她三分”，不是“三分流水七分尘”的“三分”，是“天下只有三分月色”的“三分”
                </dt>
                <dt></dt>
                <dt>                                                                          ——《围城》</dt>
            </dl>
        </div>
        <span class="arrow"></span>
    </div>
</div>
</div>
<div class="container main clearfix">
    <div class="content"   >
        <!-- 商品简介 -->
        <div class="goods-summary clearfix">
            <!-- 商品信息 -->
            <div class="goods-info pull-right">
                <h3 class="goods-title">书号：<s:property value="%{bookInfo.isbn}"/></h3>

                <div class="goods-price clearfix">
                    <strong class="goods-current-price pull-left"  style="color:#0971bc;font-family:楷体">四大名著<s:property value="%{bookInfo.name}"/> </strong>
                </div>

                <h3 class="goods-title">作者：<s:property value="%{bookInfo.author}"/></h3>
                <h3 class="goods-title">出版日期：<s:property value="%{bookInfo.issueOn}"/></h3>
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

                    <button class="button button-glow button-border button-rounded button-primary">借阅</button>
                    <button class="button button-glow button-border button-rounded button-primary">归还</button>
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
        <!-- 商品详情 -->
        <div class="goods-detail js-goods-detail">
            <h4 class="title">商品详情</h4>

            <div class="rich-text">
                <p><s:property value="%{bookInfo.summary}"/> </p>
            </div>

        </div>





        <script>
            // require common config
            var require = {
                waitSeconds: 200,
                paths: {
                    "underscore": "https://static.youzan.com/v2/vendor/underscore",
                    "jquery": "https://static.youzan.com/v2/vendor/jquery-1.10.2"
                },
                shim: {
                    "jquery": {
                        "exports": "$"
                    },
                    "underscore": {
                        "exports": "_"
                    }
                }
            }
        </script>

        <script src="https://b.yzcdn.cn/v2/vendor/require.js" onerror="_cdnFallback(this)" crossorigin="anonymous"></script>  <script src="https://b.yzcdn.cn/v2/build/www/global_fcc0e80bb7.js" onerror="_cdnFallback(this)" crossorigin="anonymous"></script>

        <script src="https://b.yzcdn.cn/v2/build/www/pages/detail_4bed05749c.js"></script>
        <script>
            var req = require.config({
                baseUrl: 'https://static.youzan.com/v2/www/pages/detail'
            });
            window.req = req
            req(['main'], function(App) {
                if (App && App.initialize && (Object.prototype.toString.call(App.initialize) == '[object Function]')) {
                    App.initialize();
                }
            });
        </script>
        <div style="display: none;">
            <script>
                var _hmt = _hmt || [];
                (function() {
                    var hm = document.createElement("script");
                    hm.src = "https://hm.baidu.com/hm.js?e0ce2859f2523fd8c9a649d8daf058dc";
                    var s = document.getElementsByTagName("script")[0];
                    s.parentNode.insertBefore(hm, s);
                })();
            </script>
        </div>
        <script>
            setTimeout(function() {
                var bp = document.createElement('script');
                var curProtocol = window.location.protocol.split(':')[0];
                if (curProtocol === 'https') {
                    bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
                } else {
                    bp.src = 'http://push.zhanzhang.baidu.com/push.js';
                }
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(bp, s);
            }, 2000);
        </script>
</body>
</html>
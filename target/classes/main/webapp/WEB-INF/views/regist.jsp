<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册界面</title>
    <script src='/static/login/js/prefixfree.min.js'></script>
    <link rel="stylesheet" href="/static/login/css/styles.css">
    <link rel="shortcut icon" href="/static/favicon.ico" />
</head>

<body>
<script>
    if('${msg}'=='1')
        alert("注册失败!!");
</script>
<div id="container">
    <div id="logo">
        <h1 class="hogo"><i> 笔记共享系统</i></h1>
    </div>
    <section class="stark-login">
        <form action="/login/regist" method="POST">
            <div id="fade-box">
                <input type="text" name="username" id="username" placeholder="Username" required>
                <input type="text" name="useremail" id="email" placeholder="E-mail" required>
                <input type="password" name="userpass" placeholder="Password" required>

                <button>Sign Out</button>

            </div>

        </form>
        <div class="hexagons">
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <br>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <br>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>

            <br>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <br>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
            <span>&#x2B22;</span>
        </div>
    </section>

    <div id="circle1">
        <div id="inner-cirlce1">
            <h2></h2>
        </div>
    </div>
    <ul>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>
<%--live2d--%>
<link rel="stylesheet" type="text/css" href="/static/live2d/waifu.css"/>
<script type="text/javascript" src="/static/js/jquery-2.1.1.min.js"></script>
<div class="waifu" id="waifu" style="bottom: 0; left:18px;  margin-left: auto; margin-right: auto;">
    <div class="waifu-tips" style="opacity: 1;"></div>
    <canvas id="live2d" width="350" height="312.500" class="live2d" style=""></canvas>
    <div class="waifu-tool" style="">
        <span class="fui-home"></span>
        <span class="fui-chat"></span>
        <span class="fui-eye"></span>
        <span class="fui-user"></span>
        <span class="fui-photo"></span>
        <span class="fui-info-circle"></span>
        <span class="fui-cross"></span>
    </div>
</div>
<script src="/static/live2d/live2d.js"></script>
<script src="/static/live2d/waifu-tips.js"></script>
<script type="text/javascript">
    window.onload = function(){
        preInit();
        initModel();
    }
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = location.search.substr(1).match(reg);
        if(r != null) return decodeURIComponent(r[2]);
        return null;
    }
    function preInit(){
        var dom = document.querySelector('#waifu');
        var canvas = document.querySelector('#live2d');
        var tips = document.querySelector('.waifu-tips');
        var tool = document.querySelector('.waifu-tool');
        var bottom = getQueryString('bottom') || 0;
        var right = getQueryString('right') || 18;
        if(bottom){
            dom.style.bottom = bottom+'px';
        }
        if(right){
            dom.style.left = right+'px';
        }
        var innerWidth = window.innerWidth;
        var innerHeight = window.innerHeight;
        if(innerHeight>1.2*innerWidth){
            dom.className = 'waifu mobile';
            dom.style.left = 0;
            dom.style.right = 0;
            dom.style.margin = 'auto 0';
            canvas.width = window.innerWidth-60;
            canvas.height = (window.innerWidth-60)*250/280;
            canvas.style.left = '30px';
            tool.style['transform-origin'] = '100% 0';
            tool.style['transform'] = 'scale(5)';
        } else {
            dom.style.left = 'auto';
            dom.style.left = right+'px';
        }
    }
</script>
<%--live2d--%>
</body>

</html>
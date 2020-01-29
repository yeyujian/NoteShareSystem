<%--
  Created by IntelliJ IDEA.
  User: 叶宇
  Date: 2019/12/12
  Time: 9:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="shortcut icon" href="/static/favicon.ico" />
</head>
<body>
index 界面
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心</title>
    <link rel="stylesheet" href="/static/personal/css/style.css">
    <link rel="stylesheet" href="/static/css/note.css"/>
    <script type="text/javascript" src="/static/ckeditor/ckeditor.js"></script>
    <link rel="shortcut icon" href="/static/favicon.ico"/>
</head>

<body>
<div class="htmleaf-container">
    <div class="htmleaf-content">

        <section class="main" id="main">
        </section>
    </div>
</div>
<!-- 文档 -->
<div id="note" style="display: none;">
    <div>
        <div class="grid top left"></div>
        <div class="grid top center">
            <div id="title"><img src="/static/Images/title.png"/></div>
        </div>
        <div class="grid top right"></div>
    </div>
    <div>
        <div class="grid middle left"></div>
        <div class="grid middle center">
            <div id="content"></div>
        </div>
        <div class="grid middle right"></div>
    </div>
    <div>
        <div class="grid bottom left"></div>
        <div class="grid bottom center">
            <img class="button" id="save" src="/static/Images/save.png"></img>
            <img class="button" id="discard" src="/static/Images/discard.png" style=""></img>
        </div>
        <div class="grid bottom right"></div>
    </div>
</div>
<script type="text/javascript" src="/static/js/note.js"></script>
<!-- 文档 -->
<script src="/static/personal/js/script.js"></script>
<script type="text/javascript" src="/static/js/jquery-2.1.1.min.js"></script>
<script>
    //去掉默认的contextmenu事件，否则会和右键事件同时出现。
    document.oncontextmenu = function (e) {
        e.preventDefault();
    };
    var elements = [];
    const $_ = e => document.querySelector(e);

    window.init = function () {
        $.ajax({
            //请求方式
            type: "GET",
            //请求的媒体类型
            contentType: "application/json;charset=UTF-8",
            //请求地址
            url: "/note/get",
            //数据，json字符串
            // data: JSON.stringify(list),
            //请求成功
            success: function (result) {
                // console.log(result);
                elements = result["data"];
                addData();
            },
            //请求失败，包含具体的错误信息
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
                alert("出现错误！！！！");
            }
        });
    }

    window.init();

    function addData() {


        var wrapsMain = document.getElementById('main');
        wrapsMain.innerHTML = "";
        for (var i = 0; i < elements.length; i += 3) {

            var element = document.createElement('div');
            element.className = 'wrap wrap--' + (i / 3 + 1).toString();
            var wrapChild = document.createElement('div');
            wrapChild.className = 'container containers';
            wrapChild.innerHTML = '<p>' + (i / 3 + 1).toString() + '. ' + elements[i] + '</p>';
            element.appendChild(wrapChild);
            wrapsMain.appendChild(element);
        }
        {
            var element = document.createElement('div');
            element.className = 'wrap wrap--' + (elements.length / 3 + 1).toString();
            var wrapChild = document.createElement('div');
            wrapChild.className = 'container containers';
            wrapChild.innerHTML = "<p style='color:rgba(10,10,10,0.4);'>点击添加新笔记</p>";
            wrapChild.style.background = 'linear-gradient(hsla(0, 0%, 100%, .1), hsla(0, 0%, 100%, .1))';
            wrapChild.onclick = function () {
                let note = document.getElementById('note');
                note.style.display = 'block';
                showNote();
                wrapsMain.style.display = 'none';
            }
            element.appendChild(wrapChild);
            wrapsMain.appendChild(element);
        }

        function getOnclockEvent(e) {
            var index = e ? e : 0;
            var note = document.getElementById('note');
            return function (event) {
                if (event.button == 2) {
                    // alert("你点了右键");
                    if (confirm("你确定删除吗？")) {
                        $.ajax({
                            url: "/note/delete?id=" + index,
                            data: null,
                            type: "GET",
                            // dataType: "json",
                            success: function (data) {
                                if (data == "success") {
                                    alert("删除成功!!!");
                                    window.init();
                                }else{
                                    alert("删除失败!!!");
                                }
                            },
                            error: function (data) {
                                console.log("error");

                                alert("删除失败!!!");
                            }
                        });
                    } else {

                    }


                } else if (event.button == 0) {
                    note.style.display = 'block';
                    showNote(index);
                    wrapsMain.style.display = 'none';
                } else if (event.button == 1) {
                    alert("你点了滚轮");
                }
            }
        }

        // console.log(elements);
        for (let i = 0; i < elements.length / 3; i++) {
            var wrap = $_('.wrap--' + (i + 1).toString());
            new parallaxTiltEffect({
                element: wrap,
                tiltEffect: 'reverse'
            });
            wrap.onmousedown = getOnclockEvent(elements[i * 3 + 2]);
            // wrap.onmousedown = function(e){
            //
            // }
        }
    }
</script>
<%--live2d--%>
<link rel="stylesheet" type="text/css" href="/static/live2d/waifu.css"/>
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
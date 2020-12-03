<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>时间线</title>
    <link rel="stylesheet" type="text/css" href="/static/timeline/css/bootstrap-grid.min.css"/>
    <link rel="shortcut icon" href="/static/favicon.ico"/>
    <style>
        .demo {
            padding: 25px 0;
        }

        .main-timeline {
            font-family: 'Roboto', sans-serif;
        }

        .main-timeline:after {
            content: '';
            display: block;
            clear: both;
        }

        .main-timeline:before {
            content: '';
            height: 100%;
            width: 2px;
            border: 2px dashed #000;
            transform: translateX(-50%);
            position: absolute;
            left: 50%;
            top: 30px;
        }

        .main-timeline .timeline {
            width: 50%;
            padding: 100px 70px 0 25px;
            margin: 0 50px 0 0;
            float: left;
            position: relative;
        }

        .main-timeline .timeline-content {
            padding: 15px 15px 15px 40px;
            border: 2px solid #00A79B;
            border-radius: 15px 0 15px 15px;
            display: block;
            position: relative;
        }

        .main-timeline .timeline-content:hover {
            text-decoration: none;
        }

        .main-timeline .timeline-content:after {
            content: '';
            background-color: #00A79B;
            height: 18px;
            width: 15px;
            position: absolute;
            right: -15px;
            top: -2px;
            clip-path: polygon(100% 0, 0 0, 0 100%);
        }

        .main-timeline .timeline-year {
            color: #fff;
            background-color: #00A79B;
            font-size: 15px;
            font-weight: 900;
            text-align: center;
            line-height: 98px;
            height: 100px;
            width: 100px;
            border-radius: 50%;
            position: absolute;
            right: -120px;
            top: -85px;
        }

        .main-timeline .timeline-year:after {
            content: '';
            height: 130px;
            width: 130px;
            border: 8px solid #00A79B;
            border-left-color: transparent;
            border-radius: 50%;
            transform: translateX(-50%) translateY(-50%) rotate(-20deg);
            position: absolute;
            left: 50%;
            top: 50%;
        }

        .main-timeline .timeline-icon {
            color: #fff;
            background-color: #00A79B;
            font-size: 35px;
            text-align: center;
            line-height: 50px;
            height: 50px;
            width: 50px;
            border-radius: 50%;
            transform: translateY(-50%);
            position: absolute;
            top: 50%;
            left: -25px;
            transition: all 0.3s;
        }

        .main-timeline .title {
            color: #222;
            font-size: 20px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin: 0 0 7px 0;
        }

        .main-timeline .description {
            color: #222;
            font-size: 15px;
            letter-spacing: 1px;
            text-align: justify;
            margin: 0 0 5px;
        }

        .main-timeline .timeline:nth-child(even) {
            padding: 100px 25px 0 70px;
            margin: 0 0 0 50px;
            float: right;
        }

        .main-timeline .timeline:nth-child(even) .timeline-content {
            padding: 15px 40px 15px 15px;
            border-radius: 0 15px 15px 15px;
        }

        .main-timeline .timeline:nth-child(even) .timeline-content:after {
            transform: rotateY(180deg);
            right: auto;
            left: -15px;
        }

        .main-timeline .timeline:nth-child(even) .timeline-year {
            right: auto;
            left: -120px;
        }

        .main-timeline .timeline:nth-child(even) .timeline-year:after {
            transform: translateX(-50%) translateY(-50%) rotate(200deg);
        }

        .main-timeline .timeline:nth-child(even) .timeline-icon {
            left: auto;
            right: -25px;
        }

        .timeline:nth-child(4n+2) .timeline-content,
        .timeline:nth-child(4n+2) .timeline-year:after {
            border-color: #9E005D;
        }

        .timeline:nth-child(4n+2) .timeline-year:after {
            border-left-color: transparent;
        }

        .timeline:nth-child(4n+2) .timeline-content:after,
        .timeline:nth-child(4n+2) .timeline-icon,
        .timeline:nth-child(4n+2) .timeline-year {
            background-color: #9E005D;
        }

        .timeline:nth-child(4n+3) .timeline-content,
        .timeline:nth-child(4n+3) .timeline-year:after {
            border-color: #f24f0e;
        }

        .timeline:nth-child(4n+3) .timeline-year:after {
            border-left-color: transparent;
        }

        .timeline:nth-child(4n+3) .timeline-content:after,
        .timeline:nth-child(4n+3) .timeline-icon,
        .timeline:nth-child(4n+3) .timeline-year {
            background-color: #f24f0e;
        }

        .timeline:nth-child(4n+4) .timeline-content,
        .timeline:nth-child(4n+4) .timeline-year:after {
            border-color: #0870C5;
        }

        .timeline:nth-child(4n+4) .timeline-year:after {
            border-left-color: transparent;
        }

        .timeline:nth-child(4n+4) .timeline-content:after,
        .timeline:nth-child(4n+4) .timeline-icon,
        .timeline:nth-child(4n+4) .timeline-year {
            background-color: #0870C5;
        }

        @media screen and (max-width: 767px) {
            .main-timeline:before {
                display: none;
            }

            .main-timeline .timeline {
                width: 100%;
                padding-top: 80px;
                padding-right: 12px;
                margin-bottom: 20px;
            }

            .main-timeline .timeline:nth-child(even) {
                padding-left: 10px;
                padding-top: 80px;
                margin-bottom: 20px;
            }

            .main-timeline .timeline-content,
            .main-timeline .main-timeline .timeline:nth-child(even) .timeline-content {
                background-color: #fff;
                padding-top: 25px;
            }

            .main-timeline .timeline-content:after {
                display: none;
            }

            .main-timeline .timeline-year {
                font-size: 24px;
                line-height: 70px;
                height: 70px;
                width: 70px;
                right: 0;
                top: -65px;
            }

            .main-timeline .timeline-year:after {
                display: none;
            }

            .main-timeline .timeline:nth-child(even) .timeline-year {
                left: 3px;
            }
        }

        @media screen and (max-width: 567px) {
            .main-timeline .title {
                font-size: 18px;
            }
        }
    </style>
</head>

<body>
<div class="htmleaf-container">
    <div class="demo">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="main-timeline" id="main">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/static/js/jquery-2.1.1.min.js"></script>
<script>


    var elements = [];
    const $_ = e => document.querySelector(e);

    window.init = function () {
        $.ajax({
            //请求方式
            type: "GET",
            //请求的媒体类型
            contentType: "application/json;charset=UTF-8",
            //请求地址
            url: "/note/getlog",
            success: function (result) {
                elements = result;
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

        var lineMain = document.getElementById('main');
        lineMain.innerHTML = "";
        if(elements.length==0){
            lineMain.innerHTML ='<h2>目前没有产生历史时间线,请创建或者修改笔记!!!</h2>';
            return;
        }
        for (var i = 0; i < elements.length; i += 3) {

            var element = document.createElement('div');
            element.className = 'timeline';
            var aEle = document.createElement('a');
            aEle.className = "timeline-content";
            aEle.innerHTML = '<div class="timeline-year"> ' +
                '<span>' + elements[i + 1].slice(0, 10) + '</span> </div><div class="timeline-icon">' +
                ' <i class="fa fa-globe">' + (i / 3 + 1).toString() + '</i> </div>' +
                '<h3 class="title">' + elements[i + 2] + '</h3>' +
                '<p class="description">' + elements[i + 2] +':<span style="color:red;">'+elements[i]+'</span>' +'<h4>' + elements[i + 1] + '</h4></p>';
            element.appendChild(aEle);
            lineMain.appendChild(element);
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
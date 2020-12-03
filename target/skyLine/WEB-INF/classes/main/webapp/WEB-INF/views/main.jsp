<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>笔记共享系统</title>
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/mfb.css" rel="stylesheet">
    <link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" type="text/css" href="/static/css/normalize.css"/>
    <%--    <link rel="stylesheet" href="/static/css/samples-styles.css">--%>
    <link href="/static/css/animate.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/static/css/note.css"/>
    <link rel="stylesheet" href="/static/css/style.css">
    <script type="text/javascript" src="/static/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/static/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="/static/js/noteShow.js"></script>
    <link rel="shortcut icon" href="/static/favicon.ico"/>
    <style>
        .htmleaf-content {
            width: 300px;
            margin: 20px auto;
        }

        td.alt {
            background-color: #ffc;
            background-color: rgba(230, 127, 34, 0.2);
        }

        .item {
            max-width: 65%;
            padding: 1em;
            background: #eee;
            display: none;
            position: relative;
            -webkit-box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.15);
            -moz-box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.15);
            box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.15);
            border-radius: 3px;
            color: #000;
            overflow-y: visible;
            z-index: 10;
        }

        .item tr:hover {
            background: rgb(226, 175, 175);
        }

        .item-close {
            cursor: pointer;
            right: 5px;
            top: 5px;
            position: absolute;
            background: #222;
            color: #fff;
            border-radius: 100%;
            font-size: 14px;
            height: 24px;
            line-height: 22px;
            text-align: center;
            width: 24px;
        }

        .seleted {
            background: blue;
            color: red;
        }

        #menu1 {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
            z-index: 10;
            /*display: none;*/
        }

        #btn1 {
            color: rgba(127, 255, 255, 0.75);
            background: transparent;
            outline: 1px solid rgba(127, 255, 255, 0.75);
            border: 0px;
            padding: 5px 10px;
            cursor: pointer;
        }

        #btn1:hover {
            background-color: rgba(0, 255, 255, 0.5);
        }

        #danmuText {
            color: rgba(127, 255, 255, 0.75);
            background: transparent;
            outline: 1px solid rgba(127, 255, 255, 0.75);
            border: 0px;
            padding: 5px 10px;
            cursor: pointer;
            width: 200px;
            height: 40px;
        }

        #btn1:active {
            color: #000000;
            background-color: rgba(0, 255, 255, 0.75);
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/static/dist/css/barrager.css">
</head>

<body>
<audio src="/static/Melody.mp3" hidden="true"  id="myAudio" volume=50 autoplay="true" loop="true"></audio>
<script src="/static/js/three.min.js"></script>
<script src="/static/js/tween.umd.js"></script>
<script src="/static/js/TrackballControls.js"></script>
<script src="/static/js/CSS3DRenderer.js"></script>
<%--弹幕--%>
<script type="text/javascript" src="/static/dist/js/jquery.barrager.js"></script>
<div id="menu1">
    <input type="text" style="" id="danmuText">
    <button id="btn1">shoot</button>
</div>
<script type="text/javascript">
    $.ajaxSettings.async = false;
    $("#btn1").click(function () {
        if ($("#danmuText").val() == "") {
            alert("请输入弹幕");
        } else {
            // alert($("#danmuText").val());
            var data={};
            data["barragetext"]=$("#danmuText").val();
            $.ajax({
                //请求方式
                type: "POST",
                //请求的媒体类型
                contentType: "application/json;charset=UTF-8",
                //请求地址
                url: "/barrage/add",
                //数据，json字符串
                data: JSON.stringify(data),
                //请求成功
                success: function(result) {
                    if(result=="true"){
                        $('body').barrager({"info":$("#danmuText").val(),"color":"rgb(0,250,150)"});
                    }else{
                        alert("发射失败");
                    }
                },
                //请求失败，包含具体的错误信息
                error: function(e) {
                    console.log(e.status);
                    console.log(e.responseText);
                    alert("发射失败");
                }
            });
            $("#danmuText").val("");
        }
    });
    $.getJSON('/barrage/getall', function (data) {
        //每条弹幕发送间隔
        var looper_time = 3 * 1000 * Math.random();
        var items = data;
        //弹幕总数
        var total = data.length;
        //是否首次执行
        var run_once = true;
        //弹幕索引
        var index = 0;
        //先执行一次
        barrager();
        if(total==0){
            return;
        }
        function barrager() {
            if (run_once) {
                //如果是首次执行,则设置一个定时器,并且把首次执行置为false
                looper = setInterval(barrager, looper_time);
                run_once = false;
            }
            //发布一个弹幕
            $('body').barrager(items[index]);
            //索引自增
            index++;
            //所有弹幕发布完毕，清除计时器。
            if (index == total) {
                clearInterval(looper);
                return false;
            }
        }
    });

</script>
<%--弹幕--%>
<!-- 搜索 -->
<div id="container"></div>
<!-- 浮标 -->
<div>
    <ul id="menu" class="mfb-component--br mfb-zoomin" data-mfb-toggle="hover">
        <li class="mfb-component__wrap">
            <a href="#" class="mfb-component__button--main">
                <i class="mfb-component__main-icon--resting ion-plus-round"></i>
                <i class="mfb-component__main-icon--active ion-close-round"></i>
            </a>
            <ul class="mfb-component__list">
                <li>
                    <a href="/login/logout" data-mfb-label="注销" class="mfb-component__button--child">
                        <i class="mfb-component__child-icon ion-android-walk"></i>
                    </a>
                </li>
                <li>
                    <a href="#" data-mfb-label="搜索" class="mfb-component__button--child btn1">
                        <i class="mfb-component__child-icon ion-aperture"></i>
                    </a>
                </li>

                <li>
                    <a href="/personal" data-mfb-label="个人中心" class="mfb-component__button--child">
                        <i class="mfb-component__child-icon ion-man"></i>
                    </a>

                </li>
                <li>
                    <a href="/timeline" data-mfb-label="个人时间线" class="mfb-component__button--child">
                        <i class="mfb-component__child-icon ion-ios-pulse"></i>
                    </a>
                </li>
                <li>
                    <a href="/changepassword" data-mfb-label="修改密码" class="mfb-component__button--child">
                        <i class="mfb-component__child-icon ion-ios-medical"></i>
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</div>
<!-- 浮标 -->
<!-- 搜索 -->
<div id="item1" class="item item--mod">
    <h3>Simple table with column search</h3>
    <table id="sampleTableB" class="table table-striped sampleTable">
        <tr>
            <th style="padding:3px;">名称</th>
            <th style="padding:3px;">作者</th>
            <th style="padding:3px;">时间</th>
        </tr>
    </table>
    <b class="item-close js-popup-close">x</b>
</div>
<script src="/static/js/jquery.popup.min.js"></script>

<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/moment.min.js"></script>
<script src="/static/js/fancyTable.js"></script>
<script type="text/javascript">
    // console.log("projection");
    var actualLen = -1;

    function searchView() {
        $('.btn1').on('click', function () {
            $('#item1').popup({
                time: 1000,
                classAnimateShow: 'flipInX',
                classAnimateHide: 'hinge',
                onPopupClose: function e() {
                    // console.log('0')
                },
                onPopupInit: function e() {
                    // console.log('1')
                }
            });
        });
        var lastSeletedItemNum = -1;

        function getSearchItem(e) {
            var index = e;

            return function () {
                objects[index].element.style.boxShadow = "0px 0px 100px rgba(255, 255, 255, 0.9)";
                objects[index].element.style.border = "3px solid rgba(127, 255, 255, 0.75)";
                if (lastSeletedItemNum != -1) {
                    objects[lastSeletedItemNum].element.style.boxShadow = "0px 0px 12px rgba(0, 255, 255, 0.5)";
                    objects[lastSeletedItemNum].element.style.border = "1px solid rgba(127, 255, 255, 0.25)";
                }
                lastSeletedItemNum = index;
                // controls.target0 = objects[index].position.clone();
                // controls.reset();
                controls.enabled = false;
                new TWEEN.Tween(controls.target)
                    .to({
                        y: objects[index].position.y
                    }, 3000)
                    .easing(TWEEN.Easing.Circular.InOut)
                    .start().onComplete(function () {
                    controls.enabled = true;
                })
                ;


                new TWEEN.Tween(this)
                    .to({}, 3100)
                    .onUpdate(render)
                    .start();

            }
        }

        for (var i = 0; i < actualLen; i += 4) {
            var row = $("<tr>");
            for (var ii = 0; ii < 3; ii++) {
                $("<td>", {
                    html: table[i + ii],
                    style: "padding:2px;"
                }).appendTo($(row));
            }
            // $(row).find("td:last").first().html(moment(new Date(Math.floor(new Date().getTime() * Math.random()))).format('l'));
            $(row).click(getSearchItem(i / 4));
            row.appendTo($("#sampleTableB"));
        }
        $("#sampleTableB").fancyTable({
            pagination: true,
            perPage: 10
        });
    }
</script>

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
            <!-- <img class="button" id="save" src="Images/save.png" style="display:initial;"></img> -->
            <img class="button" id="discard" src="/static/Images/discard.png" style="display:initial;"></img>
        </div>
        <div class="grid bottom right"></div>
    </div>
</div>
<!-- 文档 -->
<script>
    var camera, scene, renderer;
    var controls;
    var table = [];
    var objects = [];
    var targets = {
        table: [],
        sphere: [],
        helix: [],
        grid: []
    };
    var targetPoint = {
        index: 0,
        position: new THREE.Vector3(),
        rotation: new THREE.Euler()
    };


    function startAll() {
        searchView();
        init();
        animate();

    }

    // startAll();
    /////////////////////start
    $.ajax({
        //请求方式
        type: "GET",
        //请求的媒体类型
        contentType: "application/json;charset=UTF-8",
        //请求地址
        url: "/note/getall",
        //数据，json字符串
        // data: JSON.stringify(list),
        //请求成功
        success: function (result) {
            // console.log(result);
            table = result["data"];
            actualLen = table.length;
            if (table.length / 4 < 270) {
                for (let i = 0; i < 1080 - table.length; i++) {
                    table.push("");
                }
            }
            startAll();
        },
        //请求失败，包含具体的错误信息
        error: function (e) {
            console.log(e.status);
            console.log(e.responseText);
            alert("出现错误！！！！");
        }
    });

    /////////////////////start


    function init() {

        document.getElementById('discard').onclick = function () {

            document.getElementById('note').style.display = 'none';
            objects[targetPoint.index].element.style.display = 'block';
            document.getElementById("menu1").style.display = "block";
            setTimeout(function () {
                    controls.enabled = true;
                },
                2000
            )
            ;
            new TWEEN.Tween(objects[targetPoint.index].position)
                .to({
                    x: targetPoint.position.x,
                    y: targetPoint.position.y,
                    z: targetPoint.position.z
                }, 2000)
                .easing(TWEEN.Easing.Exponential.InOut)
                .start();

            new TWEEN.Tween(objects[targetPoint.index].rotation)
                .to({
                    x: targetPoint.rotation.x,
                    y: targetPoint.rotation.y,
                    z: targetPoint.rotation.z
                }, 2000)
                .easing(TWEEN.Easing.Circular.InOut)
                .start();


            new TWEEN.Tween(this)
                .to({}, 2000)
                .onUpdate(render)
                .start();

        }

        function getOnclickEvent(e, pos) {
            var index = e;
            var pos = pos;
            var note = document.getElementById('note');
            var menu1 = document.getElementById("menu1");
            return function () {
                controls.enabled = false;
                targetPoint.position = objects[index].position.clone();
                targetPoint.rotation = objects[index].rotation.clone();
                targetPoint.index = index;
                setTimeout(function () {
                        note.style.display = 'block';
                        menu1.style.display = "none";
                        // console.log(pos);
                        showNote(pos);
                        objects[index].element.style.display = 'none';
                    },
                    2800
                )
                ;
                // console.log(objects[index]);
                new TWEEN.Tween(objects[index].position)
                    .to({
                        x: camera.position.x,
                        y: camera.position.y,
                        z: camera.position.z
                    }, 3000)
                    .easing(TWEEN.Easing.Exponential.InOut)
                    .start();

                new TWEEN.Tween(objects[index].rotation)
                    .to({
                        x: -camera.rotation.x,
                        y: -camera.rotation.y,
                        z: -camera.rotation.z
                    }, 3000)
                    .easing(TWEEN.Easing.Exponential.InOut)
                    .start();


                new TWEEN.Tween(this)
                    .to({}, 3000)
                    .onUpdate(render)
                    .start();
            }
        }


        camera = new THREE.PerspectiveCamera(40, window.innerWidth / window.innerHeight, 1, 10000);
        camera.position.z = 1800;

        scene = new THREE.Scene();


        for (var i = 0; i < table.length; i += 4) {

            var element = document.createElement('div');
            element.className = 'element';
            element.style.backgroundColor = 'rgba(0,127,127,' + (Math.random() * 0.5 + 0.3) + ')';
            var number = document.createElement('div');
            number.className = 'number';
            number.textContent = (i / 4) + 1;
            element.appendChild(number);

            var symbol = document.createElement('div');
            symbol.className = 'symbol';
            symbol.textContent = table[i];
            element.appendChild(symbol);

            var details = document.createElement('div');
            details.className = 'details';
            details.innerHTML = table[i + 1] + '<br>' + table[i + 2];
            element.appendChild(details);

            var object = new THREE.CSS3DObject(element);
            object.position.x = Math.random() * 4000 - 2000;
            object.position.y = Math.random() * 4000 - 2000;
            object.position.z = Math.random() * 4000 - 2000;
            scene.add(object);
            element.onclick = getOnclickEvent(i / 4, table[i + 3]);
            objects.push(object);

        }


        // helix

        var vector = new THREE.Vector3();

        for (var i = 0, l = objects.length; i < l; i++) {

            var phi = i * 0.175 * 1.5 + Math.PI;

            var object = new THREE.Object3D();

            object.position.x = 900 * Math.sin(phi);
            object.position.y = -(i * 8) + 450;
            object.position.z = 900 * Math.cos(phi);

            vector.x = object.position.x * 2;
            vector.y = object.position.y * 1.5;
            vector.z = object.position.z * 2;

            object.lookAt(vector);

            targets.helix.push(object);

        }


        //

        renderer = new THREE.CSS3DRenderer();
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.domElement.style.position = 'absolute';
        document.getElementById('container').appendChild(renderer.domElement);

        //

        controls = new THREE.TrackballControls(camera, renderer.domElement);
        controls.rotateSpeed = 0.01;
        controls.minDistance = 500;
        controls.maxDistance = 1800;
        controls.dynamicDampingFactor = 0.2; // 阻尼系数 越小 则滑动越大
        controls.addEventListener('change', render);


        transform(targets.helix, 2000);

        //

        window.addEventListener('resize', onWindowResize, false);

    }

    function transform(targets, duration) {

        TWEEN.removeAll();

        for (var i = 0; i < objects.length; i++) {

            var object = objects[i];
            var target = targets[i];

            new TWEEN.Tween(object.position)
                .to({
                    x: target.position.x,
                    y: target.position.y,
                    z: target.position.z
                }, Math.random() * duration + duration)
                .easing(TWEEN.Easing.Exponential.InOut)
                .start();

            new TWEEN.Tween(object.rotation)
                .to({
                    x: target.rotation.x,
                    y: target.rotation.y,
                    z: target.rotation.z
                }, Math.random() * duration + duration)
                .easing(TWEEN.Easing.Exponential.InOut)
                .start();

        }

        new TWEEN.Tween(this)
            .to({}, duration * 2)
            .onUpdate(render)
            .start();

    }

    function onWindowResize() {

        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();

        renderer.setSize(window.innerWidth, window.innerHeight);

        render();

    }

    function animate() {

        requestAnimationFrame(animate);

        TWEEN.update();
        controls.update();

    }

    function render() {
        camera.position.y = controls.target.y;
        renderer.render(scene, camera);

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
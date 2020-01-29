var note = {

    init: function (parent) {
        this.parent = parent;
        this.index=null;
        this.url = 'note://' + window.location.pathname;
            this.save(this.DEFAULT_NOTE);

    },
    setIndex:function(index){
        this.index=index;
    },
    data: function () {
        return localStorage.getItem(this.url);
    },
    save: function (text, action) {
        localStorage.setItem(this.url, text);
        if (action===true) {
            var data = {};
            data["data"] = text;
            data["id"] = this.index;
            data["name"] = prompt("请输入标题名",elements[elements.indexOf(this.index)-2]);
            $.ajax({
                //请求方式
                type: "POST",
                //请求的媒体类型
                contentType: "application/json;charset=UTF-8",
                //请求地址
                url: this.index?"/note/change":"/note/save",
                //数据，json字符串
                data: JSON.stringify(data),
                //请求成功
                success: function(result) {
                    // console.log(result);
                    window.init();
                },
                //请求失败，包含具体的错误信息
                error: function(e) {
                    console.log(e.status);
                    console.log(e.responseText);
                    alert("保存失败");
                }
            });
        }
    },
    show: function (text) {
        if (text == null)
            this.parent.innerHTML = this.data();
        else {
            this.save(text);
            this.parent.innerHTML = text;
        }

        this.parent.onclick = function () {

            note.hide();
            editor.show(note.data());
            button.show();
        }
    },
    hide: function () {
        this.parent.onclick = null;
        this.parent.innerHTML = '';
    },
    DEFAULT_NOTE: '<p style="text-align:center"><img src="/static/Images/welcome.png" /></p>' +
        '<h2 style="text-align:center">点击中心可输入你想要的内容,右上角小三角形能打开扩展功能!</h2>' +
        '<h3 style="text-align:center">点击蓝色按钮保存,点击红色按钮退出编辑,右键笔记删除!</h3>'
};

var editor = {
    init: function (parent) {
        this.parent = parent;
    },
    data: function () {
        return this.value;
    },
    show: function (data) {
        this.ck = CKEDITOR.appendTo(this.parent, null, data);
        this.ck.on('instanceReady', function () {
            editor.ck.resize('100%', editor.parent.clientHeight);
        });
    },
    hide: function () {
        this.value = this.ck.getData();
        this.ck.destroy();
        delete this.ck;
    }
};

var button = {
    init: function () {
        this.save = document.getElementById('save');
        this.discard = document.getElementById('discard');

        this.save.onclick = function () {
            button.hide();
            editor.hide();
            note.save(editor.data(),true);
            note.show();
            document.getElementById('note').style.display='none';
            document.getElementById('main').style.display='flex';
        }
        this.discard.onclick = function () {
            button.hide();
            editor.hide();
            note.show();
            document.getElementById('note').style.display='none';
            document.getElementById('main').style.display='flex';
        }
    },
    show: function () {
        this.save.style.display = "initial";
        this.discard.style.display = "initial";
    },
    hide: function () {
        this.save.style.display = "none";
        this.discard.style.display = "none";
    }
};

function showNote(e) {
    var content = document.getElementById('content');
    note.init(content);
    editor.init(content);
    button.init();
    if (e != null) {
        console.log(e);
        $.ajax({
            url: "/note/view?id="+e,
            data: null,
            type: "GET",
            // dataType: "json",
            success: function(data) {
                note.setIndex(e);
                note.show(data);
            },
            error: function(data) {
                console.log("error");
                note.show();
                alert("数据获取异常!!!");
            }
        });
    } else {
        note.show();
    }
}
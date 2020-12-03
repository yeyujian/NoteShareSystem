var noteShow = {
    init: function (parent) {
        this.parent = parent;
        this.url = 'note://' + window.location.pathname;
        this.save(this.DEFAULT_NOTE);

    },
    data: function () {
        return localStorage.getItem(this.url);
    },
    save: function (text) {
        localStorage.setItem(this.url, text);
    },
    show: function (HTMLtext = null) {
        if (HTMLtext == null)
            this.parent.innerHTML = this.data();
        else {
            this.parent.innerHTML = HTMLtext;
        }
    },
    hide: function () {
        this.parent.onclick = null;
        this.parent.innerHTML = '';
    },
    DEFAULT_NOTE: '<p style="text-align:center"><img src="/static/Images/welcome.png" /></p>' +
        '<h2 style="text-align:center">无法获取资源</h2>'
};

var showNote = function (e) {
    var content = document.getElementById('content');
    noteShow.init(content);
    // noteShow.show(e);
    // console.log(e+"????");
    if (e == "") {
        noteShow.show();
    } else {

        // console.log(e);
        $.ajax({
            url: "/note/view?id=" + e,
            data: null,
            type: "GET",
            // dataType: "json",
            success: function (data) {
                // console.log(data);
                noteShow.show(data);
            },
            error: function (data) {
                console.log("error");
                noteShow.show();
                alert("数据获取异常!!!");
            }
        });
    }

    // $.ajax({
    //     //请求方式
    //     type : "POST",
    //     //请求的媒体类型
    //     contentType: "application/json;charset=UTF-8",
    //     //请求地址
    //     url : "http://127.0.0.1/admin/list/",
    //     //数据，json字符串
    //     data : JSON.stringify(list),
    //     //请求成功
    //     success : function(result) {
    //         console.log(result);
    //     },
    //     //请求失败，包含具体的错误信息
    //     error : function(e){
    //         console.log(e.status);
    //         console.log(e.responseText);
    //     }
    // });

}
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ch">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>主页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-4.2.1.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>

<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
    <div class="my-0 mr-md-auto font-weight-normal">
        <div class="logo">
            <h1 id="log">Video</h1>
        </div>
    </div>
    <nav class="my-2 my-md-0 mr-md-3 ">
        <a class="p-4 active" href="#"><strong>主页</strong></a>
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/allVideo"><strong>索引</strong></a>
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/AddVideo"><strong>创作中心</strong></a>
    </nav>
    <div id="isLogin"><a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/login">Sign up</a></div>
</div>


<div class="home-banner">
    <div class="home-banner-body">
        <div class="home-banner-slider">
            <div class="home-banner-con">
                <div class="home-shadow">
                    <div class="home-banner-line">
                        <div class="home-banner-list">
                        </div>
                    </div>
                    <div class="bd">
                        <div class="tempWrap" style="overflow:hidden; position:relative; width:740px">
                            <ul id="ulMain"
                                style="width: 2220px; left: -1480px; position: relative; overflow: hidden; padding: 0px; margin: 0px;">

                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor"
                 class="bi bi-chevron-left prev" viewBox="0 0 16 16">
                <path fill-rule="evenodd"
                      d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"></path>
            </svg>

            <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor"
                 class="bi bi-chevron-right next" viewBox="0 0 16 16">
                <path fill-rule="evenodd"
                      d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path>
            </svg>

        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-4.2.1.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.SuperSlide.2.1.3.js"></script>
<script src="${pageContext.request.contextPath}/static/js/layui/layui.js"></script>
<script>
    const msg = '${msg}';
    if (msg.length > 0) {
        layer.msg(msg, {icon: 2});
    }
    function isUser() {//判断用户是否登陆
        const userId = "${user.id}";
        if (userId.length > 0) {
            $("#isLogin").empty();
            let str = "<div class='btn-group'>";
            str += " <button type='button' class='btn btn-danger dropdown-toggle' data-toggle='dropdown' aria-expanded='false'>" + "${user.username}" + " </button>";
            str += "<div class='dropdown-menu'>" + "<a class='dropdown-item' href='${pageContext.request.contextPath}/user'>用户中心</a>";
            str += "<a class='dropdown-item' href='${pageContext.request.contextPath}/outLogin'>退出登陆</a>" + "</div></div>";
            $("#isLogin").append(str);
        }
    }
    $(function () {//初始化从数据库调用视频信息用来展示轮播
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/VideoIndex',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            success: function (data) {
                for (let i = 0; i < data.length; i++) {
                    let src = data[i].img;
                    const temp = src.substring(34);
                    src = "${pageContext.request.contextPath}/file/videoImg/" + temp;
                    let str = '<li style=';
                    str += "'float:left;width: 740px;'"+ '>'
                    str += ' <img src=' + src +' '+'style='+"'height:420px;'"+'>' + '</td>';
                    str += ' <div class=' + 'home-banner-text' + '>'
                    str += ' <h2 style='+"'padding:60px 0 10px 0'"+'>' + data[i].name + '</h2>';
                    str += ' <div class=' + 'home-text' + '>' + data[i].info + '</div>';
                    str += '<div class=' + 'home-button' + '>';
                    str += '<a href='+"${pageContext.request.contextPath}"+'/video'+'?videos='+ data[i].id + '>立刻观看</a>' + '</div>' + '</div>' + '</li>'
                    $("#ulMain").append(str);
                }
                jQuery(".home-banner-slider").slide({
                    mainCell: ".bd ul",
                    effect: "left",
                    autoPlay: true,
                    delayTime: 1000
                });
            },
            error: function (xhr, status) {
                console.log(status);
            }
        })
        isUser();
    })
    $(document).on('click', "#log", function () {
        window.location.href = "${pageContext.request.contextPath}/index";
    })
</script>

</body>

</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>视频检索</title>
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
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/index"><strong>主页</strong></a>
        <a class="p-4 active" href="#"><strong>索引</strong></a>
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/AddVideo"><strong>创作中心</strong></a>
    </nav>
    <div id="isLogin"><a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/login">Sign up</a></div>
</div>
<div class="album py-5 bg-light">
    <div class="container">
        <div class="container" style="margin-bottom: 20px ">
            <button class="button" onclick="getSort(5)">展示全部</button>
            <button class="button" onclick="getSort(1)">电影</button>
            <button class="button" onclick="getSort(2)">生活</button>
            <button class="button" onclick="getSort(3)">学习</button>
            <button class="button" onclick="getSort(4)">动漫</button>
        </div>
        <div class="row" id="isRow">


        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-4.2.1.js"></script>
<script>
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

    $(document).on('click', "#log", function () {
        window.location.href = "${pageContext.request.contextPath}/index";
    })



    $(function () {
        isUser();

        $.ajax({
            type: 'Post',
            url: '${pageContext.request.contextPath}/getAllVideo',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            success: function (data) {
                for (let i = 0; i < data.length; i++) {
                    let src = data[i].img;
                    const temp = src.substring(34);
                    src = "${pageContext.request.contextPath}/file/videoImg/" + temp;
                    let str = '<div class="col-md-4">';
                    str += ' <div class="card mb-4 shadow-sm">' + ' <img src="'+src+'" alt="">' + '<div class="card-body">';
                    str += ' <p class="card-text">'+data[i].info+' </p>' + '<div class="d-flex justify-content-between align-items-center">' + '  <div class="btn-group" style="padding-left: 40px;">';
                    str += ' <a type="button" href="'+"${pageContext.request.contextPath}"+'/video'+'?videos='+ data[i].id+'" class="btn btn-sm btn-outline-secondary">立刻观看</a>';
                    str +=  ' <a type="button" href="'+"${pageContext.request.contextPath}"+'/down'+'?videoId='+ data[i].id+'" class="btn btn-sm btn-outline-secondary">下载</a>'+' </div> </div> </div> </div> </div>';
                    $("#isRow").append(str);
                }
            }
            , error: function (xhr, status) {
                console.log(status)
            }
        })


    })


    function getSort(index) {
        if (index === 5){
            $("#isRow").empty();
            $.ajax({
                type: 'Post',
                url: '${pageContext.request.contextPath}/getAllVideo',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (data) {
                    for (let i = 0; i < data.length; i++) {
                        let src = data[i].img;
                        const temp = src.substring(34);
                        src = "${pageContext.request.contextPath}/file/videoImg/" + temp;
                        let str = '<div class="col-md-4">';
                        str += ' <div class="card mb-4 shadow-sm">' + ' <img src="'+src+'" alt="">' + '<div class="card-body">';
                        str += ' <p class="card-text">'+data[i].info+' </p>' + '<div class="d-flex justify-content-between align-items-center">' + '  <div class="btn-group" style="padding-left: 40px;">';
                        str += ' <a type="button" href="'+"${pageContext.request.contextPath}"+'/video'+'?videos='+ data[i].id+'" class="btn btn-sm btn-outline-secondary">立刻观看</a>';
                        str +=  ' <a type="button" href="'+"${pageContext.request.contextPath}"+'/down'+'?videoId='+ data[i].id+'" class="btn btn-sm btn-outline-secondary">下载</a>'+' </div> </div> </div> </div> </div>';
                        $("#isRow").append(str);
                    }
                }
                , error: function (xhr, status) {
                    console.log(status)
                }
            })
        }
        $("#isRow").empty();
        $.ajax({
            type: 'Post',
            url: '${pageContext.request.contextPath}/getSortVideo',
            dataType: 'json',
            data:{"index":index},
            success: function (data) {
                for (let i = 0; i < data.length; i++) {
                    let src = data[i].img;
                    const temp = src.substring(34);
                    src = "${pageContext.request.contextPath}/file/videoImg/" + temp;
                    let str = '<div class="col-md-4">';
                    str += ' <div class="card mb-4 shadow-sm">' + ' <img src="'+src+'" alt="">' + '<div class="card-body">';
                    str += ' <p class="card-text">'+data[i].info+' </p>' + '<div class="d-flex justify-content-between align-items-center">' + '  <div class="btn-group" style="padding-left: 40px;">';
                    str += ' <a type="button" href="'+"${pageContext.request.contextPath}"+'/video'+'?videos='+ data[i].id+'" class="btn btn-sm btn-outline-secondary">立刻观看</a>';
                    str +=  ' <a type="button" href="'+"${pageContext.request.contextPath}"+'/down'+'?videoId='+ data[i].id+'" class="btn btn-sm btn-outline-secondary">下载</a>'+' </div> </div> </div> </div> </div>';
                    $("#isRow").append(str);
                }
            }
            , error: function (xhr, status) {
                console.log(status)
            }
        })
    }
</script>
</body>
</html>

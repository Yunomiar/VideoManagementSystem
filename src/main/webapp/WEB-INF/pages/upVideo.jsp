<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创作中心</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-4.2.1.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/layui/css/layui.css">
</head>
<body>
<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
    <div class="my-0 mr-md-auto font-weight-normal">
        <div class="logo">
            <h1 id="log">Video</h1>
        </div>
    </div>
    <nav class="my-2 my-md-0 mr-md-3 ">
        <a class="p-4 active" href="${pageContext.request.contextPath}/index"><strong>主页</strong></a>
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/allVideo"><strong>索引</strong></a>
        <a class="p-4 text-dark" href="#"><strong>创作中心</strong></a>
    </nav>
    <div id="isLogin"><a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/login">Sign up</a></div>
</div>

<div class="container">
    <div class="row align-items-center g-lg-5 py-5">
        <div class="col-lg-5 text-center text-lg-start">
            <h1 class="display-4 fw-bold lh-1 mb-3">Video inspires your imagination</h1>
            <p class="col-lg-10 fs-4" style="padding-left: 10%;">视频创作中心，在这里上传的视频会自动生成想要的封面，快来试试吧，成为一个视频UP主</p>
        </div>
        <div class="col-md-10 mx-auto col-lg-7">
            <form class="p-4 p-md-5 border rounded-3 bg-light" action="/user/AddVideo" method="post"
                  enctype="multipart/form-data">
                <label for="UpFile">上传视频：</label>
                <div class="form-floating mb-3">
                    <input type="file" id="UpFile" accept="video/*,.ts" name="videoFile" onchange="fileChange(this);">
                </div>
                <br>
                <div class="form-floating mb-3">
                    <label for="videoName">视频名称：</label>
                    <input type="text" class="form-control" id="videoName" name="name" placeholder="Video Name">
                </div>
                <br>
                <div class="form-floating mb-3">
                    <label for="videoInfo">视频简介：</label>
                    <input type="tel" class="form-control" id="videoInfo" name="info" placeholder="Video videoInfo">
                </div>
                <hr class="my-2">
                <div class="d-block my-3">
                    <label>视频分区：</label>
                    <div class="custom-control custom-radio">
                        <input id="Movie" name="sort" type="radio" value="1" class="custom-control-input" required="">
                        <label class="custom-control-label" for="Movie">电影区</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="life" name="sort" type="radio" value="2" class="custom-control-input" required="">
                        <label class="custom-control-label" for="life">生活区</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="study" name="sort" type="radio" value="3" class="custom-control-input" required="">
                        <label class="custom-control-label" for="study">学习区</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="comic" name="sort" type="radio"  value="4" class="custom-control-input" required="">
                        <label class="custom-control-label" for="comic">动漫区</label>
                    </div>
                </div>
                <hr class="my-2">
                <button class="w-100 btn btn-lg btn-primary" type="submit">确认上传</button>
            </form>
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-4.2.1.js"></script>
<script src="${pageContext.request.contextPath}/static//js/layui/layui.js"></script>
<script type="text/javascript">
    const isIE = /msie/i.test(navigator.userAgent) && !window.opera;

    function fileChange(target, id) {
        var fileSize = 0;
        var filepath = target.value;
        var fileMaxSize = 1024 * 2000;//2000M
        if (filepath) {
            var isNext = false;
            var fileEnd = filepath.substring(filepath.lastIndexOf("."));
        } else {
            return false;
        }
        if (isIE && !target.files) {
            var filePath = target.value;
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
            if (!fileSystem.FileExists(filePath)) {
                layer.msg("附件不存在，请重新输入！", {icon: 0});
                return false;
            }
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;
        } else {
            fileSize = target.files[0].size;
        }

        var size = fileSize / 1024;
        if (size > fileMaxSize) {
            layer.msg("附件大小不能大于" + fileMaxSize / 1024 + "M！", {icon: 0});
            target.value = "";
            return false;
        }
        if (size <= 0) {
            layer.msg("附件大小不能为0M！", {icon: 0});
            target.value = "";
            return false;
        }
    }
    $(document).on('click',"#log",function () {
        window.location.href="${pageContext.request.contextPath}/index";
    })
</script>
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
    $(function (){
        isUser();
    })
</script>
</body>
</html>

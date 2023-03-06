<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
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
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/allVideo"><strong>索引</strong></a>
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/user/AddVideo"><strong>创作中心</strong></a>
    </nav>
</div>


<div style="padding: 50px 0px;">
    <section class="contact-area pt-120 pb-120">
        <div class="container">
            <div class="col-sm-6 col-xs-4 m-auto">
                <div class="section-title-two mb-30">
                    <h5 class="sub-title">Sign In</h5>
                    <h2 class="title">沉浸式体验<span>.</span></h2>
                </div>
                <div class="contact-wrap-content" style="padding: 30px 0px;">
                    <form action="${pageContext.request.contextPath}/LoginSubmit" method="post" class="contact-form">
                        <div class="form-grp">
                            <label for="userName">用户名</label>
                            <input type="text" required="required" id="userName" name="userName" placeholder="Your UserName">
                        </div>
                        <div class="form-grp">
                            <label for="password">密码</label>
                            <input type="password" required="required" id="password" name="password" placeholder="Your Password">
                        </div>
                        <div class="form-grp">
                            <label for="SecurityCode">请输入验证码:</label>
                            <input type="text" required="required" id="SecurityCode" name="inputCode" placeholder="In SecurityCode">
                        </div>
                        <div class="form-grp">
                            <img id="imgSignCode" src="${pageContext.request.contextPath}/getSecurityCode"
                                 onclick="reloadCode()" title="重新获取"
                                 style="cursor:pointer; width: 15%" ; height="4%"/>
                        </div>
                        <input type="submit" value="登录" class="btn">
                    </form>
                </div>
            </div>
        </div>
    </section>
</div>


<div class="container">
    <div class="col-sm-10 col-xs-4 m-auto">
        <div class="kb-trial-wrap">
            <h2 class="title" style="padding: 0px 20px 0px 70px;">还没有账号? &#8195&#8195&#8195快来加入我们</h2>
            <div class="kb-trial-form col-xs-4">
                <button class="btn" onclick="toRegister()" style="margin-left: 80px;"> 注 册</button>
            </div>
            <img src="${pageContext.request.contextPath}/static/img/trial_shape01.png" alt=""
                 class="trial-shape top-shape wow fadeInDownBig" data-wow-delay=".3s"
                 style="visibility: visible; animation-delay: 0.3s;">
            <img src="${pageContext.request.contextPath}/static/img/trial_shape02.png" alt=""
                 class="trial-shape bottom-shape wow fadeInUpBig"
                 data-wow-delay=".3s"
                 style="visibility: visible; animation-delay: 0.3s;">
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-4.2.1.js"></script>
<script src="${pageContext.request.contextPath}/static/js/layui/layui.js"></script>


<script type="text/javascript">
    const msg = '${msg}';
    if (msg.length > 0) {
        layer.msg(msg, {icon: 2});
    }

    $(document).on('click', "#log", function () {
        window.location.href = "${pageContext.request.contextPath}/index";
    })

    function reloadCode() {
        document.getElementById("imgSignCode").src = "getSecurityCode?r=" + new Date().getTime();
        // 浏览器带有缓存功能
        //当一个src中的URL请求一次后，再次请求浏览器就不会再去请求获得新数据，而是直接用
        //上次请求返回的数据
    }
    function toRegister(){
        window.location.href="${pageContext.request.contextPath}/register";
    }
</script>
</body>
</html>

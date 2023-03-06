<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>注册</title>
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


<div style="padding: 50px 0;">
    <section class="contact-area pt-120 pb-120">
        <div class="container">
            <div class="col-sm-6 col-xs-4 m-auto">
                <div class="section-title-two mb-30">
                    <h5 class="sub-title">Join Us</h5>
                    <h2 class="title">让你成为我们一员<span>.</span></h2>
                </div>
                <div class="contact-wrap-content" style="padding: 30px 0;">
                    <form action="${pageContext.request.contextPath}/toRegister" class="contact-form" method="post">
                        <div class="form-grp">
                            <label for="username">用户名</label>
                            <input type="text" id="username" required="required" name="username" placeholder="Your UserName">
                        </div>
                        <div class="form-grp">
                            <label for="name">姓名</label>
                            <input type="text" id="name" required="required" name="name" placeholder="Your Name">
                        </div>
                        <div class="form-grp">
                            <label for="email">邮箱</label>
                            <input type="text" id="email" name="email" required="required" placeholder="info.example@.com">
                        </div>
                        <div class="form-grp">
                            <label for="password">密码</label>
                            <input type="password" id="password" required="required" name="password" placeholder="Your Password">
                        </div>
                        <div class="form-grp">
                            <label for="birthday">生日</label>
                            <input type="date" id="birthday" required="required" name="birthday" placeholder="Your Birthday">
                        </div>
                        <hr class="my-2">
                        <button type="submit" class="btn registerBtn">注 册</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</div>


<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-4.2.1.js"></script>
<script>
    $(document).on('click', "#log", function () {
        window.location.href = "${pageContext.request.contextPath}/index";
    })
</script>
</body>
</html>

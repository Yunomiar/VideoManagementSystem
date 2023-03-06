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
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/allVideo"><strong>索引</strong></a>
        <a class="p-4 text-dark" href="${pageContext.request.contextPath}/AddVideo"><strong>创作中心</strong></a>
    </nav>
    <div id="isLogin"><a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/login">Sign up</a>
    </div>
</div>

   <div class="row">
       <div class="col-lg-4">

           <div class="card-header">
               当前用户信息
           </div>
           <div class="card-body">
               <form class="user">
                   <div class="form-group ">登录名：
                       <input type="text" class="form-control form-control-user" readonly="readonly"
                              placeholder="${user.username}">
                   </div>
                   <div class="form-group ">姓名：
                       <input type="text" class="form-control form-control-user" readonly="readonly"
                              placeholder="${user.name}">
                   </div>
                   <div class="form-group ">性别：
                       <input type="text" class="form-control form-control-user" readonly="readonly"
                              placeholder=" ${user.sex}">
                   </div>
                   <div class="form-group ">生日：
                       <input type="text" class="form-control form-control-user" readonly="readonly"
                              placeholder="${user.birthday}">
                   </div>
                   <div class="form-group ">注册日期：
                       <input type="text" class="form-control form-control-user" readonly="readonly"
                              placeholder="${user.regdate}">
                   </div>
                   <div class="form-group ">邮箱：
                       <input type="text" class="form-control form-control-user" readonly="readonly"
                              placeholder="${user.email}">
                   </div>
               </form>
           </div>
       </div>
       <div class="col-lg-8">

           <div class="card-header">
           </div>
           <h3>个人视频上传表：</h3>
           <div class="card-body">
               <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                   <thead>
                   <tr>
                       <th>序号</th>
                       <th>视频</th>
                       <th>名称</th>
                       <th>介绍</th>
                       <th>上传时间</th>
                       <th>上传用户id</th>
                       <th>操作</th>
                   </tr>
                   </thead>
                   <tbody id="videosTB">
                   </tbody>
               </table>
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

        function isEorp(eorp) {
            if (eorp === '1') {
                return "已审核";
            } else {
                return "未审核";
            }
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/getAllVideoByUser',
            type: 'post',
            dataType: 'json',
            async: 'true',
            success: function (data) {
                $("tr:gt(0)").remove();
                for (let i = 0; i < data.length; i++) {
                    let src = data[i].img;
                    const temp = src.substring(34);
                    src = "${pageContext.request.contextPath}/file/videoImg/" + temp;
                    let tr = '<tr >';
                    tr += '<td >' + (i + 1) + '</td>';
                    tr += '<td>' + '<img src=' + src + ' ' + 'style=' + "'height:100px; weight:50px;'" + '>' + '</td>';
                    tr += '<td>' + data[i].name + '</td>';
                    tr += '<td>' + data[i].info + '</td>';
                    tr += '<td>' + data[i].date + '</td>';
                    tr += '<td>' + data[i].userId + '</td>';
                    tr += '<td ><p  class="op' + i + '" ></p>' + '<a  class="del' + i + '" >删除</a>' + '</td>';
                    tr += "</tr>";
                    $('#videosTB').append(tr);
                    let temps = '.op' + i;
                    $(temps).append(isEorp(data[i].ischeck + ''));
                    let temps1 = '.del' + i;
                    $(temps1).attr("href", "${pageContext.request.contextPath}" + '/delete?videoId=' + data[i].id);
                }
                ;
            },
            error: function (xhr, status) {
            }
        });

    });

</script>
</body>
</html>

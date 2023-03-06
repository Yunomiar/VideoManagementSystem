<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>视频播放</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-4.2.1.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/video-js.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/video.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style1.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/review/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/review/css/comment.css">

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


<div class="container">
    <div class="row" id="row">
        <div class="col-sm-12" style="
             margin-bottom: 200px;">
            <div class="jumbotron">
                <%-- vjs-big-play-centered可使大的播放按钮居住，vjs-fluid可使视频占满容器 --%>
                <video id="myVideo" class="video-js vjs-big-play-centered vjs-fluid">
                    <p class="vjs-no-js">
                        To view this video please enable JavaScript, and consider upgrading to a
                        web browser that
                        <a href="https://videojs.com/html5-video-support/" target="_blank">
                            supports HTML5 video
                        </a>
                    </p>
                </video>
                <div style="height: 50px;padding-left: 20px;">
                    <div class="heart" id="heart" rel="like"
                         style="margin-left: 50px;background-image:url('${pageContext.request.contextPath}/static/img/web_heart_animation.png')"></div>
                    <div id="likeCount" style="padding: 80px 0 0 10px"></div>
                </div>
            </div>
        </div>
    </div>


    <div class="pingLun">
        <%--<!--评论区域 begin-->--%>
        <div class="reviewArea clearfix">
            <textarea class="content comment-input" placeholder="请输入评论&hellip;" onkeyup="keyUP(this)" style="padding-bottom: 30px;"></textarea>
            <a href="javascript:;" class="plBtn" style="margin-top: 40px;">评论</a>
        </div>
        <%--<!--评论区域 end-->--%>
        <%--<!--回复区域 begin-->--%>
        <div class="comment-show">
        </div>
        <%-- <!--回复区域 end-->--%>
    </div>

</div>

<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-4.2.1.js"></script>
<script src="${pageContext.request.contextPath}/static/js/video.min.js"></script>


<script>
    function getCard() {
        $.ajax({
            type: "Post",
            url: '${pageContext.request.contextPath}/doCard',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            success: function (data) {
                for (let i = 0; i < data.length; i++) {
                    let src = data[i].img;
                    const temp = src.substring(34);
                    src = "${pageContext.request.contextPath}/file/videoImg/" + temp;
                    let str = '<div class="col-md-4">';
                    str += ' <div class="card mb-4 shadow-sm">' + ' <img src="' + src + '" alt="">' + '<div class="card-body">';
                    str += ' <p class="card-text">' + data[i].info + ' </p>' + '<div class="d-flex justify-content-between align-items-center">' + '  <div class="btn-group" style="padding-left: 90px;">';
                    str += ' <a type="button" href="' + "${pageContext.request.contextPath}" + '/video' + '?videos=' + data[i].id + '" class="btn btn-sm btn-outline-secondary">立刻观看</a>' + ' </div> </div> </div> </div> </div>';
                    $("#row").append(str);
                }
            },
            error: function (xhr, status) {
                console.log("status:" + "Error");
            }
        })

    }

    function getMessage(){
        $.ajax({
            url: '${pageContext.request.contextPath}/getMessage',
            type: "POST",
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            success: function (data) {
                for (let i = 0; i < data.length; i++) {
                    let str='<div class="comment-show-con clearfix"><div class="comment-show-con-list pull-left clearfix"><div class="pl-text clearfix"> <a href="#" class="comment-size-name">'+data[i].user.username+ ' </a> <span class="my-pl-con">&nbsp;' + data[i].content + '</span> </div> <div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + data[i].msgdate + '</span> <div class="date-dz-right pull-right comment-pl-block"><a href="javascript:;" class="removeBlock">删除</a> <a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a> <span class="pull-left date-dz-line">|</span> <a href="javascript:;" class="date-dz-z pull-left"><i class="date-dz-z-click-red"></i>赞 (<i class="z-num">0</i>)</a> </div> </div><div class="hf-list-con"></div></div> </div>';
                    $(".comment-show").append(str);
                }
            },
            error: function (xhr, status) {
                console.log("status:" + "Error");
            }
        })
    }

    function isLikes() {
        $.ajax({
            type: "Get",
            url: "${pageContext.request.contextPath}/getLikes",
            dataType: "text",
            success: function (data) {
                if(data=="1"){
                    $("#heart").css("background-position", "")
                    $("#heart").addClass("heartAnimation").attr("rel", "unlike");
                }
            },
            error: function () {
                console.log("获取数据出错!");
            },
        });
    }

    $(function () {
        isUser();
        getCard();
        getMessage();
        isLikes();
        $("#likeCount").html("${video.likes}");
        const videoSrc = "${video.src}";
        const videoImg = "${video.img}";
        let src = "${pageContext.request.contextPath}/file/video/" + videoSrc.substring(28);
        let img = "${pageContext.request.contextPath}/file/videoImg/" + videoImg.substring(31);
        let player = videojs(document.getElementById('myVideo'), {
            controls: true, // 是否显示控制条
            // 视频封面图地址
            preload: 'auto',
            autoplay: false,
            fluid: true, // 自适应宽高
            language: 'zh-CN', // 设置语言
            muted: false, // 是否静音
            inactivityTimeout: false,
            controlBar: { // 设置控制条组件
                /* 使用children的形式可以控制每一个控件的位置，以及显示与否 */
                children: [
                    {name: 'playToggle'}, // 播放按钮
                    {name: 'currentTimeDisplay'}, // 当前已播放时间
                    {name: 'progressControl'}, // 播放进度条
                    {name: 'durationDisplay'}, // 总时间
                    { // 倍数播放
                        name: 'playbackRateMenuButton',
                        'playbackRates': [0.5, 1, 1.5, 2, 2.5]
                    }, {
                        name: 'volumePanel', // 音量控制
                        inline: false, // 不使用水平方式
                    },
                    {name: 'FullscreenToggle'} // 全屏
                ]
            },
            sources: [ // 视频源
                {
                    src: src,
                    type: 'video/mp4',
                    poster: img
                }
            ]
        }, function () {
            console.log('VideoJs'+this);
        });
    })

</script>
<script type="text/javascript">
    $(document).on('click', '#heart', function () {
        let index;
        const videoId = $("#videoId").html();

        $(this).css("background-position", "")
        const isHeart = $(this).attr("rel");
        if (isHeart === 'like') {//点赞
            index = 1;
            $(this).addClass("heartAnimation").attr("rel", "unlike");
        } else {//取消点赞
            index = -1;
            $(this).removeClass("heartAnimation").attr("rel", "like");
            $(this).css("background-position", "left");
        }
        $.ajax({
            async: false,
            type: "POST",
            url: "${pageContext.request.contextPath}/videoLike",
            data: {"videoId": videoId, "index": index},
            dataType: "text",
            success: function (data) {
                $("#likeCount").html(data);
            },
            error: function () {
                console.log("获取数据出错!");
            },
        });

    })

    $(document).on('click', "#log", function () {
        window.location.href = "${pageContext.request.contextPath}/index";
    })

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
</script>


<script type="text/javascript" src="${pageContext.request.contextPath}/static/review/js/jquery.flexText.js"></script>
<!--textarea高度自适应-->
<script type="text/javascript">
    $(function () {
        $('.content').flexText();
    });
</script>
<!--textarea限制字数-->
<script type="text/javascript">
    function keyUP(t) {
        var len = $(t).val().length;
        if (len > 139) {
            $(t).val($(t).val().substring(0, 140));
        }
    }
</script>
<!--点击评论创建评论条-->
<script type="text/javascript">
    $('.pingLun').on('click', '.plBtn', function () {
        var myDate = new Date();
        //获取当前年
        var year = myDate.getFullYear();
        //获取当前月
        var month = myDate.getMonth() + 1;
        //获取当前日
        var date = myDate.getDate();
        var h = myDate.getHours();       //获取当前小时数(0-23)
        var m = myDate.getMinutes();     //获取当前分钟数(0-59)
        if (m < 10) m = '0' + m;
        var s = myDate.getSeconds();
        if (s < 10) s = '0' + s;
        var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
        //获取输入内容
        var oSize = $(this).siblings('.flex-text-wrap').find('.comment-input').val();
        console.log("内容：" + oSize + ",时间：" + now + "用户名视频");
        const  username="${user.username}";
        //动态创建评论模块
        oHtml = '<div class="comment-show-con clearfix"><div class="comment-show-con-list pull-left clearfix"><div class="pl-text clearfix"> <a href="#" class="comment-size-name">'+username+ ' </a> <span class="my-pl-con">&nbsp;' + oSize + '</span> </div> <div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + now + '</span> <div class="date-dz-right pull-right comment-pl-block"><a href="javascript:;" class="removeBlock">删除</a> <a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a> <span class="pull-left date-dz-line">|</span> <a href="javascript:;" class="date-dz-z pull-left"><i class="date-dz-z-click-red"></i>赞 (<i class="z-num">0</i>)</a> </div> </div><div class="hf-list-con"></div></div> </div>';
        if (oSize.replace(/(^\s*)|(\s*$)/g, "") != '') {
            $(this).parents('.reviewArea ').siblings('.comment-show').prepend(oHtml);
            $(this).siblings('.flex-text-wrap').find('.comment-input').prop('value', '').siblings('pre').find('span').text('');
        }
        $(".date-dz-z-click-red").css("background-image","url('${pageContext.request.contextPath}/static/review/images/icon-all_01.png')");
        let param={content:oSize,msgdate:now};
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath}/addMessage',
            dataType:'json',
            data :param,
            success :function (data){
                console.log(data);
            },
            error: function (xhr, status) {
                console.log(status);
            }
        })
    });
</script>
<!--点击回复动态创建回复块-->
<script type="text/javascript">
    $('.pingLun').on('click', '.pl-hf', function () {
        //获取回复人的名字
        var fhName = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        //回复@
        var fhN = '回复@' + fhName;
        //var oInput = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.hf-con');
        var fhHtml = '<div class="hf-con pull-left"> <textarea class="content comment-input hf-input" placeholder="" onkeyup="keyUP(this)"></textarea> <a href="javascript:;" class="hf-pl">评论</a></div>';
        //显示回复
        if ($(this).is('.hf-con-block')) {
            $(this).parents('.date-dz-right').parents('.date-dz').append(fhHtml);
            $(this).removeClass('hf-con-block');
            $('.content').flexText();
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.pre').css('padding', '6px 15px');
            //console.log($(this).parents('.date-dz-right').siblings('.hf-con').find('.pre'))
            //input框自动聚焦
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.hf-input').val('').focus().val(fhN);
        } else {
            $(this).addClass('hf-con-block');
            $(this).parents('.date-dz-right').siblings('.hf-con').remove();
        }
    });
</script>
<%--<!--评论回复块创建-->--%>
<%--<script type="text/javascript">--%>
<%--    $('.comment-show').on('click', '.hf-pl', function () {--%>
<%--        var oThis = $(this);--%>
<%--        var myDate = new Date();--%>
<%--        //获取当前年--%>
<%--        var year = myDate.getFullYear();--%>
<%--        //获取当前月--%>
<%--        var month = myDate.getMonth() + 1;--%>
<%--        //获取当前日--%>
<%--        var date = myDate.getDate();--%>
<%--        var h = myDate.getHours();       //获取当前小时数(0-23)--%>
<%--        var m = myDate.getMinutes();     //获取当前分钟数(0-59)--%>
<%--        if (m < 10) m = '0' + m;--%>
<%--        var s = myDate.getSeconds();--%>
<%--        if (s < 10) s = '0' + s;--%>
<%--        var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;--%>
<%--        //获取输入内容--%>
<%--        var oHfVal = $(this).siblings('.flex-text-wrap').find('.hf-input').val();--%>
<%--        console.log(oHfVal)--%>
<%--        var oHfName = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();--%>
<%--        var oAllVal = '回复@' + oHfName;--%>
<%--        if (oHfVal.replace(/^ +| +$/g, '') == '' || oHfVal == oAllVal) {--%>

<%--        } else {--%>
<%--            $.getJSON("json/pl.json", function (data) {--%>
<%--                var oAt = '';--%>
<%--                var oHf = '';--%>
<%--                $.each(data, function (n, v) {--%>
<%--                    delete v.hfContent;--%>
<%--                    delete v.atName;--%>
<%--                    var arr;--%>
<%--                    var ohfNameArr;--%>
<%--                    if (oHfVal.indexOf("@") == -1) {--%>
<%--                        data['atName'] = '';--%>
<%--                        data['hfContent'] = oHfVal;--%>
<%--                    } else {--%>
<%--                        arr = oHfVal.split(':');--%>
<%--                        ohfNameArr = arr[0].split('@');--%>
<%--                        data['hfContent'] = arr[1];--%>
<%--                        data['atName'] = ohfNameArr[1];--%>
<%--                    }--%>
<%--                    if (data.atName == '') {--%>
<%--                        oAt = data.hfContent;--%>
<%--                    } else {--%>
<%--                        oAt = '回复<a href="#" class="atName">@' + data.atName + '</a> : ' + data.hfContent;--%>
<%--                    }--%>
<%--                    oHf = data.hfName;--%>
<%--                });--%>

<%--                var oHtml = '<div class="all-pl-con"><div class="pl-text hfpl-text clearfix"><a href="#" class="comment-size-name">我的名字 : </a><span class="my-pl-con">' + oAt + '</span></div><div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + now + '</span> <div class="date-dz-right pull-right comment-pl-block"> <a href="javascript:;" class="removeBlock">删除</a> <a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a> <span class="pull-left date-dz-line">|</span> <a href="javascript:;" class="date-dz-z pull-left"><i class="date-dz-z-click-red"></i>赞 (<i class="z-num">666</i>)</a> </div> </div></div>';--%>
<%--                oThis.parents('.hf-con').parents('.comment-show-con-list').find('.hf-list-con').css('display', 'block').prepend(oHtml) && oThis.parents('.hf-con').siblings('.date-dz-right').find('.pl-hf').addClass('hf-con-block') && oThis.parents('.hf-con').remove();--%>
<%--            });--%>
<%--        }--%>
<%--    });--%>
<%--</script>--%>
<!--删除评论块-->
<script type="text/javascript">
    $('.pingLun').on('click', '.removeBlock', function () {
        var oT = $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con');
        if (oT.siblings('.all-pl-con').length >= 1) {
            oT.remove();
        } else {
            $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con').parents('.hf-list-con').css('display', 'none')
            oT.remove();
        }
        $(this).parents('.date-dz-right').parents('.date-dz').parents('.comment-show-con-list').parents('.comment-show-con').remove();

    })
</script>
<!--点赞-->
<script type="text/javascript">
    $('.comment-show').on('click', '.date-dz-z', function () {
        var zNum = $(this).find('.z-num').html();
        if ($(this).is('.date-dz-z-click')) {
            zNum--;
            $(this).removeClass('date-dz-z-click red');
            $(this).find('.z-num').html(zNum);
            $(this).find('.date-dz-z-click-red').removeClass('red');
        } else {
            zNum++;
            $(this).addClass('date-dz-z-click');
            $(this).find('.z-num').html(zNum);
            $(this).find('.date-dz-z-click-red').addClass('red');
        }
    })
</script>
</body>
</html>

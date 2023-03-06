package com.aiit.videomanagesystem.controller;


import com.aiit.videomanagesystem.entity.Likes;
import com.aiit.videomanagesystem.entity.Message;
import com.aiit.videomanagesystem.entity.User;
import com.aiit.videomanagesystem.entity.Video;
import com.aiit.videomanagesystem.service.LikesService;
import com.aiit.videomanagesystem.service.MessageService;
import com.aiit.videomanagesystem.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class VideoController {

    @Autowired
    VideoService videoService;

    @Autowired
    MessageService messageService;

    @Autowired
    LikesService likesService;


    @ResponseBody
    @GetMapping("/getVideoById")
    public Video getVideoByIdAction(String videoId) {
        Video video = this.videoService.queryById(videoId);
        return video;
    }

    //点赞数增加
    @PostMapping("/videoLike")
    @ResponseBody
    public Integer increaseLikeCount(Integer index, HttpSession session) {
        Video videos = (Video) session.getAttribute("video");
        Integer likes = Integer.valueOf(videos.getLikes()) + index;
        videos.setLikes(String.valueOf(likes));
        this.videoService.update(videos);
        System.out.println("videoLike success");
        User user = (User) session.getAttribute("user");
        if (index > 0) {
            Likes likes1 = new Likes();
            likes1.setLdate(new Date());
            likes1.setVideoId(videos.getId());
            likes1.setUserId(user.getId());
            likesService.insert(likes1);
        } else if (index < 0) {
            boolean isDelete = likesService.deleteByVidAndUid(user.getId(), videos.getId());
            System.out.println(isDelete);
        }
        return likes;
    }

    @PostMapping("/doCard")
    @ResponseBody
    public List<Video> doGetCard(HttpSession session) {
        Object object = session.getAttribute("video");
        System.out.println(object);
        if (object != null) {
            System.out.println("存在VideoSession");
            Video video = (Video) object;
            List<Video> list = this.videoService.queryBySort3(video.getSort(), video.getId());
            return list;
        }
        System.out.println("getCard error");
        return null;
    }

    @PostMapping("/getAllVideo")
    @ResponseBody
    public List<Video> doGetAllVideo() {
        List<Video> list = this.videoService.queryAll();
        System.out.println(list);
        return list;
    }

    @PostMapping("/getAllVideoAdmin")
    @ResponseBody
    public List<Video> doGetAllVideoAdmin() {
        List<Video> list = this.videoService.queryAllAmin();
        System.out.println(list);
        return list;
    }


    @PostMapping("/addMessage")
    @ResponseBody
    public String doAddMessage(String content, String msgdate, HttpSession session) {
        Object object = session.getAttribute("video");
        if (object != null) {
            User user = (User) session.getAttribute("user");
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = null;
            try {
                date = simpleDateFormat.parse(msgdate);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            Video video = (Video) object;
            Message message = new Message();
            message.setUserId(user.getId());
            message.setContent(content);
            message.setMsgdate(date);
            message.setVideoId(video.getId());
            this.messageService.insert(message);
        }
        return "doError";
    }

    @PostMapping("/getMessage")
    @ResponseBody
    public List<Message> doGetMessage(HttpSession session) {
        Object object = session.getAttribute("video");
        List<Message> list = null;
        if (object != null) {
            Video video = (Video) object;
            list = this.messageService.queryByUserIDAndVideoId(video.getId());
        }
        return list;
    }

    @GetMapping("/check")
    public String doCheck(String videos) {
        System.out.println("videos:" + videos);
        Video video = this.videoService.queryById(videos);
        video.setIscheck("1");
        this.videoService.update(video);
        return "redirect:/videos";
    }

    @GetMapping("/getLikes")
    @ResponseBody
    public String doGetLikesAll(HttpSession session) {
        Video video = (Video) session.getAttribute("video");
        User user = (User) session.getAttribute("user");
        System.out.println(video + "," + user);
        Likes likes = this.likesService.queryByUserIdAndVideoId(user.getId(), video.getId());
        if (likes == null) {
            return "0";
        } else {
            return "1";//表示点赞过了
        }
    }

    @RequestMapping("/down")
    public void down(String videoId, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Video video = this.videoService.queryById(videoId);
        //模拟文件，myfile.txt为需要下载的文件
        String fileName = video.getSrc();
        //获取输入流
        InputStream bis = new BufferedInputStream(new FileInputStream(fileName));
        //假如以中文名下载的话
        /*  String filename = "下载文件.txt";  */
        //转码，免得文件名中文乱码
        String downloadFilename = processFileName(request, fileName);
        //filename = new String(filename.getBytes("UTF-8"),"iso8859-1");
        // filename = URLEncoder.encode(fileName,"UTF-8");
        //设置文件下载头
        response.addHeader("Content-Disposition", "attachment;filename=" + downloadFilename);
        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
        response.setContentType("multipart/form-data");
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        int len = 0;
        while ((len = bis.read()) != -1) {
            out.write(len);
            out.flush();
        }
        out.close();
    }

    public static String processFileName(HttpServletRequest request, String fileNames) {//解决文件乱码
        String codedfilename = null;
        try {
            String agent = request.getHeader("USER-AGENT");
            if (null != agent && -1 != agent.indexOf("MSIE") || null != agent
                    && -1 != agent.indexOf("Trident")) {// ie

                String name = java.net.URLEncoder.encode(fileNames, "UTF8");

                codedfilename = name;
            } else if (null != agent && -1 != agent.indexOf("Mozilla")) {// 火狐,chrome等


                codedfilename = new String(fileNames.getBytes("UTF-8"), "iso-8859-1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return codedfilename;
    }

    @PostMapping("/getSortVideo")
    @ResponseBody
    public List<Video> doGetSortVideo(String index) {
        return this.videoService.queryBySort(index);
    }

    @PostMapping("/getAllVideoByUser")
    @ResponseBody
    public List<Video> doGetAllVideoByUser(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return this.videoService.queryByUserId(user.getId());
    }

    @GetMapping("/delete")
    public String doDelete(String videoId) {
        this.videoService.deleteById(videoId);
        return "redirect:/user";
    }

    @GetMapping("/view")
    public String doView() {
        return "/admin/view";
    }
}

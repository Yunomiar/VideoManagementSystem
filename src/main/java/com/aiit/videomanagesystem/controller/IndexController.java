package com.aiit.videomanagesystem.controller;

import com.aiit.videomanagesystem.entity.User;
import com.aiit.videomanagesystem.entity.Video;
import com.aiit.videomanagesystem.service.UserService;
import com.aiit.videomanagesystem.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class IndexController {

    @Autowired
    VideoService videoService;

    @Autowired
    UserService userService;

    @RequestMapping("/")
    public String indexAction() {
        return "/index";
    }

    @RequestMapping("/index")
    public String getIndexAction() {
        return "/index";
    }

    @RequestMapping("/login")
    public String getLogin() {
        return "/login";
    }


    @RequestMapping("/register")
    public String getRegister() {
        return "/register";
    }


    @ResponseBody
    @PostMapping("/VideoIndex")
    public List<Video> VideoIndexAction() {
        return videoService.query3();
    }

    @GetMapping("/video")
    public String getVideos(String videos, HttpSession session) {
        Video video = this.videoService.queryById(videos);
        session.setAttribute("video", video);
        return "/video";
    }

    @RequestMapping("/allVideo")
    public String getAllVideos() {
        return "/allVideo";
    }

    @RequestMapping("/admin")
    public String getAdmin(HttpSession session) {
        List<User> list = userService.queryAll();
        session.setAttribute("userList", list);
        return "/admin/index";
    }

    @RequestMapping("/videos")
    public String getVideosAction(){
        return "/admin/videos";
    }

    @GetMapping("/AddVideo")
    public String getAddVideoAction(){return "/upVideo";}

    @RequestMapping("/user")
    public String getUserAction(){
        return "/user";
    }


}

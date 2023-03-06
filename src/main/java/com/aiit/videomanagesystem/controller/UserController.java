package com.aiit.videomanagesystem.controller;


import com.aiit.videomanagesystem.entity.User;
import com.aiit.videomanagesystem.entity.Video;
import com.aiit.videomanagesystem.service.UserService;
import com.aiit.videomanagesystem.service.VideoService;
import com.aiit.videomanagesystem.util.VideoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    VideoService videoService;

    @Autowired
    UserService userService;

    @PostMapping("/AddVideo")//上传视频
    public String doAddVideo(Video video, @RequestParam("videoFile") MultipartFile file, HttpSession session) throws IllegalStateException, IOException {
        //获取用户信息
        User user = null;
        Object object = session.getAttribute("user");
        if (object != null) {
            user = (User) object;
        }

        String fileName = file.getOriginalFilename();
        // 获取request对象
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                .getRequest();
        // 通过请求获取项目所在的真实路径，并指定一个存放封面图片的子目录
        String realPath = "D:\\VideoManagementSystem";
        // 检查目录是否存在
        File filePath = new File(realPath);
        if (!filePath.exists() || !filePath.isDirectory()) { // 此处应当对非文件夹进行单独处理
            filePath.mkdirs();
        }
        // 防止提交同名文件产生覆盖，使用UUID生成唯一的文件名
        String dstFileName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));

        if (dstFileName.contains(".mp4")) {
            realPath = realPath + "\\" + "video" + "\\\\" + dstFileName;
        } else {
            System.out.println("此视频需要转码");
            realPath = realPath + "\\" + "videotemp" + "\\\\" + dstFileName;
        }
        file.transferTo(new File(realPath));
        // 转存文件
        //VideoUtil.ChangeFormat(realPath,dstFileName);
        // 设置最终文件名到book对象中
        video.setSrc(realPath.replace("temp",""));
        video.setImg(VideoUtil.processImg(realPath));
        video.setDate(new Date());
        video.setUserId(user.getId());
        System.out.println(video);
        int rlt = videoService.insert(video);
        if (rlt == 1) {
            request.setAttribute("msg", "视频上传成功！");
        } else {
            request.setAttribute("msg", "视频上传失败！");
        }
        return "redirect:/index";
    }

    @PostMapping("/getAllUser")
    @ResponseBody
    public List<User> getAllUser(){
        List<User> list=this.userService.queryAll();
        System.out.println(list);
        return list;
    }
    @RequestMapping("/updateUser")
    public String getUpdate(String username, String password, String name, String birthday, String sex, String email){
        System.out.println("Update"+username+password+name+birthday+sex+email);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date=null;
        try {
            date = simpleDateFormat.parse(birthday);

        } catch (ParseException e) {
            e.printStackTrace();
        }
        User user=this.userService.queryByUserName(username);
        System.out.println(user);
        user.setName(name);
        user.setPassword(password);
        user.setBirthday(date);
        user.setSex(sex);
        user.setEmail(email);
        this.userService.update(user);
        return "redirect:/admin";
    }
}


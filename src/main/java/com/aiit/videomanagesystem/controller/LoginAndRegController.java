package com.aiit.videomanagesystem.controller;

import com.aiit.videomanagesystem.entity.User;
import com.aiit.videomanagesystem.service.UserService;
import com.aiit.videomanagesystem.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;


@Controller
public class LoginAndRegController {

    @Autowired
    UserService userService;

    @PostMapping("/LoginSubmit")
    public String submit(String inputCode, String userName, String password, HttpServletRequest request, HttpServletResponse response) {
        String code = request.getSession().getAttribute("code").toString().toLowerCase();
        System.out.println("userName:" + userName + ",password:" + password + ",code:" + code + ",inputCode:" + inputCode);
        if (code.equals(inputCode)) {
            User user = userService.queryByUserNameAndPassword(userName, password);
            if (user == null) {
                request.setAttribute("msg", "用户名或密码输入错误！");
                return "login";
            } else {
                request.getSession().setAttribute("user", user);
                if (user.getIsadmin().equals(1)) {
                    return "redirect:/admin";
                } else {
                    return "redirect:/index";
                }
            }
        }
        request.setAttribute("msg", "验证码输入错误！");
        return "login";
    }


    @RequestMapping(value = "/getSecurityCode")
    public void getSecurityCode(HttpServletResponse response, HttpServletRequest request) {
        // 通知浏览器不要缓存
        response.setHeader("Expires", "-1");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Pragma", "-1");
        SecurityUtil util = SecurityUtil.Instance();
        // 将验证码输入到session中，用来验证
        String code = util.getString();
        request.getSession().setAttribute("code", code);
        // 输出打web页面
        try {
            ImageIO.write(util.getImage(), "jpg", response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @PostMapping("/toRegister")
    public String toRegister(User user, HttpServletRequest request) {
        User tempUser = this.userService.queryByUserName(user.getUsername());
        if (tempUser == null) {
            user.setRegdate(new Date());
            System.out.println(user);
            int rlt = this.userService.insert(user);
            if (rlt == 1) {
                request.setAttribute("msg", "添加成功！");
                return "redirect:/index";
            } else {
                request.setAttribute("msg", "添加失败！请重试");
                return "/register";
            }
        } else {
            request.setAttribute("msg", "存在相同用户！");
            return "/register";
        }
    }

    @RequestMapping("/outLogin")
    public String doOutLogin(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/index";
    }
}

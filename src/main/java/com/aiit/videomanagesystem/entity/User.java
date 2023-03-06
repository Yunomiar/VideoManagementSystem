package com.aiit.videomanagesystem.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class User {
    /**
     * 用户id 自增
     */
    private String id;

    /**
     * 登陆名
     */
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * 姓名
     */
    private String name;

    /**
     * 生日
     */
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date birthday;

    /**
     * 注册时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date regdate;

    /**
     * 是否为管理员否为-1 是为1
     */
    private Integer isadmin;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 性别
     */
    private String sex;
}


package com.aiit.videomanagesystem.entity;

import java.util.Date;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Message {
    /**
     * id自增
     */
    private String id;

    /**
     * 留言用户id
     */
    private String userId;

    /**
     * 内容
     */
    private String content;

    /**
     * 留言时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date msgdate;

    /**
     * 点赞表
     */
    private String likesId;

    /**
     * 视频id
     */
    private String videoId;

    private User user;
}


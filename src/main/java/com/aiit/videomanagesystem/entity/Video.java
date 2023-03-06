package com.aiit.videomanagesystem.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Video {
    /**
     * 视频id
     */
    private String id;

    /**
     * 视频名称
     */
    private String name;

    /**
     * 视频介绍
     */
    private String info;

    /**
     * 视频热度
     */
    private String heat;

    /**
     * 点赞数
     */
    private String likes;

    /**
     * 收藏数
     */
    private String collects;

    /**
     * 视频地址
     */
    private String src;

    /**
     * 视频封面地址
     */
    private String img;

    /**
     * 上传时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date date;

    /**
     * 视频分类
     */
    private String sort;

    /**
     * 上传视频用户
     */
    private String userId;

    /**
     * 是否审核
     */
    private String ischeck;
}


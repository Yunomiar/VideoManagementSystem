package com.aiit.videomanagesystem.service;

import com.aiit.videomanagesystem.entity.Video;

import java.util.List;


public interface VideoService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Video queryById(String id);
    List<Video> queryAll();
    List<Video> queryBySort(String sort);
    List<Video> queryByUserId(String userId);
    List<Video> queryAllAmin();
    List<Video> query3();
    List<Video> queryBySort3(String sort,String videoId);


    /**
     * 新增数据
     *
     * @param video 实例对象
     * @return 实例对象
     */
    int insert(Video video);

    /**
     * 修改数据
     *
     * @param video 实例对象
     * @return 实例对象
     */
    Video update(Video video);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(String id);

}

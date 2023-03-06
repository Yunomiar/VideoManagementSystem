package com.aiit.videomanagesystem.service.impl;

import com.aiit.videomanagesystem.entity.Video;
import com.aiit.videomanagesystem.dao.VideoDao;
import com.aiit.videomanagesystem.service.VideoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("videoService")
public class VideoServiceImpl implements VideoService {
    @Resource
    private VideoDao videoDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public Video queryById(String id) {
        Video video=this.videoDao.queryById(id);
        System.out.println("Service:"+video);
        return video;
    }

    @Override
    public List<Video> queryAll() {
        List<Video> list=this.videoDao.queryAll();
        System.out.println("service:"+list);
        return list;
    }

    @Override
    public List<Video> queryBySort(String sort) {
        return this.videoDao.queryBySort(sort);
    }

    @Override
    public List<Video> queryByUserId(String userId) {
        return this.videoDao.queryByUserId(userId);
    }

    @Override
    public List<Video> queryAllAmin() {
        List<Video> list=this.videoDao.queryAllAmin();
        System.out.println("service:"+list);
        return list;
    }

    @Override
    public List<Video> query3() {
        List<Video> list=this.videoDao.query3();
        System.out.println("service:"+list);
        return list;
    }

    @Override
    public List<Video> queryBySort3(String sort,String videoId) {
        List<Video> list=this.videoDao.queryBySort3(sort,videoId);
        System.out.println("service:"+list);
        return list;
    }


    /**
     * 新增数据
     *
     * @param video 实例对象
     * @return int
     */
    @Override
    public int insert(Video video) {
        return this.videoDao.insert(video);
    }

    /**
     * 修改数据
     *
     * @param video 实例对象
     * @return 实例对象
     */
    @Override
    public Video update(Video video) {
        this.videoDao.update(video);
        return this.queryById(video.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(String id) {
        return this.videoDao.deleteById(id) > 0;
    }
}

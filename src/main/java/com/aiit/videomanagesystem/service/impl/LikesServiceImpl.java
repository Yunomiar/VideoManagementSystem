package com.aiit.videomanagesystem.service.impl;

import com.aiit.videomanagesystem.entity.Likes;
import com.aiit.videomanagesystem.dao.LikesDao;
import com.aiit.videomanagesystem.service.LikesService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * (Likes)表服务实现类
 *
 * @author makejava
 * @since 2022-01-05 02:21:03
 */
@Service("likesService")
public class LikesServiceImpl implements LikesService {
    @Resource
    private LikesDao likesDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public Likes queryById(String id) {
        return this.likesDao.queryById(id);
    }

    @Override
    public List<Likes> queryAll() {
         return this.likesDao.queryAll();
    }

    @Override
    public Likes queryByUserIdAndVideoId(String userId, String videoId) {
        System.out.println(userId+","+videoId);
        return this.likesDao.queryByUserIdAndVideoId(userId, videoId);
    }


    /**
     * 新增数据
     *
     * @param likes 实例对象
     * @return 实例对象
     */
    @Override
    public Likes insert(Likes likes) {
        this.likesDao.insert(likes);
        return likes;
    }

    /**
     * 修改数据
     *
     * @param likes 实例对象
     * @return 实例对象
     */
    @Override
    public Likes update(Likes likes) {
        this.likesDao.update(likes);
        return this.queryById(likes.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(String id) {
        return this.likesDao.deleteById(id) > 0;
    }

    @Override
    public boolean deleteByVidAndUid(String user_id, String video_id) {
        System.out.println(user_id+","+video_id);
        return this.likesDao.deleteByVidAndUid(user_id, video_id)>0;
    }
}

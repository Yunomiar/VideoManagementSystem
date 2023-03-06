package com.aiit.videomanagesystem.service;

import com.aiit.videomanagesystem.entity.Likes;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * (Likes)表服务接口
 *
 * @author makejava
 * @since 2022-01-05 02:21:02
 */
public interface LikesService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Likes queryById(String id);
    List<Likes> queryAll();
    Likes queryByUserIdAndVideoId(String userId,String videoId);


    /**
     * 新增数据
     *
     * @param likes 实例对象
     * @return 实例对象
     */
    Likes insert(Likes likes);

    /**
     * 修改数据
     *
     * @param likes 实例对象
     * @return 实例对象
     */
    Likes update(Likes likes);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(String id);
    boolean deleteByVidAndUid(String user_id, String video_id);

}

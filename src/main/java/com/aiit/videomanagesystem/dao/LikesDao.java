package com.aiit.videomanagesystem.dao;

import com.aiit.videomanagesystem.entity.Likes;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LikesDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Likes queryById(String id);
    List<Likes> queryAll();
    Likes queryByUserIdAndVideoId(@Param("userId") String userId,@Param("videoId")String videoId);



    /**
     * 统计总行数
     *
     * @param likes 查询条件
     * @return 总行数
     */
    long count(Likes likes);

    /**
     * 新增数据
     *
     * @param likes 实例对象
     * @return 影响行数
     */
    int insert(Likes likes);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Likes> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Likes> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Likes> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Likes> entities);

    /**
     * 修改数据
     *
     * @param likes 实例对象
     * @return 影响行数
     */
    int update(Likes likes);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(String id);
    int deleteByVidAndUid(@Param("userId")String user_id,@Param("videoId")String video_id);

}


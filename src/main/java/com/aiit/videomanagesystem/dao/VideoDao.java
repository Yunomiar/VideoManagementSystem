package com.aiit.videomanagesystem.dao;

import com.aiit.videomanagesystem.entity.Video;
import org.apache.ibatis.annotations.Param;


import java.util.List;


public interface VideoDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Video queryById(String id);
    Video queryByUserName(String userName);
    List<Video> queryByUserId(String userId);
    List<Video> queryAll();
    List<Video> queryBySort(String sort);
    List<Video> queryAllAmin();
    List<Video> query3();
    List<Video> queryBySort3(@Param("sort")String sort, @Param("videoId")String videoId);

    /**
     * 统计总行数
     *
     * @param video 查询条件
     * @return 总行数
     */
    long count(Video video);

    /**
     * 新增数据
     *
     * @param video 实例对象
     * @return 影响行数
     */
    int insert(Video video);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Video> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Video> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Video> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Video> entities);

    /**
     * 修改数据
     *
     * @param video 实例对象
     * @return 影响行数
     */
    int update(Video video);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(String id);

}


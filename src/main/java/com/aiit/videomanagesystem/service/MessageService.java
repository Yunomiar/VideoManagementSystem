package com.aiit.videomanagesystem.service;

import com.aiit.videomanagesystem.entity.Message;

import java.util.List;

/**
 * (Message)表服务接口
 *
 * @author makejava
 * @since 2022-01-05 02:20:48
 */
public interface MessageService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Message queryById(String id);
List<Message> queryByUserIDAndVideoId(String video_id);

    /**
     * 新增数据
     *
     * @param message 实例对象
     * @return 实例对象
     */
    Message insert(Message message);

    /**
     * 修改数据
     *
     * @param message 实例对象
     * @return 实例对象
     */
    Message update(Message message);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(String id);

}

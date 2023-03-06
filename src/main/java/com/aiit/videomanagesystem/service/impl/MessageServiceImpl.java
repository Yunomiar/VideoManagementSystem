package com.aiit.videomanagesystem.service.impl;

import com.aiit.videomanagesystem.entity.Message;
import com.aiit.videomanagesystem.dao.MessageDao;
import com.aiit.videomanagesystem.service.MessageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * (Message)表服务实现类
 *
 * @author makejava
 * @since 2022-01-05 02:20:48
 */
@Service("messageService")
public class MessageServiceImpl implements MessageService {
    @Resource
    private MessageDao messageDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public Message queryById(String id) {
        return this.messageDao.queryById(id);
    }

    @Override
    public List<Message> queryByUserIDAndVideoId( String video_id) {
        System.out.println(video_id);
        List<Message> list=this.messageDao.queryByUserIDAndVideoId(video_id);
        System.out.println("SERVICE:"+list);
        return list;
    }


    /**
     * 新增数据
     *
     * @param message 实例对象
     * @return 实例对象
     */
    @Override
    public Message insert(Message message) {
        this.messageDao.insert(message);
        return message;
    }

    /**
     * 修改数据
     *
     * @param message 实例对象
     * @return 实例对象
     */
    @Override
    public Message update(Message message) {
        this.messageDao.update(message);
        return this.queryById(message.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(String id) {
        return this.messageDao.deleteById(id) > 0;
    }
}

package com.aiit.videomanagesystem.service.impl;

import com.aiit.videomanagesystem.entity.User;
import com.aiit.videomanagesystem.dao.UserDao;
import com.aiit.videomanagesystem.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * (User)表服务实现类
 *
 * @author makejava
 * @since 2022-01-03 12:04:53
 */
@Service("userService")
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public User queryById(String id) {
        User user=this.userDao.queryById(id);
        System.out.println("Service:"+user);
        return user;
    }

    @Override
    public User queryByUserName(String username) {
        return this.userDao.queryByUserName(username);
    }

    @Override
    public User queryByUserNameAndPassword(String username, String password) {
        return this.userDao.queryByUserNameAndPassword(username, password);
    }

    @Override
    public List<User> queryAll() {
        return this.userDao.queryAll();
    }


    /**
     * 新增数据
     *
     * @param user 实例对象
     * @return 实例对象
     */
    @Override
    public int insert(User user) {

        return this.userDao.insert(user);
    }

    /**
     * 修改数据
     *
     * @param user 实例对象
     * @return 实例对象
     */
    @Override
    public int update(User user) {
        return this.userDao.update(user);
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(String id) {
        return this.userDao.deleteById(id) > 0;
    }
}

package com.note.dao;

import com.note.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

/**
 * 用户DAO
 *
 * @date 2019年12月15日
 */
@Repository
public class UserDao {
    @Autowired
    private MongoTemplate mongoTemplate;

    /**
     * 保存用户信息
     *
     * @param user
     * @return
     * @date 2019年12月15日
     */
    public boolean save(User user) {
        mongoTemplate.save(user);
        Query query = new Query();
        query.addCriteria(new Criteria().where("username").is(user.getUsername()).and("useremail").is(user.getUseremail()));
        if (mongoTemplate.findOne(query, User.class) == null) {
            return false;
        } else {
            return true;
        }
    }

    public User findById(String id) {
        Query query = new Query();
        query.addCriteria(new Criteria("_id").is(id));
        User user = mongoTemplate.findOne(query, User.class);
        return user;
    }

    public User findByEmail(String email){
        Query query = new Query();
        query.addCriteria(new Criteria("useremail").is(email));
        User user = mongoTemplate.findOne(query, User.class);
        return user;
    }

    public User findByPass(String name, String pass) {
        Query query = new Query();
        query.addCriteria(new Criteria().where("username").is(name).and("userpass").is(pass));
        User user = mongoTemplate.findOne(query, User.class);
        return user;
    }

    public User saveOrUpdate(User user) {
        User one=null;
        Query query = new Query();
        query.addCriteria(new Criteria().where("username").is(user.getUsername()).and("useremail").is(user.getUseremail()));
        if ((one=mongoTemplate.findOne(query, User.class)) == null) {
            return null;
        }
        user.setId(one.getId());
        mongoTemplate.save(user);
        user = findById(user.getId());
        return user;
    }
}

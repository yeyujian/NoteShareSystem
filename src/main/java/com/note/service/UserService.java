package com.note.service;

import com.note.dao.UserDao;
import com.note.model.User;
import com.note.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public boolean Login(User user, HttpServletRequest request) {
        try {
            user.setUserpass(MD5Utils.md5(user.getUserpass()));
            User one = userDao.findByPass(user.getUsername(), user.getUserpass());
            if (one == null) {
                return false;
            } else {
                request.getSession().setAttribute("userid", one.getId());
                request.getSession().setAttribute("username", one.getUsername());
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean register(User user) {
        try {
            User one = userDao.findByEmail(user.getUseremail());
            if (one != null) {
                return false;
            } else {
                user.setUserpass(MD5Utils.md5(user.getUserpass()));
                return userDao.save(user);
            }
        } catch (Exception e) {
            return false;
        }
    }

    public boolean changePass(User user) {
        try {
            user.setUserpass(MD5Utils.md5(user.getUserpass()));
            User one = userDao.saveOrUpdate(user);
            if (one == null) {
                return false;
            } else {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
    }
}

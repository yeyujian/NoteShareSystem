package com.note.controller;

import com.note.model.User;
import com.note.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/login/login")
    public String login(User user, Model model, HttpServletRequest request){
        if(userService.Login(user,request)){
            return "main";
        }
        model.addAttribute("index",1);
        model.addAttribute("msg","用户名或密码错误!");
        return "login";
    }

    @RequestMapping("/login/logout")
    public String logout(HttpSession session){
        //清除session
        session.invalidate();
        //重定向到登录页面的跳转方法
        return "login";
    }

    @RequestMapping("/login/regist")
    public String regsit(User user, Model model, HttpServletRequest request){

        if(userService.register(user)){
            model.addAttribute("index",1);
            model.addAttribute("msg","注册成功!");
            return "login";
        }
        model.addAttribute("msg",1);
        return "regist";
    }
    @RequestMapping("/login/changepassword")
    public String changepassword(User user, Model model, HttpServletRequest request){
        if(userService.changePass(user)){
            request.getSession().invalidate();
            model.addAttribute("index",1);
            model.addAttribute("msg","修改密码成功!");
            return "login";
        }
        model.addAttribute("msg",1);
        return "changepassword";
    }
}

package com.note.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class IndexController {

    @RequestMapping("/favicon.ico")
    public String ico() {
        return "redirect:/static/favicon.ico";
    }
    @RequestMapping("/")
    public String indexPage() {
        return "index";
    }
    @RequestMapping("/login")
    public String loginPage() {
        return "login";
    }

    @RequestMapping("/regist")
    public String registPage() {
        return "regist";
    }

    @RequestMapping("/main")
    public String mainPage() {
        return "main";
    }

    @RequestMapping("/timeline")
    public String timelinePage() {
        return "timeline";
    }

    @RequestMapping("/personal")
    public String personalPage() {
        return "personal";
    }

    @RequestMapping("/changepassword")
    public String changepasswordPage() {
        return "changepassword";
    }
}

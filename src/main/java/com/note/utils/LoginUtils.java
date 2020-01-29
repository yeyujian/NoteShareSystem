package com.note.utils;

import javax.servlet.http.HttpSession;

public class LoginUtils {
    /**
     * 登录检测
     *
     * @param session
     * @return boolean
     */
    public static boolean loginCheck(HttpSession session) {
        if(session.getAttribute("userid")!=null){
//            System.out.println((String)session.getAttribute("userid"));
            return true;
        }else{
            return false;
        }
    }

    public static void logout(HttpSession session) {
        session.removeAttribute("userid");
    }
}

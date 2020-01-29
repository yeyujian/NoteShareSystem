package com.note.controller;

import com.note.dao.NoteDao;
import com.note.dao.NoteLogDao;
import com.note.dao.UserDao;
import com.note.model.Note;
import com.note.model.NoteLog;
import com.note.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
public class testController {
    @Autowired
    private UserDao UserDao;

    @Autowired
    private NoteDao noteDao;
    @Autowired
    private NoteLogDao noteLogDao;
    @RequestMapping("/test")
    @ResponseBody
    public String testIndex() {

        NoteLog noteLog = new NoteLog();
        noteLog.setNoteid("df");
        noteLog.setOperatetime(new Date());
        noteLog.setOperation("operation");
        noteLogDao.save(noteLog);
      return "ddd";
    }
}

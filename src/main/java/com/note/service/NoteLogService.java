package com.note.service;

import com.note.dao.NoteLogDao;
import com.note.model.NoteLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoteLogService {

    @Autowired
    private NoteLogDao noteLogDao;

    public List<NoteLog> getNoteLogsByNote(String noteid){

            try {
                return noteLogDao.getList(noteid);
            } catch (Exception e) {
                return null;
            }

    }

    public List<NoteLog> getNoteLogsByUser(String userid){

        try {
            return noteLogDao.getList(userid);
        } catch (Exception e) {
            return null;
        }

    }
}

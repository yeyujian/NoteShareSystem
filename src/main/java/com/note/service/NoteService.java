package com.note.service;


import com.note.dao.NoteDao;
import com.note.dao.NoteLogDao;
import com.note.model.Barrage;
import com.note.model.Note;
import com.note.model.NoteLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class NoteService {
    @Autowired
    private NoteDao noteDao;
    @Autowired
    private NoteLogDao noteLogDao;

    public List<Note> getAllNote() {
        try {
            return noteDao.findAll();
        } catch (Exception e) {
            return null;
        }
    }

    public List<Note> getByUser(String userid) {
        try {
            return noteDao.findByUserID(userid);
        } catch (Exception e) {
            return null;
        }
    }

    public Note getByID(String id) {
        try {
            return noteDao.findById(id);
        } catch (Exception e) {
            return null;
        }
    }

    public Note change(Note note) {
        try {
            addLog("changed",note);
            return noteDao.saveOrUpdate(note);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean creatNote(Note note) {
        try {
            Note one=null;
            if((one=noteDao.save(note))!=null){
                addLog("created",one);
                System.out.println("created");
                return true;
            }else{
                return false;
            }

        } catch (Exception e) {
            return false;
        }

    }

    public boolean delectNote(Note note){
        try {
            addLog("deleted",note);
            return noteDao.delete(note.getId());
        } catch (Exception e) {
            return false;
        }
    }

    private boolean addLog(String operation, Note note) {
        NoteLog noteLog = new NoteLog();
        noteLog.setNoteid(note.getId());
        noteLog.setUserid(note.getAutherID());
        noteLog.setOperatetime(new Date());
        noteLog.setOperation(operation);
        return noteLogDao.save(noteLog);
    }
}

package com.note.service;


import com.note.dao.BarrageDao;
import com.note.model.Barrage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BarrageService {
    @Autowired
    private BarrageDao barrageDao;

    public List<Barrage> getBarragesByNote(String noteid) {
        try {
            return barrageDao.getList(noteid);
        } catch (Exception e) {
            return null;
        }
    }
    public boolean addBarrage(Barrage barrage){
        try {
            return barrageDao.save(barrage);
        } catch (Exception e) {
            return false;
        }
    }

    public List<Barrage> getAllBarrage(){
        try {
            return barrageDao.getAll();
        } catch (Exception e) {
            return null;
        }
    }
}

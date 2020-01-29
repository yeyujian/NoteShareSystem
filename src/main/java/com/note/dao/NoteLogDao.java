package com.note.dao;

import com.mongodb.WriteResult;
import com.note.model.Barrage;
import com.note.model.NoteLog;
import com.note.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NoteLogDao {

    @Autowired
    private MongoTemplate mongoTemplate;

    public NoteLog findById(String id) {
        return mongoTemplate.findById(id, NoteLog.class);
    }


    public boolean delete(String id) {
        Query query = new Query();
        query.addCriteria(new Criteria().where("_id").is(id));
        WriteResult result = mongoTemplate.remove(query, NoteLog.class);
        if (result.getN() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean save(NoteLog noteLog) {
        mongoTemplate.save(noteLog);
        Query query = new Query();
        query.addCriteria(new Criteria().where("operatetime").is(noteLog.getOperatetime()));
        if (mongoTemplate.findOne(query, NoteLog.class) == null) {
            return false;
        } else {
            return true;
        }
    }

    public List<NoteLog> getList(String id){
        Query query = new Query();
        query.addCriteria(new Criteria().where("userid").is(id));
        List<NoteLog> noteLogs = mongoTemplate.find(query, NoteLog.class);
        return noteLogs;
    }
}

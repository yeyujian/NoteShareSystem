package com.note.dao;


import com.mongodb.BasicDBObject;
import com.mongodb.WriteResult;
import com.note.model.Note;
import com.note.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NoteDao {

    @Autowired
    private MongoTemplate mongoTemplate;

    public Note findById(String id) {
        return mongoTemplate.findById(id, Note.class);
    }

    public Note saveOrUpdate(Note note) {
        Note one=null;
        Query query = new Query();
        query.addCriteria(new Criteria().where("_id").is(note.getId()).and("autherID").is(note.getAutherID()));
        if ((one=mongoTemplate.findOne(query, Note.class)) == null) {
            return null;
        }
        note.setId(one.getId());
        mongoTemplate.save(note);
        note = findById(note.getId());
        return note;
    }

    public boolean delete(String id) {
        Query query = new Query();
        query.addCriteria(new Criteria().where("_id").is(id));
        WriteResult result = mongoTemplate.remove(query, Note.class);
        if (result.getN() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public List<Note> findByUserID(String id){

        BasicDBObject dbObject = new BasicDBObject();
        dbObject.put("autherID", id);
        //指定返回的字段
        BasicDBObject fieldsObject = new BasicDBObject();
        fieldsObject.put("_id", true);
        fieldsObject.put("notename", true);
        fieldsObject.put("changedate", true);
        Query query = new BasicQuery(dbObject, fieldsObject);
        List<Note> notes = mongoTemplate.find(query, Note.class);
        return notes;
    }

    public List<Note> findAll(){

        BasicDBObject dbObject = new BasicDBObject();
//        dbObject.put("_id", id);
        //指定返回的字段
        BasicDBObject fieldsObject = new BasicDBObject();
        fieldsObject.put("_id", true);
        fieldsObject.put("notename", true);
        fieldsObject.put("auther", true);
        fieldsObject.put("changedate", true);
        Query query = new BasicQuery(dbObject, fieldsObject);
        List<Note> notes = mongoTemplate.find(query, Note.class);
        return notes;
    }

    public Note save(Note note) {
        mongoTemplate.save(note);
        Note one=null;
        Query query = new Query();
        query.addCriteria(new Criteria().where("createdate").is(note.getCreatedate()));
        if ((one=mongoTemplate.findOne(query, Note.class)) != null) {
            return one;
        } else {
            return null;
        }
    }
}

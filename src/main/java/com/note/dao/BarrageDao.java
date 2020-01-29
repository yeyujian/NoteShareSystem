package com.note.dao;

import com.mongodb.WriteResult;
import com.note.model.Barrage;
import com.note.model.Note;
import com.note.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 弹幕DAO
 *
 * @date 2019年12月15日
 */
@Repository
public class BarrageDao {
    @Autowired
    private MongoTemplate mongoTemplate;

    public Barrage findById(String id) {
        return mongoTemplate.findById(id, Barrage.class);
    }


    public boolean delete(String id) {
        Query query = new Query();
        query.addCriteria(new Criteria().where("_id").is(id));
        WriteResult result = mongoTemplate.remove(query, Barrage.class);
        if (result.getN() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean save(Barrage barrage) {
        mongoTemplate.save(barrage);
        Query query = new Query();
        query.addCriteria(new Criteria().where("date").is(barrage.getDate()));
        if (mongoTemplate.findOne(query, Barrage.class) == null) {
            return false;
        } else {
            return true;
        }
    }

    public List<Barrage> getList(String id){
        Query query = new Query();
        query.addCriteria(new Criteria().where("noteID").is(id));
        List<Barrage> barrages = mongoTemplate.find(query, Barrage.class);
        return barrages;
    }

    public List<Barrage> getAll(){
        Query query = new Query();
        query.with(new Sort(Sort.Direction.ASC, "_id")).limit(500);
        List<Barrage> barrages = mongoTemplate.find(query, Barrage.class);
        return barrages;
    }
}

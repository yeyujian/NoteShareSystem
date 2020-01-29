package com.note.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Collection;

@Document(collection = "t_user")
public class User {
    @Id
    private String id;
    private String username;
    private String userpass;
    private String useremail;

    public String getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getUserpass() {
        return userpass;
    }

    public String getUseremail() {
        return useremail;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setUserpass(String userpass) {
        this.userpass = userpass;
    }

    public void setUseremail(String useremail) {
        this.useremail = useremail;
    }


}

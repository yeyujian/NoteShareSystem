package com.note.controller;

import com.note.model.Note;
import com.note.model.NoteLog;
import com.note.model.User;
import com.note.service.NoteLogService;
import com.note.service.NoteService;
import com.note.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class NoteController {
    @Autowired
    private NoteService noteService;
    @Autowired
    private NoteLogService noteLogService;

    @RequestMapping("/note/save")
    @ResponseBody
    public Map<String, Object> noteSave(@RequestBody Map<String, Object> map, HttpSession session) {
        Note note = new Note();
        note.setNotename((String) map.get("name"));
//        System.out.println((String) session.getAttribute("username"));
        note.setAuther((String) session.getAttribute("username"));
        note.setChangedate(new Date());
        note.setCreatedate(new Date());
        note.setNotetext((String) map.get("data"));
        note.setAutherID((String) session.getAttribute("userid"));
        noteService.creatNote(note);
        return map;
    }

    @RequestMapping("/note/delete")
    @ResponseBody
    public String noteDel(@RequestParam("id") String id, HttpSession session) {
        Note note = new Note();
        note.setId(id);
        note.setAutherID((String) session.getAttribute("userid"));
        note.setAuther((String) session.getAttribute("username"));
        if (noteService.delectNote(note)) {
            return "success";
        }
        return "failed";
    }

    @RequestMapping("/note/view")
    @ResponseBody
    public String noteView(@RequestParam("id") String id) {
        Note note = noteService.getByID(id);
        return note.getNotetext();
    }

    @RequestMapping("/note/change")
    @ResponseBody
    public Map<String, Object> noteChange(@RequestBody Map<String, Object> map, HttpSession session) {
        Note note = new Note();
        note.setId((String) map.get("id"));
        note.setNotename((String) map.get("name"));
        note.setAuther((String) session.getAttribute("username"));
        note.setChangedate(new Date());
        note.setCreatedate(new Date());
        note.setNotetext((String) map.get("data"));
        note.setAutherID((String) session.getAttribute("userid"));
        noteService.change(note);
        return map;
    }

    @RequestMapping("/note/get")
    @ResponseBody
    public Map<String, Object> noteGet(HttpSession session) {
//        System.out.println((String)session.getAttribute("userid"));
        List<Note> notes = noteService.getByUser((String) session.getAttribute("userid"));
        Map<String, Object> map = new HashMap<String, Object>();
        List<String> list = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (int i = 0; i < notes.size(); i++) {
            list.add(notes.get(i).getNotename());
            list.add(sdf.format(notes.get(i).getChangedate()));
            list.add(notes.get(i).getId());
        }
        map.put("data", list);
        return map;
    }

    @RequestMapping("/note/getall")
    @ResponseBody
    public Map<String, Object> noteGetAll() {

        List<Note> notes = noteService.getAllNote();
        Map<String, Object> map = new HashMap<String, Object>();
        List<String> list = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (int i = 0; i < notes.size(); i++) {
            list.add(notes.get(i).getNotename());
            list.add(notes.get(i).getAuther());
            list.add(sdf.format(notes.get(i).getChangedate()));
            ;
            list.add(notes.get(i).getId());
            ;
        }
        map.put("data", list);
        return map;
    }

    @RequestMapping("/note/getlog")
    @ResponseBody
    public List<String> noteGetLog(HttpSession session) {
        List<NoteLog> logs = noteLogService.getNoteLogsByUser((String) session.getAttribute("userid"));
        List<String> list = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (int i = 0; i < logs.size(); i++) {
            list.add(logs.get(i).getNoteid());
            list.add(sdf.format(logs.get(i).getOperatetime()));
            list.add(logs.get(i).getOperation());
        }
        return list;
    }
}

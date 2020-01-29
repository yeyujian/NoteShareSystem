package com.note.controller;

import com.note.model.Barrage;
import com.note.model.Note;
import com.note.service.BarrageService;
import com.note.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class BarrageController {

    @Autowired
    private BarrageService barrageService;

    @RequestMapping("/barrage/getall")
    @ResponseBody
    public List<Object> barrageGetAll() {
        List<Barrage> barrages = barrageService.getAllBarrage();
        List<Object> list = new ArrayList<>();
        for (int i = 0; i < barrages.size(); i++) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("info", barrages.get(i).getBarragetext());
            list.add(map);
        }
        return list;
    }

    @RequestMapping("/barrage/add")
    @ResponseBody
    public String barrageAdd(@RequestBody Barrage barrage, HttpSession session) {

        barrage.setFrom((String) session.getAttribute("userid"));
        barrage.setDate(new Date());
        if (barrageService.addBarrage(barrage)) {
            return "true";
        } else {
            return "false";
        }

    }
}

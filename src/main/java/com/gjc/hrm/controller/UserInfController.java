package com.gjc.hrm.controller;

import com.alibaba.fastjson.JSONObject;
import com.gjc.hrm.domain.PageBean;
import com.gjc.hrm.domain.UserInf;
import com.gjc.hrm.service.UserInfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserInfController {

    @Autowired
    UserInfService userInfService;

    @RequestMapping("/findUserInfPaging.action")
    @ResponseBody
    public String  findUserInfPaging(int page,int rows){
        int count = userInfService.findAllUserCount();
        PageBean pageBean = new PageBean(page,rows,count);
        pageBean.setTotalRecord(count);
        List<UserInf> userInfList = userInfService.findAUserInfPaging(pageBean.getStartIndex(),pageBean.getPageSize());
        Map<String,Object> map = new HashMap<>();
        map.put("rows",userInfList);
        map.put("total",count);
        String rst = JSONObject.toJSON(map).toString();
        System.out.println(rst);
        return rst;
    }

    @RequestMapping("/addUserInf.action")
    @ResponseBody
    public String addUserInf(UserInf userInf){
        if (userInf.getUsername() == null || userInf.getUsername() == ""
                ||userInf.getLoginname() == null || userInf.getLoginname() == ""
                ||userInf.getPassword() == null || userInf.getPassword() == ""
                ||userInf.getStatus() ==null )
            return "0";
       int rst = userInfService.addUserInf(userInf);
        return rst+"";
    }
}
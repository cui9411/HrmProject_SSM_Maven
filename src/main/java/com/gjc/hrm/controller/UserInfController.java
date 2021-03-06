package com.gjc.hrm.controller;

import com.alibaba.fastjson.JSONObject;
import com.gjc.hrm.domain.PageBean;
import com.gjc.hrm.domain.UserInf;
import com.gjc.hrm.service.UserInfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserInfController {

    @Autowired
    UserInfService userInfService;

    @RequestMapping("/findUserInfPaging.action")
    @ResponseBody
    public String  findUserInfPaging(int page,int rows,String startTime,String endTime,String searchStatus,String searchName) throws ParseException {
        System.out.println(page+":"+rows+":"+startTime+":"+endTime+":"+searchStatus+":"+searchName);
        int count = userInfService.findAllUserCount(startTime,endTime,searchStatus,searchName);
        PageBean pageBean = new PageBean(page,rows,count);
        pageBean.setTotalRecord(count);
        List<UserInf> userInfList = userInfService.findAUserInfPaging(pageBean.getStartIndex(),pageBean.getPageSize(),startTime,endTime,searchStatus,searchName);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",userInfList);
        map.put("total",count);
        String rst = JSONObject.toJSON(map).toString();
        //System.out.println(rst);
        return rst;
    }

    @RequestMapping("/addUserInf.action")
    @ResponseBody
    public String addUserInf(UserInf userInf){
        if (userInf.getUsername() == null || userInf.getUsername() == ""
                ||userInf.getLoginname() == null || userInf.getLoginname() == ""
                ||userInf.getPassword() == null || userInf.getPassword() == ""
                ||userInf.getStatus() ==null )
            return "lack";
       int rst = userInfService.addUserInf(userInf);
        if (rst ==1)
            return "ok";
        else
            return "fail";
    }

    @RequestMapping(value = "/findUserInfById.action",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String findUserInfById(int id){
        UserInf userInf = userInfService.findUserInfById(id);
        String rst = JSONObject.toJSON(userInf).toString();
        return rst;
    }

    @RequestMapping("/editUserInf.action")
    @ResponseBody
    public String editUserInf(UserInf userInf){
        if (userInf.getUsername() == null || userInf.getUsername() == ""
                ||userInf.getStatus() == null )
            return "lack";
        int rst = userInfService.editUserInf(userInf);
        if (rst ==1)
            return "ok";
        else
            return "fail";
    }

    @RequestMapping("/deleteUserInfById.action")
    @ResponseBody
    public String deleteUserInfById(int[] ids){
        if (ids.length == 0){
            return "lack";
        }
        int rst = userInfService.deleteUserInfById(ids);
        if (rst ==1)
            return "ok";
        else
            return "fail";
    }

    @RequestMapping("/resetUserPasswordById.action")
    @ResponseBody
    public String resetUserPasswordById(int[] ids){
        if (ids.length == 0){
            return "lack";
        }
        int rst = userInfService.resetUserPasswordById(ids);
        if (rst == 1){
            return "ok";
        }else {
            return "fail";
        }
    }

    @RequestMapping("/changePassword.action")
    @ResponseBody
    public String changePassword(HttpServletRequest request,String oldPassword, String newPassword, String reNewPassword){
        if (oldPassword == null || oldPassword == "" ||
                newPassword == null || newPassword == ""
                || reNewPassword == null || reNewPassword == ""){
            return "lack";
        }
        int userId = (int) request.getSession().getAttribute("userId");
        int rst = userInfService.changePassword(userId,oldPassword,newPassword,reNewPassword);
        if (rst == 1){
            return "ok";
        }else {
            return "fail";
        }
    }
}

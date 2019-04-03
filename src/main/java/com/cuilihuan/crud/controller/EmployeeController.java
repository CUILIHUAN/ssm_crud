package com.cuilihuan.crud.controller;

import com.cuilihuan.crud.bean.Employee;
import com.cuilihuan.crud.bean.Msg;
import com.cuilihuan.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Auther:Cu i LiHuan
 * @Date: 2019/4/1 13:45
 * @Description:
 */

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    //导入Jaskson包 json才能正常工作
    @RequestMapping("/emp")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn
        , Model model) {
//      在插入之前只需要调用 ，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        //引入PageHelper分布插件
        List<Employee> emps = employeeService.getAll();
//        使用pageInfo包装查询后的结果，只需要将PageInfo交给页面,传入连续显示的页面
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}

package com.cuilihuan.crud.service;

import com.cuilihuan.crud.bean.Employee;
import com.cuilihuan.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Auther:Cui LiHuan
 * @Date: 2019/4/1 13:47
 * @Description:
 */

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDpet(null);
    }
}

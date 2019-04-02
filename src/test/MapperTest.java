import com.cuilihuan.crud.bean.Department;
import com.cuilihuan.crud.bean.Employee;
import com.cuilihuan.crud.dao.DepartmentMapper;
import com.cuilihuan.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @Auther:Cui LiHuan
 * @Date: 2019/4/1 10:41
 * @Description: 使用Spirng的项目单元测试，可以自动的注入
 *
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.支持@AutoWird自动装配
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;


    /**
     * 测试DepartMentMapper
     */
    @Test
    public void testCRUD() {
//        //1.创建SpringIoc容器
//        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("application.xml");
//        //2.从容器中获取mapper
//        DepartmentMapper bean = applicationContext.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);

//        1.插入几个数据
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "技术部"));
//        employeeMapper.insertSelective(new Employee(null, "Jerry", "女", "1738127840@qq.com", 1));
//        批量插入多个员工、批量，使用执行操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uuid , "M", uuid+"@cuilihuan.com", 1));
        }


    }
}

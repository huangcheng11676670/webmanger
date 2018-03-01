package com.jspxcms.core.service.impl;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jspxcms.core.AbstractServiceTest;
import com.jspxcms.core.domain.User;
import com.jspxcms.core.service.UserService;

public class UserServiceTest extends AbstractServiceTest {

    @Autowired
    UserService userService;
    
    @Test
    public void findAreaListByPid() {
        List<User> list  = userService.selectAll();
        list.forEach(item -> System.out.println(item.getId()));
    }
}

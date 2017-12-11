package com.jspxcms.core;

import java.util.Optional;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jspxcms.core.domain.User;
import com.jspxcms.core.repository.TestUserDao;

public class JpaDaoTest extends AbstractServiceTest{

    @Autowired
    TestUserDao dao;
    
    @Test
    public void test() {
        Optional<User> optUser =  dao.findById(1);
        optUser.ifPresent(item -> System.out.println(optUser.get().getUsername()));
    }
}

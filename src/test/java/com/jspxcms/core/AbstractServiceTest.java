package com.jspxcms.core;

import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//@TestPropertySource(locations = { "classpath:application-test.properties" })
//@SpringBootTest
@SpringBootTest(classes = Application.class)
@RunWith(SpringJUnit4ClassRunner.class)
public abstract class AbstractServiceTest {


}
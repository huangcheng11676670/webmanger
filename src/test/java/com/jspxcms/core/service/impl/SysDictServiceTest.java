package com.jspxcms.core.service.impl;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.jspxcms.core.AbstractServiceTest;
import com.jspxcms.core.dto.TreeDto;
import com.jspxcms.core.service.SysDictService;

public class SysDictServiceTest extends AbstractServiceTest {

    @Autowired
    SysDictService sysDictService;
    
    @Test
    public void findAreaListByPid() {
        TreeDto dto = new TreeDto();
        sysDictService.findAreaListByPid(dto, 9);
        System.out.println(JSON.toJSONString(dto));
    }

}

package com.jspxcms.core.web.back;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.service.SysDictService;

/**
 * 报表管理
 */
@Controller
@RequestMapping("/core/reports")
public class ReportsController {
    @Autowired
    private SysDictService sysDictService;

    @RequiresPermissions("core:reports:list")
    @RequestMapping("test.do")
    public String test() {
        return "core/reports/test";
    }

    @RequiresPermissions("core:reports:list")
    @RequestMapping("list.do")
    public String list(Model modelMap) {
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        return "core/reports/list";
    }
}
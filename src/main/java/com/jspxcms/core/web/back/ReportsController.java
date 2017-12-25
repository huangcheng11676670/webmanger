package com.jspxcms.core.web.back;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 报表管理
 */
@Controller
@RequestMapping("/core/reports")
public class ReportsController {

    @RequiresPermissions("core:sentiment:list")
    @RequestMapping("test.do")
    public String test() {
        return "core/reports/test";
    }
}
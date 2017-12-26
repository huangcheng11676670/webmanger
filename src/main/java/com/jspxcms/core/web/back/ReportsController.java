package com.jspxcms.core.web.back;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jspxcms.common.util.MessageUtils;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.dto.ReportSentimentNumDto;
import com.jspxcms.core.service.SentimentService;
//github.com/huangcheng11676670/webmanger.git
import com.jspxcms.core.service.SysDictService;

/**
 * 报表管理
 */
@Controller
@RequestMapping("/core/reports")
public class ReportsController {
    @Autowired
    private SysDictService sysDictService;

    @Autowired
    private SentimentService sentimentService;

    /**
     * 业务数据
     * @param modelMap
     * @return
     */
    @RequiresPermissions("core:reports:list")
    @RequestMapping("list.do")
    public String list(Model modelMap) {
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        return "core/reports/reports_list";
    }

    @RequiresPermissions("core:reports:list")
    @RequestMapping("sentiment_data.do")
    public Object sentimentData(Integer userid, String startDate, String endDate) {
        List<ReportSentimentNumDto> dtoList = sentimentService.reportSentimentNumNativeQuery(userid, startDate, endDate);
        return MessageUtils.sucessMsg("获取成功", dtoList);
    }
}
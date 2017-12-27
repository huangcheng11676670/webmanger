package com.jspxcms.core.web.back;

import java.text.ParseException;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jspxcms.common.util.DateUtils;
import com.jspxcms.common.util.MessageUtils;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.domain.SysFavorite;
import com.jspxcms.core.dto.ReportSentimentNumDto;
import com.jspxcms.core.dto.ReportCountAndIdDto;
import com.jspxcms.core.service.SentimentService;
//github.com/huangcheng11676670/webmanger.git
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.service.SysFavoriteService;

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

    @Autowired
    private SysFavoriteService sysFavoriteService;
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

    @ResponseBody
    @RequiresPermissions("core:reports:list")
    @RequestMapping("sentiment_data.do")
    public Object sentimentData(Integer userid, String startDate, String endDate) {
        if(StringUtils.isBlank(startDate)){
            return MessageUtils.failMsg("开始日期不能为空");
        }
        if(StringUtils.isBlank(endDate)){
            return MessageUtils.failMsg("结束日期不能为空");
        }
        //日期间隔不能超过一个月
        try {
            int dayNum = DateUtils.daysBetween(DateUtils.getDateString(startDate), DateUtils.getDateString(endDate));
            if(dayNum > 30) {
                return MessageUtils.failMsg("日期不能超过30天");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<ReportSentimentNumDto> dtoList = sentimentService.reportSentimentNumNativeQuery(userid, startDate, endDate);
        return MessageUtils.sucessMsg("获取成功", dtoList);
    }

    /**
     * 饼图，按收藏夹分
     * @param userid
     * @param startDate
     * @param endDate
     * @return
     */
    @ResponseBody
    @RequiresPermissions("core:reports:list")
    @RequestMapping("sentiment_pie_data.do")
    public Object sentimentPieData(Integer userid, String startDate, String endDate) {
        if(StringUtils.isBlank(startDate)){
            return MessageUtils.failMsg("开始日期不能为空");
        }
        if(StringUtils.isBlank(endDate)){
            return MessageUtils.failMsg("结束日期不能为空");
        }
        //日期间隔不能超过一个月
        try {
            int dayNum = DateUtils.daysBetween(DateUtils.getDateString(startDate), DateUtils.getDateString(endDate));
            if(dayNum > 31) {
                return MessageUtils.failMsg("日期不能超过31天");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<ReportCountAndIdDto> dtoList = sentimentService.reportSentimentPieNativeQuery(userid, startDate, endDate);
        if(dtoList != null) {
            dtoList.forEach(item -> {
                SysFavorite dbFavorite = sysFavoriteService.get(item.getFavoriteid());
                item.setFavoriteName(dbFavorite.getFavoriteName());
            });
        }
        return MessageUtils.sucessMsg("获取成功", dtoList);
    }
    /**
     * 柱状图，按行政区分
     * @param userid
     * @param startDate
     * @param endDate
     * @return
     */
    @ResponseBody
    @RequiresPermissions("core:reports:list")
    @RequestMapping("sentiment_bar_data.do")
    public Object sentimentAreaData(String startDate, String endDate) {
        if(StringUtils.isBlank(startDate)){
            return MessageUtils.failMsg("开始日期不能为空");
        }
        if(StringUtils.isBlank(endDate)){
            return MessageUtils.failMsg("结束日期不能为空");
        }
        //日期间隔不能超过一个月
        try {
            int dayNum = DateUtils.daysBetween(DateUtils.getDateString(startDate), DateUtils.getDateString(endDate));
            if(dayNum > 31) {
                return MessageUtils.failMsg("日期不能超过31天");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<ReportCountAndIdDto> dtoList = sentimentService.reportSentimentAreaNativeQuery(startDate, endDate);
        if(dtoList != null) {
            dtoList.forEach(item -> {
                SysDict dbSysDict = sysDictService.get(item.getFavoriteid());
                item.setFavoriteName(dbSysDict.getLabel());
            });
        }
        return MessageUtils.sucessMsg("获取成功", dtoList);
    }
}
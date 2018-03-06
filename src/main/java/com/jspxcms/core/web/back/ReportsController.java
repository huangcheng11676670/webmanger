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
import com.jspxcms.core.domain.User;
import com.jspxcms.core.dto.ReportContractDto;
import com.jspxcms.core.dto.ReportCountAndIdDto;
import com.jspxcms.core.dto.ReportSentimentNumDto;
import com.jspxcms.core.dto.ReportUserSentimentDto;
import com.jspxcms.core.dto.ReportUserTimeDto;
import com.jspxcms.core.service.ContractService;
import com.jspxcms.core.service.SentimentService;
//github.com/huangcheng11676670/webmanger.git
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.service.SysFavoriteService;
import com.jspxcms.core.service.UserService;
import com.jspxcms.core.service.UserViewTimeService;

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

    @Autowired
    private ContractService contractService;

    @Autowired
    private UserViewTimeService userViewTimeService;

    @Autowired
    private UserService userService;
    
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
    
    /**
     * 销售数据
     * @param modelMap
     * @return
     */
    @RequiresPermissions("core:reports:list")
    @RequestMapping("saleList.do")
    public String saleList(Model modelMap) {
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        return "core/reports/reports_sale_list";
    }
    
    /**
     * 合同统计， 柱状图，按行政区分
     * @param userid
     * @param startDate
     * @param endDate
     * @return
     */
    @ResponseBody
    @RequiresPermissions("core:reports:list")
    @RequestMapping("contract_bar_data.do")
    public Object contractAreaData(Integer areaId, String startDate, String endDate) {
        if(StringUtils.isBlank(startDate)){
            return MessageUtils.failMsg("开始日期不能为空");
        }
        if(StringUtils.isBlank(endDate)){
            return MessageUtils.failMsg("结束日期不能为空");
        }
        //日期间隔不能超过一个月
        try {
            int dayNum = DateUtils.daysBetween(DateUtils.getDateString(startDate), DateUtils.getDateString(endDate));
            if(dayNum > 365) {
                return MessageUtils.failMsg("日期不能超过1年");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<ReportContractDto> dtoList = contractService.reportContractAreaNativeQuery(areaId, startDate, endDate);
        return MessageUtils.sucessMsg("获取成功", dtoList);
    }
    /**
     * 监测员数据
     * @param modelMap
     * @return
     */
    @RequiresPermissions("core:reports:list")
    @RequestMapping("userList.do")
    public String userList(Model modelMap) {
        List<User> userList = userService.selectAll();
        modelMap.addAttribute("userList", userList);
        return "core/reports/reports_user_list";
    }
    
    /**
     * 员工舆情采集数据统计
     * @param userid
     * @param startDate
     * @param endDate
     * @return
     */
    @ResponseBody
    @RequiresPermissions("core:reports:list")
    @RequestMapping("user_bar_data.do")
    public Object userBarData(Integer userId, String startDate, String endDate) {
        if(StringUtils.isBlank(startDate)){
            return MessageUtils.failMsg("开始日期不能为空");
        }
        if(StringUtils.isBlank(endDate)){
            return MessageUtils.failMsg("结束日期不能为空");
        }
        //日期间隔不能超过一个月
        try {
            int dayNum = DateUtils.daysBetween(DateUtils.getDateString(startDate), DateUtils.getDateString(endDate));
            if(dayNum > 365) {
                return MessageUtils.failMsg("日期不能超过1年");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<ReportUserSentimentDto> dtoList = contractService.reportUserSentimentNativeQuery(userId, startDate, endDate);
        dtoList.forEach(item -> {
            SysFavorite dbSysFavorite = sysFavoriteService.get(item.getFavoriteId());
            if(dbSysFavorite != null) {
                item.setFavoriteName(dbSysFavorite.getFavoriteName());
            }
        });
        return MessageUtils.sucessMsg("获取成功", dtoList);
    }
    /**
     * 员工舆情分类浏览时长
     * @param userid
     * @param startDate
     * @param endDate
     * @return
     */
    @ResponseBody
    @RequiresPermissions("core:reports:list")
    @RequestMapping("usertime_bar_data.do")
    public Object userTimeBarData(Integer userId, String startDate, String endDate) {
        if(StringUtils.isBlank(startDate)){
            return MessageUtils.failMsg("开始日期不能为空");
        }
        if(StringUtils.isBlank(endDate)){
            return MessageUtils.failMsg("结束日期不能为空");
        }
        //日期间隔不能超过一个月
        try {
            int dayNum = DateUtils.daysBetween(DateUtils.getDateString(startDate), DateUtils.getDateString(endDate));
            if(dayNum > 365) {
                return MessageUtils.failMsg("日期不能超过1年");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<ReportUserTimeDto> dtoList = userViewTimeService.reportUserTimeNativeQuery(userId, startDate, endDate);
        dtoList.forEach(item -> {
            SysFavorite dbSysFavorite = sysFavoriteService.get(item.getFavoriteId().intValue());
            if(dbSysFavorite != null) {
                item.setFavoriteName(dbSysFavorite.getFavoriteName());
            }
        });
        return MessageUtils.sucessMsg("获取成功", dtoList);
    }
}
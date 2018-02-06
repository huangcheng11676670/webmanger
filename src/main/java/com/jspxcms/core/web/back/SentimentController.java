package com.jspxcms.core.web.back;

import static com.jspxcms.core.constant.Constants.CREATE;
import static com.jspxcms.core.constant.Constants.DELETE_SUCCESS;
import static com.jspxcms.core.constant.Constants.EDIT;
import static com.jspxcms.core.constant.Constants.MESSAGE;
import static com.jspxcms.core.constant.Constants.OPRT;
import static com.jspxcms.core.constant.Constants.SAVE_SUCCESS;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jspxcms.common.util.AliyunSMSUtils;
import com.jspxcms.common.util.HtmlAnalysisUtils;
import com.jspxcms.common.util.MessageUtils;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.constant.Constants;
import com.jspxcms.core.domain.Customer;
import com.jspxcms.core.domain.Sentiment;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.domain.SysFavorite;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.OperationLogService;
import com.jspxcms.core.service.SentimentService;
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.service.SysFavoriteService;
import com.jspxcms.core.support.Backends;
import com.jspxcms.core.support.Context;

/**
 * 舆情管理
 */
@Controller
@RequestMapping("/core/sentiment")
public class SentimentController {
    private static final Logger logger = LoggerFactory.getLogger(SentimentController.class);

    @Resource(name="aliyunSMSUtils")
    private AliyunSMSUtils aliyunSMSUtils;
    @Autowired
    private OperationLogService logService;

    @Autowired
    private SentimentService service;

    @Autowired
    private SysDictService sysDictService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private SysFavoriteService sysFavoriteService;

    @Autowired  
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;  

    @ModelAttribute("bean")
    public Sentiment preloadBean(@RequestParam(required = false) Integer oid) {
        return oid != null ? service.get(oid) : null;
    }

    @RequiresPermissions("core:sentiment:list")
    @RequestMapping("list.do")
    public String list(@PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Map<String, String[]> params = Servlets.getParamValuesMap(request, Constants.SEARCH_PREFIX);
        List<Sentiment> pagedList = service.findList(siteId, params, pageable.getSort());
        pagedList.forEach(item -> {
            item.setInfoLevelShow(sysDictService.getLabelById(item.getInfoLevel()));
            item.setInfoTypeShow(sysDictService.getLabelById(item.getInfoType()));
        });
        modelMap.addAttribute("pagedList", pagedList);
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        return "core/sentiment/sentiment_list";
    }

    @RequiresPermissions("core:sentiment:list")
    @RequestMapping("listCase.do")
    public String listByCase(@PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Map<String, String[]> params = Servlets.getParamValuesMap(request, Constants.SEARCH_PREFIX);
        params.put("EQ_caseStatus_Boolean", new String[]{"true"});
        List<Sentiment> pagedList = service.findList(siteId, params, pageable.getSort());
        pagedList.forEach(item -> {
            item.setInfoLevelShow(sysDictService.getLabelById(item.getInfoLevel()));
            item.setInfoTypeShow(sysDictService.getLabelById(item.getInfoType()));
        });
        modelMap.addAttribute("pagedList", pagedList);
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        return "core/sentiment/sentiment_case_list";
    }

    @RequiresPermissions("core:sentiment:list")
    @RequestMapping("favoriteList.do")
    public String favoriteList(org.springframework.ui.Model modelMap) {
        modelMap.addAttribute("pagedList", sysFavoriteService.findAll());
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        return "core/sentiment/sentiment_favorite_list";
    }

    @RequiresPermissions("core:sentiment:create")
    @RequestMapping("create.do")
    public String create(Integer id, 
            @RequestParam(name="favoriteId", required=true)Integer favoriteId, HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        SysFavorite  favorite  = sysFavoriteService.get(favoriteId);
        if(favorite != null) {
            modelMap.addAttribute("favorite", favorite);
            Sentiment bean = new Sentiment();
            bean.setAreaId(favorite.getCustomer().getAreaId());
            bean.setFavoriteId(favoriteId);
            bean.setCustomer(favorite.getCustomer());
            modelMap.addAttribute("bean", bean);
            Customer dbCustomer = customerService.get(favorite.getCustomer().getId());
            modelMap.addAttribute("customer", dbCustomer);
        }
        if (id != null) {
            Sentiment bean = service.get(id);
            Backends.validateDataInSite(bean, siteId);
            modelMap.addAttribute("bean", bean);
        }
/*        List<Customer> dbCustomerList = customerService.findList(siteId);
        modelMap.addAttribute("customerList", dbCustomerList);
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);*/
        List<SysDict> infoLevelList = sysDictService.findListByType(SysDict.INFO_LEVEL);
        modelMap.addAttribute("infoLevelList", infoLevelList);
        List<SysDict> infoTypelList = sysDictService.findListByType(SysDict.INFO_TYPE);
        modelMap.addAttribute("infoTypelList", infoTypelList);
        List<SysDict> schoolLevelList = sysDictService.findListByType(SysDict.SCHOOL_LEVEL);
        modelMap.addAttribute("schoolLevelList", schoolLevelList);
        //客户对应的联系人
        
        modelMap.addAttribute(OPRT, CREATE);
        return "core/sentiment/sentiment_form";
    }

    @RequiresPermissions("core:sentiment:edit")
    @RequestMapping("edit.do")
    public String edit(Integer id, 
            @PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Sentiment bean = service.get(id);
        Backends.validateDataInSite(bean, siteId);
        modelMap.addAttribute("bean", bean);
        SysFavorite  favorite  = sysFavoriteService.get(bean.getFavoriteId());
        if(favorite != null) {
            modelMap.addAttribute("favorite", favorite);
        }
        List<SysDict> infoLevelList = sysDictService.findListByType(SysDict.INFO_LEVEL);
        modelMap.addAttribute("infoLevelList", infoLevelList);
        List<SysDict> infoTypelList = sysDictService.findListByType(SysDict.INFO_TYPE);
        modelMap.addAttribute("infoTypelList", infoTypelList);
        List<SysDict> schoolLevelList = sysDictService.findListByType(SysDict.SCHOOL_LEVEL);
        modelMap.addAttribute("schoolLevelList", schoolLevelList);
        modelMap.addAttribute(OPRT, EDIT);
        return "core/sentiment/sentiment_form";
    }

    @RequiresPermissions("core:sentiment:save")
    @RequestMapping("save.do")
    public String save(Sentiment bean, String redirect, HttpServletRequest request, RedirectAttributes ra) {
        Integer siteId = Context.getCurrentSiteId();
        bean.setUser(Context.getCurrentUser());
        bean.setCreateDatetime(new Date());
        service.save(bean, siteId);
        //是否发送短信
        if(bean.getSendSMS()) {
            threadPoolTaskExecutor.execute(new Runnable() {
                @Override
                public void run() {
                    aliyunSMSUtils.sendSms(bean.getSendSMSPhone(), bean.getSmsContent());
                }
            });  
        }
        logService.operation("opr.Sentiment.add", bean.getSentimentTitle(), null, bean.getId(), request);
        logger.info("save Sentiment, title={}.", bean.getSentimentTitle());
        ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
        if (Constants.REDIRECT_LIST.equals(redirect)) {
            return "redirect:list.do";
        } else if (Constants.REDIRECT_CREATE.equals(redirect)) {
            return "redirect:create.do";
        } else {
            ra.addAttribute("id", bean.getId());
            return "redirect:edit.do";
        }
    }

    @ResponseBody
    @RequiresPermissions("core:sentiment:save")
    @RequestMapping(value="joincase.do", method=RequestMethod.POST)
    public Object joincase(Integer id) {
        Sentiment dbSentiment =  service.joincase(id);
        return MessageUtils.sucessMsg("保存成功", dbSentiment.getCaseStatus());
    }

    @RequiresPermissions("core:sentiment:update")
    @RequestMapping("update.do")
    public String update(@ModelAttribute("bean") Sentiment bean, Integer position, String redirect,
            Integer sysDictTypeId,
            Integer customerId,
            HttpServletRequest request, RedirectAttributes ra) {
        Site site = Context.getCurrentSite();
        Backends.validateDataInSite(bean, site.getId());
        service.update(bean, site.getId(), sysDictTypeId, customerId);
        logService.operation("opr.Sentiment.edit", bean.getSentimentTitle(), null, bean.getId(), request);
        logger.info("update SentimentGroup, title={}.", bean.getSentimentTitle());
        ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
        if (Constants.REDIRECT_LIST.equals(redirect)) {
            return "redirect:list.do";
        } else {
            ra.addAttribute("id", bean.getId());
            ra.addAttribute("position", position);
            return "redirect:edit.do";
        }
    }

    @RequiresPermissions("core:sentiment:delete")
    @RequestMapping("delete.do")
    public String delete(Integer[] ids, HttpServletRequest request, RedirectAttributes ra) {
        List<Sentiment> beans = service.delete(ids);
        for (Sentiment bean : beans) {
            logService.operation("opr.Sentiment_group.delete", bean.getSentimentTitle(), null, bean.getId(), request);
            logger.info("delete Sentiment, title={}.", bean.getSentimentTitle());
        }
        ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);
        return "redirect:list.do";
    }
    
    @ResponseBody
    @RequiresPermissions("core:sentiment:create")
    @RequestMapping("autogetinfo.do")
    public Object autogetinfo(@RequestParam(name="favoriteId", required=true)Integer favoriteId, 
            @RequestParam(name="url", required=true)String url) {
        SysFavorite  favorite  = sysFavoriteService.get(favoriteId);
        if(favorite == null) {
            return MessageUtils.failMsg("数据错误");
        }
        return MessageUtils.sucessMsg("获取成功", HtmlAnalysisUtils.analysisDetailPage(url, favorite));
    }
}
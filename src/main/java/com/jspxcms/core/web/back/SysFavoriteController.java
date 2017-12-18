package com.jspxcms.core.web.back;

import static com.jspxcms.core.constant.Constants.CREATE;
import static com.jspxcms.core.constant.Constants.EDIT;
import static com.jspxcms.core.constant.Constants.MESSAGE;
import static com.jspxcms.core.constant.Constants.OPRT;
import static com.jspxcms.core.constant.Constants.SAVE_SUCCESS;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.constant.Constants;
import com.jspxcms.core.domain.Customer;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.domain.SysFavorite;
import com.jspxcms.core.dto.FaviruteListDto;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.OperationLogService;
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.service.SysFavoriteService;
import com.jspxcms.core.support.Backends;
import com.jspxcms.core.support.Context;

/**
 * 收藏夹管理
 */
@Controller
@RequestMapping("/core/sysfavorite")
public class SysFavoriteController {
    private static final Logger logger = LoggerFactory.getLogger(SysFavoriteController.class);

    @Autowired
    private OperationLogService logService;

    @Autowired
    private SysFavoriteService service;

    @Autowired
    private SysDictService sysDictService;

    @Autowired
    private CustomerService customerService;

    @ModelAttribute("bean")
    public SysFavorite preloadBean(@RequestParam(required = false) Integer oid) {
        return oid != null ? service.get(oid) : null;
    }

    @RequiresPermissions("core:sysfavorite:list")
    @RequestMapping("list.do")
    public String list(@PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Map<String, String[]> params = Servlets.getParamValuesMap(request, Constants.SEARCH_PREFIX);
        List<SysFavorite> pagedList = service.findList(siteId, params, pageable.getSort());
        modelMap.addAttribute("pagedList", pagedList);
        List<SysDict> dictList = sysDictService.findListByType(SysDict.FAVORITE_TYPE);
        modelMap.addAttribute("favoriteTypeList", dictList);
/*        List<SysDict> areaList = sysDictService.findListByTree("0000");
        modelMap.addAttribute("areaList", areaList);*/
        return "core/sysfavorite/sysfavorite_list";
    }

    @RequiresPermissions("core:sysfavorite:create")
    @RequestMapping("create.do")
    public String create(Integer id, HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        if (id != null) {
            SysFavorite bean = service.get(id);
            Backends.validateDataInSite(bean, siteId);
            modelMap.addAttribute("bean", bean);
        }
        List<SysDict> dictList = sysDictService.findListByType(SysDict.FAVORITE_TYPE);
        modelMap.addAttribute("favoriteTypeList", dictList);
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
/*        List<Customer> dbCustomerList = customerService.findList(siteId);
        modelMap.addAttribute("customerList", dbCustomerList);*/
        modelMap.addAttribute(OPRT, CREATE);
        return "core/sysfavorite/sysfavorite_form";
    }

    @RequiresPermissions("core:sysfavorite:edit")
    @RequestMapping("edit.do")
    public String edit(Integer id, @PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        SysFavorite bean = service.get(id);
        Backends.validateDataInSite(bean, siteId);
        modelMap.addAttribute("bean", bean);
        List<SysDict> dictList = sysDictService.findListByType(SysDict.FAVORITE_TYPE);
        modelMap.addAttribute("favoriteTypeList", dictList);
/*        List<Customer> dbCustomerList = customerService.findList(siteId);
        modelMap.addAttribute("customerList", dbCustomerList);*/
        modelMap.addAttribute(OPRT, EDIT);
        return "core/sysfavorite/sysfavorite_form";
    }

    @RequiresPermissions("core:sysfavorite:save")
    @RequestMapping("save.do")
    public String save(SysFavorite bean, String redirect, HttpServletRequest request, RedirectAttributes ra) {
        Integer siteId = Context.getCurrentSiteId();
        service.save(bean, siteId);
        logService.operation("opr.sysfavorite.add", bean.getFavoriteName(), null, bean.getId(), request);
        logger.info("save SysFavorite, title={}.", bean.getFavoriteName());
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

    @RequiresPermissions("core:sysfavorite:update")
    @RequestMapping("update.do")
    public String update(@ModelAttribute("bean") SysFavorite bean, Integer position, String redirect,
            Integer sysDictTypeId,
            Integer customerId,
            HttpServletRequest request, RedirectAttributes ra) {
        Site site = Context.getCurrentSite();
        Backends.validateDataInSite(bean, site.getId());
        service.update(bean, site.getId(), sysDictTypeId, customerId);
        logService.operation("opr.sysfavorite.edit", bean.getFavoriteName(), null, bean.getId(), request);
        logger.info("update SysFavoriteGroup, title={}.", bean.getFavoriteName());
        ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
        if (Constants.REDIRECT_LIST.equals(redirect)) {
            return "redirect:list.do";
        } else {
            ra.addAttribute("id", bean.getId());
            ra.addAttribute("position", position);
            return "redirect:edit.do";
        }
    }

    @RequiresPermissions("core:sysfavorite:delete")
    @RequestMapping("delete.do")
    public String delete(Integer[] ids, HttpServletRequest request, RedirectAttributes ra) {
       /* SysFavorite[] beans = service.delete(ids);
        for (SysFavorite bean : beans) {
            logService.operation("opr.sysfavorite_group.delete", bean.getValue(), null, bean.getId(), request);
            logger.info("delete SysFavorite, title={}.", bean.getValue());
        }
        ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);*/
        return "redirect:list.do";
    }
    
    /**
     * 选择学校下的收藏夹
     * @param schoolid
     * @return
     */
    @ResponseBody
    @RequiresPermissions("core:sysfavorite:list")
    @RequestMapping("faviruteList.do")
    public Object autogetinfo(@RequestParam(name="schoolid", defaultValue="1")Integer schoolid) {
        List<FaviruteListDto> listDto = new ArrayList<FaviruteListDto>();
           List<SysFavorite> dbCustomerList = service.findByCustomerId(schoolid);
           if(dbCustomerList != null) {
               dbCustomerList.forEach(item -> {
                   listDto.add(new FaviruteListDto(item.getFavoriteName(), item.getId()));
               });
           }
        return listDto;
    }
}
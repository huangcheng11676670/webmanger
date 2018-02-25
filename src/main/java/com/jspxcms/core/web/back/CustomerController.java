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

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
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
import com.jspxcms.core.dto.SchoolListDto;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.OperationLogService;
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.support.Backends;
import com.jspxcms.core.support.Context;

/**
 *客户
 */
@Controller
@RequestMapping("/core/customer")
public class CustomerController {
    private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

    @Autowired
    private OperationLogService logService;

    @Autowired
    private CustomerService service;

    @Autowired
    private SysDictService sysDictService;

    @ModelAttribute("bean")
    public Customer preloadBean(@RequestParam(required = false) Integer oid) {
        return oid != null ? service.get(oid) : null;
    }

    @RequiresPermissions("core:customer:list")
    @RequestMapping("list.do")
    public String list(@PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Map<String, String[]> params = Servlets.getParamValuesMap(request, Constants.SEARCH_PREFIX);
        Page<Customer> pagedList = service.findPage(siteId, params, pageable);
        modelMap.addAttribute("pagedList", pagedList);
/*        List<SysDict> dictList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("dictList", dictList);*/
        if(params.get("EQ_areaId") != null && params.get("EQ_areaId").length > 0 && StringUtils.isNotBlank(params.get("EQ_areaId")[0])) {
            modelMap.addAttribute("area",  sysDictService.get(Integer.valueOf(params.get("EQ_areaId")[0])));
        }
        return "core/customer/customer_list";
    }

    @RequiresPermissions("core:customer:create")
    @RequestMapping("create.do")
    public String create(Integer id, HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        if (id != null) {
            Customer bean = service.get(id);
            Backends.validateDataInSite(bean, siteId);
            modelMap.addAttribute("bean", bean);
        }
        modelMap.addAttribute(OPRT, CREATE);
        return "core/customer/customer_form";
    }

    @RequiresPermissions("core:customer:edit")
    @RequestMapping("edit.do")
    public String edit(Integer id, @PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Customer bean = service.get(id);
        Backends.validateDataInSite(bean, siteId);
        modelMap.addAttribute("bean", bean);
        modelMap.addAttribute("area",  sysDictService.get(bean.getAreaId()));
        modelMap.addAttribute(OPRT, EDIT);
        return "core/customer/customer_form";
    }

    @RequiresPermissions("core:customer:save")
    @RequestMapping("save.do")
    public String save(Customer bean, String redirect, HttpServletRequest request, RedirectAttributes ra) {
        Integer siteId = Context.getCurrentSiteId();
        service.save(bean, siteId);
        logService.operation("opr.Customer.add", bean.getName(), null, bean.getId(), request);
        logger.info("save Customer, title={}.", bean.getName());
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

    @RequiresPermissions("core:customer:update")
    @RequestMapping("update.do")
    public String update(@ModelAttribute("bean") Customer bean, Integer position, String redirect,
            HttpServletRequest request, RedirectAttributes ra) {
        Site site = Context.getCurrentSite();
        Backends.validateDataInSite(bean, site.getId());
        service.update(bean);
        logService.operation("opr.customer.edit", bean.getName(), null, bean.getId(), request);
        logger.info("update CustomerGroup, title={}.", bean.getName());
        ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
        if (Constants.REDIRECT_LIST.equals(redirect)) {
            return "redirect:list.do";
        } else {
            ra.addAttribute("id", bean.getId());
            ra.addAttribute("position", position);
            return "redirect:edit.do";
        }
    }

    @RequiresPermissions("core:customer:delete")
    @RequestMapping("delete.do")
    public String delete(Integer[] ids, HttpServletRequest request, RedirectAttributes ra) {
       /* Customer[] beans = service.delete(ids);
        for (Customer bean : beans) {
            logService.operation("opr.Customer_group.delete", bean.getValue(), null, bean.getId(), request);
            logger.info("delete Customer, title={}.", bean.getValue());
        }
        ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);*/
        return "redirect:list.do";
    }
    
    @ResponseBody
    @RequiresPermissions("core:customer:list")
    @RequestMapping("customerList.do")
    public Object autogetinfo(@RequestParam(name="areaid", defaultValue="9")Integer areaid) {
        List<SchoolListDto> listDto = new ArrayList<SchoolListDto>();
           List<Customer> dbCustomerList = service.findByAreaId(areaid);
           if(dbCustomerList != null) {
               dbCustomerList.forEach(item -> {
                   listDto.add(new SchoolListDto(item.getName(), item.getId()));
               });
           }
        return listDto;
    }
    @ResponseBody
    @RequiresPermissions("core:customer:list")
    @RequestMapping("customerAllList.do")
    public Object customerAllList(@RequestParam(name="areaid", defaultValue="9")Integer areaid) {
        List<SchoolListDto> listDto = new ArrayList<SchoolListDto>();
        List<Customer> dbCustomerList = service.findByAreaId(areaid);
        if(dbCustomerList != null) {
            dbCustomerList.forEach(item -> {
                listDto.add(new SchoolListDto(item.getName(), item.getId(),
                        item.getContact1(),
                        item.getContact1Phone(),
                        item.getContact1QQ(),
                        item.getContact2(),
                        item.getContact2Phone(),
                        item.getContact2QQ(),
                        item.getContact3(),
                        item.getContact3Phone(),
                        item.getContact3QQ(),
                        item.getContact4(),
                        item.getContact4Phone(),
                        item.getContact4QQ()
                        ));
            });
        }
     return listDto;
    }
}
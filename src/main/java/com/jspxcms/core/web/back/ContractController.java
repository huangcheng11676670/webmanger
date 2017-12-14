package com.jspxcms.core.web.back;

import static com.jspxcms.core.constant.Constants.CREATE;
import static com.jspxcms.core.constant.Constants.EDIT;
import static com.jspxcms.core.constant.Constants.MESSAGE;
import static com.jspxcms.core.constant.Constants.OPRT;
import static com.jspxcms.core.constant.Constants.SAVE_SUCCESS;
import static com.jspxcms.core.constant.Constants.DELETE_SUCCESS;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.constant.Constants;
import com.jspxcms.core.domain.Contract;
import com.jspxcms.core.domain.Customer;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.service.ContractService;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.OperationLogService;
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.support.Backends;
import com.jspxcms.core.support.Context;

/**
 * 合同管理
 */
@Controller
@RequestMapping("/core/contract")
public class ContractController {
    private static final Logger logger = LoggerFactory.getLogger(ContractController.class);

    @Autowired
    private OperationLogService logService;

    @Autowired
    private ContractService service;

    @Autowired
    private SysDictService sysDictService;

    @Autowired
    private CustomerService customerService;

    @ModelAttribute("bean")
    public Contract preloadBean(@RequestParam(required = false) Integer oid) {
        return oid != null ? service.get(oid) : null;
    }

    @RequiresPermissions("core:contract:list")
    @RequestMapping("list.do")
    public String list(@PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Map<String, String[]> params = Servlets.getParamValuesMap(request, Constants.SEARCH_PREFIX);
        List<Contract> pagedList = service.findList(siteId, params, pageable.getSort());
        modelMap.addAttribute("pagedList", pagedList);
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        return "core/contract/contract_list";
    }

    @RequiresPermissions("core:contract:create")
    @RequestMapping("create.do")
    public String create(Integer id, HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        if (id != null) {
            Contract bean = service.get(id);
            Backends.validateDataInSite(bean, siteId);
            modelMap.addAttribute("bean", bean);
        }
        List<Customer> dbCustomerList = customerService.findList(siteId);
        modelMap.addAttribute("customerList", dbCustomerList);
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        modelMap.addAttribute(OPRT, CREATE);
        return "core/contract/contract_form";
    }

    @RequiresPermissions("core:contract:edit")
    @RequestMapping("edit.do")
    public String edit(Integer id, @PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Contract bean = service.get(id);
        Backends.validateDataInSite(bean, siteId);
        modelMap.addAttribute("bean", bean);
        List<Customer> dbCustomerList = customerService.findList(siteId);
        modelMap.addAttribute("customerList", dbCustomerList);
        List<SysDict> areaList = sysDictService.findAreaListByTree("0000");
        modelMap.addAttribute("areaList", areaList);
        modelMap.addAttribute(OPRT, EDIT);
        return "core/contract/contract_form";
    }

    @RequiresPermissions("core:contract:save")
    @RequestMapping("save.do")
    public String save(Contract bean, String redirect, HttpServletRequest request, RedirectAttributes ra) {
        Integer siteId = Context.getCurrentSiteId();
        service.save(bean, siteId);
        logService.operation("opr.Contract.add", bean.getContractCode(), null, bean.getId(), request);
        logger.info("save Contract, title={}.", bean.getContractCode());
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

    @RequiresPermissions("core:contract:update")
    @RequestMapping("update.do")
    public String update(@ModelAttribute("bean") Contract bean, Integer position, String redirect,
            Integer sysDictTypeId,
            Integer customerId,
            HttpServletRequest request, RedirectAttributes ra) {
        Site site = Context.getCurrentSite();
        Backends.validateDataInSite(bean, site.getId());
        service.update(bean, site.getId(), sysDictTypeId, customerId);
        logService.operation("opr.Contract.edit", bean.getContractCode(), null, bean.getId(), request);
        logger.info("update ContractGroup, title={}.", bean.getContractCode());
        ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
        if (Constants.REDIRECT_LIST.equals(redirect)) {
            return "redirect:list.do";
        } else {
            ra.addAttribute("id", bean.getId());
            ra.addAttribute("position", position);
            return "redirect:edit.do";
        }
    }

    @RequiresPermissions("core:contract:delete")
    @RequestMapping("delete.do")
    public String delete(Integer[] ids, HttpServletRequest request, RedirectAttributes ra) {
        List<Contract> beans = service.delete(ids);
        for (Contract bean : beans) {
            logService.operation("opr.Contract_group.delete", bean.getContractCode(), null, bean.getId(), request);
            logger.info("delete Contract, title={}.", bean.getContractCode());
        }
        ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);
        return "redirect:list.do";
    }
}
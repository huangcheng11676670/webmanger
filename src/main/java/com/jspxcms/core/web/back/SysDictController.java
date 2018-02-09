package com.jspxcms.core.web.back;

import static com.jspxcms.core.constant.Constants.CREATE;
import static com.jspxcms.core.constant.Constants.DELETE_SUCCESS;
import static com.jspxcms.core.constant.Constants.EDIT;
import static com.jspxcms.core.constant.Constants.MESSAGE;
import static com.jspxcms.core.constant.Constants.OPRT;
import static com.jspxcms.core.constant.Constants.SAVE_SUCCESS;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.dto.SysDictType;
import com.jspxcms.core.service.OperationLogService;
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.support.Backends;
import com.jspxcms.core.support.Context;

/**
 * 字典
 * 
 */
@Controller
@RequestMapping("/core/sysdict")
public class SysDictController {
    private static final Logger logger = LoggerFactory
            .getLogger(SysDictController.class);

    @Autowired
    private OperationLogService logService;

    @Autowired
    private SysDictService service;

    @ModelAttribute("bean")
    public SysDict preloadBean(@RequestParam(required = false) Integer oid) {
        return oid != null ? service.get(oid) : null;
    }

    @RequiresPermissions("core:sysdict:list")
    @RequestMapping("list.do")
    public String list(
            @PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        Map<String, String[]> params = Servlets.getParamValuesMap(request, Constants.SEARCH_PREFIX);
        //List<SysDict> pagedList = service.findList(siteId, params, pageable.getSort());
        Page<SysDict> pagedList = service.findPage(siteId, params, pageable);
        modelMap.addAttribute("sysDictTypeList", SysDictType.values());
        modelMap.addAttribute("pagedList", pagedList);
        return "core/sysdict/sysdict_list";
    }

    @RequiresPermissions("core:sysdict:create")
    @RequestMapping("create.do")
    public String create(Integer id, Integer parentId, 
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        if (id != null) {
            SysDict bean = service.get(id);
            Backends.validateDataInSite(bean, siteId);
            if(parentId != null ) {
                bean.setParentId(parentId);
            }
            modelMap.addAttribute("bean", bean);
        }
        modelMap.addAttribute("sysDictTypeList", SysDictType.values());
        modelMap.addAttribute(OPRT, CREATE);
        return "core/sysdict/sysdict_form";
    }

    @RequiresPermissions("core:sysdict:edit")
    @RequestMapping("edit.do")
    public String edit(
            Integer id,
            @PageableDefault(sort = "id", direction = Direction.DESC) Pageable pageable,
            HttpServletRequest request, org.springframework.ui.Model modelMap) {
        Integer siteId = Context.getCurrentSiteId();
        SysDict bean = service.get(id);
        Backends.validateDataInSite(bean, siteId);
        modelMap.addAttribute("sysDictTypeList", SysDictType.values());
        modelMap.addAttribute("bean", bean);
        modelMap.addAttribute(OPRT, EDIT);
        return "core/sysdict/sysdict_form";
    }

    @RequiresPermissions("core:sysdict:save")
    @RequestMapping("save.do")
    public String save(SysDict bean,
            Integer groupId,
            String redirect, HttpServletRequest request, RedirectAttributes ra) {
        Integer siteId = Context.getCurrentSiteId();
        service.save(bean, groupId, siteId);
        logService.operation("opr.sysdict.add", bean.getValue(), null,
                bean.getId(), request);
        logger.info("save SysDict, title={}.", bean.getValue());
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

    @RequiresPermissions("core:sysdict:update")
    @RequestMapping("update.do")
    public String update(@ModelAttribute("bean")SysDict bean,
            Integer position,
            Integer groupId,
            String redirect, HttpServletRequest request, RedirectAttributes ra) {
        Site site = Context.getCurrentSite();
        Backends.validateDataInSite(bean, site.getId());
        service.update(bean, groupId);
        logService.operation("opr.sysdictGroup.edit", bean.getValue(), null,
                bean.getId(), request);
        logger.info("update SysDictGroup, title={}.", bean.getValue());
        ra.addFlashAttribute(MESSAGE, SAVE_SUCCESS);
        if (Constants.REDIRECT_LIST.equals(redirect)) {
            return "redirect:list.do";
        } else {
            ra.addAttribute("id", bean.getId());
            ra.addAttribute("position", position);
            return "redirect:edit.do";
        }
    }

    @RequiresPermissions("core:sysdict:delete")
    @RequestMapping("delete.do")
    public String delete(Integer[] ids, HttpServletRequest request,
            RedirectAttributes ra) {
        SysDict[] beans = service.delete(ids);
        for (SysDict bean : beans) {
            logService.operation("opr.sysdict_group.delete", bean.getValue(), null,
                    bean.getId(), request);
            logger.info("delete SysDict, title={}.", bean.getValue());
        }
        ra.addFlashAttribute(MESSAGE, DELETE_SUCCESS);
        return "redirect:list.do";
    }

    @ResponseBody
    @RequestMapping("tree.do")
    public Object tree(Integer pid) {
        Integer siteId = Context.getCurrentSiteId();
        List<SysDict> list = service.findTreeList(siteId, pid);
        return list;
    }
}
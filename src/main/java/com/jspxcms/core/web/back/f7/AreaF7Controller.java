package com.jspxcms.core.web.back.f7;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jspxcms.common.web.Servlets;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.service.SysDictService;

/**
 * 地区控制器
 */
@Controller
@RequestMapping("/core/area")
public class AreaF7Controller {
    @Autowired
    private SysDictService service;

    /**
     * 地区行政区单选
     * 
     * @param id
     * @param excludeChildrenId
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping("choose_area_tree.do")
    public String f7AreaTree(Integer id, String treeNumber, @RequestParam(defaultValue = "true") Boolean allowRoot,
            Integer excludeChildrenId, HttpServletRequest request, HttpServletResponse response,
            org.springframework.ui.Model modelMap) {
        if (StringUtils.isNotBlank(treeNumber)) {
            allowRoot = false;
        }
        List<SysDict> list = service.findList(treeNumber);
        SysDict bean = null, excludeChildrenBean = null;
        if (id != null) {
            bean = service.get(id);
        }
        if (excludeChildrenId != null) {
            excludeChildrenBean = service.get(excludeChildrenId);
        }

        modelMap.addAttribute("id", id);
        modelMap.addAttribute("allowRoot", allowRoot);
        modelMap.addAttribute("excludeChildrenId", excludeChildrenId);
        modelMap.addAttribute("bean", bean);
        modelMap.addAttribute("excludeChildrenBean", excludeChildrenBean);
        modelMap.addAttribute("list", list);
        modelMap.addAttribute("treeNumber", treeNumber);
        Servlets.setNoCacheHeader(response);
        return "core/sysdict/choose_area_tree";
    }
}
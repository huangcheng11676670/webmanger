package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.dto.TreeDto;

/**
 * SysDictService
 * 
 */
public interface SysDictService {
    public List<SysDict> findList(Integer siteId, Map<String, String[]> params, Sort sort);

    public List<SysDict> findList(Integer siteId);

    public List<SysDict> findAreaListByTree(String treeNumber);

    public void findAreaListByPid(TreeDto treeParent, Integer pid);
    //获取四川省
    public TreeDto findAreaListBySichuan();
    
    public List<SysDict> findListByType(String type);

    public SysDict get(Integer id);

    public SysDict save(SysDict bean, Integer groupId, Integer siteId);

    public SysDict update(SysDict bean, Integer groupId);

    public List<SysDict> batchUpdate(Integer[] id, String[] name, String[] description);

    public SysDict delete(Integer id);

    public SysDict[] delete(Integer[] ids);
    /**
     * 树状节点
     * @param pid
     * @return
     */
    public List<SysDict> findTreeList(Integer siteId, Integer pid);

    public String getLabelById(Integer id);
    /**
     * 分页
     * @param siteId
     * @param params
     * @param pageable
     * @return
     */
    public Page<SysDict> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable);
}

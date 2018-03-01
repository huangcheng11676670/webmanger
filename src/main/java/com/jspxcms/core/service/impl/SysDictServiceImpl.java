package com.jspxcms.core.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.util.Strings;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.dto.TreeDto;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.SysDictDao;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.support.DeleteException;

/**
 * SysDictServiceImpl
 * 
 */
@Service
@Transactional(readOnly = true)
public class SysDictServiceImpl implements SysDictService, SiteDeleteListener {

    @Autowired
    private SysDictDao dao;
    
    @Autowired
    private SiteService siteService;

    public List<SysDict> findList(Integer siteId, Map<String, String[]> params, Sort sort) {
        return dao.findAll(spec(siteId, params), sort);
    }

    @Override
    public Page<SysDict> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable) {
        return dao.findAll(spec(siteId, params), pageable);
    }

    private Specification<SysDict> spec(final Integer siteId, Map<String, String[]> params) {
        Collection<SearchFilter> filters = SearchFilter.parse(params).values();
        final Specification<SysDict> fsp = SearchFilter.spec(filters, SysDict.class);
        Specification<SysDict> sp = new Specification<SysDict>() {
            public Predicate toPredicate(Root<SysDict> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = fsp.toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                return pred;
            }
        };
        return sp;
    }

    public List<SysDict> findList(Integer siteId) {
        Sort sort = new Sort("type", "sort");
        return dao.findBySiteIdAndStatus(siteId, 1, sort);
    }

    public SysDict get(Integer id) {
        return dao.findOne(id);
    }

    @Transactional
    public SysDict save(SysDict bean, Integer groupId, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        buildTreeNumber(bean);
        bean = dao.save(bean);
        return bean;
    }

    private void buildTreeNumber(SysDict bean) {
        if(StringUtils.isBlank(bean.getTreeNumber())){
            bean.setTreeNumber("0000");
        }
        if(bean.getParentId() != null) {
            //获取上级
            SysDict parent =  dao.findOne(bean.getParentId());
            if(parent != null) {
                bean.setTreeNumber(parent.getTreeNumber() +"-"+ Strings.frontCompWithZore(bean.getSort(), 4));
            }
        }
    }

    @Transactional
    public SysDict update(SysDict bean, Integer groupId) {
        buildTreeNumber(bean);
        bean = dao.save(bean);
        return bean;
    }

    @Transactional
    public List<SysDict> batchUpdate(Integer[] id, String[] name, String[] description) {
        List<SysDict> beans = new ArrayList<SysDict>();
        if (ArrayUtils.isEmpty(id)) {
            return beans;
        }
        SysDict bean;
        for (int i = 0, len = id.length; i < len; i++) {
            bean = get(id[i]);
            bean.setDescription(description[i]);
            beans.add(bean);
        }
        return beans;
    }

    private SysDict doDelete(Integer id) {
        SysDict entity = dao.findOne(id);
        if (entity != null) {
            dao.delete(entity);
        }
        return entity;
    }

    @Transactional
    public SysDict delete(Integer id) {
        return doDelete(id);
    }

    @Transactional
    public SysDict[] delete(Integer[] ids) {
        SysDict[] beans = new SysDict[ids.length];
        for (int i = 0; i < ids.length; i++) {
            beans[i] = doDelete(ids[i]);
        }
        return beans;
    }

    public void preSiteDelete(Integer[] ids) {
        if (ArrayUtils.isNotEmpty(ids)) {
            if (dao.countBySiteId(Arrays.asList(ids)) > 0) {
                throw new DeleteException("SysDict.management");
            }
        }
    }

    @Override
    public List<SysDict> findTreeList(Integer siteId, Integer pid) {
        Sort sort = new Sort("treeNumber");
        return dao.findBySiteIdAndParentId(siteId, pid, sort);
    }

    public List<SysDict> findAreaListByTree(String treeNumber) {
        if (StringUtils.isNotBlank(treeNumber)) {
            return dao.findByTreeNumberStartingWithAndType(treeNumber, SysDict.AREA_TYPE, new Sort("treeNumber"));
        } else {
            return dao.findByType(SysDict.AREA_TYPE, new Sort("treeNumber"));
        }
    }

    @Override
    public List<SysDict> findListByType(String type) {
        return dao.findByType(type, new Sort("sort"));
    }

    @Override
    public String getLabelById(Integer id) {
        if(id == null) {
            return "";
        }
        SysDict dbSysDict = dao.findOne(id);
        if(dbSysDict != null) {
            return dbSysDict.getLabel();
        }else {
            return "";
        }
    }

    @Override
    public TreeDto findAreaListBySichuan() {
        TreeDto dto = new TreeDto();
        dto.setId("9");
        dto.setName("四川省");
        dto.setOpen(true);
        findAreaListByPid(dto, 9);
        return dto;
    }
    @Override
    public void findAreaListByPid(TreeDto treeParent, Integer pid) {
        List<SysDict> dtoList = dao.findByParentIdAndType(pid, SysDict.AREA_TYPE, new Sort("treeNumber"));
        if(dtoList.size() > 0) {
            List<TreeDto> treeDtoList = new ArrayList<TreeDto>();
            dtoList.forEach(item -> {
                TreeDto dto = new TreeDto();
                dto.setId(String.valueOf(item.getId()));
                dto.setName(item.getLabel());
                dto.setPid(String.valueOf(item.getParentId()));
                treeDtoList.add(dto);
                findAreaListByPid(dto, item.getId());
            });
            treeParent.setChildren(treeDtoList);
        }
    }
}
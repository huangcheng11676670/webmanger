package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.SysFavorite;

/**
 * SysFavoriteService
 * 
 */
public interface SysFavoriteService extends IBaseService<SysFavorite, Integer>{

    void save(SysFavorite bean, Integer siteId);
    
    public List<SysFavorite> findList(Integer siteId, Map<String, String[]> params, Sort sort);
}

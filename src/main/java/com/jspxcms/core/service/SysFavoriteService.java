package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.SysFavorite;
import com.jspxcms.ext.dto.CommentListDto;

/**
 * SysFavoriteService
 * 
 */
public interface SysFavoriteService extends IBaseService<SysFavorite, Integer>{

    void save(SysFavorite bean, Integer siteId);
    
    public List<SysFavorite> findList(Integer siteId, Map<String, String[]> params, Sort sort);
    
    public void update(SysFavorite bean, Integer siteId, Integer sysDictTypeId, Integer customerId);
    
    public List<CommentListDto> findFavoriteByUrl(String url, Integer favoriteId);

    List<SysFavorite> findByCustomerId(Integer schoolid);
    //分页查询
    Page<SysFavorite> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable);
}

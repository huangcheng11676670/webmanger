package com.jspxcms.core.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import com.jspxcms.common.orm.BaseCrudDao;
import com.jspxcms.core.domain.SysShortUrl;

/**
 * SysSMSDao短地址转换
 * 
 */
public interface SysShortUrlDao extends BaseCrudDao<SysShortUrl, Integer> {

    public Page<SysShortUrl> findAll(Specification<SysShortUrl> spec, Pageable pageable);
}
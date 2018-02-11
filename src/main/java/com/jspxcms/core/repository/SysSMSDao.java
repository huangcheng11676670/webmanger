package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import com.jspxcms.common.orm.BaseCrudDao;
import com.jspxcms.core.domain.SysSMS;

/**
 * SysSMSDao短信
 * 
 */
public interface SysSMSDao extends BaseCrudDao<SysSMS, Integer> {

    public List<SysSMS> findBySiteId(Integer siteId, Sort sort);

    public Page<SysSMS> findAll(Specification<SysSMS> spec, Pageable pageable);
}
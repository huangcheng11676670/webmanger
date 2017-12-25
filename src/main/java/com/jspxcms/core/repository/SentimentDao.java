package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import com.jspxcms.common.orm.BaseCrudDao;
import com.jspxcms.core.domain.Sentiment;

/**
 * SentimentDao
 * 
 */
public interface SentimentDao extends BaseCrudDao<Sentiment, Integer> {

    public List<Sentiment> findBySiteId(Integer siteId, Sort sort);

    public Page<Sentiment> findAll(Specification<Sentiment> spec, Pageable pageable);
}
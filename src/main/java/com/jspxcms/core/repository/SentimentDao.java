package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;

import com.jspxcms.common.orm.BaseCrudDao;
import com.jspxcms.core.domain.Sentiment;

/**
 * SentimentDao
 * 
 */
public interface SentimentDao extends BaseCrudDao<Sentiment, Integer> {

    public List<Sentiment> findBySiteId(Integer siteId, Sort sort);

    public Page<Sentiment> findAll(Specification<Sentiment> spec, Pageable pageable);

    @Query(value = "select count(*) from cms_yq_sentiment where cast( f_create_datetime as date)= cast(now() as date) ", nativeQuery = true)
    public long countByToday();
}
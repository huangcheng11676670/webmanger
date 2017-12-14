package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.Sentiment;

/**
 * SentimentService
 * 
 */
public interface SentimentService extends IBaseService<Sentiment, Integer>{

    public List<Sentiment> findList(Integer siteId, Map<String, String[]> params, Sort sort);
    
    public void update(Sentiment bean, Integer siteId, Integer sysDictTypeId, Integer customerId);

    public void save(Sentiment bean, Integer siteId);
}
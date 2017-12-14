package com.jspxcms.core.service.impl;

import java.util.List;
import java.util.Map;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.service.BaseServiceImpl;
import com.jspxcms.core.domain.Sentiment;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.SentimentDao;
import com.jspxcms.core.service.SentimentService;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.SiteService;

/**
 * SentimentServiceImpl
 * 
 */
@Service
@Transactional(readOnly = true)
public class SentimentServiceImpl extends BaseServiceImpl<Sentiment, Integer> implements SentimentService, SiteDeleteListener {

    @Autowired
    public void setDao(SentimentDao dao) {
        super.setDao(dao);
    }

    @Autowired
    private SiteService siteService;

    @Autowired
    private CustomerService customerService;

    public List<Sentiment> findList(Integer siteId, Map<String, String[]> params, Sort sort) {
        return dao.findAll(spec(siteId, params), sort);
    }

    private Specification<Sentiment> spec(final Integer siteId, Map<String, String[]> params) {
        Specification<Sentiment> sp = new Specification<Sentiment>() {
            public Predicate toPredicate(Root<Sentiment> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, Sentiment.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                return pred;
            }
        };
        return sp;
    }

    public List<Sentiment> findList(Integer siteId) {
        return dao.findAll();
    }

    @Transactional
    public void save(Sentiment bean, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        bean = dao.save(bean);
    }

    @Transactional
    public void update(Sentiment bean, Integer siteId, Integer sysDictTypeId, Integer customerId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        if(customerId != null) {
            bean.setCustomer(customerService.get(customerId));
        }
        bean = dao.save(bean);
    }

    @Override
    public void preSiteDelete(Integer[] ids) {
        
    }
}
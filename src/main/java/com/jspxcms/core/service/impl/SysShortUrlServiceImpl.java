package com.jspxcms.core.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.service.BaseServiceImpl;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysShortUrl;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.SysShortUrlDao;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.SysShortUrlService;

/**
 * 短地址服务类
 * 
 */
@Service
@Transactional(readOnly = true)
public class SysShortUrlServiceImpl extends BaseServiceImpl<SysShortUrl, Integer> implements SysShortUrlService, SiteDeleteListener {

    private SysShortUrlDao dao;
    
    @Autowired
    private SiteService siteService;

    @Autowired
    public void setDao(SysShortUrlDao dao) {
        super.setDao(dao);
        this.dao = dao;
    }

    @Autowired
    private SysShortUrlService service;

    @Override
    public Page<SysShortUrl> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable) {
        return dao.findAll(spec(siteId, params), pageable);
    }

    private Specification<SysShortUrl> spec(final Integer siteId, Map<String, String[]> params) {
        Specification<SysShortUrl> sp = new Specification<SysShortUrl>() {
            public Predicate toPredicate(Root<SysShortUrl> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, SysShortUrl.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                return pred;
            }
        };
        return sp;
    }

    public List<SysShortUrl> findList(Integer siteId) {
        return dao.findAll();
    }

    @Transactional
    public void save(final SysShortUrl bean, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        bean.setCreateDatetime(new Date());
        dao.save(bean);
    }

    @Transactional
    public void update(SysShortUrl bean, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        bean = dao.save(bean);
    }

    @Override
    public void preSiteDelete(Integer[] ids) {
    }

    @Override
    public String getRedirectUrl(Integer id) {
        SysShortUrl dbSysShortUrl  =  service.get(id);
        if(dbSysShortUrl != null) {
            return dbSysShortUrl.getTargetUrl();
        }else {
            return null;
        }
    }
}
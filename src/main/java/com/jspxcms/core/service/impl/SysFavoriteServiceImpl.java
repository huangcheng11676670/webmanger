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
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysFavorite;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.SysFavoriteDao;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.SysDictService;
import com.jspxcms.core.service.SysFavoriteService;

/**
 * SysFavoriteServiceImpl
 * 
 */
@Service
@Transactional(readOnly = true)
public class SysFavoriteServiceImpl extends BaseServiceImpl<SysFavorite, Integer> implements SysFavoriteService, SiteDeleteListener {

    @Autowired
    public void setDao(SysFavoriteDao dao) {
        super.setDao(dao);
    }

    @Autowired
    private SiteService siteService;

    @Autowired
    private SysDictService sysDictService;
    
    @Autowired
    private CustomerService customerService;

    public List<SysFavorite> findList(Integer siteId, Map<String, String[]> params, Sort sort) {
        return dao.findAll(spec(siteId, params), sort);
    }

    private Specification<SysFavorite> spec(final Integer siteId, Map<String, String[]> params) {
        /*Collection<SearchFilter> filters = SearchFilter.parse(params).values();
        final Specification<SysFavorite> fsp = SearchFilter.spec(filters, SysFavorite.class);*/
        Specification<SysFavorite> sp = new Specification<SysFavorite>() {
            public Predicate toPredicate(Root<SysFavorite> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, SysFavorite.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                return pred;
            }
        };
        return sp;
    }

    public List<SysFavorite> findList(Integer siteId) {
        Sort sort = new Sort("type", "sort");
        return findList(siteId);
    }

    /*
     * @Transactional public SysFavorite save(SysFavorite bean, Integer groupId, Integer
     * siteId) { Site site = siteService.get(siteId); bean.setSite(site);
     * super.save(bean); return bean; }
     */

    @Transactional
    public List<SysFavorite> batchUpdate(Integer[] id, String[] name, String[] description) {
        /*
         * List<SysFavorite> beans = new ArrayList<SysFavorite>(); if (ArrayUtils.isEmpty(id))
         * { return beans; } SysFavorite bean; for (int i = 0, len = id.length; i < len;
         * i++) { bean = get(id[i]); beans.add(bean); } return beans;
         */
        return null;
    }

    /*
     * private SysFavorite doDelete(Integer id) { SysFavorite entity = dao.findOne(id); if
     * (entity != null) { dao.delete(entity); } return entity; }
     */

    public void preSiteDelete(Integer[] ids) {
        /*
         * if (ArrayUtils.isNotEmpty(ids)) { if (dao.countBySiteId(Arrays.asList(ids)) >
         * 0) { throw new DeleteException("SysFavorite.management"); } }
         */
    }

    @Transactional
    public void save(SysFavorite bean, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        bean = dao.save(bean);
    }

    @Transactional
    public void update(SysFavorite bean, Integer siteId, Integer sysDictTypeId, Integer customerId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        if(customerId != null) {
            bean.setCustomer(customerService.get(customerId));
        }
        if(sysDictTypeId != null) {
            bean.setSysDictType(sysDictService.get(sysDictTypeId));
        }
        bean = dao.save(bean);
    }
}

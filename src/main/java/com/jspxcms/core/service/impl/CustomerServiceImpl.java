package com.jspxcms.core.service.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.service.BaseServiceImpl;
import com.jspxcms.core.domain.Customer;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.CustomerDao;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.SiteService;

/**
 * CustomerServiceImpl
 * 
 */
@Service
@Transactional(readOnly = true)
public class CustomerServiceImpl extends BaseServiceImpl<Customer, Integer> implements CustomerService, SiteDeleteListener {

    private CustomerDao dao;
    
    @Autowired
    public void setDao(CustomerDao dao) {
        this.dao = dao;
        super.setDao(dao);
    }

    @Autowired
    private SiteService siteService;

    public List<Customer> findList(Integer siteId, Map<String, String[]> params, Sort sort) {
        return dao.findAll(spec(siteId, params), sort);
    }
    
    @Override
    public Page<Customer> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable) {
        return dao.findAll(spec(siteId, params), pageable);
    }

    private Specification<Customer> spec(final Integer siteId, Map<String, String[]> params) {
        /*Collection<SearchFilter> filters = SearchFilter.parse(params).values();
        final Specification<Customer> fsp = SearchFilter.spec(filters, Customer.class);*/
        Specification<Customer> sp = new Specification<Customer>() {
            public Predicate toPredicate(Root<Customer> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, Customer.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                return pred;
            }
        };
        return sp;
    }

    public List<Customer> findList(Integer siteId) {
        return dao.findAll();
    }

    /*
     * @Transactional public Customer save(Customer bean, Integer groupId, Integer
     * siteId) { Site site = siteService.get(siteId); bean.setSite(site);
     * super.save(bean); return bean; }
     */

    @Transactional
    public List<Customer> batchUpdate(Integer[] id, String[] name, String[] description) {
        /*
         * List<Customer> beans = new ArrayList<Customer>(); if (ArrayUtils.isEmpty(id))
         * { return beans; } Customer bean; for (int i = 0, len = id.length; i < len;
         * i++) { bean = get(id[i]); beans.add(bean); } return beans;
         */
        return null;
    }

    /*
     * private Customer doDelete(Integer id) { Customer entity = dao.findOne(id); if
     * (entity != null) { dao.delete(entity); } return entity; }
     */

    public void preSiteDelete(Integer[] ids) {
        /*
         * if (ArrayUtils.isNotEmpty(ids)) { if (dao.countBySiteId(Arrays.asList(ids)) >
         * 0) { throw new DeleteException("Customer.management"); } }
         */
    }

    @Transactional
    public void save(Customer bean, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        bean = dao.save(bean);
    }

    @Override
    public List<Customer> findByAreaId(Integer areaId) {
        return dao.findByAreaId(areaId);
    }

    @Override
    public Long countCustomer() {
        return dao.countByStatus();
    }
}

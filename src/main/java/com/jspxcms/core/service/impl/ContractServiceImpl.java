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
import com.jspxcms.core.domain.Contract;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.ContractDao;
import com.jspxcms.core.service.ContractService;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.SiteService;

/**
 * ContractServiceImpl
 * 
 */
@Service
@Transactional(readOnly = true)
public class ContractServiceImpl extends BaseServiceImpl<Contract, Integer> implements ContractService, SiteDeleteListener {

    @Autowired
    public void setDao(ContractDao dao) {
        super.setDao(dao);
    }

    @Autowired
    private SiteService siteService;

    @Autowired
    private CustomerService customerService;

    public List<Contract> findList(Integer siteId, Map<String, String[]> params, Sort sort) {
        return dao.findAll(spec(siteId, params), sort);
    }

    private Specification<Contract> spec(final Integer siteId, Map<String, String[]> params) {
        Specification<Contract> sp = new Specification<Contract>() {
            public Predicate toPredicate(Root<Contract> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, Contract.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                return pred;
            }
        };
        return sp;
    }

    public List<Contract> findList(Integer siteId) {
        return dao.findAll();
    }

    @Transactional
    public void save(Contract bean, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        bean = dao.save(bean);
    }

    @Transactional
    public void update(Contract bean, Integer siteId, Integer sysDictTypeId, Integer customerId) {
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
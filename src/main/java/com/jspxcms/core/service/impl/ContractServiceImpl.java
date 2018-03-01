package com.jspxcms.core.service.impl;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.service.BaseServiceImpl;
import com.jspxcms.core.domain.Contract;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.dto.ReportContractDto;
import com.jspxcms.core.dto.ReportCountAndIdDto;
import com.jspxcms.core.dto.ReportUserSentimentDto;
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

    private ContractDao dao;

    private EntityManager em;

    @PersistenceContext
    public void setEm(EntityManager em) {
        this.em = em;
    }

    @Autowired
    public void setDao(ContractDao dao) {
        super.setDao(dao);
        this.dao = dao;
    }

    @Autowired
    private SiteService siteService;

    @Autowired
    private CustomerService customerService;

    public List<Contract> findList(Integer siteId, Map<String, String[]> params, Sort sort) {
        return dao.findAll(spec(siteId, params), sort);
    }

    @Override
    public Page<Contract> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable) {
        return dao.findAll(spec(siteId, params), pageable);
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

    @Override
    public BigInteger reportContractNewNumNativeQuery(Integer areaId, String searchMonth) {
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(*) FROM cms_yq_contract WHERE 1=1");
        if(areaId != null) {
            query.append(" AND f_area_id = "+areaId);
        }
        if(StringUtils.isNotBlank(searchMonth)) {
            query.append(" AND date_format(f_contract_create_time , '%Y-%m') = '"+ searchMonth+"'");
        }
      //执行原生SQL
      Query nativeQuery = em.createNativeQuery(query.toString());
      //返回对象
      Object resultObj = nativeQuery.getSingleResult();
      return (BigInteger)resultObj;
    }

    @Override
    public List<ReportContractDto> reportContractAreaNativeQuery(Integer areaId, String startDate, String endDate) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Long endContractNum() {
        return dao.endContractNum();
    }

    @Override
    public List<ReportUserSentimentDto> reportUserSentimentNativeQuery(Integer userId, String startDate,
            String endDate) {
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(*), sentiment0_.f_favorite_id");
        query.append(" FROM cms_yq_sentiment sentiment0_ WHERE 1=1");
        query.append(" AND f_user_id = "+userId);
        if(StringUtils.isNotBlank(startDate)) {
            query.append(" AND cast( sentiment0_.f_create_datetime AS DATE ) >= '"+startDate+"'");
        }
        if(StringUtils.isNotBlank(endDate)) {
            query.append(" AND cast( sentiment0_.f_create_datetime AS DATE ) <= '"+endDate+"'");
        }
        query.append(" GROUP BY sentiment0_.f_favorite_id ");
    
      //执行原生SQL
      Query nativeQuery = em.createNativeQuery(query.toString());
      //返回对象
      @SuppressWarnings("unchecked")
      List<Object> resultList = nativeQuery.getResultList();
      List<ReportUserSentimentDto> dtoList = new ArrayList<ReportUserSentimentDto>();
      resultList.forEach(item -> {
          Object[] cells = (Object[]) item;
          dtoList.add( new ReportUserSentimentDto((BigInteger)cells[0], (Integer)cells[1]));
      });
      return dtoList;
    }
}
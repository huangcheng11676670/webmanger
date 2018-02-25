package com.jspxcms.core.service.impl;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
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
import com.jspxcms.common.util.DateUtils;
import com.jspxcms.core.domain.Sentiment;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.dto.ReportSentimentNumDto;
import com.jspxcms.core.dto.ReportCountAndIdDto;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.SentimentDao;
import com.jspxcms.core.service.CustomerService;
import com.jspxcms.core.service.SentimentService;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.support.Context;

/**
 * SentimentServiceImpl
 * 
 */
@Service
@Transactional(readOnly = true)
public class SentimentServiceImpl extends BaseServiceImpl<Sentiment, Integer> implements SentimentService, SiteDeleteListener {
    private SentimentDao dao;

    private EntityManager em;

    @PersistenceContext
    public void setEm(EntityManager em) {
        this.em = em;
    }

    @Autowired
    public void setDao(SentimentDao dao) {
        super.setDao(dao);
        this.dao = dao;
    }

    @Autowired
    private SiteService siteService;

    @Autowired
    private CustomerService customerService;
    
    public long countByToday() {
       return dao.countByToday();
    }

    public List<Sentiment> findList(Integer siteId, Map<String, String[]> params, Sort sort) {
        return dao.findAll(spec(siteId, params), sort);
    }

    @Override
    public Page<Sentiment> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable) {
        return dao.findAll(spec(siteId, params), pageable);
    }

    private Specification<Sentiment> spec(final Integer siteId, Map<String, String[]> params) {
        Specification<Sentiment> sp = new Specification<Sentiment>() {
            public Predicate toPredicate(Root<Sentiment> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, Sentiment.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                pred = cb.and(pred, cb.equal(root.get("user").<Integer>get("id"), Context.getCurrentUser().getId()));
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
    
    public List<ReportSentimentNumDto> reportSentimentNumNativeQuery(Integer userid, String startDate, String endDate) {
            StringBuilder query = new StringBuilder();
            query.append("SELECT ");
            query.append(" count(sentiment0_.f_sentiment_id) as num, cast( sentiment0_.f_create_datetime AS date)  as dateString");
            query.append(" FROM cms_yq_sentiment sentiment0_ ");
            query.append(" WHERE 1=1");
            if(StringUtils.isNotBlank(startDate)) {
                query.append(" and cast( sentiment0_.f_create_datetime AS DATE ) >= '"+startDate+"'");
            }
            if(StringUtils.isNotBlank(endDate)) {
                query.append(" and cast( sentiment0_.f_create_datetime AS DATE ) <= '"+endDate+"'");
            }
            query.append(" AND sentiment0_.f_user_id = "+userid);
            query.append(" GROUP BY cast(sentiment0_.f_create_datetime AS date)");
        
          //执行原生SQL
          Query nativeQuery = em.createNativeQuery(query.toString());
          //返回对象
          @SuppressWarnings("unchecked")
        List<Object> resultList = nativeQuery.getResultList();
          List<ReportSentimentNumDto> dtoList = new ArrayList<ReportSentimentNumDto>();
          resultList.forEach(item -> {
              Object[] cells = (Object[]) item;
              dtoList.add( new ReportSentimentNumDto((BigInteger)cells[0], (Date)cells[1]));
          });
          return dtoList;
    }

    public List<Sentiment> reportNumByDateAndUser(Integer userid, String startDate, String endDate) {
            Specification<Sentiment> querySpecifi = new Specification<Sentiment>() {
                @Override
                public Predicate toPredicate(Root<Sentiment> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                    List<Predicate> predicateList = new ArrayList<>();
                    if(startDate != null){
                        predicateList.add(criteriaBuilder.greaterThanOrEqualTo(root.get("createDatetime").as(String.class), startDate));
                    }
                    if(endDate != null){
                        predicateList.add(criteriaBuilder.lessThanOrEqualTo(root.get("createDatetime").as(String.class), endDate+ " 23:59:59"));
                    }
                    if(null != userid){
                        predicateList.add(criteriaBuilder.equal(root.get("user").get("id"), userid));
                    }
                    criteriaQuery.where(predicateList.toArray(new Predicate[predicateList.size()]));
                    criteriaQuery.groupBy(root.get("createDatetime").as(java.sql.Date.class));
                    criteriaQuery.getGroupList();
                    return criteriaQuery.getGroupRestriction();
                }
            };
            System.out.println(dao.count(querySpecifi));
            return  null;
    }

    @Override
    public List<ReportCountAndIdDto> reportSentimentPieNativeQuery(Integer userid, String startDate, String endDate) {
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(sentiment0_.f_sentiment_id) , sentiment0_.f_favorite_id ");
        query.append(" FROM cms_yq_sentiment sentiment0_ WHERE 1=1");
        if(StringUtils.isNotBlank(startDate)) {
            query.append(" AND cast( sentiment0_.f_create_datetime AS DATE ) >= '"+startDate+"'");
        }
        if(StringUtils.isNotBlank(endDate)) {
            query.append(" AND cast( sentiment0_.f_create_datetime AS DATE ) <= '"+endDate+"'");
        }
        query.append(" AND sentiment0_.f_user_id = "+userid);
        query.append(" GROUP BY sentiment0_.f_favorite_id ");
    
      //执行原生SQL
      Query nativeQuery = em.createNativeQuery(query.toString());
      //返回对象
      @SuppressWarnings("unchecked")
    List<Object> resultList = nativeQuery.getResultList();
      List<ReportCountAndIdDto> dtoList = new ArrayList<ReportCountAndIdDto>();
      resultList.forEach(item -> {
          Object[] cells = (Object[]) item;
          dtoList.add( new ReportCountAndIdDto((BigInteger)cells[0], (Integer)cells[1]));
      });
      return dtoList;
    }

    @Override
    public List<ReportCountAndIdDto> reportSentimentAreaNativeQuery(String startDate, String endDate) {
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(sentiment0_.f_sentiment_id), sentiment0_.f_area_id");
        query.append(" FROM cms_yq_sentiment sentiment0_ WHERE 1=1");
        if(StringUtils.isNotBlank(startDate)) {
            query.append(" AND cast( sentiment0_.f_create_datetime AS DATE ) >= '"+startDate+"'");
        }
        if(StringUtils.isNotBlank(endDate)) {
            query.append(" AND cast( sentiment0_.f_create_datetime AS DATE ) <= '"+endDate+"'");
        }
        query.append(" GROUP BY sentiment0_.f_area_id ");
    
      //执行原生SQL
      Query nativeQuery = em.createNativeQuery(query.toString());
      //返回对象
      @SuppressWarnings("unchecked")
      List<Object> resultList = nativeQuery.getResultList();
      List<ReportCountAndIdDto> dtoList = new ArrayList<ReportCountAndIdDto>();
      resultList.forEach(item -> {
          Object[] cells = (Object[]) item;
          dtoList.add( new ReportCountAndIdDto((BigInteger)cells[0], (Integer)cells[1]));
      });
      return dtoList;
    }

    @Override
    @Transactional
    public Sentiment joincase(Integer id) {
        Sentiment dbSentiment =  super.get(id);
        if(dbSentiment.getCaseStatus()) {
            dbSentiment.setCaseStatus(false);
        }else {
            dbSentiment.setCaseStatus(true);
        }
        super.update(dbSentiment);
        return dbSentiment;
    }

    @Override
    public Long countTotal() {
        return dao.count();
    }

    @Override
    public Long countTotalByUserId(Integer userId){
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(*) FROM cms_yq_sentiment sentiment0_ WHERE DATE_FORMAT(sentiment0_.f_create_datetime, '%Y-%m') = '");
        query.append(DateUtils.getYearAndMonth(new Date()));
        query.append("' and sentiment0_.f_user_id = "+userId);
      //执行原生SQL
      Query nativeQuery = em.createNativeQuery(query.toString());
      //返回对象
      Object resultList = nativeQuery.getSingleResult();
      return ((BigInteger)resultList).longValue();
    }
}
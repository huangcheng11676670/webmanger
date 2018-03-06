package com.jspxcms.core.service.impl;

import java.math.BigDecimal;
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
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.UserViewTime;
import com.jspxcms.core.dto.ReportUserTimeDto;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.UserViewTimeDao;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.UserViewTimeService;
import com.jspxcms.core.support.Context;

/**
 * UserViewTimeServiceImpl
 * 
 */
@Service
@Transactional(readOnly = true)
public class UserViewTimeServiceImpl extends BaseServiceImpl<UserViewTime, Integer> implements UserViewTimeService, SiteDeleteListener {
    private UserViewTimeDao dao;

    private EntityManager em;

    @PersistenceContext
    public void setEm(EntityManager em) {
        this.em = em;
    }

    @Autowired
    public void setDao(UserViewTimeDao dao) {
        super.setDao(dao);
        this.dao = dao;
    }

    @Autowired
    private SiteService siteService;

    public List<UserViewTime> findList(Integer siteId, Map<String, String[]> params, Sort sort) {
        return dao.findAll(spec(siteId, params), sort);
    }

    @Override
    public Page<UserViewTime> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable) {
        return dao.findAll(spec(siteId, params), pageable);
    }

    private Specification<UserViewTime> spec(final Integer siteId, Map<String, String[]> params) {
        Specification<UserViewTime> sp = new Specification<UserViewTime>() {
            public Predicate toPredicate(Root<UserViewTime> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, UserViewTime.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                pred = cb.and(pred, cb.equal(root.get("user").<Integer>get("id"), Context.getCurrentUser().getId()));
                return pred;
            }
        };
        return sp;
    }

    public List<UserViewTime> findList(Integer siteId) {
        return dao.findAll();
    }

    @Transactional
    public void save(UserViewTime bean, Integer siteId) {
        if(bean.getMinuteNum() <= 0) {
            return;
        }
        Site site = siteService.get(siteId);
        bean.setSite(site);
        UserViewTime dbUserViewTime = dao.findByFavoriteIdAndUserIdAndCreateDate(bean.getFavoriteId(), bean.getUserId(), bean.getCreateDate());
        if(dbUserViewTime != null) {
            if(dbUserViewTime.getMinuteNum() == null) {
                dbUserViewTime.setMinuteNum(0);
            }
            dbUserViewTime.setMinuteNum(dbUserViewTime.getMinuteNum() +bean.getMinuteNum());
            dao.save(dbUserViewTime);
        }else {
            dao.save(bean);
        }
    }
    

    @Transactional
    public void update(UserViewTime bean, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        bean = dao.save(bean);
    }

    @Override
    public void preSiteDelete(Integer[] ids) {
    }
    
    @Override
    public List<ReportUserTimeDto> reportUserTimeNativeQuery(Integer userId, String startDate,
            String endDate) {
        StringBuilder query = new StringBuilder();
        query.append("SELECT sum(f_minute_num), sentiment0_.f_favorite_id");
        query.append(" FROM cms_yq_view_time sentiment0_ WHERE 1=1");
        query.append(" AND f_user_id = "+userId);
        if(StringUtils.isNotBlank(startDate)) {
            query.append(" AND cast( sentiment0_.f_create_date AS DATE ) >= '"+startDate+"'");
        }
        if(StringUtils.isNotBlank(endDate)) {
            query.append(" AND cast( sentiment0_.f_create_date AS DATE ) <= '"+endDate+"'");
        }
        query.append(" GROUP BY sentiment0_.f_favorite_id ");
      //执行原生SQL
      Query nativeQuery = em.createNativeQuery(query.toString());
      //返回对象
      @SuppressWarnings("unchecked")
      List<Object> resultList = nativeQuery.getResultList();
      List<ReportUserTimeDto> dtoList = new ArrayList<ReportUserTimeDto>();
      resultList.forEach(item -> {
          Object[] cells = (Object[]) item;
          dtoList.add( new ReportUserTimeDto((BigDecimal)cells[0], (BigInteger)cells[1]));
      });
      return dtoList;
    }
}
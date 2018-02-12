package com.jspxcms.core.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.jspxcms.common.orm.SearchFilter;
import com.jspxcms.common.service.BaseServiceImpl;
import com.jspxcms.common.util.AliyunSMSUtils;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysSMS;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.SysSMSDao;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.SysSMSService;

/**
 * 短信服务类
 * 
 */
@Service
@Transactional(readOnly = true)
public class SysSMSServiceImpl extends BaseServiceImpl<SysSMS, Integer> implements SysSMSService, SiteDeleteListener {

    private SysSMSDao dao;

    @Resource(name="aliyunSMSUtils")
    private AliyunSMSUtils aliyunSMSUtils;
    
    @Autowired  
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;  

    @Autowired
    public void setDao(SysSMSDao dao) {
        super.setDao(dao);
        this.dao = dao;
    }

    @Autowired
    private SiteService siteService;

    @Override
    public Page<SysSMS> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable) {
        return dao.findAll(spec(siteId, params), pageable);
    }

    private Specification<SysSMS> spec(final Integer siteId, Map<String, String[]> params) {
        Specification<SysSMS> sp = new Specification<SysSMS>() {
            public Predicate toPredicate(Root<SysSMS> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, SysSMS.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                return pred;
            }
        };
        return sp;
    }

    public List<SysSMS> findList(Integer siteId) {
        return dao.findAll();
    }

    @Transactional
    public void save(final SysSMS bean, Integer siteId) {
        Site site = siteService.get(siteId);
        bean.setAreaName(bean.getAreaName().trim());
        bean.setSite(site);
        bean.setCreateDatetime(new Date());
        bean.setMessage("发送中...");
        SysSMS dbBean = dao.save(bean);
        //发送短信
        threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                SendSmsResponse response = aliyunSMSUtils.sendSms(bean.getContact1Phone(), bean.getSmsContent());
                dbBean.setMessage(response.getMessage());
                dao.save(dbBean);
            }
        });  
    }

    @Transactional
    public void update(SysSMS bean, Integer siteId, Integer sysDictTypeId, Integer customerId) {
        Site site = siteService.get(siteId);
        bean.setSite(site);
        bean = dao.save(bean);
    }

    @Override
    public void preSiteDelete(Integer[] ids) {
    }
}
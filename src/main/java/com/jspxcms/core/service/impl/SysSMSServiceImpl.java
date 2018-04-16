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
import com.jspxcms.core.domain.Customer;
import com.jspxcms.core.domain.Sentiment;
import com.jspxcms.core.domain.Site;
import com.jspxcms.core.domain.SysDict;
import com.jspxcms.core.domain.SysSMS;
import com.jspxcms.core.domain.SysShortUrl;
import com.jspxcms.core.listener.SiteDeleteListener;
import com.jspxcms.core.repository.CustomerDao;
import com.jspxcms.core.repository.SysDictDao;
import com.jspxcms.core.repository.SysSMSDao;
import com.jspxcms.core.repository.SysShortUrlDao;
import com.jspxcms.core.service.SiteService;
import com.jspxcms.core.service.SysSMSService;

/**
 * 短信服务类
 * 
 */
@Service
@Transactional(readOnly = true)
public class SysSMSServiceImpl extends BaseServiceImpl<SysSMS, Integer> implements SysSMSService, SiteDeleteListener {

    @Autowired  
    private SysSMSDao dao;

    @Autowired  
    private CustomerDao customerDao;

    @Autowired  
    private SysShortUrlDao sysShortUrlDao;

    @Autowired  
    private SysDictDao sysDictDao;

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
    public Page<SysSMS> findPage(Integer siteId, Integer areaId, Map<String, String[]> params, Pageable pageable) {
        return dao.findAll(spec(siteId, params, areaId), pageable);
    }

    private Specification<SysSMS> spec(final Integer siteId, Map<String, String[]> params, Integer areaId) {
        Specification<SysSMS> sp = new Specification<SysSMS>() {
            public Predicate toPredicate(Root<SysSMS> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate pred = SearchFilter.buildSpecification(params, SysSMS.class).toPredicate(root, query, cb);
                if (siteId != null) {
                    pred = cb.and(pred, cb.equal(root.get("site").<Integer>get("id"), siteId));
                }
                if(areaId != null) {
                    SysDict dbSysDict = sysDictDao.findOne(areaId);
                    pred = cb.like(root.join("area").get("treeNumber").as(String.class), dbSysDict.getTreeNumber()+"%");
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
    public void save(final SysSMS bean, Integer siteId, Integer areaId) {
        Site site = siteService.get(siteId);
        if(bean.getAreaName() != null) {
            bean.setAreaName(bean.getAreaName().trim());
        }
        bean.setSite(site);
        bean.setCreateDatetime(new Date());
        bean.setMessage("发送中...");
        if(areaId != null) {
            SysDict dbSysDict = sysDictDao.findOne(areaId);
            bean.setArea(dbSysDict);
            bean.setAreaName(dbSysDict.getLabel());
        }
        SysSMS dbBean = dao.save(bean);
        //发送短信
        threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                String shorId = "";
                if(bean.getRefId() != null) {
                    shorId = bean.getRefId().toString();
                }
                SendSmsResponse response = aliyunSMSUtils.sendSMS_125116385(bean.getContact1Phone(), bean.getContact1(), shorId, bean.getSmsContent());
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

    @Override
    @Transactional
    public void save(Sentiment bean, Integer areaId) {
        //生成一个跳转记录
        SysShortUrl shortUrl = new SysShortUrl();
        shortUrl.setCode("");
        shortUrl.setCreateDatetime(bean.getCreateDatetime());
        shortUrl.setSite(bean.getSite());
        shortUrl.setTargetUrl(bean.getSentimentUrl());
        sysShortUrlDao.save(shortUrl);
        //下面产生一个短信发送记录
        SysSMS smsBean = new SysSMS();
        if(areaId != null) {
            SysDict dbSysDict = sysDictDao.findOne(areaId);
            smsBean.setArea(dbSysDict);
            smsBean.setAreaName(dbSysDict.getLabel());
        }
        if(bean.getCustomer() != null) {
            Customer dbCustomer = customerDao.getOne(bean.getCustomer().getId());
            if(dbCustomer != null) {
                if(bean.getSendSMSPhone().equalsIgnoreCase(dbCustomer.getContact1Phone())) {
                    //联系人
                    smsBean.setContact1(dbCustomer.getContact1());
                    //联系人电话
                    smsBean.setContact1Phone(dbCustomer.getContact1Phone());
                    smsBean.setContact1Qq(dbCustomer.getContact1QQ());
                }else if(bean.getSendSMSPhone().equalsIgnoreCase(dbCustomer.getContact2Phone())) {
                    //联系人
                    smsBean.setContact1(dbCustomer.getContact2());
                    //联系人电话
                    smsBean.setContact1Phone(dbCustomer.getContact2Phone());
                    smsBean.setContact1Qq(dbCustomer.getContact2QQ());
                }else if(bean.getSendSMSPhone().equalsIgnoreCase(dbCustomer.getContact3Phone())) {
                    //联系人
                    smsBean.setContact1(dbCustomer.getContact3());
                    //联系人电话
                    smsBean.setContact1Phone(dbCustomer.getContact3Phone());
                    smsBean.setContact1Qq(dbCustomer.getContact3QQ());
                }
                smsBean.setCustomerId(dbCustomer.getId());
                smsBean.setCustomerName(dbCustomer.getName());
            }
        }
        smsBean.setCreateDatetime(bean.getCreateDatetime());
        smsBean.setSite(bean.getSite());
        //smsBean.setMessage(bean.getSmsContent()); 回调信息不用写
        //跳转的id
        smsBean.setRefId(shortUrl.getId());
        //短信内容
        smsBean.setSmsContent(bean.getSmsContent());
        save(smsBean, bean.getSite().getId(), areaId);
    }
}
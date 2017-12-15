package com.jspxcms.core.service.impl;

import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.ClientProtocolException;
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
import com.jspxcms.ext.domain.Collect;
import com.jspxcms.ext.dto.CommentListDto;

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
        return dao.findAll();
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

    /**
     * 手机浏览器代理
     */
    public static final String agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1";
    
    @Override
    public List<CommentListDto> findFavoriteByUrl(String url, Integer favoriteId) {
        SysFavorite bean = dao.findOne(favoriteId);
        if(bean ==null || StringUtils.isBlank(bean.getCustomerUrl())) {
            return null;
        }
        String webSiteHtml;
        try {
            webSiteHtml = Collect.fetchHtml(URI.create(url), "utf-8", agent);
        } catch (ClientProtocolException e) {
            return null;
        } catch (IOException e) {
            return null;
        }
        if(StringUtils.isBlank(webSiteHtml)){
            return null;
        }
        List<CommentListDto> dtoList = new ArrayList<CommentListDto>();
        //假设有50个类似的数据
        List<String> itemsList = Collect.findByReg(webSiteHtml, bean.getItemsPattern(), 50);
        itemsList.forEach(item -> {
            CommentListDto dto = new CommentListDto();
            dto.setCommentNum(getHtmlValue(bean.getCommentNumPattern(), item));
            dto.setContentCreateTime(getHtmlValue(bean.getContentCreateTimePattern(), item));
            dto.setSummary(getHtmlValue(bean.getSummaryPattern(), item));
            dto.setTitle(getHtmlValue(bean.getTitlePattern(), item));
            dtoList.add(dto);
        });
        return dtoList;
    }

    private String getHtmlValue(String pattern, String item) {
        List<String> numList = Collect.findByReg(item, pattern ,1);
        if(numList != null && numList.size() >= 1) {
            return numList.get(0);
        }else {
            return null;
        }
    }
}
package com.jspxcms.core.service;

import java.util.Map;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.SysSMS;

/**
 * 短信服务类
 * 
 */
public interface SysSMSService extends IBaseService<SysSMS, Integer>{

    public void update(SysSMS bean, Integer siteId, Integer sysDictTypeId, Integer customerId);

    public void save(SysSMS bean, Integer siteId);
    /**
     * 分页
     * @param siteId
     * @param params
     * @param pageable
     * @return
     */
    public Page<SysSMS> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable);
}
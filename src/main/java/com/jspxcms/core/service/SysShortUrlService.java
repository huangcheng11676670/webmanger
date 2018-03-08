package com.jspxcms.core.service;

import java.util.Map;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.SysShortUrl;

/**
 * 短地址
 * 
 */
public interface SysShortUrlService extends IBaseService<SysShortUrl, Integer>{

    public void update(SysShortUrl bean, Integer siteId);

    public void save(SysShortUrl bean, Integer siteId);

    public Page<SysShortUrl> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable);
    /**
     * 获取跳转后的url
     * @param id
     * @return
     */
    public String getRedirectUrl(Integer id);
}
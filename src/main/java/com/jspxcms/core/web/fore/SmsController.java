package com.jspxcms.core.web.fore;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.jspxcms.core.service.SysShortUrlService;

/**
 * 短地址转换
 * 
 */
@Controller
public class SmsController {
    
    @Autowired
    private SysShortUrlService service;

    @RequestMapping("/s/{id}")
    private String redirect(@PathVariable("id") Integer id) {
        String redirectUrl = service.getRedirectUrl(id);
        if(StringUtils.isBlank(redirectUrl)) {
            return "shortUrlBlank";
        }else {
            return "redirect:"+service.getRedirectUrl(id);
        }
    }
}
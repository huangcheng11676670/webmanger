package com.jspxcms.core.web.back;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jspxcms.common.util.MessageUtils;
import com.jspxcms.core.domain.UserViewTime;
import com.jspxcms.core.service.UserViewTimeService;
import com.jspxcms.core.support.Context;

/**
 * 操作员访问，监控网页停留的时间,单位分钟
 */
@Controller
@RequestMapping("/core/viewtime")
public class UserViewTimeController {

    @Autowired
    private UserViewTimeService service;

    @ResponseBody
    @RequiresPermissions("core:sentiment:create")
    @RequestMapping(value="save.do", method= {RequestMethod.POST})
    public Object autogetinfo(UserViewTime bean) {
        Integer siteId = Context.getCurrentSiteId();
        bean.setCreateDate(new Date());
        bean.setUserId(Context.getCurrentUser().getId());
        BigDecimal minute = BigDecimal.valueOf(bean.getMinuteNum()).divide(BigDecimal.valueOf(60L), RoundingMode.HALF_UP);
        bean.setMinuteNum(minute.intValue());
        service.save(bean, siteId);
        return MessageUtils.sucessMsg("获取成功");
    }
}
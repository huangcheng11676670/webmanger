package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.UserViewTime;
import com.jspxcms.core.dto.ReportUserTimeDto;

/**
 * UserViewTimeService
 * 
 */
public interface UserViewTimeService extends IBaseService<UserViewTime, Integer>{

    public void update(UserViewTime bean, Integer siteId);

    public void save(UserViewTime bean, Integer siteId);

    /**
     * 分页展示
     * @param siteId
     * @param params
     * @param pageable
     * @return
     */
    public Page<UserViewTime> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable);
    /**
     * 统计时间范围内，操作员录入的舆情总数
     * @param areaId
     * @param startDate
     * @param endDate
     * @return
     */
    public List<ReportUserTimeDto> reportUserTimeNativeQuery(Integer userId, String startDate,
            String endDate);
}
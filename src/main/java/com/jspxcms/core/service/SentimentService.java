package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.Sentiment;
import com.jspxcms.core.dto.ReportSentimentNumDto;
import com.jspxcms.core.dto.ReportCountAndIdDto;

/**
 * SentimentService
 * 
 */
public interface SentimentService extends IBaseService<Sentiment, Integer>{
    public long countByToday();

    public List<Sentiment> findList(Integer siteId, Map<String, String[]> params, Sort sort);
    
    public void update(Sentiment bean, Integer siteId, Integer sysDictTypeId, Integer customerId, Integer areaId);

    public void save(Sentiment bean, Integer siteId, Integer areaId);

    public List<ReportSentimentNumDto> reportSentimentNumNativeQuery(Integer userid, String startDate, String endDate);
    /**
     * 饼图，按收藏夹统计
     * @param userid
     * @param startDate
     * @param endDate
     * @return
     */
    public List<ReportCountAndIdDto> reportSentimentPieNativeQuery(Integer userid, String startDate, String endDate);
    /**
     * 柱状图，按区域统计
     * @param startDate
     * @param endDate
     * @return
     */
    public List<ReportCountAndIdDto> reportSentimentAreaNativeQuery(String startDate, String endDate);
    /**
     * 加入案例
     * @param id
     */
    public Sentiment joincase(Integer id);
    /**
     * 舆情总数
     * @return
     */
    public Long countTotal();
    /**
     * 舆情总数
     * @return
     */
    public Long countTotalByUserId(Integer userId);
    /**
     * 分页展示
     * @param siteId
     * @param params
     * @param pageable
     * @return
     */
    public Page<Sentiment> findPage(Integer siteId, Integer areaId, Map<String, String[]> params, Pageable pageable);
}
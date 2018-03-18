package com.jspxcms.core.service;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.Contract;
import com.jspxcms.core.dto.ReportContractDto;
import com.jspxcms.core.dto.ReportUserSentimentDto;

/**
 * ContractService
 * 
 */
public interface ContractService extends IBaseService<Contract, Integer>{

    public List<Contract> findList(Integer siteId, Map<String, String[]> params, Sort sort);
    
    public void update(Contract bean, Integer siteId, Integer sysDictTypeId, Integer customerId);

    public void save(Contract bean, Integer siteId, Integer customerId);
    /**
     * 每月新增合同数
     * @param searchMonth 格式为yyyy-MM
     * @return
     */
    public BigInteger reportContractNewNumNativeQuery(Integer areaId, String searchMonth);
    /**
     * 月份区间内统计，新增合同数，续约数，合同总数，总金额，按月份统计
     * @param areaId
     * @param startDate
     * @param endDate
     * @return
     */
    public List<ReportContractDto> reportContractAreaNativeQuery(Integer areaId, String startDate, String endDate);
    /**
     * 合同到期数
     * @return
     */
    public Long endContractNum();
    /**
     * 分页
     * @param siteId
     * @param params
     * @param pageable
     * @return
     */
    public Page<Contract> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable);
    /**
     * 统计时间范围内，操作员录入的舆情总数
     * @param areaId
     * @param startDate
     * @param endDate
     * @return
     */
    public List<ReportUserSentimentDto> reportUserSentimentNativeQuery(Integer userId, String startDate,
            String endDate);
}
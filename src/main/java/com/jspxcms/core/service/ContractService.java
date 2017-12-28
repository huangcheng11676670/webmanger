package com.jspxcms.core.service;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.Contract;
import com.jspxcms.core.dto.ReportContractDto;

/**
 * ContractService
 * 
 */
public interface ContractService extends IBaseService<Contract, Integer>{

    public List<Contract> findList(Integer siteId, Map<String, String[]> params, Sort sort);
    
    public void update(Contract bean, Integer siteId, Integer sysDictTypeId, Integer customerId);

    public void save(Contract bean, Integer siteId);
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
}
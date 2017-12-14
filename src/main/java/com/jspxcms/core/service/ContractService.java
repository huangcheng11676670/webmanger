package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.Contract;

/**
 * ContractService
 * 
 */
public interface ContractService extends IBaseService<Contract, Integer>{

    public List<Contract> findList(Integer siteId, Map<String, String[]> params, Sort sort);
    
    public void update(Contract bean, Integer siteId, Integer sysDictTypeId, Integer customerId);

    public void save(Contract bean, Integer siteId);
}
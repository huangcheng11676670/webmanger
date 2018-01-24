package com.jspxcms.core.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;

import com.jspxcms.common.orm.BaseCrudDao;
import com.jspxcms.core.domain.Contract;

/**
 * ContractDao
 * 
 */
public interface ContractDao extends BaseCrudDao<Contract, Integer> {

    public List<Contract> findBySiteId(Integer siteId, Sort sort);

    public Page<Contract> findAll(Specification<Contract> spec, Pageable pageable);
    
    @Query(value = "select count(*) from cms_yq_contract where cast( f_contract_end_time as date) > cast(now() as date) ", nativeQuery = true)
    public Long endContractNum();

}
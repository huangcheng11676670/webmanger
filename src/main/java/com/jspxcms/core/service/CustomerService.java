package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jspxcms.common.service.IBaseService;
import com.jspxcms.core.domain.Customer;

/**
 * CustomerService
 * 
 */
public interface CustomerService extends IBaseService<Customer, Integer>{

    void save(Customer bean, Integer siteId);
    
    public List<Customer> findList(Integer siteId, Map<String, String[]> params, Sort sort);

    List<Customer> findList(Integer siteId);

    List<Customer> findByAreaId(Integer areaId);
    
    Long countCustomer();
    /**
     * 分页
     * @param siteId
     * @param params
     * @param pageable
     * @return
     */
    Page<Customer> findPage(Integer siteId, Map<String, String[]> params, Pageable pageable);
}

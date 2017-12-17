package com.jspxcms.core.repository;

import java.util.Collection;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;
import com.jspxcms.common.orm.BaseCrudDao;
import com.jspxcms.core.domain.Customer;

/**
 * CustomerDao
 * 
 */
public interface CustomerDao extends BaseCrudDao<Customer, Integer> {

    public List<Customer> findBySiteIdAndStatus(Integer siteId, Integer status, Sort sort);

    @Query("select count(*) from Customer bean where bean.site.id in ?1")
    public long countBySiteId(Collection<Integer> siteIds);

    public Page<Customer> findAll(Specification<Customer> spec, Pageable pageable);
    
    public List<Customer> findByAreaId(Integer areaId);
}
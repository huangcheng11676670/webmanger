package com.jspxcms.core.repository;

import java.util.Collection;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;
import com.jspxcms.common.orm.BaseCrudDao;
import com.jspxcms.core.domain.SysFavorite;

/**
 * SysFavoriteDao
 * 
 */
public interface SysFavoriteDao extends BaseCrudDao<SysFavorite, Integer> {

    public List<SysFavorite> findBySiteId(Integer siteId, Sort sort);

    @Query("select count(*) from SysFavorite bean where bean.site.id in ?1")
    public long countBySiteId(Collection<Integer> siteIds);

    public Page<SysFavorite> findAll(Specification<SysFavorite> spec, Pageable pageable);

    public List<SysFavorite> findByCustomerId(Integer schoolid);

}
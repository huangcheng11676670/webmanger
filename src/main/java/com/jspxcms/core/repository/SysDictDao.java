package com.jspxcms.core.repository;

import java.util.Collection;
import java.util.List;

import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import com.jspxcms.common.orm.Limitable;
import com.jspxcms.core.domain.SysDict;

/**
 * SysDictDao
 * 
 */
@CacheConfig(cacheNames = "sysDict")
public interface SysDictDao extends Repository<SysDict, Integer> {
    public List<SysDict> findAll(Specification<SysDict> spec, Sort sort);

    public List<SysDict> findAll(Specification<SysDict> spec, Limitable limit);

    @Cacheable
    public SysDict findOne(Integer id);

    @CacheEvict(allEntries=true)
    public SysDict save(SysDict bean);

    @CacheEvict(allEntries=true)
    public void delete(SysDict bean);

    public List<SysDict> findBySiteId(Integer siteId, Sort sort);
    
   public List<SysDict> findBySiteIdAndStatus(Integer siteId, Integer status, Sort sort);

    @Query("select count(*) from SysDict bean where bean.site.id in ?1")
    public long countBySiteId(Collection<Integer> siteIds);

    public Page<SysDict> findAll(Specification<SysDict> spec, Pageable pageable);

    @Query("select bean from SysDict bean where bean.site.id = ?1 and bean.parentId = ?2 ")
    public List<SysDict> findBySiteIdAndParentId(Integer siteId, Integer pid, Sort sort);

    public List<SysDict> findByTreeNumberStartingWith(String treeNumber, Sort sort);

    public List<SysDict> findAll(Sort sort);

   @Cacheable
    public List<SysDict> findByTreeNumberStartingWithAndType(String treeNumber, String type, Sort sort);

   @Cacheable
    public List<SysDict> findByType(String areaType, Sort sort);
}
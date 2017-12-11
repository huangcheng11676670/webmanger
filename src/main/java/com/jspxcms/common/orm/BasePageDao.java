package com.jspxcms.common.orm;

import java.io.Serializable;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

/**
 * 通用的分页DAO层
 * @author HuangCheng
 * @param <T>
 * @param <ID>
 */
public interface BasePageDao<T, ID extends Serializable> extends BaseCrudDao<T, ID> {

    /**
     * 使用代码
     * PagingAndSortingRepository<User, Long> repository = // … get access to a bean
        Page<User> users = repository.findAll(new PageRequest(1, 20));
     * @param sort
     * @return
     */
    Iterable<T> findAll(Sort sort);

    Page<T> findAll(Pageable pageable);
}
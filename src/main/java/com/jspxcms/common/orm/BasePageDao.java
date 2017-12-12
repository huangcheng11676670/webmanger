package com.jspxcms.common.orm;

import java.io.Serializable;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 通用的分页DAO层
 * @author HuangCheng
 * @param <T>
 * @param <ID>
 */
public interface BasePageDao<T, ID extends Serializable> extends BaseCrudDao<T, ID> {


    Page<T> findAll(Pageable pageable);
}
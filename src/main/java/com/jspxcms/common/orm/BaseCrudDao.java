package com.jspxcms.common.orm;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * 通用DAO层
 * @author HuangCheng
 */
public interface BaseCrudDao<T, ID extends Serializable> extends JpaRepository<T, ID>, JpaSpecificationExecutor<T>{

    /**
     * Saves the given entity.
     * 
     * @param entity
     * @return
     */
    <S extends T> S save(S entity);

    /**
     * Returns the entity identified by the given id.
     * 
     * @param primaryKey
     * @return
     */
    Optional<T> findById(ID primaryKey);


    List<T> findAll(Specification<T> spec, Sort sort);
    /**
     * Returns the number of entities.
     * 
     * @return
     */
    long count();

    /**
     * Indicates whether an entity with the given id exists.
     * 
     * @param primaryKey
     * @return
     */
    boolean existsById(ID primaryKey);
}
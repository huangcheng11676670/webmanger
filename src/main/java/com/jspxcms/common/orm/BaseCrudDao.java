package com.jspxcms.common.orm;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.Repository;

/**
 * 通用DAO层
 * @author HuangCheng
 */
public interface BaseCrudDao<T, ID extends Serializable> extends Repository<T, ID> {

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

    /**
     * Returns all entities.
     * 
     * @return
     */
    Iterable<T> findAll();

    List<T> findAll(Specification<T> spec, Sort sort);

    /**
     * Returns the number of entities.
     * 
     * @return
     */
    long count();

    /**
     * Deletes the given entity.
     * 
     * @param entity
     */
    T delete(T entity);

    /**
     * Indicates whether an entity with the given id exists.
     * 
     * @param primaryKey
     * @return
     */
    boolean existsById(ID primaryKey);
}
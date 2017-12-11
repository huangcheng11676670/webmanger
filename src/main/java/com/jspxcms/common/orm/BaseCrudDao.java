package com.jspxcms.core.repository;

import java.io.Serializable;
import java.util.Optional;
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
    void delete(T entity);

    /**
     * Indicates whether an entity with the given id exists.
     * 
     * @param primaryKey
     * @return
     */
    boolean existsById(ID primaryKey);
}
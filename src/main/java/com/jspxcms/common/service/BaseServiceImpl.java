package com.jspxcms.common.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import com.jspxcms.common.orm.BaseCrudDao;

public class BaseServiceImpl<T, ID extends Serializable> implements IBaseService<T, ID>{

    public BaseCrudDao<T, ID> dao;

    public void setDao(BaseCrudDao<T, ID> dao) {
        this.dao = dao;
    }

    public BaseCrudDao<T, ID> getDao() {
        return dao;
    }

    @Override
    public List<T> findAll() {
        return dao.findAll();
    }

    @Override
    public T get(ID id) {
        Optional<T> optEntity = dao.findById(id);
        if(optEntity.isPresent()) {
            return optEntity.get();
        }else {
            return null;
        }
    }

    @Override
    public T update(T bean) {
        bean = dao.saveAndFlush(bean);
        return bean;
    }

    @Override
    public T delete(ID id) {
        Optional<T> optEntity = dao.findById(id);
        if(optEntity.isPresent()) {
            T entity = optEntity.get();
            dao.delete(entity);
        }
        return optEntity.get();
    }

    @Override
    public List<T> delete(ID[] ids) {
        List<T> beans = new ArrayList<T>();
        for (int i = 0; i < ids.length; i++) {
            beans.add(delete(ids[i]));
        }
        return beans;
    }
}
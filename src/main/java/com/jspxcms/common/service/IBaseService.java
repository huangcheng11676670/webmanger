package com.jspxcms.common.service;

import java.io.Serializable;
import java.util.List;

public interface IBaseService<T, ID extends Serializable> {

    public List<T> findAll();

    public T get(ID id);

    public T update(T bean);

    public T delete(ID id);

    public List<T> delete(ID[] ids);
}
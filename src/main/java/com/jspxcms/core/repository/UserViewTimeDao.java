package com.jspxcms.core.repository;

import java.util.Date;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import com.jspxcms.common.orm.BaseCrudDao;
import com.jspxcms.core.domain.UserViewTime;

/**
 * UserViewTimeDao
 * 
 */
public interface UserViewTimeDao extends BaseCrudDao<UserViewTime, Integer> {

    public Page<UserViewTime> findAll(Specification<UserViewTime> spec, Pageable pageable);

    public UserViewTime findByFavoriteIdAndUserIdAndCreateDate( Integer favoriteId, Integer userId, Date createDate);
}
package com.jspxcms.core.repository;

import java.util.List;
import java.util.concurrent.Future;
import java.util.stream.Stream;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.scheduling.annotation.Async;

import com.jspxcms.core.domain.Org;
import com.jspxcms.core.domain.User;

public interface TestUserDao extends JpaRepository<User, Integer>{

    User findByOrg_Parent(Org org);
    
   // Page<User> findByUsername(String lastname, Pageable pageable);
    
    User findFirstByOrderByUsernameAsc();
    
    @Query("select u from User u")
    Stream<User> findAllByCustomQueryAndStream();
    
    @Query("select u from User u")
    Stream<User> streamAllPaged(Pageable pageable);
    
    @Async
    Future<User> findByUsername(String firstname);   
    
    @Query("from User u where u.username=:name")
    User findUser(@Param("name") String name);// 参数name 映射到数据库字段name

    @Query("select u from User u where u.username like %?1")
    List<User> findByUsernameEndsWith(String firstname);
    
    @Query(value = "SELECT * FROM cms_user WHERE f_username = ?1", nativeQuery = true)
    User findByfusername(String emailAddress);
    
  /*  @Query(
        value = "SELECT * FROM cms_user WHERE f_username = ?1", 
        countQuery = "SELECT count(*) FROM cms_user WHERE f_username = ?1", 
        nativeQuery = true)
    public Page<User> findByUsername(String lastname, Pageable pageable);*/
    
    @Query("select u from User u where u.username like ?1%")
    List<User> findByAndSort(String lastname, Sort sort);
    
    @Query("select u from User u where u.username = :firstname")
    User findByLastname(@Param("firstname") String firstname);
}
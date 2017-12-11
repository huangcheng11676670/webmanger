package com.jspxcms.core;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jspxcms.core.domain.User;
import com.jspxcms.core.domain.dsl.QUser;
import com.jspxcms.core.repository.OrgDao;
import com.jspxcms.core.repository.TestUserDao;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class JpaDaoTest extends AbstractServiceTest {

    @Autowired
    TestUserDao dao;

    @Autowired
    OrgDao orgDao;
    
    private EntityManager em;

    @PersistenceContext
    public void setEm(EntityManager em) {
        this.em = em;
    }
    
    @Test
    public void testQuery() {
        JPAQuery<?> query = new JPAQuery<Void>(em);
        QUser user = QUser.user;
        query.from(user);
    }
    @Test
    public void testjpa() {
        JPAQueryFactory  factory = new JPAQueryFactory (em);
        QUser user = QUser.user;
       User dbUser = factory.selectFrom(user)
        .where(user.username.eq("admin"))
        .fetchOne();
       System.out.println(dbUser.getRealName());
    }

    //@Test
    public void test() {
        /*
         * Optional<User> optUser = dao.findById(1); optUser.ifPresent(item ->
         * System.out.println(optUser.get().getUsername()));
         */
    /*    Org dbOrg = orgDao.findById(1);
        User listUser = dao.findByOrg_Parent(dbOrg);*/
//        Page<User> page = dao.findByUsername("admin", new PageRequest(1, 10));
       /* Stream<User> dbUser = dao.streamAllPaged(new PageRequest(1, 10));
        dbUser.forEach(item -> System.out.println(item.getUsername()));*/
        //dao.findByUsername("admin");
    }
    
    //@Test
    public void testquerydsl() {
        /*JPAQueryFactory jpaFactory = new JPAQueryFactory(this.em);
        QUser user = QUser.user;*/
     /*   JPAQuery<User> query = new JPAQuery<User>(this.em);
        query.from(user);
        Predicate predicate = user.username.eq("admin");
        query.where(predicate);
        query.fetch();*/
/*        jpaFactory.selectFrom(user)
        .where(user.username.eq("admin"))
        .fetchOne();*/
      //  dao.findByfusername("admin");
//        dao.findByAndSort("admin", new Sort("id"));
        dao.findByLastname("admin");
    }
}

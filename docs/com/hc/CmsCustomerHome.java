package com.hc;
// Generated 2017-12-10 15:16:21 by Hibernate Tools 5.2.6.Final

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class CmsCustomer.
 * @see com.hc.CmsCustomer
 * @author Hibernate Tools
 */
@Stateless
public class CmsCustomerHome {

    private static final Log log = LogFactory.getLog(CmsCustomerHome.class);

    @PersistenceContext
    private EntityManager entityManager;

    public void persist(CmsCustomer transientInstance) {
        log.debug("persisting CmsCustomer instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(CmsCustomer persistentInstance) {
        log.debug("removing CmsCustomer instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public CmsCustomer merge(CmsCustomer detachedInstance) {
        log.debug("merging CmsCustomer instance");
        try {
            CmsCustomer result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public CmsCustomer findById(Integer id) {
        log.debug("getting CmsCustomer instance with id: " + id);
        try {
            CmsCustomer instance = entityManager.find(CmsCustomer.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

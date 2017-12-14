package com.jspxcms.core.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.jspxcms.core.support.Siteable;

/**
 * 收藏夹管理
 */
@Entity
@Table(name = "cms_yq_favorite")
public class SysFavorite implements Siteable, java.io.Serializable {

    private static final long serialVersionUID = 6209612344565429906L;
    private Integer id;
    private SysDict sysDictType;
    private String favoriteName;
    private Customer customer;
    private String customerUrl;
    private Site site;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "f_favorite_id", unique = true, nullable = false)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_favorite_type_id", nullable = false)
    public SysDict getSysDictType() {
        return this.sysDictType;
    }

    public void setSysDictType(SysDict sysDictType) {
        this.sysDictType = sysDictType;
    }

    @Column(name = "f_favorite_name")
    public String getFavoriteName() {
        return this.favoriteName;
    }

    public void setFavoriteName(String favoriteName) {
        this.favoriteName = favoriteName;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_customer_id", nullable = false)
    public Customer getCustomer() {
        return this.customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Column(name = "f_customer_url", length = 1024)
    public String getCustomerUrl() {
        return this.customerUrl;
    }

    public void setCustomerUrl(String customerUrl) {
        this.customerUrl = customerUrl;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_site_id", nullable = false)
    public Site getSite() {
        return this.site;
    }
    public void setSite(Site site) {
        this.site = site;
    }
}
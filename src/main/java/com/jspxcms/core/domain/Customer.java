package com.jspxcms.core.domain;

import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.jspxcms.core.support.Siteable;

/**
 * 客户
 */
@Entity
@Table(name = "cms_customer")
public class Customer implements Siteable, java.io.Serializable {

    private static final long serialVersionUID = -8120003150160744976L;
    private Integer id;
    private String name;
    private String webUrl;
    private String weixinName;
    private Integer areaId;
    private String code;
    /**
     * 是否回款
     */
    private Boolean clearance;
    private String remarks;
    private Integer status;
    private Site site;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "f_customer_id", unique = true, nullable = false)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer customerId) {
        this.id = customerId;
    }

    @Column(name = "f_name", nullable = false, length = 100)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "f_web_url", nullable = false, length = 1024)
    public String getWebUrl() {
        return this.webUrl;
    }

    public void setWebUrl(String webUrl) {
        this.webUrl = webUrl;
    }

    @Column(name = "f_weixin_name", nullable = false, length = 200)
    public String getWeixinName() {
        return this.weixinName;
    }

    public void setWeixinName(String weixinName) {
        this.weixinName = weixinName;
    }

    @Column(name = "f_area_id", nullable = false)
    public Integer getAreaId() {
        return this.areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    @Column(name = "f_code", nullable = false, length = 200)
    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "f_clearance")
    public Boolean getClearance() {
        return this.clearance;
    }

    public void setClearance(Boolean clearance) {
        this.clearance = clearance;
    }

    @Column(name = "f_remarks")
    public String getRemarks() {
        return this.remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @Column(name = "f_status", nullable = false)
    public Integer getStatus() {
        return this.status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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

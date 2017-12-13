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
    
    private String contact1;
    private String contact1Phone;
    private String contact1QQ;
    private String contact1Weixin;

    private String contact2;
    private String contact2Phone;
    private String contact2QQ;
    private String contact2Weixin;

    private String contact3;
    private String contact3Phone;
    private String contact3QQ;
    private String contact3Weixin;

    private String contact4;
    private String contact4Phone;
    private String contact4QQ;
    private String contact4Weixin;

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

    @Column(name = "f_contact1", length = 30)
    public String getContact1() {
        return contact1;
    }

    public void setContact1(String contact1) {
        this.contact1 = contact1;
    }

    @Column(name = "f_contact1_phone", length = 20)
    public String getContact1Phone() {
        return contact1Phone;
    }

    public void setContact1Phone(String contact1Phone) {
        this.contact1Phone = contact1Phone;
    }

    @Column(name = "f_contact2", length = 30)
    public String getContact2() {
        return contact2;
    }

    public void setContact2(String contact2) {
        this.contact2 = contact2;
    }

    @Column(name = "f_contact2_phone", length = 20)
    public String getContact2Phone() {
        return contact2Phone;
    }

    public void setContact2Phone(String contact2Phone) {
        this.contact2Phone = contact2Phone;
    }

    @Column(name = "f_contact3", length = 30)
    public String getContact3() {
        return contact3;
    }

    public void setContact3(String contact3) {
        this.contact3 = contact3;
    }

    @Column(name = "f_contact3_phone", length = 20)
    public String getContact3Phone() {
        return contact3Phone;
    }

    public void setContact3Phone(String contact3Phone) {
        this.contact3Phone = contact3Phone;
    }

    @Column(name = "f_contact4", length = 30)
    public String getContact4() {
        return contact4;
    }

    public void setContact4(String contact4) {
        this.contact4 = contact4;
    }

    @Column(name = "f_contact4_phone", length = 20)
    public String getContact4Phone() {
        return contact4Phone;
    }

    public void setContact4Phone(String contact4Phone) {
        this.contact4Phone = contact4Phone;
    }

    @Column(name = "f_contact1_qq", length = 20)
    public String getContact1QQ() {
        return contact1QQ;
    }

    public void setContact1QQ(String contact1qq) {
        contact1QQ = contact1qq;
    }

    @Column(name = "f_contact1_weixin", length = 20)
    public String getContact1Weixin() {
        return contact1Weixin;
    }

    public void setContact1Weixin(String contact1Weixin) {
        this.contact1Weixin = contact1Weixin;
    }

    @Column(name = "f_contact2_qq", length = 20)
    public String getContact2QQ() {
        return contact2QQ;
    }

    public void setContact2QQ(String contact2qq) {
        contact2QQ = contact2qq;
    }

    @Column(name = "f_contact2_weixin", length = 20)
    public String getContact2Weixin() {
        return contact2Weixin;
    }

    public void setContact2Weixin(String contact2Weixin) {
        this.contact2Weixin = contact2Weixin;
    }

    @Column(name = "f_contact3_qq", length = 20)
    public String getContact3QQ() {
        return contact3QQ;
    }

    public void setContact3QQ(String contact3qq) {
        contact3QQ = contact3qq;
    }

    @Column(name = "f_contact3_weixin", length = 20)
    public String getContact3Weixin() {
        return contact3Weixin;
    }

    public void setContact3Weixin(String contact3Weixin) {
        this.contact3Weixin = contact3Weixin;
    }

    @Column(name = "f_contact4_qq", length = 20)
    public String getContact4QQ() {
        return contact4QQ;
    }

    public void setContact4QQ(String contact4qq) {
        contact4QQ = contact4qq;
    }

    @Column(name = "f_contact4_weixin", length = 20)
    public String getContact4Weixin() {
        return contact4Weixin;
    }

    public void setContact4Weixin(String contact4Weixin) {
        this.contact4Weixin = contact4Weixin;
    }
    
    
}

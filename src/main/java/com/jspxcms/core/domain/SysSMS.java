package com.jspxcms.core.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.jspxcms.core.support.Siteable;

/**
 * 短信管理
 */
@Entity
@Table(name = "cms_yq_sms")
public class SysSMS implements Siteable, java.io.Serializable {

    private static final long serialVersionUID = 6427469572404598316L;
    private Integer id;
    private SysDict area;
    private String areaName;
    private Integer customerId;
    private String customerName;
    private String contact1;
    private String contact1Phone;
    private String contact1Qq;
    private String smsContent;
    private Site site;
    private String message;
    private Date createDatetime;
    /**
     * 短地址cms_yq_short_url外键id
     */
    private Integer refId;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "f_sms_id", unique = true, nullable = false)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "f_create_datetime", length = 19)
    public Date getCreateDatetime() {
        return this.createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_area_id", nullable = false)
    public SysDict getArea() {
        return this.area;
    }
    
    public void setArea(SysDict area) {
        this.area = area;
    }

    @Column(name = "f_ref_id", nullable = false)
    public Integer getRefId() {
        return this.refId;
    }

    public void setRefId(Integer refId) {
        this.refId = refId;
    }

    @Column(name = "f_area_name", nullable = false, length = 100)
    public String getAreaName() {
        return this.areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    @Column(name = "f_customer_id", nullable = false)
    public Integer getCustomerId() {
        return this.customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    @Column(name = "f_customer_name", length = 150)
    public String getCustomerName() {
        return this.customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    @Column(name = "f_contact1", length = 30)
    public String getContact1() {
        return this.contact1;
    }

    public void setContact1(String contact1) {
        this.contact1 = contact1;
    }

    @Column(name = "f_contact1_phone", length = 20)
    public String getContact1Phone() {
        return this.contact1Phone;
    }

    public void setContact1Phone(String contact1Phone) {
        this.contact1Phone = contact1Phone;
    }

    @Column(name = "f_contact1_qq", length = 20)
    public String getContact1Qq() {
        return this.contact1Qq;
    }

    public void setContact1Qq(String contact1Qq) {
        this.contact1Qq = contact1Qq;
    }

    @Column(name = "f_sms_content")
    public String getSmsContent() {
        return this.smsContent;
    }

    public void setSmsContent(String smsContent) {
        this.smsContent = smsContent;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_site_id", nullable = false)
    public Site getSite() {
        return this.site;
    }
    public void setSite(Site site) {
        this.site = site;
    }

    @Column(name = "f_message")
    public String getMessage() {
        return this.message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
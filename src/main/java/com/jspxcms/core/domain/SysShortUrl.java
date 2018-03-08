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
 * 短地址管理，短地址跳转实际长地址
 */
@Entity
@Table(name = "cms_yq_short_url")
public class SysShortUrl implements Siteable, java.io.Serializable {

    private static final long serialVersionUID = 6427469572404598316L;
    private Integer id;
    private String targetUrl;
    private String code;
    private Site site;
    private Date createDatetime;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "f_short_id", unique = true, nullable = false)
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

    @Column(name = "f_code", nullable = false, length = 20)
    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "f_target_url", nullable = false, length = 1024)
    public String getTargetUrl() {
        return this.targetUrl;
    }

    public void setTargetUrl(String targetUrl) {
        this.targetUrl = targetUrl;
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
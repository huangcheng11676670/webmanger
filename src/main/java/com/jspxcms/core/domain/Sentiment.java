package com.jspxcms.core.domain;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.jspxcms.core.support.Siteable;

/**
 * 舆情管理
 */
@Entity
@Table(name = "cms_yq_sentiment")
public class Sentiment implements Siteable, java.io.Serializable {

    private static final long serialVersionUID = -8078013965593727495L;
    private Integer id;
    private String sentimentTitle;
    private String sentimentUrl;
    private User user;
    private Integer infoLevel;
    private String infoLevelShow;
    private Integer infoType;
    private String infoTypeShow;
    private Date createDatetime;
    private Integer schoolLevel;
    private Integer areaId;
    private Site site;
    private Customer customer;
    /**
     * 采集的内容创建时间,发帖时间
     */
    private String contentCreateTime;
    private Integer relayNum;
    private Integer commentNum;
    private String summary;
    private String smsContent;
    private Integer favoriteId;
<<<<<<< HEAD

    @Transient
    public String getInfoLevelShow() {
        return infoLevelShow;
    }

    public void setInfoLevelShow(String infoLevelShow) {
        this.infoLevelShow = infoLevelShow;
    }
    @Transient
    public String getInfoTypeShow() {
        return infoTypeShow;
    }

    public void setInfoTypeShow(String infoTypeShow) {
        this.infoTypeShow = infoTypeShow;
    }
=======
>>>>>>> branch 'master' of https://github.com/huangcheng11676670/webmanger.git

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "f_sentiment_id", unique = true, nullable = false)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name = "f_sentiment_title", length = 100)
    public String getSentimentTitle() {
        return this.sentimentTitle;
    }

    public void setSentimentTitle(String sentimentTitle) {
        this.sentimentTitle = sentimentTitle;
    }

    @Column(name = "f_sentiment_url", length = 1024)
    public String getSentimentUrl() {
        return this.sentimentUrl;
    }

    public void setSentimentUrl(String sentimentUrl) {
        this.sentimentUrl = sentimentUrl;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_user_id", nullable = false)
    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "f_info_level")
    public Integer getInfoLevel() {
        return this.infoLevel;
    }

    public void setInfoLevel(Integer infoLevel) {
        this.infoLevel = infoLevel;
    }

    @Column(name = "f_info_type")
    public Integer getInfoType() {
        return this.infoType;
    }

    public void setInfoType(Integer infoType) {
        this.infoType = infoType;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "f_create_datetime", length = 19)
    public Date getCreateDatetime() {
        return this.createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    @Column(name = "f_school_level")
    public Integer getSchoolLevel() {
        return this.schoolLevel;
    }

    public void setSchoolLevel(Integer schoolLevel) {
        this.schoolLevel = schoolLevel;
    }

    @Column(name = "f_area_id")
    public Integer getAreaId() {
        return this.areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_site_id", nullable = false)
    public Site getSite() {
        return this.site;
    }
    public void setSite(Site site) {
        this.site = site;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_customer_id", nullable = false)
    public Customer getCustomer() {
        return this.customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Column(name = "f_content_create_time", length = 20)
    public String getContentCreateTime() {
        return this.contentCreateTime;
    }

    public void setContentCreateTime(String contentCreateTime) {
        this.contentCreateTime = contentCreateTime;
    }

    @Column(name = "f_relay_num")
    public Integer getRelayNum() {
        return this.relayNum;
    }

    public void setRelayNum(Integer relayNum) {
        this.relayNum = relayNum;
    }

    @Column(name = "f_comment_num")
    public Integer getCommentNum() {
        return this.commentNum;
    }

    public void setCommentNum(Integer commentNum) {
        this.commentNum = commentNum;
    }

    @Column(name = "f_summary", length = 2000)
    public String getSummary() {
        return this.summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    @Column(name = "f_sms_content")
    public String getSmsContent() {
        return this.smsContent;
    }

    public void setSmsContent(String smsContent) {
        this.smsContent = smsContent;
    }

    @Column(name = "f_favorite_id")
    public Integer getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(Integer favoriteId) {
        this.favoriteId = favoriteId;
    }
}
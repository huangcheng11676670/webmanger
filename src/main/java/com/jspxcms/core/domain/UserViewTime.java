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

import com.jspxcms.core.support.Siteable;

/**
 * 操作员访问，监控网页停留的时间,单位分钟
 */
@Entity
@Table(name = "cms_yq_view_time")
public class UserViewTime  implements Siteable, java.io.Serializable {

    private static final long serialVersionUID = 1805490765419844082L;
    private Integer id;
    private Integer favoriteId;
    private String favoriteName;
    private Site site;
    private Date createDate;
    private Integer userId;
    private Integer minuteNum;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "f_view_id", unique = true, nullable = false)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name = "f_favorite_id", nullable = false)
    public Integer getFavoriteId() {
        return this.favoriteId;
    }

    public void setFavoriteId(Integer favoriteId) {
        this.favoriteId = favoriteId;
    }

    @Column(name = "f_favorite_name", nullable = false, length = 255)
    public String getFavoriteName() {
        return this.favoriteName;
    }

    public void setFavoriteName(String favoriteName) {
        this.favoriteName = favoriteName;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_site_id", nullable = false)
    public Site getSite() {
        return this.site;
    }
    public void setSite(Site site) {
        this.site = site;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "f_create_date", length = 10)
    public Date getCreateDate() {
        return this.createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @Column(name = "f_user_id")
    public Integer getUserId() {
        return this.userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Column(name = "f_minute_num")
    public Integer getMinuteNum() {
        return this.minuteNum;
    }

    public void setMinuteNum(Integer minuteNum) {
        this.minuteNum = minuteNum;
    }
}
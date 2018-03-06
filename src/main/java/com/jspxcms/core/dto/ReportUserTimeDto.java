package com.jspxcms.core.dto;

import java.math.BigDecimal;
<<<<<<< HEAD
import java.math.BigInteger;

public class ReportUserTimeDto {
    private BigDecimal num;
    private BigInteger favoriteId;
    private String favoriteName;

    public ReportUserTimeDto(BigDecimal num, String favoriteName) {
        super();
        this.num = num;
        this.favoriteName = favoriteName;
    }
    public ReportUserTimeDto(BigDecimal num, BigInteger favoriteId) {
        super();
        this.num = num;
        this.favoriteId = favoriteId;
    }

    public BigDecimal getNum() {
        return num;
    }

    public void setNum(BigDecimal num) {
        this.num = num;
    }

    public BigInteger getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(BigInteger favoriteId) {
=======

public class ReportUserTimeDto {
    private BigDecimal num;
    private Integer favoriteId;
    private String favoriteName;

    public ReportUserTimeDto(BigDecimal num, String favoriteName) {
        super();
        this.num = num;
        this.favoriteName = favoriteName;
    }

    public BigDecimal getNum() {
        return num;
    }

    public void setNum(BigDecimal num) {
        this.num = num;
    }

    public Integer getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(Integer favoriteId) {
>>>>>>> branch 'master' of https://github.com/huangcheng11676670/webmanger.git
        this.favoriteId = favoriteId;
    }

    public String getFavoriteName() {
        return favoriteName;
    }

    public void setFavoriteName(String favoriteName) {
        this.favoriteName = favoriteName;
    }
}

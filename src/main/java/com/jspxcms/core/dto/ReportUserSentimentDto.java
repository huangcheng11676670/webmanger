package com.jspxcms.core.dto;

import java.math.BigInteger;

public class ReportUserSentimentDto {
    private BigInteger num;
    private Integer favoriteId;
    private String favoriteName;

    public ReportUserSentimentDto(BigInteger num, Integer favoriteId) {
        super();
        this.num = num;
        this.favoriteId = favoriteId;
    }

    public BigInteger getNum() {
        return num;
    }

    public void setNum(BigInteger num) {
        this.num = num;
    }

    public Integer getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(Integer favoriteId) {
        this.favoriteId = favoriteId;
    }

    public String getFavoriteName() {
        return favoriteName;
    }

    public void setFavoriteName(String favoriteName) {
        this.favoriteName = favoriteName;
    }
}

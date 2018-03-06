package com.jspxcms.core.dto;

import java.math.BigDecimal;

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
        this.favoriteId = favoriteId;
    }

    public String getFavoriteName() {
        return favoriteName;
    }

    public void setFavoriteName(String favoriteName) {
        this.favoriteName = favoriteName;
    }
}

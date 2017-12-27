package com.jspxcms.core.dto;

import java.math.BigInteger;

public class ReportCountAndIdDto {
    private BigInteger num;
    private Integer favoriteid;
    private String favoriteName;
    
    public ReportCountAndIdDto(BigInteger num, Integer favoriteid) {
        super();
        this.num = num;
        this.favoriteid = favoriteid;
    }
    public String getFavoriteName() {
        return favoriteName;
    }
    public void setFavoriteName(String favoriteName) {
        this.favoriteName = favoriteName;
    }
    public BigInteger getNum() {
        return num;
    }
    public void setNum(BigInteger num) {
        this.num = num;
    }
    public Integer getFavoriteid() {
        return favoriteid;
    }
    public void setFavoriteid(Integer favoriteid) {
        this.favoriteid = favoriteid;
    }
}
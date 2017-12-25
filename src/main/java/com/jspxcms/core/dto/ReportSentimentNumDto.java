package com.jspxcms.core.dto;

import java.math.BigInteger;
import java.util.Date;

public class ReportSentimentNumDto {
    private BigInteger num;
    private Date dateString;
    
    public ReportSentimentNumDto(BigInteger num, Date dateString) {
        super();
        this.num = num;
        this.dateString = dateString;
    }
    public BigInteger getNum() {
        return num;
    }
    public void setNum(BigInteger num) {
        this.num = num;
    }
    public Date getDateString() {
        return dateString;
    }
    public void setDateString(Date dateString) {
        this.dateString = dateString;
    }
 
    
}
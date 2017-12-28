package com.jspxcms.core.dto;

import java.math.BigDecimal;
import java.math.BigInteger;

public class ReportContractDto {
    private BigInteger newNum;
    private BigInteger continueNum;
    private BigDecimal totoalMoney;
    
    public ReportContractDto(BigInteger newNum, BigInteger continueNum, BigDecimal totoalMoney) {
        super();
        this.newNum = newNum;
        this.continueNum = continueNum;
        this.totoalMoney = totoalMoney;
    }

    public BigInteger getNewNum() {
        return newNum;
    }

    public void setNewNum(BigInteger newNum) {
        this.newNum = newNum;
    }

    public BigInteger getContinueNum() {
        return continueNum;
    }

    public void setContinueNum(BigInteger continueNum) {
        this.continueNum = continueNum;
    }

    public BigDecimal getTotoalMoney() {
        return totoalMoney;
    }

    public void setTotoalMoney(BigDecimal totoalMoney) {
        this.totoalMoney = totoalMoney;
    }
}
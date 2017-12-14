package com.jspxcms.core.domain;

import java.math.BigDecimal;
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
 * 合同
 */
@Entity
@Table(name = "cms_yq_contract")
public class Contract implements Siteable, java.io.Serializable {

    private static final long serialVersionUID = -5636398269133080206L;
    private Integer id;
    private Customer customer;
    private String contractCode;
    private String operator;
    private BigDecimal contractMoney;
    private Date contractCreateTime;
    private Date contractEndTime;
    private String remark;
    private Integer areaId;
    private Site site;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "f_contract_id", unique = true, nullable = false)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "f_customer_id", nullable = false)
    public Customer getCustomer() {
        return this.customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Column(name = "f_contract_code", length = 100)
    public String getContractCode() {
        return this.contractCode;
    }

    public void setContractCode(String contractCode) {
        this.contractCode = contractCode;
    }

    @Column(name = "f_operator", length = 50)
    public String getOperator() {
        return this.operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    @Column(name = "f_contract_money", precision = 11)
    public BigDecimal getContractMoney() {
        return this.contractMoney;
    }

    public void setContractMoney(BigDecimal contractMoney) {
        this.contractMoney = contractMoney;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "f_contract_create_time", length = 10)
    public Date getContractCreateTime() {
        return this.contractCreateTime;
    }

    public void setContractCreateTime(Date contractCreateTime) {
        this.contractCreateTime = contractCreateTime;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "f_contract_end_time", length = 10)
    public Date getContractEndTime() {
        return this.contractEndTime;
    }

    public void setContractEndTime(Date contractEndTime) {
        this.contractEndTime = contractEndTime;
    }

    @Column(name = "f_remark", length = 500)
    public String getRemark() {
        return this.remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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
}
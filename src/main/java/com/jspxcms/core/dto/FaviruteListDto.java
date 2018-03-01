package com.jspxcms.core.dto;

public class FaviruteListDto {
    private String name;
    private Integer id;
    private String customerUrl;
    public FaviruteListDto(String name, Integer id, String customerUrl) {
       this.name = name;
       this.id = id;
       this.customerUrl = customerUrl;
    }
    
    public String getCustomerUrl() {
        return customerUrl;
    }

    public void setCustomerUrl(String customerUrl) {
        this.customerUrl = customerUrl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
}
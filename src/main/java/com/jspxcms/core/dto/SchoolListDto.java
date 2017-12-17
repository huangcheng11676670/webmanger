package com.jspxcms.core.dto;

public class SchoolListDto {
    private String schoolName;
    private Integer id;
    public SchoolListDto(String name, Integer id) {
       this.schoolName = name;
       this.id = id;
    }
    public String getSchoolName() {
        return schoolName;
    }
    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
}
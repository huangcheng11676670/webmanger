package com.jspxcms.core.dto;

public class SchoolListDto {
    private String schoolName;
    private Integer id;
    private String contact1;
    private String contact1Phone;
    private String contact1QQ;

    private String contact2;
    private String contact2Phone;
    private String contact2QQ;

    private String contact3;
    private String contact3Phone;
    private String contact3QQ;

    private String contact4;
    private String contact4Phone;
    private String contact4QQ;
    
    public SchoolListDto(String name, Integer id) {
       this.schoolName = name;
       this.id = id;
    }
    public SchoolListDto(String name, Integer id, 
     String contact1,
     String contact1Phone,
     String contact1QQ,
     String contact2,
     String contact2Phone,
     String contact2QQ,
     String contact3,
     String contact3Phone,
     String contact3QQ,
     String contact4,
     String contact4Phone,
     String contact4QQ
            ) {
        this.schoolName = name;
        this.id = id;
        this.contact1 = contact1;
        this.contact1Phone = contact1Phone;
        this.contact1QQ = contact1QQ;
        this.contact2 = contact2;
        this.contact2Phone = contact2Phone;
        this.contact2QQ = contact2QQ;
        this.contact3 = contact3;
        this.contact3Phone = contact3Phone;
        this.contact3QQ = contact3QQ;
        this.contact4 = contact4;
        this.contact4Phone = contact4Phone;
        this.contact4QQ = contact4QQ;
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
    public String getContact1() {
        return contact1;
    }
    public void setContact1(String contact1) {
        this.contact1 = contact1;
    }
    public String getContact1Phone() {
        return contact1Phone;
    }
    public void setContact1Phone(String contact1Phone) {
        this.contact1Phone = contact1Phone;
    }
    public String getContact1QQ() {
        return contact1QQ;
    }
    public void setContact1QQ(String contact1qq) {
        contact1QQ = contact1qq;
    }
    public String getContact2() {
        return contact2;
    }
    public void setContact2(String contact2) {
        this.contact2 = contact2;
    }
    public String getContact2Phone() {
        return contact2Phone;
    }
    public void setContact2Phone(String contact2Phone) {
        this.contact2Phone = contact2Phone;
    }
    public String getContact2QQ() {
        return contact2QQ;
    }
    public void setContact2QQ(String contact2qq) {
        contact2QQ = contact2qq;
    }
    public String getContact3() {
        return contact3;
    }
    public void setContact3(String contact3) {
        this.contact3 = contact3;
    }
    public String getContact3Phone() {
        return contact3Phone;
    }
    public void setContact3Phone(String contact3Phone) {
        this.contact3Phone = contact3Phone;
    }
    public String getContact3QQ() {
        return contact3QQ;
    }
    public void setContact3QQ(String contact3qq) {
        contact3QQ = contact3qq;
    }
    public String getContact4() {
        return contact4;
    }
    public void setContact4(String contact4) {
        this.contact4 = contact4;
    }
    public String getContact4Phone() {
        return contact4Phone;
    }
    public void setContact4Phone(String contact4Phone) {
        this.contact4Phone = contact4Phone;
    }
    public String getContact4QQ() {
        return contact4QQ;
    }
    public void setContact4QQ(String contact4qq) {
        contact4QQ = contact4qq;
    }
}
package com.jspxcms.core.dto;

public enum SysDictType {
    INFOLEVEL("舆情等级设置","info_level"), AREATYPE("行政区设置","area_type"),
    SCHOOLLEVEL("学位分段设置","school_level"),FAVORITETYPE("收藏夹分类设置","favorite_type");

    private String name;
    private String value;

    private SysDictType(String name, String value) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
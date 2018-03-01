package com.jspxcms.core.dto;

import java.util.List;

public class TreeDto {

    private String id;
    private String index;
    private String name;
    private String pid;
    private boolean open = false;
    private boolean isParent = false;
    private List<TreeDto> children;
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getIndex() {
        return index;
    }
    public void setIndex(String index) {
        this.index = index;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPid() {
        return pid;
    }
    public void setPid(String pid) {
        this.pid = pid;
    }
    public boolean isOpen() {
        return open;
    }
    public void setOpen(boolean open) {
        this.open = open;
    }
    public boolean isParent() {
        return isParent;
    }
    public void setParent(boolean isParent) {
        this.isParent = isParent;
    }
    public List<TreeDto> getChildren() {
        return children;
    }
    public void setChildren(List<TreeDto> children) {
        this.children = children;
    }
}
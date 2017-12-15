package com.jspxcms.ext.dto;

public class CommentListDto {
    private String title;
    private String contentCreateTime;
    private String commentNum;
    private String summary;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContentCreateTime() {
        return contentCreateTime;
    }
    public void setContentCreateTime(String contentCreateTime) {
        this.contentCreateTime = contentCreateTime;
    }
    public String getCommentNum() {
        return commentNum;
    }
    public void setCommentNum(String commentNum) {
        this.commentNum = commentNum;
    }
    public String getSummary() {
        return summary;
    }
    public void setSummary(String summary) {
        this.summary = summary;
    }
}
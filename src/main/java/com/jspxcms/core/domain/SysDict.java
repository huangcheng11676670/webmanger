package com.jspxcms.core.domain;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.jspxcms.core.support.Siteable;

@Entity
@Table(name = "cms_dict")
public class SysDict implements Siteable, java.io.Serializable {
    
    public static final String AREA_TYPE = "area_type";

    private static final long serialVersionUID = -6760179206158659536L;
    private Integer id;
    private String value;
    private String label;
    private String type;
    private String description;
    private Integer sort;
    private Integer parentId;
    private String treeNumber;
    private String remarks;
    private Integer status;

    private Site site;

    public SysDict() {
    }

    public SysDict(String value, String label, String type, String description, int sort, int status) {
        this.value = value;
        this.label = label;
        this.type = type;
        this.description = description;
        this.sort = sort;
        this.status = status;
    }

    public SysDict(String value, String label, String type, String description, int sort, Integer parentId,
            String remarks, int status) {
        this.value = value;
        this.label = label;
        this.type = type;
        this.description = description;
        this.sort = sort;
        this.parentId = parentId;
        this.remarks = remarks;
        this.status = status;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "f_dict_id", unique = true, nullable = false)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name = "f_value", nullable = false, length = 20)
    public String getValue() {
        return this.value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Column(name = "f_tree_number", nullable = false, length = 100)
    public String getTreeNumber() {
        return treeNumber;
    }

    public void setTreeNumber(String treeNumber) {
        this.treeNumber = treeNumber;
    }

    @Column(name = "f_label", nullable = false, length = 100)
    public String getLabel() {
        return this.label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    @Column(name = "f_type", nullable = false, length = 100)
    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "f_description", nullable = false, length = 100)
    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "f_sort", nullable = false)
    public Integer getSort() {
        return this.sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    @Column(name = "f_parent_id", nullable = true)
    public Integer getParentId() {
        return this.parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    @Column(name = "f_remarks")
    public String getRemarks() {
        return this.remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @Column(name = "f_status", nullable = false)
    public Integer getStatus() {
        return this.status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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
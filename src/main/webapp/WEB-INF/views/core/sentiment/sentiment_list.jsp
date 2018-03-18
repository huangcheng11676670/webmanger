<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fnx" uri="http://java.sun.com/jsp/jstl/functionsx"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/head.jsp"/>
<script type="text/javascript">
$(function() {
    $("#sortHead").headSort();
});
function confirmDelete() {
    return confirm("<s:message code='confirmDelete'/>");
}
function optSingle(opt) {
    if(Cms.checkeds("ids")==0) {
        alert("<s:message code='pleaseSelectRecord'/>");
        return false;
    }
    if(Cms.checkeds("ids")>1) {
        alert("<s:message code='pleaseSelectOne'/>");
        return false;
    }
    var id = $("input[name='ids']:checkbox:checked").val();
    location.href=$(opt+id).attr("href");
}
function optDelete(form) {
    if(Cms.checkeds("ids")==0) {
        alert("<s:message code='pleaseSelectRecord'/>");
        return false;
    }
    if(!confirmDelete()) {
        return false;
    }
    form.action='delete.do';
    form.submit();
    return true;
}
</script>
</head>
<body class="skin-blue content-body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="content-header">
    <h1><s:message code="sentiment.management"/> - <s:message code="list"/></h1>
</div>
<div class="content">
    <div class="box box-primary">
        <div class="box-body table-responsive">
            <form class="form-inline ls-search" action="list.do" method="get">
                <div class="form-group">
                  <label>关键字</label>
                  <input class="form-control input-sm" type="text" name="search_CONTAIN_summary" value="${search_CONTAIN_summary[0]}"/>
                </div>
                <div class="form-group">
                  <label>开始时间</label>
                  <input class="form-control input-sm" type="text" id="search_GTE_createDatetime_Date" name="search_GTE_createDatetime_Date" value="${search_GTE_createDatetime_Date[0]}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
                </div>
                <div class="form-group">
                  <label>截止时间</label>
                  <input class="form-control input-sm" type="text" id="search_GTE_createDatetime_Date" name="search_LTE_createDatetime_Date" value="${search_LTE_createDatetime_Date[0]}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', minDate:'#F{$dp.$D(\'search_GTE_createDatetime_Date\')}'});"/>
                </div>
                <div class="form-group">
                  <label for="search_EQ_infoType_Integer">舆情分类</label>
                <select class="form-control input-sm" id="search_EQ_infoType_Integer" name="search_EQ_infoType_Integer">
                    <option value="" ><s:message code="allSelect"/></option>
                    <c:forEach var="attr" items="${infoTypelList}">
                      <c:set var="idstr">${attr.id}</c:set>
                      <option value="${attr.id}"<c:if test="${idstr eq search_EQ_infoType_Integer[0]}"> selected="selected"</c:if>>${attr.label}</option>
                      </c:forEach>
                </select>
                </div>
                <div class="form-group">
                  <label for="search_EQ_infoLevel_Integer">舆情等级</label>
                <select class="form-control input-sm" id="search_EQ_infoLevel_Integer" name="search_EQ_infoLevel_Integer">
                    <option value="" ><s:message code="allSelect"/></option>
                    <c:forEach var="attr" items="${infoLevelList}">
                      <c:set var="idstr">${attr.id}</c:set>
                      <option value="${attr.id}"<c:if test="${idstr eq search_EQ_infoLevel_Integer[0]}"> selected="selected"</c:if>>${attr.label}</option>
                      </c:forEach>
                </select>
                </div>
                <div class="form-group">
                  <label for="search_EQ_schoolLevel_Integer">学段分类</label>
                <select class="form-control input-sm" id="search_EQ_schoolLevel_Integer" name="search_EQ_schoolLevel_Integer">
                    <option value="" ><s:message code="allSelect"/></option>
                    <c:forEach var="attr" items="${schoolLevelList}">
                      <c:set var="idstr">${attr.id}</c:set>
                      <option value="${attr.id}"<c:if test="${idstr eq search_EQ_schoolLevel_Integer[0]}"> selected="selected"</c:if>>${attr.label}</option>
                      </c:forEach>
                </select>
                </div>
                <div class="form-group">
                  <label for="search_EQ_areaId_Integer">区域</label>
                  <input type="text" id="search_EQ_areaId_Integer" value="${search_EQ_areaId_Integer[0]}" name="search_EQ_areaId_Integer" class="myselectstyle">
                </div>
                <div class="form-group">
                  <label for="search_EQ_customer.id">学校列表</label>
                  <select class="form-control input-sm" id="search_EQ_customer" name="search_EQ_customer.id">
                  </select>
                </div>
              <button class="btn btn-default btn-sm" type="submit"><s:message code="search"/></button>
            </form>
            <form method="post">
                <tags:search_params/>
                <div class="btn-toolbar ls-btn-bar">
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sentiment:create">
                        <button class="btn btn-default" type="button" onclick="location.href='favoriteList.do';"><s:message code="create"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sentiment:copy">
                        <button class="btn btn-default" type="button" onclick="return optSingle('#copy_opt_');"><s:message code="copy"/></button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="core:sentiment:edit">
                        <button class="btn btn-default" type="button" onclick="return optSingle('#edit_opt_');"><s:message code="edit"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sentiment:delete">
                        <button class="btn btn-default" type="button" onclick="return optDelete(this.form);"><s:message code="delete"/></button>
                        </shiro:hasPermission>
                    </div>
                </div>
                <table id="pagedTable" class="table table-condensed table-bordered table-hover ls-tb">
                  <thead id="sortHead" pagesort="<c:out value='${page_sort[0]}' />" pagedir="${page_sort_dir[0]}" pageurl="list.do?page_sort={0}&page_sort_dir={1}&${searchstringnosort}">
                  <tr class="ls_table_th">
                    <th width="25"><input type="checkbox" onclick="Cms.check('ids',this.checked);"/></th>
                    <th width="160"><s:message code="operate"/></th>
                    <th width="30" class="ls-th-sort"><span class="ls-sort" pagesort="id">ID</span></th>
                    <th class="ls-th-sort"><span class="ls-sort" pagesort="sentimentTitle">舆情标题</span></th>
                    <th class="ls-th-sort"><span class="ls-sort" pagesort="user.realName">采集人</span></th>
                    <th class="ls-th-sort"><span class="ls-sort" pagesort="infoLevel">舆情等级</span></th>
                    <th class="ls-th-sort"><span class="ls-sort" pagesort="infoType">舆情分类</span></th>
                    <th class="ls-th-sort"><span class="ls-sort" pagesort="createDatetime">采集日期</span></th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="bean" varStatus="status" items="${pagedList.content}">
                  <tr<shiro:hasPermission name="core:sentiment:edit"> ondblclick="location.href=$('#edit_opt_${bean.id}').attr('href');"</shiro:hasPermission>>
                    <td><c:if test="${bean.id!=0}"><input type="checkbox" name="ids" value="${bean.id}"/></c:if></td>
                    <td align="center">
                            <shiro:hasPermission name="core:sentiment:copy">
                      <c:choose>
                        <c:when test="${bean.id < 1}">
                          <span class="disabled"><s:message code="copy"/></span>
                        </c:when>
                        <c:otherwise>
                              <a id="copy_opt_${bean.id}" href="create.do?id=${bean.id}&favoriteId=${bean.favoriteId}&${searchstring}" class="ls-opt"><s:message code="copy"/></a>
                        </c:otherwise>
                      </c:choose>
                      </shiro:hasPermission>
                      <shiro:hasPermission name="core:sentiment:edit">
                      <a id="edit_opt_${bean.id}" href="edit.do?id=${bean.id}&favoriteId=${bean.favoriteId}&${searchstring}" class="ls-opt"><s:message code="edit"/></a>
                      </shiro:hasPermission>
                     </td>
                    <td><c:out value="${bean.id}"/></td>
                    <td><c:out value="${bean.sentimentTitle}"/></td>
                    <td><c:out value="${bean.user.realName}"/></td>
                    <td><c:out value="${bean.infoLevelShow}"/></td>
                    <td><c:out value="${bean.infoTypeShow}"/></td>
                    <td><fmt:formatDate value="${bean.createDatetime}" pattern="yyyy-MM-dd"/></td>
                  </tr>
                  </c:forEach>
                  </tbody>
                </table>
                <c:if test="${fn:length(pagedList.content) le 0}"> 
                <div class="ls-norecord"><s:message code="recordNotFound"/></div>
                </c:if>
            </form>
            <form action="list.do" method="get" class="ls-page">
                <tags:search_params excludePage="true"/>
              <tags:pagination pagedList="${pagedList}"/>
            </form>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
/* var zNodes = [
<c:forEach var="attr" items="${areaList}">{id:${attr.id}, pId: ${attr.parentId}, name:"${attr.label}"<c:if test="${attr.id == 8 || attr.id == 9}">, open:true</c:if>},</c:forEach>
]; */
function showSchool() {
    $.getJSON("../customer/customerList.do", { areaid: $("#search_EQ_areaId_Integer").val()}, function(json){
         if(json && json.length > 0){
             var htmlString = "<option value=''>选择学校</option>";
                $.each(json, function(index, domEle) {
                htmlString += "<option value='"+domEle.id+"'>"+domEle.schoolName+"</option>";
            });
          $("#search_EQ_customer").html(htmlString);
         }else{
            $("#search_EQ_customer").html("");
         }
    });
}
$(document).ready(function() {
    $("#search_EQ_areaId_Integer").myselect(showSchool);
});
</script>
</html>
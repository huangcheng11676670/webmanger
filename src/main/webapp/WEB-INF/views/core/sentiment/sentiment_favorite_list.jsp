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
</head>
<body class="skin-blue content-body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="content-header">
    <h1><s:message code="sentiment.management"/> - <s:message code="list"/> <small>(<s:message code="totalElements" arguments="${fn:length(list)}"/>)</small></h1>
</div>
<div class="content">
    <div class="box box-primary">
        <div class="box-body table-responsive">
            <form class="form-inline ls-search" action="list.do" method="get">
                <div class="form-group">
                  <label for="search_EQ_areaId_Integer">区域</label>
                <select class="form-control input-sm" id="areaId_select" name="areaId_select" onchange="showSchool();">
                    <c:forEach var="attr" items="${areaList}">
                      <c:set var="idstr">${attr.id}</c:set>
                      <option value="${attr.id}"<c:if test="${idstr eq search_EQ_areaId_Integer[0]}"> selected="selected"</c:if>>
                        <c:choose>
                         <c:when test="${ fn:length(attr.treeNumber) == 14}">&#8711;</c:when>
                         <c:when test="${ fn:length(attr.treeNumber) == 19}">&emsp;&emsp;</c:when>
                       </c:choose>
                      ${attr.label}</option>
                      </c:forEach>
                </select>
                </div>
                <div class="form-group">
                  <label for="search_EQ_areaId_Integer">学校列表</label>
                    <select class="form-control input-sm" style="min-width: 200px;" id="school_select" name="school_select" onchange="showFavorite();">
                    </select>
                </div>
                <button class="btn btn-default btn-sm" type="button" id="add_info_btn"  style="display: none;" onclick="doAddInfo();">采集舆情</button>
            </form>
            <div class="container-fluid">
            <div class="row" id="favorite_list">
            </div>
            </div>
        </div>
    </div>
    <div class="box box-primary">
     <iframe src="" id="iframepage" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"  width="100%"></iframe>  
    </div>
</div>
</body>
<script type="text/javascript">
$(function() {
    $("#sortHead").headSort();
});
function showSchool() {
	$("#search_info_btn").attr("disabled", true);
    $.getJSON("../customer/customerList.do", { areaid: $("#areaId_select").val()}, function(json){
         if(json && json.length > 0){
             var htmlString = "<option value=''>选择学校</option>";
                $.each(json, function(index, domEle) {
                htmlString += "<option value='"+domEle.id+"'>"+domEle.schoolName+"</option>";
            });
          $("#school_select").html(htmlString);
          $("#search_info_btn").attr("disabled", false);
         }else{
            $("#school_select").html("");
         }
    });
}
function showFavorite() {
	$("#search_info_btn").attr("disabled", true);
    $.getJSON("../sysfavorite/faviruteList.do", { schoolid: $("#school_select").val()}, function(json){
         if(json && json.length > 0){
             var htmlString = "";
                $.each(json, function(index, domEle) {
                htmlString += "<a class='btn btn-primary btn-lg' href='#' role='button'>"+domEle.name+"</a><button style='margin:10px;' type='button' class='btn btn-primary btn-lg' onclick='goPage("+domEle.id+")'>"+domEle.name+"</button>";
            });
                htmlString += "";
          $("#favorite_list").html(htmlString);
          $("#search_info_btn").attr("disabled", false);
         }else{
            $("#favorite_list").html("");
         }
    });
}
var favoriteId;
function doAddInfo(){
	 window.location.href="create.do?favoriteId="+favoriteId;
}
function goPage(id){
    $("#add_info_btn").show();
    favoriteId = id;
    $("#iframepage").attr("src", "create.do?favoriteId="+id)
    // window.location.href="create.do?favoriteId="+id;
}
</script>
</html>
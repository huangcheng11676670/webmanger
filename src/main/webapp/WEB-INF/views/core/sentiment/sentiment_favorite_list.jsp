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
    <h1><s:message code="sentiment.management"/> - <s:message code="list"/></h1>
</div>
<div class="content">
    <div class="box box-primary" style="height:100%;">
        <div class="box-body table-responsive">
            <form class="form-inline ls-search" action="list.do" method="get">
                <div class="form-group">
                  <label for="search_EQ_areaId_Integer">区域</label>
                  <input type="text" id="areaId_select" name="areaId_select" class="myselectstyle">
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
            <div style="position: absolute; width: 5px; height: 600px; left: 200px; background-color: #f5e6e6; opacity: 0.1;"></div>
            <div style="position: absolute; width: 5px; height: 600px; left: 300px; background-color: #f5e6e6; opacity: 0.1;"></div>
            <div style="position: absolute; width: 5px; height: 600px; left: 500px; background-color: #f5e6e6; opacity: 0.1;"></div>
            <iframe src="" id="iframepage" frameborder="0" scrolling="yes" marginheight="0" marginwidth="0"  width="100%" height="600"></iframe>
            <!-- <div id="iframepage"></div> -->  
        </div>
        </div>
</div>
</body>
<script src="${ctx}/static/vendor/ifvisible.min.js"></script>
<script type="text/javascript">
$(function() {
    $("#sortHead").headSort();
    $("#areaId_select").myselect(showSchool);
});
function showSchool() {
    $("#add_info_btn").hide();
    $("#favorite_list").html("");
    $.getJSON("../customer/customerList.do", { areaid: $("#areaId_select").val()}, function(json){
         if(json && json.length > 0){
             var htmlString = "<option value=''>选择学校</option>";
                $.each(json, function(index, domEle) {
                htmlString += "<option value='"+domEle.id+"'>"+domEle.schoolName+"</option>";
            });
          $("#school_select").html(htmlString);
         }else{
            $("#school_select").html("");
         }
    });
}
function showFavorite() {
    if($("#school_select").val() == ""){
        return false;
    }
    $.getJSON("../sysfavorite/faviruteList.do", { schoolid: $("#school_select").val()}, function(json){
         if(json && json.length > 0){
             var htmlString = "";
                $.each(json, function(index, domEle) {
                htmlString += "<button style='margin:10px;' type='button' class='btn btn-primary btn-lg' onclick='goPage("+domEle.id+",\""+domEle.name+"\",\""+domEle.customerUrl+"\")'>"+domEle.name+"</button>";
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
function goPage(id, name, url){
    $("#add_info_btn").show();
    if(favoriteId){
        if(view_time_num > 1){
            //ajax记录停留时间
            $.post("/cmscp/core/viewtime/save.do", {favoriteId: favoriteId, favoriteName: name, minuteNum: view_time_num}, function(data){
                   if(data.status){
                         console.log(data.msg);
                   }
             });
       }
    }
    favoriteId = id;
    /* $("#iframepage").load(url, {},function(){
    }); */
    $("#iframepage").attr("src", url);
    isRecordTime = true;
    view_time_num = 0;
}
</script>
</html>
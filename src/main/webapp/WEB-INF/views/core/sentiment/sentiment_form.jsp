<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fnx" uri="http://java.sun.com/jsp/jstl/functionsx"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/head.jsp"/>
<style type="text/css">
.progress-bar.animate {
   width: 100%;
}
</style>
</head>
<body class="skin-blue content-body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="content-header">
    <h1><s:message code="sentiment.management"/> - <s:message code="${oprt=='edit' ? 'edit' : 'create'}"/></h1>
</div>
<div class="content">
    <div class="box box-primary">
        <form class="form-horizontal" id="validForm" action="${oprt=='edit' ? 'update' : 'save'}.do" method="post">
            <tags:search_params/>
            <f:hidden name="oid" value="${bean.id}" />
            <f:hidden name="position" value="${position}" />
            <input type="hidden" id="redirect" name="redirect" value="edit"/>
            <div class="box-header with-border">
                <div class="btn-toolbar">
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sentiment:create">
                        <button class="btn btn-default" type="button" onclick="location.href='create.do?favoriteId=${bean.favoriteId}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>><s:message code="create"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sentiment:delete">
                        <button class="btn btn-default" type="button" onclick="if(confirmDelete()){location.href='delete.do?ids=${bean.id}&queryParentId=${queryParentId}&${searchstring}';}"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>><s:message code="delete"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <button class="btn btn-default" type="button" onclick="location.href='list.do?showDescendants=${showDescendants}&${searchstring}';"><s:message code="return"/></button>
                    </div>
                </div>
            </div>
            <div class="box-body">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">所属收藏夹</label>
                        <div class="col-sm-8">
                            <f:hidden name="favoriteId" value="${bean.favoriteId}" />
                            <div style="padding:5px;"><a href="${favorite.customerUrl}" target="_blank">${favorite.favoriteName}</a></div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">所属客户</label>
                        <div class="col-sm-8">
                            <input type="hidden" value="${bean.areaId}" name="areaId">
                            <input type="hidden" value="${bean.customer.id}" name="customer.id">
                            <div style="padding:5px;">${bean.customer.name}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><em class="required">*</em>舆情网址</label>
                        <div class="col-sm-8">
                            <f:text name="sentimentUrl" id="sentimentUrl" value="${oprt=='edit' || oprt=='create' ? bean.sentimentUrl : ''}" class="form-control required" maxlength="1024" />
                        </div>
                        <div class="col-sm-2">
                        <button class="btn btn-primary" type="button" onclick="autogetinfo(${bean.id});">自动扫描</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>舆情标题</label>
                        <div class="col-sm-8">
                            <f:text name="sentimentTitle" id="sentimentTitle" value="${oprt=='edit' || oprt=='create' ? bean.sentimentTitle : ''}" class="form-control required" maxlength="255" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>发帖时间</label>
                        <div class="col-sm-8">
                            <f:text name="contentCreateTime" id="contentCreateTime" value="${oprt=='edit' || oprt=='create' ? bean.contentCreateTime : ''}" class="form-control " maxlength="20"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">转发数量</label>
                        <div class="col-sm-8">
                            <f:text name="relayNum" id="relayNum" value="${oprt=='edit' || oprt=='create' ? bean.relayNum : ''}" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>评论数量</label>
                        <div class="col-sm-8">
                            <f:text name="commentNum" id="commentNum" value="${oprt=='edit' || oprt=='create' ? bean.commentNum : ''}" class="form-control"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>舆情等级</label>
                        <div class="col-sm-8">
                            <select class="form-control" name="infoLevel">
                                <c:forEach var="attr" items="${infoLevelList}">
                                  <c:set var="idstr">${attr.id}</c:set>
                                  <option value="${attr.id}"<c:if test="${idstr eq bean.infoLevel}"> selected="selected"</c:if>>${attr.label}</option>
                                  </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>舆情分类</label>
                        <div class="col-sm-8">
                            <select class="form-control" name="infoType">
                                <c:forEach var="attr" items="${infoTypelList}">
                                  <c:set var="idstr">${attr.id}</c:set>
                                  <option value="${attr.id}"<c:if test="${idstr eq bean.infoType}"> selected="selected"</c:if>>${attr.label}</option>
                                  </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><em class="required">*</em>学段分类</label>
                        <div class="col-sm-4">
                        <select class="form-control" name="schoolLevel">
                                <c:forEach var="attr" items="${schoolLevelList}">
                                  <c:set var="idstr">${attr.id}</c:set>
                                  <option value="${attr.id}"<c:if test="${idstr eq bean.schoolLevel}"> selected="selected"</c:if>>${attr.label}</option>
                                  </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">舆情摘要</label>
                        <div class="col-sm-10">
                            <f:textarea class="form-control" name="summary" id="summary" value="${oprt=='edit' || oprt=='create' ? bean.summary : ''}" maxlength="2000" rows="3" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">短信内容</label>
                        <div class="col-sm-10">
                            <f:textarea class="form-control" name="smsContent" value="${oprt=='edit' || oprt=='create' ? bean.smsContent : ''}" maxlength="255" rows="3" />
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <div class="box-footer">
          <button class="btn btn-primary" type="submit"><s:message code="save"/></button>
          <button class="btn btn-default" type="submit" onclick="$('#redirect').val('list');"><s:message code="saveAndReturn"/></button>
          <c:if test="${oprt=='create'}">
          <button class="btn btn-default" type="submit" onclick="$('#redirect').val('create');"><s:message code="saveAndCreate"/></button>
             </c:if>
            </div>
        </form>
    </div>
</div>

<div class="modal js-loading-bar">
 <div class="modal-dialog">
   <div class="modal-content">
     <div class="modal-body">
       <div class="progress progress-popup">
        <div class="progress-bar"></div>
       </div>
     </div>
   </div>
 </div>
</div>
</body>
<script type="text/javascript">
$(function() {
    $("#validForm").validate({
        rules: {
               commentNum: {
                required: true,
                number:true
               }
        },
        messages: {
            commentNum:{
                required: "转发数量必填",
            }
        }
    });
    $("input[name='name']").focus();
});
function confirmDelete() {
    return confirm("<s:message code='confirmDelete'/>");
}
function autogetinfo(){
   var $modal = $('.js-loading-bar'),
   $bar = $modal.find('.progress-bar');
   $modal.modal('show');
    $bar.addClass('animate');
    
    $.getJSON("autogetinfo.do", { favoriteId: ${favorite.id}, url: $("#sentimentUrl").val() },function(json){
        if(json.status){
           $("#sentimentTitle").val(json.result.sentimentTitle);
           $("#contentCreateTime").val(json.result.contentCreateTime);
           $("#commentNum").val(json.result.commentNum);
           $("#summary").val(json.result.summary);
        }else{
            alert(json.msg);
        }
        $bar.removeClass('animate');
        $modal.modal('hide');
    });
}
this.$('.js-loading-bar').modal({
      backdrop: 'static',
      show: false
});

$('#load').click(function() {

   setTimeout(function() {
        $bar.removeClass('animate');
        $modal.modal('hide');
      }, 1500);
});
</script>
</html>
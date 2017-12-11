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
<script type="text/javascript">
$(function() {
    $("#validForm").validate();
    $("input[name='name']").focus();
});
function confirmDelete() {
    return confirm("<s:message code='confirmDelete'/>");
}
</script>
</head>
<body class="skin-blue content-body">
<jsp:include page="/WEB-INF/views/commons/show_message.jsp"/>
<div class="content-header">
    <h1><s:message code="customer.management"/> - <s:message code="${oprt=='edit' ? 'edit' : 'create'}"/></h1>
</div>
<div class="content">
    <div class="box box-primary">
        <form class="form-horizontal" id="validForm" action="${oprt=='edit' ? 'update' : 'save'}.do" method="post">
            <tags:search_params/>
            <f:hidden name="oid" value="${bean.id}" />
            <f:hidden name="position" value="${position}" />
            <f:hidden name="status" value="${bean.status}" />
            <input type="hidden" id="redirect" name="redirect" value="edit"/>
            <div class="box-header with-border">
                <div class="btn-toolbar">
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sysdict:create">
                        <button class="btn btn-default" type="button" onclick="location.href='create.do?${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>><s:message code="create"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sysdict:delete">
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
                        <label class="col-sm-4 control-label"><em class="required">*</em>名称</label>
                        <div class="col-sm-8">
                            <f:text name="name" value="${oprt=='edit' || oprt=='create' ? bean.name : ''}" class="form-control required" maxlength="150" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>网站链接</label>
                        <div class="col-sm-8">
                            <f:text name="webUrl" value="${oprt=='edit' || oprt=='create' ? bean.webUrl : ''}" class="form-control required" maxlength="1000" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>微信名称</label>
                        <div class="col-sm-8">
                            <f:text name="weixinName" value="${oprt=='edit' || oprt=='create' ? bean.weixinName : ''}" class="form-control required" maxlength="150" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>地区id</label>
                        <div class="col-sm-8">
                                <c:set var="areaName"><c:choose><c:when test="${empty area}">中国</c:when><c:otherwise><c:out value="${area.label}"/></c:otherwise></c:choose></c:set>
                                <f:hidden id="areaId" name="areaId" value="${bean.areaId}"/>
                                <div class="input-group">
                                    <f:text class="form-control" id="areaIdName" value="${areaName}" readonly="readonly"/>
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" id="areaIdButton" type="button"><s:message code='choose'/></button>
                                    </span>
                                </div>
                                <script type="text/javascript">
                                $(function(){
                                    Cms.f7.area("areaId","areaName",{
                                        settings: {"title": "选择地区"},
                                        params: {
                                            "treeNumber": "0000"
                                        }
                                    });
                                });
                                </script>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>信用统一代码</label>
                        <div class="col-sm-8">
                            <f:text name="code" value="${oprt=='edit' || oprt=='create' ? bean.code : ''}" class="form-control required" maxlength="150" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">备注</label>
                        <div class="col-sm-8">
                            <f:text name="remarks" value="${oprt=='edit' || oprt=='create' ? bean.remarks : ''}" class="form-control" maxlength="200" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                             <label class="radio-inline"><f:checkbox name="clearance" value="${oprt=='edit' || oprt=='create' ? bean.clearance : ''}" default="false" />是否回款</label>
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
</body>
</html>
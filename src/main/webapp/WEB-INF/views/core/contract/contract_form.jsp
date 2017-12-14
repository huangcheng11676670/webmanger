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
    $("#validForm").validate({
        rules: {
            contractMoney: {
                required: true,
                number:true
               }
        },
        messages: {
        	contractMoney: "合同金额必须为数字"
        }
    });
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
    <h1><s:message code="contract.management"/> - <s:message code="${oprt=='edit' ? 'edit' : 'create'}"/></h1>
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
                        <shiro:hasPermission name="core:contract:create">
                        <button class="btn btn-default" type="button" onclick="location.href='create.do?${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>><s:message code="create"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <shiro:hasPermission name="core:contract:delete">
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
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><em class="required">*</em>发票号</label>
                        <div class="col-sm-10">
                            <f:text name="contractCode" value="${oprt=='edit' || oprt=='create' ? bean.contractCode : ''}" class="form-control required" maxlength="255" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><em class="required">*</em>客户名称</label>
                        <div class="col-sm-5">
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
                        <div class="col-sm-5">
                        <select class="form-control" name="customer.id" >
                              <f:options items="${customerList}" itemLabel="name" itemValue="id" selected="${bean.customer.id}" />
                        </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>经办人</label>
                        <div class="col-sm-8">
                            <f:text name="operator" value="${oprt=='edit' || oprt=='create' ? bean.operator : ''}" class="form-control required" maxlength="50" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>合同金额</label>
                        <div class="col-sm-8">
                            <f:text name="contractMoney" value="${oprt=='edit' || oprt=='create' ? bean.contractMoney : ''}" class="form-control required"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>合同时间</label>
                        <div class="col-sm-8">
                            <input type="text" name="contractCreateTime" id="contractCreateTime" value="<c:if test="${oprt=='edit' || oprt=='create'}"><fmt:formatDate value="${bean.contractCreateTime}" pattern="yyyy-MM-dd"/></c:if>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', maxDate:'#F{$dp.$D(\'contractEndTime\')}'});" class="form-control ${oprt=='edit' || oprt=='create' ? 'required' : ''}" style="padding-left:3px;padding-right:3px;"/>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>合同终止时间</label>
                        <div class="col-sm-8">
                            <input type="text" name=contractEndTime id="contractEndTime" value="<c:if test="${oprt=='edit' || oprt=='create'}"><fmt:formatDate value="${bean.contractEndTime}" pattern="yyyy-MM-dd"/></c:if>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', minDate:'#F{$dp.$D(\'contractCreateTime\')}'});" class="form-control ${oprt=='edit' || oprt=='create' ? 'required' : ''}" style="padding-left:3px;padding-right:3px;"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">备注信息</label>
                        <div class="col-sm-10">
                            <f:textarea class="form-control" name="remark" value="${oprt=='edit' || oprt=='create' ? bean.remark : ''}" maxlength="500" rows="3" />
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
</body>
</html>
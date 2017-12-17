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
    <h1><s:message code="sysfavorite.management"/> - <s:message code="${oprt=='edit' ? 'edit' : 'create'}"/></h1>
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
                        <label class="col-sm-4 control-label"><em class="required">*</em>类型名</label>
                        <div class="col-sm-8">
                        <select class="form-control" name="sysDictType.id" >
                              <f:options items="${favoriteTypeList}" itemLabel="label" itemValue="id" selected="${bean.sysDictType.id}" />
                        </select>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>收藏夹名称</label>
                        <div class="col-sm-8">
                            <f:text name="favoriteName" value="${oprt=='edit' || oprt=='create' ? bean.favoriteName : ''}" class="form-control required" maxlength="255" />
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>所属客户</label>
                        <div class="col-sm-8">
                            <select class="form-control" name="customer.id" >
                                  <f:options items="${customerList}" itemLabel="name" itemValue="id" selected="${bean.customer.id}" />
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>收藏夹地址</label>
                        <div class="col-sm-8">
                            <f:text name="customerUrl" value="${oprt=='edit' || oprt=='create' ? bean.customerUrl : ''}" class="form-control required" maxlength="150" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">标题表达式</label>
                        <div class="col-sm-8">
                            <f:text name="titlePattern" value="${oprt=='edit' || oprt=='create' ? bean.titlePattern : ''}" class="form-control" maxlength="300" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">列表表达式</label>
                        <div class="col-sm-8">
                            <f:text name="itemsPattern" value="${oprt=='edit' || oprt=='create' ? bean.itemsPattern : ''}" class="form-control" maxlength="300" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
               <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">概要表达式</label>
                        <div class="col-sm-8">
                            <f:text name="summaryPattern" value="${oprt=='edit' || oprt=='create' ? bean.summaryPattern : ''}" class="form-control" maxlength="300" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">评论数量表达式</label>
                        <div class="col-sm-8">
                            <f:text name="commentNumPattern" value="${oprt=='edit' || oprt=='create' ? bean.commentNumPattern : ''}" class="form-control" maxlength="300" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">创建时间表达式</label>
                        <div class="col-sm-8">
                            <f:text name="contentCreateTimePattern" value="${oprt=='edit' || oprt=='create' ? bean.contentCreateTimePattern : ''}" class="form-control" maxlength="300" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">代理</label>
                        <div class="col-sm-8">
                            <f:text name="agent" value="${oprt=='edit' ? bean.agent : 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1'}" class="form-control" maxlength="200" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">编码</label>
                        <div class="col-sm-8">
                            <f:text name="charset" value="${oprt=='edit' || oprt=='create' ? bean.charset : ''}" class="form-control" maxlength="200" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">真实域名</label>
                        <div class="col-sm-8">
                            <f:text name="realUrl" value="${oprt=='edit' || oprt=='create' ? bean.realUrl : ''}" class="form-control" maxlength="500" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">被替换的域名</label>
                        <div class="col-sm-8">
                            <f:text name="originalUrl" value="${oprt=='edit' || oprt=='create' ? bean.originalUrl : ''}" class="form-control" maxlength="500" />
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
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
                                <input type="text" id="areaId" value="${bean.area.id}" name="areaId" class="myselectstyle required">
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
            <ul class="list-group">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人1</label>
                        <div class="col-sm-8">
                            <f:text name="contact1" value="${oprt=='edit' || oprt=='create' ? bean.contact1 : ''}" class="form-control" maxlength="30" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人1电话</label>
                        <div class="col-sm-8">
                            <f:text name="contact1Phone" value="${oprt=='edit' || oprt=='create' ? bean.contact1Phone : ''}" class="form-control" maxlength="20" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人1QQ</label>
                        <div class="col-sm-8">
                            <f:text name="contact1QQ" value="${oprt=='edit' || oprt=='create' ? bean.contact1QQ : ''}" class="form-control" maxlength="30" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人1微信</label>
                        <div class="col-sm-8">
                            <f:text name="contact1Weixin" value="${oprt=='edit' || oprt=='create' ? bean.contact1Weixin : ''}" class="form-control" maxlength="20" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人2</label>
                        <div class="col-sm-8">
                            <f:text name="contact2" value="${oprt=='edit' || oprt=='create' ? bean.contact2 : ''}" class="form-control" maxlength="30" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人2电话</label>
                        <div class="col-sm-8">
                            <f:text name="contact2Phone" value="${oprt=='edit' || oprt=='create' ? bean.contact2Phone : ''}" class="form-control" maxlength="20" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人2QQ</label>
                        <div class="col-sm-8">
                            <f:text name="contact2QQ" value="${oprt=='edit' || oprt=='create' ? bean.contact2QQ : ''}" class="form-control" maxlength="30" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人2微信</label>
                        <div class="col-sm-8">
                            <f:text name="contact2Weixin" value="${oprt=='edit' || oprt=='create' ? bean.contact2Weixin : ''}" class="form-control" maxlength="20" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人3</label>
                        <div class="col-sm-8">
                            <f:text name="contact3" value="${oprt=='edit' || oprt=='create' ? bean.contact3 : ''}" class="form-control" maxlength="30" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人3电话</label>
                        <div class="col-sm-8">
                            <f:text name="contact3Phone" value="${oprt=='edit' || oprt=='create' ? bean.contact3Phone : ''}" class="form-control" maxlength="20" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人3QQ</label>
                        <div class="col-sm-8">
                            <f:text name="contact3QQ" value="${oprt=='edit' || oprt=='create' ? bean.contact3QQ : ''}" class="form-control" maxlength="30" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人3微信</label>
                        <div class="col-sm-8">
                            <f:text name="contact3Weixin" value="${oprt=='edit' || oprt=='create' ? bean.contact3Weixin : ''}" class="form-control" maxlength="20" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人4</label>
                        <div class="col-sm-8">
                            <f:text name="contact4" value="${oprt=='edit' || oprt=='create' ? bean.contact4 : ''}" class="form-control" maxlength="30" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人4电话</label>
                        <div class="col-sm-8">
                            <f:text name="contact4Phone" value="${oprt=='edit' || oprt=='create' ? bean.contact4Phone : ''}" class="form-control" maxlength="20" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人4QQ</label>
                        <div class="col-sm-8">
                            <f:text name="contact4QQ" value="${oprt=='edit' || oprt=='create' ? bean.contact4QQ : ''}" class="form-control" maxlength="30" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">联系人4微信</label>
                        <div class="col-sm-8">
                            <f:text name="contact4Weixin" value="${oprt=='edit' || oprt=='create' ? bean.contact4Weixin : ''}" class="form-control" maxlength="20" />
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
<script type="text/javascript">
$(document).ready(function() {
    $("#areaId").myselect();
});
</script>
</body>
</html>
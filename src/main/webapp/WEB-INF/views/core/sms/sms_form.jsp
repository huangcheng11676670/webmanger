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
         smsContent: {
                required: true,
                rangelength:[5,30]
               }
        },
        messages: {
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
    <h1><s:message code="sms.management"/> - <s:message code="${oprt=='edit' ? 'edit' : 'create'}"/></h1>
</div>
<div class="content">
    <div class="box box-primary">
        <form class="form-horizontal" id="validForm" action="${oprt=='edit' ? 'update' : 'save'}.do" method="post">
            <tags:search_params/>
            <f:hidden name="oid" value="${bean.id}" />
            <input type="hidden" id="redirect" name="redirect" value="edit"/>
            <div class="box-header with-border">
                <div class="btn-toolbar">
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sms:create">
                        <button class="btn btn-default" type="button" onclick="location.href='create.do?${searchstring}';"<c:if test="${oprt=='create'}"> disabled="disabled"</c:if>><s:message code="create"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sms:delete">
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
                        <label class="col-sm-2 control-label"><em class="required">*</em>区域</label>
                        <div class="col-sm-5">
                            <input type="hidden" id="areaName" name="areaName" value="${bean.areaName}"/>
                            <select class="form-control input-sm" id="areaId" name="areaId" onchange="showSchool();">
                                <c:forEach var="attr" items="${areaList}">
                                  <c:set var="idstr">${attr.id}</c:set>
                                  <option value="${attr.id}"  <c:if test="${attr.id == bean.areaId}">selected="selected" </c:if>>
                                 <c:choose>
                                     <c:when test="${ fn:length(attr.treeNumber) == 14}">&#8711;</c:when>
                                     <c:when test="${ fn:length(attr.treeNumber) == 19}">&emsp;&emsp;</c:when>
                                   </c:choose>
                                  ${attr.label}</option>
                                  </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-5">
                        <input type="hidden" id="customerName" name="customerName" value="${bean.customerName}"/>
                        <select class="form-control" name="customerId" id="customerId" onchange="showContact();">
                            <option value="${bean.customerId}" selected="selected">${bean.customerName}</option>
                        </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><em class="required">*</em>联系人</label>
                        <div class="col-sm-8">
                            <input type="hidden" id="contact1Phone" name="contact1Phone" value="${bean.contact1Phone}"/>
                            <input type="hidden" id="contact1Qq" name="contact1Qq" value="${bean.contact1Qq}"/>
                            <select class="form-control" name="contact1" id="contact1" onclick="selectcontract();">
                            <option value="${bean.contact1Phone}" selected="selected">${bean.contact1}</option>
                           </select>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${oprt=='edit'}">
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">返回内容</label>
                        <div class="col-sm-10">
                            <f:textarea class="form-control" name="message" value="${oprt=='edit' || oprt=='create' ? bean.message : ''}" maxlength="50" rows="3" />
                        </div>
                    </div>
                </div>
            </div>
            </c:if>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><em class="required">*</em>发送内容</label>
                        <div class="col-sm-10">
                            <f:textarea class="form-control" name="smsContent" value="${oprt=='edit' || oprt=='create' ? bean.smsContent : ''}" maxlength="50" rows="3" />
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
function showSchool() {
    $.getJSON("../customer/customerAllList.do", { areaid: $("#areaId").val()}, function(json){
         if(json && json.length > 0){
             var htmlString = "<option value=''>选择学校</option>";
                $.each(json, function(index, domEle) {
                htmlString += "<option value='"+domEle.id+"' contactList='"+JSON.stringify(domEle)+"'>"+domEle.schoolName+"</option>";
            });
          $("#customerId").html(htmlString);
         }else{
            $("#customerId").html("");
         }
    });
}
function selectcontract() {
    var contractPhone = $("#contact1").find("option:selected").attr("value");
    $("#contact1Phone").val(contractPhone);
}
function showContact() {
    var contactList = $("#customerId").find("option:selected").attr("contactlist");
    if(contactList){
        contactList = jQuery.parseJSON(contactList);
        var contactString ="<option value=''>选择联系人</option>";;
        if(contactList){
           if(contactList.contact1Phone){
             contactString += "<option value='"+contactList.contact1Phone+"'>"+contactList.contact1+"</option>";
           }
           if(contactList.contact2Phone){
            contactString += "<option value='"+contactList.contact2Phone+"'>"+contactList.contact2+"</option>";
           }
           if(contactList.contact3Phone){
            contactString += "<option value='"+contactList.contact3Phone+"'>"+contactList.contact3+"</option>";
           }
           if(contactList.contact4Phone){
               contactString += "<option value='"+contactList.contact4Phone+"'>"+contactList.contact4+"</option>";
           }
            $("#contact1").html(contactString);
        }else{
           $("#contact1").html("");
        }
    }
}
</script>
</body>
</html>
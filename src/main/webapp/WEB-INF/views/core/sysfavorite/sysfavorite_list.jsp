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
    <h1><s:message code="sysfavorite.management"/> - <s:message code="list"/></h1>
</div>
<div class="content">
    <div class="box box-primary">
        <div class="box-body table-responsive">
            <form class="form-inline ls-search" action="list.do" method="get">
                <div class="form-group">
                  <label>名字</label>
                  <input class="form-control input-sm" type="text" name="search_CONTAIN_favoriteName" value="${search_CONTAIN_favoriteName[0]}"/>
                </div>
                <div class="form-group">
                  <label for="search_EQ_sysDictType.id">收藏夹类型</label>
                <select class="form-control input-sm" id="search_EQ_sysDictType.id_Integer" name="search_EQ_sysDictType.id_Integer">
                    <option value="" ><s:message code="allSelect"/></option>
                    <c:forEach var="attr" items="${favoriteTypeList}">
                      <c:set var="idstr">${attr.id}</c:set>
                      <option value="${attr.id}"<c:if test="${idstr eq requestScope['search_EQ_sysDictType.id_Integer'][0]}"> selected="selected"</c:if>>${attr.label}</option>
                      </c:forEach>
                </select>
                </div>
              <button class="btn btn-default btn-sm" type="submit"><s:message code="search"/></button>
            </form>
            <form method="post">
                <tags:search_params/>
                <div class="btn-toolbar ls-btn-bar">
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sysdict:create">
                        <button class="btn btn-default" type="button" onclick="location.href='create.do?${searchstring}';"><s:message code="create"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sysdict:copy">
                        <button class="btn btn-default" type="button" onclick="return optSingle('#copy_opt_');"><s:message code="copy"/></button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="core:sysdict:edit">
                        <button class="btn btn-default" type="button" onclick="return optSingle('#edit_opt_');"><s:message code="edit"/></button>
                        </shiro:hasPermission>
                    </div>
                    <div class="btn-group">
                        <shiro:hasPermission name="core:sysdict:delete">
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
                    <th class="ls-th-sort"><span class="ls-sort" pagesort="name">收藏夹类型</span></th>
                    <th class="ls-th-sort"><span class="ls-sort" pagesort="contact1">收藏夹名称</span></th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="bean" varStatus="status" items="${pagedList.content}">
                  <tr<shiro:hasPermission name="core:sysdict:edit"> ondblclick="location.href=$('#edit_opt_${bean.id}').attr('href');"</shiro:hasPermission>>
                    <td><c:if test="${bean.id!=0}"><input type="checkbox" name="ids" value="${bean.id}"/></c:if></td>
                    <td align="center">
                            <shiro:hasPermission name="core:sysdict:copy">
                      <c:choose>
                        <c:when test="${bean.id < 1}">
                          <span class="disabled"><s:message code="copy"/></span>
                        </c:when>
                        <c:otherwise>
                              <a id="copy_opt_${bean.id}" href="create.do?id=${bean.id}&${searchstring}" class="ls-opt"><s:message code="copy"/></a>
                        </c:otherwise>
                      </c:choose>
                      </shiro:hasPermission>
                      <shiro:hasPermission name="core:sysdict:edit">
                      <a id="edit_opt_${bean.id}" href="edit.do?id=${bean.id}&${searchstring}" class="ls-opt"><s:message code="edit"/></a>
                      </shiro:hasPermission>
                     </td>
                    <td><c:out value="${bean.id}"/></td>
                    <td><c:out value="${bean.sysDictType.label}"/></td>
                    <td><c:out value="${bean.favoriteName}"/></td>
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
</html>
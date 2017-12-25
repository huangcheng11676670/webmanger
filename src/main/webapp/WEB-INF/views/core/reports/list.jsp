<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fnx" uri="http://java.sun.com/jsp/jstl/functionsx"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/head.jsp" />
<script src="${ctx}/static/vendor/echarts/echarts.js"></script>
</head>
<body class="skin-blue content-body">
    <div class="content-header">
        <h1>后台首页</h1>
    </div>
    <div class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header">
                        <div class="col-md-3">
                        <i class="glyphicon glyphicon-stats"></i>
                        <h3 class="box-title">舆情数量统计</h3>
                        </div>
                        <div class="col-md-3">
                        <select class="form-control input-sm" id="areaId_select" name="areaId_select" onchange="showSchool();">
                            <c:forEach var="attr" items="${areaList}">
                              <c:set var="idstr">${attr.id}</c:set>
                              <option value="${attr.id}">${attr.label}</option>
                              </c:forEach>
                        </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm" style="min-width: 200px;" id="school_select" name="school_select" onchange="showFavorite();">
                            </select>
                        </div>
                        <input class="form-control input-sm" type="text" name="search_createTime_Date" id="search_createTime_Date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
                        <input class="form-control input-sm" type="text" name="search_endTime_Date" id="search_endTime_Date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', minDate:'#F{$dp.$D(\'search_createTime_Date\')}'});"/>
                    </div>
                    <div class="box-body">
                         <div id="main" style="width: 600px;height:400px;"></div>
                    </div>
                </div>
            </div>
        </div>
<script type="text/javascript">
// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('main'));

// 指定图表的配置项和数据
var option = {
    title: {
        text: 'ECharts 入门示例'
    },
    tooltip: {},
    legend: {
        data:['销量']
    },
    xAxis: {
        data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
    },
    yAxis: {},
    series: [{
        name: '销量',
        type: 'bar',
        data: [5, 20, 36, 10, 10, 20]
    }]
};

// 使用刚指定的配置项和数据显示图表。
myChart.setOption(option);

function showSchool() {
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
</script>
</div>
</body>
</html>
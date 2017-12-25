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
        <ul class="nav nav-tabs">
          <li role="presentation" class="active"><a href="#">业务数据</a></li>
          <li role="presentation"><a href="#">监测员数据</a></li>
          <li role="presentation"><a href="#">销售业绩</a></li>
        </ul>
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header">
                    <form class="form-inline">
                        <div class="form-group">
                        <i class="glyphicon glyphicon-stats"></i>
                        <h3 class="box-title">舆情数量统计</h3>
                        </div>
                        <div class="form-group">
                        <select class="form-control input-sm" id="areaId_select" name="areaId_select" onchange="showSchool();">
                            <c:forEach var="attr" items="${areaList}">
                              <c:set var="idstr">${attr.id}</c:set>
                              <option value="${attr.id}">${attr.label}</option>
                              </c:forEach>
                        </select>
                        </div>
                        <div class="form-group">
                            <select class="form-control input-sm" style="min-width: 200px;" id="school_select" name="school_select" onchange="showFavorite();">
                            </select>
                        </div>
                        <div class="form-group">
                        <input class="form-control input-sm" type="text" name="search_createTime_Date" id="search_createTime_Date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', maxDate:'#F{$dp.$D(\'search_endTime_Date\')}'});" />
                        至<input class="form-control input-sm" type="text" name="search_endTime_Date" id="search_endTime_Date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', minDate:'#F{$dp.$D(\'search_createTime_Date\')}'});"/>
                        </div>
                         <button type="submit" class="btn btn-primary">查询</button>
                        </form>
                    </div>
                    <div class="box-body">
                         <div id="main" style="width: 600px;height:400px;"></div>
                    </div>
                </div>
            </div>
        </div>
<script type="text/javascript">
option = {
        title: {
            text: '对数轴示例',
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c}'
        },
        legend: {
            left: 'left',
            data: ['3的指数']
        },
        xAxis: {
            type: 'category',
            name: 'x',
            splitLine: {show: false},
            data: ['2017-10-01', '二', '三', '四', '五', '六', '七', '八', '九']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        yAxis: {
            type: 'log',
            name: 'y'
        },
        series: [
            {
                name: '3的指数',
                type: 'line',
                data: [1, 13, 29, 227, 811, 247, 741, 1, 6669]
            }
        ]
    };
var myChart = echarts.init(document.getElementById('main'));
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

$(function() {
    $(".btn").on("click",function(){var b=$(this);b.button("loading..."),setTimeout(function(){b.button("reset")}, 5000)});
});
</script>
</div>
</body>
</html>
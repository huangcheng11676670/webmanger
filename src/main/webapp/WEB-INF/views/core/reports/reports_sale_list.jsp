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
</head>
<body class="skin-blue content-body">
    <div class="content-header">
        <h1>后台首页</h1>
    </div>
    <div class="content">
        <ul class="nav nav-tabs">
          <li role="presentation" ><a href="list.do">业务数据</a></li>
          <li role="presentation"><a href="#">监测员数据</a></li>
          <li role="presentation" class="active"><a href="#">销售业绩</a></li>
        </ul>
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header">
                    <form class="form-inline">
                        <div class="form-group">
                        <i class="glyphicon glyphicon-stats"></i>
                        <h3 class="box-title">销售业绩统计</h3>
                        </div>
                        <div class="form-group">
                        <select class="form-control input-sm" id="areaId_select_bar">
                            <c:forEach var="attr" items="${areaList}">
                              <c:set var="idstr">${attr.id}</c:set>
                              <option value="${attr.id}">${attr.label}</option>
                              </c:forEach>
                        </select>
                        </div>
                        <div class="form-group">
                        <input class="form-control input-sm" type="text"  id="search_createTime_Date_bar" onclick="WdatePicker({dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false, maxDate:'#F{$dp.$D(\'search_endTime_Date_bar\')}'});" />
                        至<input class="form-control input-sm" type="text" id="search_endTime_Date_bar" onclick="WdatePicker({dateFmt:'yyyy-MM', isShowToday: false, isShowClear: false, minDate:'#F{$dp.$D(\'search_createTime_Date_bar\')}'});"/>
                        </div>
                         <button type="button" class="btn btn-primary" onclick="searchReport_bar();">查询</button>
                        </form>
                    </div>
                    <div class="box-body">
                         <div id="report_main_bar" style="width: 600px;height:400px;"></div>
                    </div>
                </div>
            </div>
        </div>
<script type="text/javascript">
//柱状图开始
option_bar = {
    title : {
        text: '销售业绩统计'
    },
    tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:['区域数量']
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    xAxis : [
        {
            type : 'category',
            data : []
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'区域数量',
            type:'bar',
            data:[],
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        }
    ]
};
var myChart_bar = echarts.init(document.getElementById('report_main_bar'));
myChart_bar.setOption(option_bar);
function searchReport_bar() {
    $.getJSON("sentiment_bar_data.do", { startDate: $("#search_createTime_Date_bar").val() ,  endDate : $("#search_endTime_Date_bar").val() }, function(json){
         if(json.status){
            option_bar.xAxis[0].data = [];
            option_bar.series[0].data = [];
             $.each(json.result, function(index, item) {
                 option_bar.xAxis[0].data.push(item.favoriteName);
                 option_bar.series[0].data.push(item.num);
             });
             myChart_bar.setOption(option_bar, true);
          }
         alert(json.msg);
     });
}
//柱状图结束
$(function() {
    $(".btn").on("click",function(){var b=$(this);b.button("loading..."),setTimeout(function(){b.button("reset")}, 5000)});
});
</script>
</div>
</body>
</html>
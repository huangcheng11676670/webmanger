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
                            <select class="form-control input-sm" style="min-width: 200px;" id="school_select" name="school_select">
                            </select>
                        </div>
                        <div class="form-group">
                        <input class="form-control input-sm" type="text" name="search_createTime_Date" id="search_createTime_Date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', maxDate:'#F{$dp.$D(\'search_endTime_Date\')}'});" />
                        至<input class="form-control input-sm" type="text" name="search_endTime_Date" id="search_endTime_Date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', minDate:'#F{$dp.$D(\'search_createTime_Date\')}'});"/>
                        </div>
                         <button type="button" class="btn btn-primary" onclick="searchReport();">查询</button>
                        </form>
                    </div>
                    <div class="box-body">
                         <div id="main" style="width: 600px;height:400px;"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header">
                    <form class="form-inline">
                        <div class="form-group">
                        <i class="glyphicon glyphicon-stats"></i>
                        <h3 class="box-title">舆情分布统计</h3>
                        </div>
                        <div class="form-group">
                        <select class="form-control input-sm" id="areaId_select_pie" onchange="showSchool_pie();">
                            <c:forEach var="attr" items="${areaList}">
                              <c:set var="idstr">${attr.id}</c:set>
                              <option value="${attr.id}">${attr.label}</option>
                              </c:forEach>
                        </select>
                        </div>
                        <div class="form-group">
                            <select class="form-control input-sm" style="min-width: 200px;" id="school_select_pie">
                            </select>
                        </div>
                        <div class="form-group">
                        <input class="form-control input-sm" type="text" name="search_createTime_Date" id="search_createTime_Date_pie" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', maxDate:'#F{$dp.$D(\'search_endTime_Date_pie\')}'});" />
                        至<input class="form-control input-sm" type="text" name="search_endTime_Date" id="search_endTime_Date_pie" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', minDate:'#F{$dp.$D(\'search_createTime_Date_pie\')}'});"/>
                        </div>
                         <button type="button" class="btn btn-primary" onclick="searchReport_pie();">查询</button>
                        </form>
                    </div>
                    <div class="box-body">
                         <div id="report_main_pie" style="width: 600px;height:400px;"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header">
                    <form class="form-inline">
                        <div class="form-group">
                        <i class="glyphicon glyphicon-stats"></i>
                        <h3 class="box-title">综合统计</h3>
                        </div>
                        <div class="form-group">
                        <input class="form-control input-sm" type="text" name="search_createTime_Date" id="search_createTime_Date_bar" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', maxDate:'#F{$dp.$D(\'search_endTime_Date_bar\')}'});" />
                        至<input class="form-control input-sm" type="text" name="search_endTime_Date" id="search_endTime_Date_bar" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', minDate:'#F{$dp.$D(\'search_createTime_Date_bar\')}'});"/>
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
//线型图开始
option = {
        title : {
            text: '舆情数量统计'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['数量条数']
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
                boundaryGap : false,
                data : []
            }
        ],
        yAxis : [
            {
                type : 'value',
                axisLabel : {
                    formatter: '{value} 条'
                }
            }
        ],
        series : [
            {
                name:'数量条数',
                type:'line',
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
function searchReport() {
    $.getJSON("sentiment_data.do", { userid: $("#school_select").val(), startDate: $("#search_createTime_Date").val() ,  endDate : $("#search_endTime_Date").val() }, function(json){
         if(json.status){
             option.xAxis[0].data = [];
             option.series[0].data = [];
             $.each(json.result, function(index, item) {
                 option.xAxis[0].data.push(item.dateString);
                 option.series[0].data.push(item.num);
             });
             refreshData();
          }
         alert(json.msg);
     });
}

function refreshData(){
    myChart.setOption(option);
}
//线型图结束

//饼图开始
option_pie = {
        title : {
            text: '舆情分布统计',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient : 'vertical',
            x : 'left',
            data:[]
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true, 
                    type: ['pie', 'funnel'],
                    option: {
                        funnel: {
                            x: '25%',
                            width: '50%',
                            funnelAlign: 'left',
                            max: 1548
                        }
                    }
                },
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        series : [
            {
                name:'访问来源',
                type:'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[]
            }
        ]
    };
var myChart_pie = echarts.init(document.getElementById('report_main_pie'));
myChart_pie.setOption(option_pie);

function showSchool_pie() {
    $.getJSON("../customer/customerList.do", { areaid: $("#areaId_select_pie").val()}, function(json){
         if(json && json.length > 0){
             var htmlString = "<option value=''>选择学校</option>";
                $.each(json, function(index, domEle) {
                htmlString += "<option value='"+domEle.id+"'>"+domEle.schoolName+"</option>";
            });
          $("#school_select_pie").html(htmlString);
         }else{
            $("#school_select_pie").html("");
         }
    });
}
function searchReport_pie() {
    $.getJSON("sentiment_pie_data.do", { userid: $("#school_select_pie").val(), startDate: $("#search_createTime_Date_pie").val() ,  endDate : $("#search_endTime_Date_pie").val() }, function(json){
         if(json.status){
            option_pie.legend.data = [];
             option_pie.series[0].data = [];
             $.each(json.result, function(index, item) {
                 option_pie.legend.data.push(item.favoriteName);
                 option_pie.series[0].data.push({value: item.num ,name: item.favoriteName});
             });
             myChart_pie.setOption(option_pie, true);
          }
         alert(json.msg);
     });
}
//饼图结束
//柱状图开始
option_bar = {
    title : {
        text: '综合统计'
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
            option_bar.xAxis.data = [];
            option_bar.series[0].data = [];
             $.each(json.result, function(index, item) {
                 option_bar.xAxis.data.push(item.favoriteName);
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
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="statics/css/pintuer.css">
    <link rel="stylesheet" href="statics/css/admin.css">
   	<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
    <script src="statics/js/pintuer.js"></script>
     <script>
    function search(){
		document.getElementById("listform1").submit(); 
    }
	</script>
</head>
<body>
<form method="post" action="searchAppHistoryData.do" id="listform1">
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 应用资源使用查询</strong> <a href="" style="float:right; display:none;">添加字段</a></div>
        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">
                <li> <a class="button border-main icon-plus-square-o"> 开始时间</a> </li>
                <li><input type="text" name="startTime" id="startTime" class="input" style="width:180px; line-height:17px;
                display:inline-block" value="${startTime}" /></li>
                <li> <a class="button border-main icon-plus-square-o"> 结束时间</a> </li>
                <li><input type="text" name="endTime" id="endTime" class="input" style="width:180px; line-height:17px;
                display:inline-block" value="${endTime}"/></li>
                <li><a href="javascript:search();" class="button border-main icon-search"> 查询</a></li>
            </ul>
        </div>
    </div>
</form>
<div>
    <!--图-->
    <div id="chart">
        <div id="websearch1" style="width: 1100px;height: 300px;position: absolute; left:150px;top: 150px;"></div>
        <div id="websearch2" style="width: 1100px;height: 300px;position: absolute; left:150px;top: 500px;"></div>
        <div id="websearch3" style="width: 1100px;height: 300px;position: absolute; left:150px;top: 850px;"></div>
        <div id="websearch4" style="width: 1100px;height: 300px;position: absolute; left:150px;top: 1200px;"></div>
        <div id="websearch5" style="width: 1100px;height: 300px;position: absolute; left:150px;top: 1550px;"></div>
        <div id="websearch6" style="width: 1100px;height: 300px;position: absolute; left:150px;top: 1900px;"></div>
    </div>

</div> 
<script type="text/javascript" src="statics/js/highcharts.js"></script>
<script type="text/javascript" src="statics/js/highcharts-more.js"></script>
<script type="text/javascript" src="statics/js/laydate.js"></script>
<script type="text/javascript">
laydate.render({
    elem: '#startTime'
    ,type: 'datetime' //指定元素
});

laydate.render({
    elem: '#endTime'
    ,type: 'datetime' //指定元素
});

</script>
<script type="text/javascript">
Highcharts.setOptions({ global: { useUTC: false } });
 	var strs= new Array();//定义数组存储绘图数据
 	
    $(document).ready(function() {

    	Highcharts.chart('websearch1', {
            chart: {
                type: 'area',
                zoomType: 'x'
            },
            title: {
                text: '各应用CPU占用情况'
            },
            xAxis: {
                categories: ${appUsageStr6},
                tickmarkPlacement: 'on',
                title: {
                    enabled: false
                }
            },
            yAxis: {
                title: {
                    text: '使用率%'
                },
                min:0,
                max:100

            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            tooltip: {
                split: true,
                valueSuffix: '%'
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                area: {
                    stacking: 'normal',
                    lineColor: '#666666',
                    lineWidth: 1,
                    marker: {
                        lineWidth: 1,
                        lineColor: '#666666'
                    }
                }
            },
            series: [${appUsageStr0}]
        });
        Highcharts.chart('websearch2', {
            chart: {
                type: 'area',
                zoomType: 'x'
            },
            title: {
                text: '各应用内存占用情况'
            },
            xAxis: {
                categories: ${appUsageStr6},
                tickmarkPlacement: 'on',
                title: {
                    enabled: false
                }
            },
            yAxis: {
                title: {
                    text: '使用率%'
                },
                min:0,
                max:100
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            tooltip: {
                split: true,
                valueSuffix: '%'
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                area: {
                    stacking: 'normal',
                    lineColor: '#666666',
                    lineWidth: 1,
                    marker: {
                        lineWidth: 1,
                        lineColor: '#666666'
                    }
                }
            },
            series: [${appUsageStr1}]
        });
        
        Highcharts.chart('websearch3', {
            chart: {
                type: 'area'
            },
            title: {
                text: 'I/O input'
            },
            xAxis: {
                categories: ${appUsageStr6},
                tickmarkPlacement: 'on',
                title: {
                    enabled: false
                }
            },
            yAxis: {
                title: {
                    text: 'MB'
                },
                min:0

            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            tooltip: {
                split: true,
                valueSuffix: ' MB'
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                area: {
                    stacking: 'normal',
                    lineColor: '#666666',
                    lineWidth: 1,
                    marker: {
                        lineWidth: 1,
                        lineColor: '#666666'
                    }
                }
            },
            series: [${appUsageStr2}]
        });
        
        Highcharts.chart('websearch4', {
            chart: {
                type: 'area'
            },
            title: {
                text: 'I/O output'
            },
            xAxis: {
                categories: ${appUsageStr6},
                tickmarkPlacement: 'on',
                title: {
                    enabled: false
                }
            },
            yAxis: {
                title: {
                    text: 'MB'
                },
                min:0

            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            tooltip: {
                split: true,
                valueSuffix: ' MB'
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                area: {
                    stacking: 'normal',
                    lineColor: '#666666',
                    lineWidth: 1,
                    marker: {
                        lineWidth: 1,
                        lineColor: '#666666'
                    }
                }
            },
            series: [${appUsageStr3}]
        });

        Highcharts.chart('websearch5', {
            chart: {
                type: 'area'
            },
            title: {
                text: 'net input'
            },
            xAxis: {
                categories: ${appUsageStr6},
                tickmarkPlacement: 'on',
                title: {
                    enabled: false
                }
            },
            yAxis: {
                title: {
                    text: 'MB'
                },
                min:0

            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            tooltip: {
                split: true,
                valueSuffix: ' MB'
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                area: {
                    stacking: 'normal',
                    lineColor: '#666666',
                    lineWidth: 1,
                    marker: {
                        lineWidth: 1,
                        lineColor: '#666666'
                    }
                }
            },
            series: [${appUsageStr4}]
        });
        
        Highcharts.chart('websearch6', {
            chart: {
                type: 'area'
            },
            title: {
                text: 'net output'
            },
            xAxis: {
                categories: ${appUsageStr6},
                tickmarkPlacement: 'on',
                title: {
                    enabled: false
                }
            },
            yAxis: {
                title: {
                    text: 'MB'
                },
                min:0

            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            tooltip: {
                split: true,
                valueSuffix: ' MB'
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                area: {
                    stacking: 'normal',
                    lineColor: '#666666',
                    lineWidth: 1,
                    marker: {
                        lineWidth: 1,
                        lineColor: '#666666'
                    }
                }
            },
            series: [${appUsageStr5}]
        });


});
</script>

</body>
</html>
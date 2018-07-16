<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<!--测评结果汇总-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="statics/css/pintuer.css">
<link rel="stylesheet" href="statics/css/admin.css">
<script src="statics/js/jquery.js"></script>
<script src="statics/js/pintuer.js"></script>
</head>
<body style="height: 3300px;">
	<div>
		<ul class="nav nav-tabs" style="">
			<c:if test="${webSearch.enable==1}">
				<li class="" style="float: left;"><!-- <a href="getResult.do" -->
				<a href="getWebSearchResult.do?testRecordId=${testRecordId}"
					  id="webSearch">webSearch</a></li>
			</c:if>
			<c:if test="${webServer.enable==1}">
				<li class="" style="float: left;"><a
					href="getWebServerResult.do?testRecordId=${testRecordId}"
					  id="webServer">webServer</a></li>
			</c:if>
			<c:if test="${silo.enable==1}">
				<li class="" style="float: left;"><a
					href="getSiloResult.do?testRecordId=${testRecordId}"
					  id="silo">silo</a></li>
			</c:if>
			<c:if test="${memcached.enable==1}">
				<li class="" style="float: left;"><a
					href="getMemcachedResult.do?testRecordId=${testRecordId}"
					  id="memcached">memcached</a></li>
			</c:if>
			<c:if test="${cassandra.enable==1}">
				<li class="" style="float: left;"><a
					href="getCassandraResult.do?testRecordId=${testRecordId}"
					  id="memcached">cassandra</a></li>
			</c:if>
			<c:if test="${redis.enable==1}">
				<li class="" style="float: left;"><a
					href="getRedisResult.do?testRecordId=${testRecordId}"
					  id="redis">redis</a></li>
			</c:if>
			<c:if test="${xapian.enable==1}">
				<li class="" style="float: left;"><a
					href="getXapianResult.do?testRecordId=${testRecordId}"
					  id="xapian">xapian</a></li>
			</c:if>
		</ul>

		<!--图-->
		<div id="chart">
			<div id="websearch1"
				style="width: 1200px; height: 400px; position: absolute; left: 50px; top: 100px;"></div>
			<div id="websearch2"
				style="width: 1200px; height: 400px; position: absolute; left: 50px; top: 550px;"></div>
			<div id="websearch3"
				style="width: 1200px; height: 400px; position: absolute; left: 50px; top: 1000px;"></div>
			<div id="websearch4"
				style="width: 1200px; height: 400px; position: absolute; left: 50px; top: 1450px;"></div>
			<div id="websearch5"
				style="width: 1235px; height: 400px; position: absolute; left: -15px; top: 1900px;"></div>
			<div id="websearch6"
				style="width: 1235px; height: 400px; position: absolute; left: -15px; top: 2350px;"></div>
			<div id="websearch7"
				style="width: 1235px; height: 400px; position: absolute; left: -15px; top: 2800px;"></div>
			<div id="websearch8"
				style="width: 1235px; height: 400px; position: absolute; left: -15px; top: 3250px;"></div>
			<div id="websearch9"
				style="width: 1235px; height: 400px; position: absolute; left: -15px; top: 3700px;"></div>
			<div id="websearch10"
				style="width: 1235px; height: 400px; position: absolute; left: -15px; top: 4150px;"></div>
		</div>


	</div>
	<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="statics/js/highcharts.js"></script>
	<script type="text/javascript" src="statics/js/highcharts-more.js"></script>
	<script type="text/javascript" src="statics/js/highstock.js"></script>
	<script type="text/javascript" src="statics/js/exporting.js"></script>
	<script type="text/javascript" src="statics/js/highcharts-zh_CN.js"></script>
	<script type="text/javascript">
Highcharts.setOptions({ 
	global: { 
		useUTC: false 
		} 
	});
Highstock.setOptions({ 
	global: { 
		useUTC: false 
		} 
    });
$(document).ready(function() {
    Highstock.stockChart('websearch1', {
    	
    	credits:{ 
    	      enabled:false 
    	},
    	scrollbar : {
            enabled : false
        },
    	rangeSelector: {
    	    buttons: [{
    	        type: 'minute',
    	        count: 1,
    	        text: '1min'
    	    }, {
    	        type: 'minute',
    	        count: 5,
    	        text: '5min'
    	    }, {
    	        type: 'minute',
    	        count: 30,
    	        text: '0.5h'
    	    }, {
    	        type: 'all',
    	        text: '所有'
    	    }]
    	},
        title: {
            text: '物理机CPU使用率 %'
        },
        yAxis: {
            title: {
                text: 'used rate'
            },
       	    min:0,
       	    max:100
        },
        colors: ['#058DC7', '#ff3300'],
        xAxis:{
       	 plotLines:[${appRecordLineStr}]
       },
        series: [${sysUsageStr0},${appRecordStr}]
     });

    Highstock.stockChart('websearch2', {
    	credits:{ 
  	      enabled:false 
  	    },
	  	scrollbar : {
	          enabled : false
	      },
	  	rangeSelector: {
	  	    buttons: [{
	  	        type: 'minute',
	  	        count: 1,
	  	        text: '1min'
	  	    }, {
	  	        type: 'minute',
	  	        count: 5,
	  	        text: '5min'
	  	    }, {
	  	        type: 'minute',
	  	        count: 30,
	  	        text: '0.5h'
	  	    }, {
	  	        type: 'all',
	  	        text: '所有'
	  	    }]
	  	},
         title: {
             text: '物理机memory使用率 %'
         },
         colors: ['#058DC7', '#ff3300'],
         xAxis:{
           	 plotLines:[${appRecordLineStr}]
           },
           yAxis: {
               title: {
                   text: 'Exchange rate'
               },
          	    min:0,
          	    max:100
           },
            series: [${sysUsageStr1},${appRecordStr}]
         });



    Highstock.stockChart('websearch3', {
    	credits:{ 
    	      enabled:false 
    	    },
  	  	scrollbar : {
  	          enabled : false
  	      },
  	  	rangeSelector: {
  	  	    buttons: [{
  	  	        type: 'minute',
  	  	        count: 1,
  	  	        text: '1min'
  	  	    }, {
  	  	        type: 'minute',
  	  	        count: 5,
  	  	        text: '5min'
  	  	    }, {
  	  	        type: 'minute',
  	  	        count: 30,
  	  	        text: '0.5h'
  	  	    }, {
  	  	        type: 'all',
  	  	        text: '所有'
  	  	    }]
  	  	},
         title: {
             text: '物理机磁盘读写速度 KB/s'
         },
         colors: ['#058DC7', '#ff3300'],
         xAxis:{
           	 plotLines:[${appRecordLineStr}]
           },
           yAxis: {
               title: {
                   text: 'speed'
               },
          	    min:0 
           },
            series: [${sysUsageStr2},${appRecordStr}]
         });

    Highstock.stockChart('websearch4', {
    	credits:{ 
    	      enabled:false 
    	    },
  	  	scrollbar : {
  	          enabled : false
  	      },
  	  	rangeSelector: {
  	  	    buttons: [{
  	  	        type: 'minute',
  	  	        count: 1,
  	  	        text: '1min'
  	  	    }, {
  	  	        type: 'minute',
  	  	        count: 5,
  	  	        text: '5min'
  	  	    }, {
  	  	        type: 'minute',
  	  	        count: 30,
  	  	        text: '0.5h'
  	  	    }, {
  	  	        type: 'all',
  	  	        text: '所有'
  	  	    }]
  	  	},
         title: {
             text: '物理机网络读写速度 KB/s'
         },
         colors: ['#058DC7', '#ff3300'],
         xAxis:{
           	 plotLines:[${appRecordLineStr}]
           },
           yAxis: {
               title: {
                   text: 'speed'
               },
          	    min:0 
           },
            series: [${sysUsageStr3},${appRecordStr}]
         });

     Highcharts.chart('websearch5', {
    	 credits:{ 
   	      enabled:false 
   	    },
         chart: {
             type: 'area',
             zoomType: 'x'
         },
         title: {
             text: '各应用CPU使用率 %'
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
             align: 'center', //水平方向位置
             verticalAlign: 'bottom', //垂直方向位置
             x: 0, //距离x轴的距离
             y: 0 //距离Y轴的距离
         },
         tooltip: {
             split: true,
             valueSuffix: '%'
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
     Highcharts.chart('websearch6', {
    	 credits:{ 
   	      enabled:false 
   	    },
         chart: {
             type: 'area',
             zoomType: 'x'
         },
         title: {
             text: '各应用内存使用率 %'
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
             align: 'center', //水平方向位置
             verticalAlign: 'bottom', //垂直方向位置
             x: 0, //距离x轴的距离
             y: 0 //距离Y轴的距离
         },
         tooltip: {
             split: true,
             valueSuffix: '%'
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
     
     Highcharts.chart('websearch7', {
    	 credits:{ 
   	      enabled:false 
   	    },
         chart: {
             type: 'area'
         },
         title: {
             text: 'I/O input /MB'
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
             align: 'center', //水平方向位置
             verticalAlign: 'bottom', //垂直方向位置
             x: 0, //距离x轴的距离
             y: 0 //距离Y轴的距离
         },
         tooltip: {
             split: true,
             valueSuffix: ' MB'
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
     
     Highcharts.chart('websearch8', {
    	 credits:{ 
   	      enabled:false 
   	    },
         chart: {
             type: 'area'
         },
         title: {
             text: 'I/O output /MB'
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
             align: 'center', //水平方向位置
             verticalAlign: 'bottom', //垂直方向位置
             x: 0, //距离x轴的距离
             y: 0 //距离Y轴的距离
         },
         tooltip: {
             split: true,
             valueSuffix: ' MB'
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

     Highcharts.chart('websearch9', {
    	 credits:{ 
   	      enabled:false 
   	    },
         chart: {
             type: 'area'
         },
         title: {
             text: 'net input /MB'
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
             align: 'center', //水平方向位置
             verticalAlign: 'bottom', //垂直方向位置
             x: 0, //距离x轴的距离
             y: 0 //距离Y轴的距离
         },
         tooltip: {
             split: true,
             valueSuffix: ' MB'
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
     
     Highcharts.chart('websearch10', {
    	 credits:{ 
   	      enabled:false 
   	    },
         chart: {
             type: 'area'
         },
         title: {
             text: 'net output /MB'
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
             align: 'center', //水平方向位置
             verticalAlign: 'bottom', //垂直方向位置
             x: 0, //距离x轴的距离
             y: 0 //距离Y轴的距离
         },
         tooltip: {
             split: true,
             valueSuffix: ' MB'
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
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
		<!--图-->
		<div id="chart">
			<div id="websearch" style="width: 1250px; height: 350px; position: absolute; left: 50px; top: 0px;"></div>
			<div id="cpuUsage" style="width: 1220px; height: 350px; position: absolute; left: 110px; top: 380px;"></div>
		</div>
		<div id="AvgDiv" style="width: 50px; height: 50px; position: absolute; left: 1150px; top: 13px;">Avg:<span id="avg"></span>ms</div>
		<div id="QpsDiv" style="width: 50px; height: 50px; position: absolute; left: 1240px; top: 360px;">QPS:<span id="qps"></span></div>
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
    var lastcollecttime=null;
    var elementQps=document.getElementById('qps');
    var elementAvg=document.getElementById('avg');
$(document).ready(function() {
	Highcharts.chart('websearch', {
        chart: {
            type: 'scatter',
            zoomType: 'x',
            events: {
                load: function () { 
                    var series = this.series[0]; 
                    var x,queryTime,qps,avg;
                    setInterval(function (){
                    	$.ajax({
            				async:true,
            				type:"get",
            				url:"getOnlineQueryTime.do",
            				data:{},
        					dataType:"json",
            				success:function(returned){
            					if(returned!=null&&returned!=""){
            						x = returned[0].generateTime;
            						queryTime = returned[0].queryTime;
    							    qps = returned[0].qps;
    							    avg = returned[0].OnlineAvgQueryTime;
            						if(lastcollecttime==null){//如果第一次判断 直接添加点进去
      			            	    	 series.addPoint([x,queryTime], true, true); 
      			            	    	 elementQps.innerHTML=qps;
      			            	    	 elementAvg.innerHTML=avg;
      			            	    	 lastcollecttime = x;
      			            	    }else{ 
      			            	    	if(lastcollecttime<x){//如果不是第一次判断，则只有上次时间小于当前时间时才添加点
      			            	    		series.addPoint([x,queryTime], true, true); 
      			            	    		elementQps.innerHTML=qps;
      			            	    		elementAvg.innerHTML=avg;
      				            	    	lastcollecttime = x;
      			            	    	}
      			            	    } 
            					}
            				}	
            			}); 
                    }, 1000);
                }
            }
        },
        plotOptions: {
            series: {
                marker: {
                    radius: 2
                }
            }
        },
        boost: {
            useGPUTranslations: true
        },
        xAxis: {
            type: 'datetime',
            tickPixelInterval: 150
            
        },
        title: {
            text: '在线访问延迟分布'
        },
        legend: {                                                                    
            enabled: false                                                           
        } ,
        yAxis: {
            title: {
                text: '响应时间/ms'
            },
        },
        tooltip: {
            formatter:function(){
                return'<strong>'+this.series.name+'</strong><br/>'+
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S.%L',this.x)+'<br/>'+'响应时间：'+this.y+' ms';
            },
        },
        series: [${seriesStr}]
    });
	
   /* Highstock.stockChart('cpuUsage', {
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
        	plotLines:[{color:Highcharts.getOptions().colors[0],dashStyle:'longdashdot',value:1527644207050,width:2},{color:Highcharts.getOptions().colors[0],dashStyle:'longdashdot',value:1527644280102,width:2},{color:Highcharts.getOptions().colors[1],dashStyle:'longdashdot',value:1527644220060,width:2},{color:Highcharts.getOptions().colors[1],dashStyle:'longdashdot',value:1527644288108,width:2},{color:Highcharts.getOptions().colors[2],dashStyle:'longdashdot',value:1527644247079,width:2}]
        },
        series: [{name:'node28SDC',lineWidth:1,data:[[1527644200045,0],[1527644201046,0],[1527644202047,0],[1527644203047,1],[1527644204048,2],[1527644205049,0],[1527644206050,0],[1527644207050,1],[1527644208051,13],[1527644209052,17],[1527644210052,16],[1527644211053,13],[1527644212054,14],[1527644213055,16],[1527644214055,13],[1527644215056,15],[1527644216057,13],[1527644217057,17],[1527644218058,15],[1527644219059,13],[1527644220060,17],[1527644221060,56],[1527644222061,52],[1527644223062,55],[1527644224062,93],[1527644225063,94],[1527644226064,93],[1527644227064,99],[1527644228065,95],[1527644229066,92],[1527644230067,94],[1527644231067,92],[1527644232068,91],[1527644233069,93],[1527644234069,92],[1527644235070,93],[1527644236071,97],[1527644237072,95],[1527644238072,94],[1527644239073,94],[1527644240074,95],[1527644241074,96],[1527644242075,99],[1527644243076,98],[1527644244076,91],[1527644245077,96],[1527644246078,97],[1527644247079,95],[1527644248079,99],[1527644249080,97],[1527644250081,91],[1527644251081,92],[1527644252082,98],[1527644253083,97],[1527644254084,99],[1527644255084,90],[1527644256085,90],[1527644257086,95],[1527644258087,98],[1527644259087,92],[1527644260088,96],[1527644261089,94],[1527644262089,96],[1527644263090,96],[1527644264091,93],[1527644265091,90],[1527644266092,96],[1527644267093,99],[1527644268094,90],[1527644269094,96],[1527644270095,94],[1527644271096,97],[1527644272096,93],[1527644273097,94],[1527644274098,93],[1527644275099,90],[1527644276099,91],[1527644277100,97],[1527644278101,95],[1527644279101,91],[1527644280102,92],[1527644281103,96],[1527644282103,93],[1527644283104,97],[1527644284105,96],[1527644285106,95],[1527644286106,89],[1527644287107,92],[1527644288108,93],[1527644289108,49],[1527644290109,43],[1527644291110,47],[1527644292111,2],[1527644293111,0],[1527644294112,1],[1527644295113,1],[1527644296113,0],[1527644297114,2],[1527644298115,2],[1527644299116,2],[1527644300116,0],[1527644301117,0],[1527644302118,1],[1527644303118,1],[1527644304119,2],[1527644305120,1],[1527644306121,0],[1527644307121,2],[1527644308122,2],[1527644309123,2],[1527644310123,1],[1527644311124,0],[1527644312125,2],[1527644313125,0],[1527644314126,2],[1527644315127,0],[1527644316128,2],[1527644317128,0]],marker:{enabled:false}},{type:'flags',style:{color:'white'},data:[{x:1527644207050,title:'0',text:'在线服务访问开始'},{x:1527644280102,title:'0',text:'在线服务访问结束'}],onSeries:'dataseries',shape:'squarepin',width:16,color:Highcharts.getOptions().colors[0],fillColor:Highcharts.getOptions().colors[0]},{type:'flags',style:{color:'white'},data:[{x:1527644220060,title:'1',text:'离线任务开启'},{x:1527644288108,title:'1',text:'离线任务结束'}],onSeries:'dataseries',shape:'squarepin',width:16,color:Highcharts.getOptions().colors[1],fillColor:Highcharts.getOptions().colors[1]},{type:'flags',style:{color:'white'},data:[{x:1527644247079,title:'2',text:'开启区分隔离机制'}],onSeries:'dataseries',shape:'squarepin',width:16,color:Highcharts.getOptions().colors[2],fillColor:Highcharts.getOptions().colors[2]}]
    });*/
});
</script>

</body>
</html>
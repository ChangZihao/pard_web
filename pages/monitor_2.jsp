<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>课题2展示</title>
<link rel="stylesheet" href="statics/css/pintuer.css">
<link rel="stylesheet" href="statics/css/admin.css">
<link rel="stylesheet" href="statics/css/physical.css">
</head>

<body>
	<div id="mainDiv"> 
		<div id="container1" style="width: 1000px; height: 350px; "></div> 
		<div id="container2" style="top:350px; width: 350px; height: 350px; left:-300px"><img src="statics/images/sdc2.jpg " style="width: 500px; height: 500px; "/></div> 
		<div id="containerControl">
			<span style="font-family: 微软雅黑; font-size: 14px;">线程控制:</span> 
			<input type="button" id="startButton" value="继续" onclick="start();" style="cursor: pointer">
		</div>
		<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="statics/js/highcharts.js"></script>
		<script type="text/javascript" src="statics/js/highcharts-more.js"></script>
		<script type="text/javascript">
		var localReturnedData = null;
		var flag=false;//flag为true,开启曲线绘制
		
	  	//定时函数,每隔1000ms执行一次,向后端请求新的数据
		setInterval(function() {
			if(flag==true){
				$.ajax({
					async:true,
					type:"get",
					url:"getMonitor2.do",//发送的get请求
					data:{},
					dataType:"json",
					success:function(returned) {  
						if(returned!=null&&returned!=""&&returned!="null"){
							localReturnedData = returned; //用当前页面的临时变量接受该返回值
						}
					}
				}); 
		   }
	    },1000);
	 
		 $(document).ready(function (){
		    Highcharts.setOptions({
		        global: {
		            useUTC: false
		        }
		 }); 
       
       /**
       * 绘制高优先级cdf的曲线
       * 在container1的div里绘制该图
       */
        Highcharts.chart('container1', {
        	credits:{ 
        	      enabled:false 
        		},
            chart: {
                type: 'line',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
                events: {
                    load: function () {
                        // set up the updating of the chart each min
                        var series0 = this.series[0];
                        var series1 = this.series[1]; 
                        var lastCollectTime=null;
                        var x,y1,y2;
                        setInterval(function (){
                        	if(flag==true){
      			              if(localReturnedData!=null){
      			            	 	y1 = localReturnedData[0].ceph;
      			            		y2 = localReturnedData[0].gecko;
      			            	    x = localReturnedData[0].collectTime;
      			            	   
      			            	    if(lastCollectTime==null){//如果第一次判断 直接添加点进去
      			            	    	 series0.addPoint([x,y1], true, true);
      			            	    	 series1.addPoint([x,y2], true, true);
      			            	    	 lastCollectTime = x;
      			            	    }else{
      			            	    	if(lastCollectTime<x){//如果不是第一次判断，则只有上次时间小于当前时间时才添加点
      			            	    		series0.addPoint([x,y1], true, true);
         			            	    	series1.addPoint([x,y2], true, true);
         			            	    	lastCollectTime = x;
      			            	    	}
      			            	    }
      				               
      			               }    
                          	}
                        }, 1000);
                    }
                }
            },
            title: {
				text: '存储系统尾延迟: Gecko vs. Ceph'
			},
			 xAxis: {
				 title: {
					 text:'时间'
				 },
	          	 type: 'datetime',
	               tickPixelInterval: 150,
	           },
            yAxis: {
				title: {
						text: '99th百分比延迟(ms)'
				}
			},
			legend: {
				layout: 'horizontal',
				align: 'center',
				verticalAlign: 'bottom'
			},
            tooltip: {
                formatter: function () {
                    return '<b>' + this.series.name + '</b><br/>' +
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                        Highcharts.numberFormat(this.y, 2)+'ms';
                }
            },            
            exporting: {
                enabled: false
            },
            series:[${cephGeckoStr}] //接受前端页面传递过来的曲线字符串
        });
       
 });
			
</script>
<script>
function start(){
	if(flag==true){
		 flag=false;
		 document.getElementById('startButton').value="继续";
	}else{
		 flag=true;
		 document.getElementById('startButton').value="暂停";
	}
}
</script>
</div>
</body>
</html>
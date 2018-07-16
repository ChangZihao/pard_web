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
<title>课题3展示</title>
<link rel="stylesheet" href="statics/css/pintuer.css">
<link rel="stylesheet" href="statics/css/admin.css">
<link rel="stylesheet" href="statics/css/physical.css">
</head>

<h1 align="center" style="font-family: 黑体; font-size:60px">标签化网络栈</h1>

<body>
	<div id="mainDiv"> 
		<div id="container1" style="width: 500px; height: 350px; top:50px"></div>
		<div id="container2" style="width: 500px; height: 350px; top:50px"></div>
		<br></br>
		<br></br>
		<div id="high99thDiv"
				style="width: 450px; height: 80px; font-family:黑体; font-size:16px; position: absolute; left: -402px; bottom: 108px;">99分位延迟对比(高优先级)</div>
		<div id="highLinux99thDiv"
       style="width: 450px; height: 80px; font-family:黑体; font-size:16px; color:#438c2a; position: absolute; left: -442px; bottom: 0px;">Linux标准栈:  <div style="position: absolute; right: 180px; bottom: 50px"> <span id="highLinux99th" style="font-size:38px; font-weight:bold">${dataMetric.highLinux99th}</span><span>ms</span></div></div>
		<div id="highLNS99thDiv"
       style="width: 450px; height: 80px; font-family:黑体; font-size:16px; color:#f7a35c; position: absolute; left: -442px; bottom: 40px;">标签化网络栈: <div style="position: absolute; right: 180px;top: -22px"><span id="highLNS99th" style="font-size:38px; font-weight:bold;">${dataMetric.highLNS99th}</span><span>ms</span></div></div>
		<div id="low99thDiv"
				style="width: 450px; height: 80px; font-family:黑体; font-size:16px; position: absolute; left: 252px; bottom: 108px;">99分位延迟对比(低优先级)</div>
		<div id="lowLinux99thDiv"
       style="width: 450px; height: 80px;font-family:黑体; font-size:16px; color:#438c2a; position: absolute; left: 202px; bottom: 28px;">Linux标准栈:  <span id="lowLinux99th" style="font-size:38px; font-weight:bold">${dataMetric.lowLinux99th}</span> <span style="position: absolute; right: 175px; bottom: 38px;">ms</span></div>
		<div id="lowLNS99thDiv"
       style="width: 450px; height: 80px; font-family:黑体; font-size:16px; color:#f7a35c;position: absolute; left: 202px; bottom: 68px;">标签化网络栈: <span id="lowLNS99th" style="font-size:38px; font-weight:bold">${dataMetric.lowLNS99th}</span><span style="position: absolute; right: 175px; bottom: 35px;">ms</span></div>

		<!--	
		<div id="containerControl">
			<span style="font-family: 微软雅黑; font-size: 14px;">自动绘制:</span> 
			<input type="button" id="startButton" value="继续" onclick="start();" style="cursor: pointer">
		</div>
		-->
		<div id="drawControl" style=" position: absolute; width: 100px; left: 548px;top: 8px;height: 20px;">
			<span style="font-family: 微软雅黑; font-size: 14px;">清除:</span> 
			<input type="button" id="viewButton" value="清除" onclick="clearSeries();" style="cursor: pointer">
		</div>
		<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="statics/js/highcharts.js"></script>
		<script type="text/javascript" src="statics/js/highcharts-more.js"></script>
		<script type="text/javascript" src="statics/js/pintuer.js"></script>
		<script type="text/javascript"> 
		var localReturnedData = null;  
		var splitData=null;
	  	var old_splitData=null;
		var flag=false;//flag为true,开启曲线绘
		var chart0=null,chart1=null;
	  	//定时函数,每隔1min执行一次,向后端请求新的数据
		setInterval(function() {
			if(true){ 
				$.ajax({
					async:true,
					type:"get",
					url:"getMonitor3.do",//发送的get请求
					data:{},
					dataType:"json",
					success:function(returned) {   
						if(returned!=null&&returned!=""&&returned!="null"){
							localReturnedData = returned; //用当前页面的临时变量接受该返回值 
							old_splitData = splitData;
	  						//console.log(old_splitData);
	  						splitData=localReturnedData[0].seriesStr.split("#");
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
       chart0=new Highcharts.chart('container1', {
    	   credits:{ 
       	      enabled:false 
       		},
       		//plotOptions: {
       		//	 series: {
                 //	marker: {
                   //  	symbol: 'circle' //曲线点类型："circle", "square", "diamond", "triangle","triangle-down"，默认是"circle"
                // }
            // }
       	//	},
           chart: {
               type: 'line',
               animation: Highcharts.svg, // don't animate in old IE
               marginRight: 10,
               events: {
                   load: function () {
                 	// set up the updating of the chart each min
                       var series = this.series;
                       setInterval(function (){  
                    	   //if(flag==true){
	  		//if((old_splitData == null) || (old_splitData[0] != splitData[0]) || (old_splitData[1] != splitData[1])){
	  		if((old_splitData[0] != splitData[0]) || (old_splitData[1] != splitData[1])){
                    		  while(series.length > 0) {
              	                series[0].remove(false);
              	              }  
                    		 eval("chart0.addSeries("+splitData[0]+", false);");
                    		 eval("chart0.addSeries("+splitData[1]+", false);");
                    		 chart0.redraw();
                    		 document.getElementById('highLinux99th').innerHTML=localReturnedData[0].highLinux99th;
                    		 document.getElementById('highLNS99th').innerHTML=localReturnedData[0].highLNS99th;
                          }
                       }, 1100);
                   }
               }
           },
           title: {
				text: '高优先级部分服务延迟CDF'
			},
           xAxis: {
           	title: {
					text: 'Latency(millisecond)'
				}
           },
           yAxis: {
				title: {
						text: 'CDF'
				},
         	min:0,
         	max:1
			},
			legend: {
				layout: 'horizontal',
				align: 'center',
				verticalAlign: 'bottom',
	                        itemStyle: { "color": "#333333", "cursor": "pointer", "fontSize": "12px", "fontWeight": "normal" }
			},
           tooltip: {
               formatter: function () {
                   return '<b>' + this.series.name + '</b><br/>' +'小于'+
                       Highcharts.numberFormat(this.x,2)+'ms'+'的概率:'+
                       Highcharts.numberFormat(this.y, 2);
               }
           },            
           exporting: {
               enabled: false
           },
           series:[${cdf_high}]  
       });
       
        /**
         * 绘制高优先级cdf的曲线
         * 在container1的div里绘制该图
         */
          chart1=new Highcharts.chart('container2', {
          	credits:{ 
          	      enabled:false 
          		},
          	//	plotOptions: {
          	//		 series: {
                  //  	marker: {
                    //    	symbol: 'circle' //曲线点类型："circle", "square", "diamond", "triangle","triangle-down"，默认是"circle"
                   // }
               // }
          	//	},
              chart: {
                  type: 'line',
                  animation: Highcharts.svg, // don't animate in old IE
                  marginRight: 10,
                  events: {
                      load: function () {
                    	// set up the updating of the chart each min
                          var series = this.series;
                          setInterval(function (){  
                       	//   if(flag==true){
	  		if((old_splitData[2] != splitData[2]) || (old_splitData[3] != splitData[3])){
	  		//if((old_splitData == null) || (old_splitData[2] != splitData[2]) || (old_splitData[3] != splitData[3])){
                       		  while(series.length > 0) {
                 	                series[0].remove(false);
                 	              } 
                       		 eval("chart1.addSeries("+splitData[2]+", false);");
                       		 eval("chart1.addSeries("+splitData[3]+", false);");
                       		 chart1.redraw();
                       		 document.getElementById('lowLinux99th').innerHTML=localReturnedData[0].lowLinux99th;
                   		     document.getElementById('lowLNS99th').innerHTML=localReturnedData[0].lowLNS99th;
                             }
                          }, 1100);
                      }
                  }
              },
              title: {
  				text: '低优先级部分服务延迟CDF'
  			},
              xAxis: {
              	title: {
  					text: 'Latency(millisecond)'
  				}
              },
              yAxis: {
  				title: {
  						text: 'CDF'
  				},
            	min:0,
            	max:1
  			},
  			legend: {
  				layout: 'horizontal',
  				align: 'center',
  				verticalAlign: 'bottom',
	                        itemStyle: { "color": "#333333", "cursor": "pointer", "fontSize": "12px", "fontWeight": "normal" }
  			},
              tooltip: {
                  formatter: function () {
                      return '<b>' + this.series.name + '</b><br/>' +'小于'+
                          Highcharts.numberFormat(this.x,2)+'ms'+'的概率:'+
                          Highcharts.numberFormat(this.y, 2);
                  }
              },            
              exporting: {
                  enabled: false
              },
              series:[${cdf_low}]  
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
function clearSeries(){
	 var series_0 = chart0.series;
     while(series_0.length > 0) {
    	 series_0[0].remove(false);
     }  
     document.getElementById('highLinux99th').innerHTML='';
	 document.getElementById('highLNS99th').innerHTML='';
     var series_1 = chart1.series;
     while(series_1.length > 0) {
    	 series_1[0].remove(false);
     }  
     document.getElementById('lowLinux99th').innerHTML='';
	 document.getElementById('lowLNS99th').innerHTML='';
	 
}

</script>
</div>
</body>
</html>

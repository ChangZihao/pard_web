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
<title>riscv redis实时响应数据</title>
<link rel="stylesheet" href="statics/css/pintuer.css">
<link rel="stylesheet" href="statics/css/admin.css">
<link rel="stylesheet" href="statics/css/physical.css">
</head>

<body>
	<div id="mainDiv">
		<div id="container1" style="width:1200px;height:550px;top:20px;left:-700px"></div> 
		 <div id="QpsDiv" style="width: 100px; height: 50px; position: absolute; left: 309px; top: 27px;">QPS:<span id="qps"></span></div>
		<div id="containerControl">
			<span style="font-family: 微软雅黑; font-size: 14px;">线程控制:</span> 
			<input type="button" id="startButton" value="暂停" onclick="start();" style="cursor: pointer">
		</div> 

		<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="statics/js/highcharts.js"></script>
		<script type="text/javascript" src="statics/js/highcharts-more.js"></script>
		<script type="text/javascript">
		 
		var flag=true;
		var returnedRealData = null; 
		//var type='${type}';
		setInterval(function() {
			if(flag==true){
				$.ajax({
					async:true,
					type:"get",
					url:"getRiscvRedisRealQueryData.do?type=${type}",
					data:{},
					dataType:"json",
					success:function(returned) {  
						if(returned!=null&&returned!=""&&returned!="null"){
							returnedRealData = returned; 
						}
					}	
				});
			 
		   }
	    },1000);
	 
	function start(){
		if(flag==true){
			 flag=false;
			 document.getElementById('startButton').value="继续";
		}else{
			 flag=true;
			 document.getElementById('startButton').value="暂停";
		}
	}
	 
	 
 $(document).ready(function (){
    Highcharts.setOptions({
        global: {
            useUTC: false
        }
    });
    /**
    * mean
    */
     Highcharts.chart('container1', {
    	 credits:{ 
     	      enabled:false 
     		},
        chart: {
        	zoomType: 'x',
            type: 'line',
            animation: Highcharts.svg, // don't animate in old IE
            marginRight: 10,
            events: {
                load: function () {
                    // set up the updating of the chart each second
                    var series0 = this.series[0];
                    var series1 = this.series[1];
                    var series2 = this.series[2];
                    var series3 = this.series[3];
                    var series4 = this.series[4];
                    var series5 = this.series[5];
                    var series6 = this.series[6];
                    var series7 = this.series[7];
                    var lastcollecttime=null;
                    var x;
                    var qps;
                	var mean;
                	var min;
                	var fiftyTh;
                	var eightyTh;
                	var nintyTh;
                	var nintyNineTh;
                	var nintyNinePointNineTh;
                	var max;
                	var qps;
                    setInterval(function (){
                    	if(flag==true){
            				if(returnedRealData!=null){
          			            x = returnedRealData[0].collectTime;
          			            qps = returnedRealData[0].qps;
          			            min = returnedRealData[0].min;
          			            mean = returnedRealData[0].mean;
          			            fiftyTh = returnedRealData[0].fiftyTh;
          			            eightyTh = returnedRealData[0].eightyTh;
          			            nintyTh = returnedRealData[0].nintyTh;
          			            nintyNineTh = returnedRealData[0].nintyNineTh;
          			            nintyNinePointNineTh = returnedRealData[0].nintyNinePointNineTh;
          			            max = returnedRealData[0].max;
          			            if(lastcollecttime==null){//如果第一次判断 直接添加点进去
          			            	   series0.addPoint([x,min], true, true); 
          			            	   series1.addPoint([x,mean], true, true); 
          			            	   series2.addPoint([x,fiftyTh], true, true); 
	          			               series3.addPoint([x,eightyTh], true, true); 
	          			               series4.addPoint([x,nintyTh], true, true); 
	          			               series5.addPoint([x,nintyNineTh], true, true); 
	          			               series6.addPoint([x,nintyNinePointNineTh], true, true); 
	          			               series7.addPoint([x,max], true, true); 
          			            	   lastcollecttime = x;
          			            	   document.getElementById('qps').innerHTML=qps;
          			            }else{ 
          			            	   if(lastcollecttime<x){//如果不是第一次判断，则只有上次时间小于当前时间时才添加点
          			            		 series0.addPoint([x,min], true, true); 
            			            	 series1.addPoint([x,mean], true, true); 
            			            	 series2.addPoint([x,fiftyTh], true, true); 
  	          			                 series3.addPoint([x,eightyTh], true, true); 
  	          			                 series4.addPoint([x,nintyTh], true, true); 
  	          			                 series5.addPoint([x,nintyNineTh], true, true); 
  	          			                 series6.addPoint([x,nintyNinePointNineTh], true, true); 
  	          			                 series7.addPoint([x,max], true, true); 
          				            	  lastcollecttime = x; 
          				            	  document.getElementById('qps').innerHTML=qps;
          			            	   }
          			            } 
          			          }  
            				}
                    }, 1000);
                }
            }
        },
        title: {
            text: 'redis实时响应时间'
        },
        xAxis: {
        	type: 'datetime',
            tickPixelInterval: 150,
            gridLineWidth: 1
        },
        yAxis: {
            title: {
                text: '响应时间 /us'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }], 
			min:0,
        },
        tooltip: {
            formatter: function () {
                return '<b>' + this.series.name + '</b><br/>' +
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                    Highcharts.numberFormat(this.y,0)+'us';
            }
        },
        legend: {
            
        },
         plotOptions: {
            area: {
                fillColor: {
                    linearGradient: {
                        x1: 0,
                        y1: 0,
                        x2: 0,
                        y2: 1
                    },
                    stops: [
                        [0, Highcharts.getOptions().colors[0]],
                        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                    ]
                },
                marker: {
                    radius: 2
                },
                lineWidth: 1,
                states: {
                    hover: {
                        lineWidth: 1
                    }
                },
                threshold: null
            }
        },
        exporting: {
            enabled: false
        },
        series:[${str}]
    });
     
 });
</script>
	</div>
</body>
</html>

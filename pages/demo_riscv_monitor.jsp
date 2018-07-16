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
<title>RISC-V系统节点${riscvId}资源监控</title>
<link rel="stylesheet" href="statics/css/pintuer.css">
<link rel="stylesheet" href="statics/css/admin.css">
<link rel="stylesheet" href="statics/css/physical.css">
</head>

<body>
	<div id="mainDiv">
		<div id="container1" style="height: 250px;"></div>
		<div id="container2" style="height: 250px;" ></div>
		<div id="container3" style="top:250px;height: 250px;"></div>
		<div id="container4" style="top:250px;height: 250px;"></div> 
		<div id="QpsDiv"
				style="width: 150px; height: 50px; position: absolute; left: -116px; top: 24px;">平均利用率:<span id="avgUsagePerc"></span>%</div>
	
		<div id="containerControl">
			<span style="font-family: 微软雅黑; font-size: 14px;">线程控制:</span> 
			<input type="button" id="startButton" value="暂停" onclick="start();" style="cursor: pointer">
		</div> 

		<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="statics/js/highcharts.js"></script>
		<script type="text/javascript" src="statics/js/highcharts-more.js"></script>
		<script type="text/javascript">
		 
		var flag=true;
		var returnedPqosData = null;
		var riscvId=${riscvId};
		setInterval(function() {
			if(flag==true){
				$.ajax({
					async:true,
					type:"get",
					url:"getRiscvLLCdRAM.do?riscvId="+riscvId,
					data:{},
					dataType:"json",
					success:function(returned) {  
						if(returned!=null&&returned!=""&&returned!="null"){
							returnedPqosData = returned; 
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
    * cpu
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
                    // set up the updating of the chart each second
                    var series = this.series[0];
                    var lastcollecttime=null;
                    var x,y,z;
                    var lastY;
                    setInterval(function (){
                    	if(flag==true){
                    		$.ajax({
            					async:true,
            					type:"get",
            					url:"getRiscvCpuUsage.do?riscvId="+riscvId,
            					data:{},
            					dataType:"json",
            					success:function(returnedData) { 
            						  if(returnedData!=null){
          			            	    x = returnedData[0].collectTime;
          			            	    y = returnedData[0].cpuUsageRate;
          			            	    z = returnedData[0].cpuAvgUsageRate;
          			            	    if(lastcollecttime==null){//如果第一次判断 直接添加点进去
          			            	    	 series.addPoint([x,y], true, true); 
          			            	    	 lastcollecttime = x; 
          			            	    	 lastY=y;
          			            	    	 document.getElementById('avgUsagePerc').innerHTML=z;
          			            	    }else{ 
          			            	    	if(lastcollecttime<x&&lastY!=y){//如果不是第一次判断，则只有上次时间小于当前时间时才添加点
          			            	    		series.addPoint([x,y], true, true); 
          				            	    	lastcollecttime = x;  
          				            	    	lastY=y;
             			            	    	document.getElementById('avgUsagePerc').innerHTML=z;
          			            	    	}
          			            	    }
          				               
          			               } 
            					}	
            				});
			               
                    	}
                    }, 1000);
                }
            }
        },
        title: {
            text: 'CPU使用率'
        },
        xAxis: {
        	type: 'datetime',
            tickPixelInterval: 150,
            gridLineWidth: 1
        },
        yAxis: {
            title: {
                text: '使用率 %'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }],
            max:100,
			min:0,
        },
        tooltip: {
            formatter: function () {
                return '<b>' + this.series.name + '</b><br/>' +
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                    Highcharts.numberFormat(this.y, 2)+'%';
            }
        },
        legend: {
            enabled: false
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
        series:[${cpuStr}]
    });
     /**
      * memory
      */
      Highcharts.chart('container2', {
    	  credits:{ 
      	      enabled:false 
      		},
         chart: {
             type: 'line',
             animation: Highcharts.svg, // don't animate in old IE
             marginRight: 10,
             events: {
            	  load: function () {
                      // set up the updating of the chart each second
                      var series = this.series[0];
                      var lastcollecttime=null;
                      var x,y;
                      setInterval(function (){
                      	if(flag==true){
                      		$.ajax({
              					async:true,
              					type:"get",
              					url:"getRiscvMemUsage.do?riscvId="+riscvId,
              					data:{},
              					dataType:"json",
              					success:function(returnedData) { 
              						  if(returnedData!=null){
            			            	    x = returnedData[0].collectTime;
            			            	    y = returnedData[0].memUsageRate;
            			            	    if(lastcollecttime==null){//如果第一次判断 直接添加点进去
            			            	    	 series.addPoint([x,y], true, true); 
            			            	    	 lastcollecttime = x;
            			            	    }else{ 
            			            	    	if(lastcollecttime<x){//如果不是第一次判断，则只有上次时间小于当前时间时才添加点
            			            	    		series.addPoint([x,y], true, true); 
            				            	    	lastcollecttime = x; 
            			            	    	}
            			            	    }
            				               
            			               } 
              					}	
              				});
  			               
                      	}
                      }, 1000);
                   }
             }
         },
         title: {
             text: '内存使用率'
         },
         xAxis: {
        	 type: 'datetime',
             tickPixelInterval: 150,
         },
         yAxis: {
             title: {
                 text: '使用率 %'
             },
             plotLines: [{
                 value: 0,
                 width: 1,
                 color: '#808080'
             }],
             max:100,
 			 min:0,
         },
         tooltip: {
             formatter: function () {
                 return '<b>' + this.series.name + '</b><br/>' +
                     Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                     Highcharts.numberFormat(this.y, 2)+'%';
             }
         },
         legend: {
             enabled: false
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
         series:[${memStr}]
     });
      /**
       * llc缺失率
       */
       Highcharts.chart('container3', {
     	  credits:{ 
       	      enabled:false 
       		},
          chart: {
              type: 'line',
              animation: Highcharts.svg, // don't animate in old IE
              marginRight: 10,
              events: {
             	  load: function () {
                       // set up the updating of the chart each second
                       var series = this.series[0];
                       var lastcollecttime=null;
                       var x,y;
                       setInterval(function (){
                       	if(flag==true){
   			              if(returnedPqosData!=null){
   			            	    x = returnedPqosData[0].collectTime;
   			            	    y = returnedPqosData[0].llcMisses;
   			            	    if(lastcollecttime==null){//如果第一次判断 直接添加点进去
   			            	    	 series.addPoint([x,y], true, true); 
   			            	    	 lastcollecttime = x;
   			            	    }else{ 
   			            	    	if(lastcollecttime<x){//如果不是第一次判断，则只有上次时间小于当前时间时才添加点
   			            	    		series.addPoint([x,y], true, true); 
   				            	    	lastcollecttime = x; 
   			            	    	}
   			            	    }
   				               
   			               }    
                       	}
                       }, 200);
                    }
              }
          },
          title: {
              text: '末级缓存'
          },
          xAxis: {
         	 type: 'datetime',
              tickPixelInterval: 150,
          },
          yAxis: {
              title: {
                  text: '缺失率 %'
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
                      Highcharts.numberFormat(this.y, 2)+'%';
              }
          },
          legend: {
              enabled: false
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
          series:[${llcStr}]
      });
       /**
        * 内存带宽请求数
        */
        Highcharts.chart('container4', {
      	  credits:{ 
        	      enabled:false 
        		},
           chart: {
               type: 'line',
               animation: Highcharts.svg, // don't animate in old IE
               marginRight: 10,
               events: {
              	  load: function () {
                        // set up the updating of the chart each second
                        var series = this.series[0];
                        var lastcollecttime=null;
                        var x,y;
                        setInterval(function (){
                        	if(flag==true){
    			              if(returnedPqosData!=null){
    			            	    x = returnedPqosData[0].collectTime;
    			            	    y = returnedPqosData[0].bandwidth;
    			            	    if(lastcollecttime==null){//如果第一次判断 直接添加点进去
    			            	    	 series.addPoint([x,y], true, true); 
    			            	    	 lastcollecttime = x;
    			            	    }else{ 
    			            	    	if(lastcollecttime<x){//如果不是第一次判断，则只有上次时间小于当前时间时才添加点
    			            	    		series.addPoint([x,y], true, true); 
    				            	    	lastcollecttime = x; 
    			            	    	}
    			            	    }
    				               
    			               }    
                        	}
                        }, 200);
                     }
               }
           },
           title: {
               text: '内存带宽'
           },
           xAxis: {
          	 type: 'datetime',
               tickPixelInterval: 150,
           },
           yAxis: {
               title: {
                   text: '请求数/s'
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
                       Highcharts.numberFormat(this.y, 0)+'/s';
               }
           },
           legend: {
               enabled: false
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
           series:[${memBDStr}]
       });
 });
</script>
	</div>
</body>
</html>

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
<title>物理机监控</title>
<link rel="stylesheet" href="statics/css/pintuer.css">
<link rel="stylesheet" href="statics/css/admin.css">
<link rel="stylesheet" href="statics/css/physical.css">
</head>

<body>
	<div id="mainDiv">
		<div id="container1"></div>
		<div id="container2"></div>
		<div id="container3"></div>
		<div id="container4"></div>
		<div id="container5"></div>
		<div id="container6"></div>
		<div id="containerControl">
			<span style="font-family: 微软雅黑; font-size: 14px;">线程控制:</span>
			<c:if test="${cronFlag==1}">
			<input type="button" id="startButton" value="暂停" onclick="start();" style="cursor: pointer">
			</c:if>
			<c:if test="${cronFlag==0}">
			<input type="button" id="startButton" value="继续" onclick="start();" style="cursor: pointer">
			</c:if>
		</div> 

		<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="statics/js/highcharts.js"></script>
		<script type="text/javascript" src="statics/js/highcharts-more.js"></script>
		<script type="text/javascript">
		var returnedData = null; 
		var returnedPqosData = null;
		var flag=false;
		var cornFlag="<%=request.getAttribute("cronFlag")%>";
		if(cornFlag=="1"){
			flag=true;
		} 
		var no=${no};
		setInterval(function() {
			if(flag==true){
				$.ajax({
					async:true,
					type:"get",
					url:"getPqos.do?no="+no,
					data:{},
					dataType:"json",
					success:function(returned) {  
						if(returned!=null&&returned!=""&&returned!="null"){
							returnedPqosData = returned; 
						}
					}	
				});
				$.ajax({
					async:true,
					type:"get",
					url:"getPhyResourceUse.do?no="+no,
					data:{},
					dataType:"json",
					success:function(returned) { 
						if(returned!=null&&returned!=""&&returned!="null"){
							returnedData = returned; 
						}
					}	
				});
		   }
	    },1000);
	 
	function start(){
		if(flag==true){
			 $.ajax({
					async:false,
					type:"post",
					url:"monitor/cronFlag.do",
					data:{flag:0},
					dataType:"text",
					success:function(returned){
						 if(returned=="0"){
							 flag=false;
							 document.getElementById('startButton').value="继续";
						 }
					}	
				}); 
		}else{
			$.ajax({
				async:false,
				type:"post",
				url:"monitor/cronFlag.do",
				data:{flag:1},
				dataType:"text",
				success:function(returned){
					 if(returned=="1"){
						 flag=true;
						 document.getElementById('startButton').value="暂停";
					 }
				}	
			});
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
                    var x,y;
                    setInterval(function (){
                    	if(flag==true){
			              if(returnedData!=null){
			            	    x = returnedData[0].collecttime.time;
			            	    y = returnedData[0].cpuusagerate*100;
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
        series:[${cpu}]
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
    			              if(returnedData!=null){
    			            	    x = returnedData[0].collecttime.time;
    			            	    y = returnedData[0].memusagerate;
    			            	    if(lastcollecttime==null){
    			            	    	 series.addPoint([x,y], true, true); 
    			            	    	 lastcollecttime = x;
    			            	    }else{
    			            	    	if(lastcollecttime<x){
    			            	    		series.addPoint([x,y], true, true); 
    				            	    	lastcollecttime = x;
    			            	    	} 
    			            	    }
    				               
    			               }    
                        	}
                      },200);
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
         series:[${memory}]
     });
      /**
       * IO
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
    			              if(returnedData!=null){
    			            	    x = returnedData[0].collecttime.time;
    			            	    y = returnedData[0].iousagerate;
    			            	    if(lastcollecttime==null){
    			            	    	 series.addPoint([x,y], true, true); 
    			            	    	 lastcollecttime = x;
    			            	    }else{
    			            	    	if(lastcollecttime<x){
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
              text: 'IO使用'
          },
          xAxis: {
          	type: 'datetime',
              tickPixelInterval: 150,
              gridLineWidth: 1
          },
          yAxis: {
              title: {
                  text: '读写速度 KB/s'
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
                      Highcharts.numberFormat(this.y, 0)+'KB/s';
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
          series:[${io}]
      });
       /**
        * net
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
     			              if(returnedData!=null){
     			            	    x = returnedData[0].collecttime.time;
     			            	    y = returnedData[0].netusagerate;
     			            	    if(lastcollecttime==null){
     			            	    	 series.addPoint([x,y], true, true); 
     			            	    	 lastcollecttime = x;
     			            	    }else{
     			            	    	if(lastcollecttime<x){
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
               text: '网络使用'
           },
           xAxis: {
           	type: 'datetime',
               tickPixelInterval: 150,
               gridLineWidth: 1
           },
           yAxis: {
               title: {
                   text: '读写速度 KB/s'
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
                       Highcharts.numberFormat(this.y, 2)+'KB/s';
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
           series:[${net}]
       });
       /**
       * LLC miss
       */
        Highcharts.chart('container5', {
        	credits:{ 
        	      enabled:false 
        		},
            chart: {
                type: 'area',
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
    			              if(returnedPqosData!=null&&returnedPqosData[0].time!=0){
    			            	    x = returnedPqosData[0].time;
    			            	    y = returnedPqosData[0].cachemiss;
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
                text: '缓存缺失率'
            },
            xAxis: {
            	type: 'datetime',
                tickPixelInterval: 150,
                gridLineWidth: 1
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
               // max:100,
    			min:0
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
            series:[${llc}]
        });
        Highcharts.chart('container6', {
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
                        var series0 = this.series[0];
                        var series1 = this.series[1];
                        var lastcollecttime=null;
                        var x,y;
                        setInterval(function (){
                     	   if(flag==true){
      			              if(returnedPqosData!=null&&returnedPqosData[0].time!=0){
      			            	    x = returnedPqosData[0].time;
      			            	    y = returnedPqosData[0].mbl;
      			            	    z=  returnedPqosData[0].mbr;
      			            	    if(lastcollecttime==null){
      			            	    	 series0.addPoint([x,y], true, true); 
      			            	    	 series1.addPoint([x,z], true, true); 
      			            	    	 lastcollecttime = x;
      			            	    }else{
      			            	    	if(lastcollecttime<x){
      			            	    		series0.addPoint([x,y], true, true); 
      			            	    		series1.addPoint([x,z], true, true); 
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
                text: '内存带宽使用'
            },
            xAxis: {
            	type: 'datetime',
                tickPixelInterval: 150,
                gridLineWidth: 1
            },
            yAxis: {
                title: {
                    text: '读写速度  MB/s'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }], 
    			min:0
            },
            legend: {
               enabled:false
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.series.name + '</b><br/>' +
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                        Highcharts.numberFormat(this.y, 2)+'MB/s';
                }
            },
            
            exporting: {
                enabled: false
            },
            series:[${mbm}]
        });
 });
</script>
	</div>
</body>
</html>

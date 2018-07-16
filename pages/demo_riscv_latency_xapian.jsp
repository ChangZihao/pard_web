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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="statics/css/pintuer.css">
    <link rel="stylesheet" href="statics/css/admin.css"> 
    <link rel="stylesheet" href="statics/css/showBo.css"/>
    <script src="statics/js/jquery.js"></script>
    <script src="statics/js/pintuer.js"></script>
</head>
<body style="height:2000px;">

    <!--图-->
    <div style="width: 900px;" id="chart">
        <div id="websearch1" style="width: 550px;height: 300px;position: absolute; left:150px;top: 320px;"></div>
        <div id="websearch2" style="width: 550px;height: 300px;position: absolute; left:750px;top: 320px;"></div>
        <div id="websearch3" style="width: 400px;height: 300px;position: absolute; left:150px;top: 0px;"></div>
        <div id="websearch4" style="width: 400px;height: 300px;position: absolute; left:550px;top: 0px;"></div>
        <div id="websearch5" style="width: 400px;height: 300px;position: absolute; left:950px;top: 0px;"></div>
   		 
    <!--表-->
        <div style=" width: 1200px; position: absolute; top: 640px;left: 160px;" id="table">
        <form method="post" action="" id="">
            <div class="panel admin-panel">
                <div class="panel-head"><strong class="icon-reorder">服务指标对比差异 QPS=${qps}</strong> <a href="" style="float:right; display:none;">添加字段</a></div>

                <table class="table table-hover text-center">
                    <tr>
                        <th style="background:#f1f5fa" width="18%">指标</th>
                        <th style="background:#f9f9f9" width="18%">无干扰</th>
                        <th style="background:#f1f5fa" width="18%">干扰下</th>
                        <th style="background:#f9f9f9" width="18%">变化率</th>
                        <th style="background:#f1f5fa" width="18%">区分隔离后</th>
                        <th style="background:#f9f9f9" width="10%">变化率</th>
                    </tr>
                    <tr>
                    	<td style="background:#f1f5fa">响应时间90th /ms</td>
                        <td style="background:#f9f9f9">${BaseResult.nintyTh}</td>
                        <td style="background:#f1f5fa">${Result.nintyTh}</td>
                        <c:choose>
							<c:when test="${diffBean1.nintyThDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean1.nintyThDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean1.nintyThDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean1.nintyThDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean1.nintyThDiff}%</td>														
							</c:otherwise>
						</c:choose>
						<td style="background:#f1f5fa">${LabelResult.nintyTh}</td>
                        <c:choose>
							<c:when test="${diffBean2.nintyThDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean2.nintyThDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean2.nintyThDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean2.nintyThDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean2.nintyThDiff}%</td>														
							</c:otherwise>
						</c:choose>
                    </tr>
                    <tr>
                    	<td style="background:#f1f5fa">响应时间95th /ms</td>						 
                         <td style="background:#f9f9f9">${BaseResult.nintyFiveTh}</td>
                        <td style="background:#f1f5fa">${Result.nintyFiveTh}</td>
                        <c:choose>
							<c:when test="${diffBean1.nintyFiveThDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean1.nintyFiveThDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean1.nintyFiveThDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean1.nintyFiveThDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean1.nintyFiveThDiff}%</td>														
							</c:otherwise>
						</c:choose>
						<td style="background:#f1f5fa">${LabelResult.nintyFiveTh}</td>
                        <c:choose>
							<c:when test="${diffBean2.nintyFiveThDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean2.nintyFiveThDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean2.nintyFiveThDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean2.nintyFiveThDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean2.nintyFiveThDiff}%</td>														
							</c:otherwise>
						</c:choose>		
                    </tr>
                    <tr>
                    	<td style="background:#f1f5fa"> 响应时间99th /ms</td>
                        <td style="background:#f9f9f9">${BaseResult.nintyNineTh}</td>
                        <td style="background:#f1f5fa">${Result.nintyNineTh}</td>
                        <c:choose>
							<c:when test="${diffBean1.nintyNineThDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean1.nintyNineThDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean1.nintyNineThDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean1.nintyNineThDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean1.nintyNineThDiff}%</td>														
							</c:otherwise>
						</c:choose>
						<td style="background:#f1f5fa">${LabelResult.nintyNineTh}</td>
                        <c:choose>
							<c:when test="${diffBean2.nintyNineThDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean2.nintyNineThDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean2.nintyNineThDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean2.nintyNineThDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean2.nintyNineThDiff}%</td>														
							</c:otherwise>
						</c:choose>	
                    </tr>
                    <tr>
                   	 	<td style="background:#f1f5fa"> 响应时间方差</td>    						
                         <td style="background:#f9f9f9">${BaseResult.var}</td>
                        <td style="background:#f1f5fa">${Result.var}</td>
                        <c:choose>
							<c:when test="${diffBean1.varDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean1.varDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean1.varDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean1.varDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean1.varDiff}%</td>														
							</c:otherwise>
						</c:choose>
						<td style="background:#f1f5fa">${LabelResult.var}</td>
                        <c:choose>
							<c:when test="${diffBean2.varDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean2.varDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean2.varDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean2.varDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean2.varDiff}%</td>														
							</c:otherwise>
						</c:choose>	
                    </tr>
                    <tr>
                   	 	<td style="background:#f1f5fa"> 响应时间平均值 /ms</td>                                        
                         <td style="background:#f9f9f9">${BaseResult.mean}</td>
                        <td style="background:#f1f5fa">${Result.mean}</td>
                        <c:choose>
							<c:when test="${diffBean1.meanDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean1.meanDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean1.meanDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean1.meanDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean1.meanDiff}%</td>														
							</c:otherwise>
						</c:choose>
						<td style="background:#f1f5fa">${LabelResult.mean}</td>
                        <c:choose>
							<c:when test="${diffBean2.meanDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean2.meanDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean2.meanDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean2.meanDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean2.meanDiff}%</td>														
							</c:otherwise>
						</c:choose>
                    </tr>
                    <tr>
                   	 	<td style="background:#f1f5fa"> 响应时间最小值 /ms</td>  						  
                         <td style="background:#f9f9f9">${BaseResult.min}</td>
                        <td style="background:#f1f5fa">${Result.min}</td>
                        <c:choose>
							<c:when test="${diffBean1.minDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean1.minDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean1.minDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean1.minDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean1.minDiff}%</td>														
							</c:otherwise>
						</c:choose>
						<td style="background:#f1f5fa">${LabelResult.min}</td>
                        <c:choose>
							<c:when test="${diffBean2.minDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean2.minDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean2.minDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean2.minDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean2.minDiff}%</td>														
							</c:otherwise>
						</c:choose>
                    </tr>
                    <tr>
                    	<td style="background:#f1f5fa"> 响应时间最大值 /ms</td>  
                         <td style="background:#f9f9f9">${BaseResult.max}</td>
                        <td style="background:#f1f5fa">${Result.max}</td>
                        <c:choose>
							<c:when test="${diffBean1.maxDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean1.maxDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean1.maxDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean1.maxDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean1.maxDiff}%</td>														
							</c:otherwise>
						</c:choose>
						<td style="background:#f1f5fa">${LabelResult.max}</td>
                        <c:choose>
							<c:when test="${diffBean2.maxDiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean2.maxDiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean2.maxDiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean2.maxDiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean2.maxDiff}%</td>														
							</c:otherwise>
						</c:choose>
                    </tr>
                   <%--  <tr>
                    	<td style="background:#f1f5fa"> 体验可用性</td> 						
                         <td style="background:#f9f9f9">${BaseResult.EA}</td>
                        <td style="background:#f1f5fa">${Result.EA}</td>
                        <c:choose>
							<c:when test="${diffBean1.EADiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean1.EADiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean1.EADiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean1.EADiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean1.EADiff}%</td>														
							</c:otherwise>
						</c:choose>
						<td style="background:#f1f5fa">${LabelResult.EA}</td>
                        <c:choose>
							<c:when test="${diffBean2.EADiff>0}">
                               <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean2.EADiff}%</td>							
                            </c:when>
                            <c:when test="${diffBean2.EADiff<0}">
                               <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean2.EADiff}%</td>							
                            </c:when>
							<c:otherwise>
							   <td style="background:#f9f9f9">${diffBean2.EADiff}%</td>														
							</c:otherwise>
						</c:choose>
                    </tr> --%>
                </table>
            </div>
        </form>

    </div>

</div>
 
<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="statics/js/highcharts.js"></script>
<script type="text/javascript" src="statics/js/highcharts-more.js"></script> 
<script type="text/javascript" src="statics/js/showBo.js"></script>
<script type="text/javascript">
Highcharts.setOptions({ global: { useUTC: false } });
    $(document).ready(function() {
       var message="${message}";
       if(message!=null&&message!=""){
    	   Showbo.Msg.alert(message)
       }

        Highcharts.chart('websearch1', {
        	credits:{ 
      	      enabled:false 
      	},
            chart: {
                zoomType: 'x'
            },
            title: {
                text: '${appName}访问延迟累积分布曲线'
            },

            xAxis: {
                title: {
                    text: '响应时间/ms'
                },
                min:0
            },
            yAxis: {
                title: {
                    text: '累积概率'
                },
                min:0,
                max:1,
                tickPositions: [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            plotOptions: {
            	 series: {
                     marker:false
                 }
            },
        colors: ['#058DC7', '#ff3300','#28e109'],
        series:[${CDFStrs}]


});
        Highcharts.chart('websearch2', {
        	credits:{ 
      	      enabled:false 
      	},
            chart: {
                type: 'column',
                zoomType: 'x'
            },
            title: {
                text: '各项指标变化率'
            },
            xAxis: {
                categories: ['90th', '95th', '99th', '平均值','最小值','最大值','方差']
            },
            yAxis: {
                title: {
                    text: '变化率/%'
                },
            },
            legend: {                                                                    
                enabled: true                                                           
            } ,
            tooltip: {
                formatter: function () {
                	return '<span style="color: '+ this.series.color + '">\u25CF</span> '+
                    this.series.name+': <br/><b>'+ this.x+'变化'+this.y+'%' +'</b><br/>'
                  }
                }, 
            credits: {
                enabled: false
            },
            colors: ['#ff3300','#28e109'],
            series: [{name:'干扰后指标',data:[${diffBean1.nintyThDiff}, ${diffBean1.nintyFiveThDiff}, ${diffBean1.nintyNineThDiff},${diffBean1.meanDiff},${diffBean1.minDiff},${diffBean1.maxDiff},${diffBean1.varDiff}]},
                     {name:'开启隔离后指标',data:[${diffBean2.nintyThDiff}, ${diffBean2.nintyFiveThDiff}, ${diffBean2.nintyNineThDiff},${diffBean2.meanDiff},${diffBean2.minDiff},${diffBean2.maxDiff},${diffBean2.varDiff}]}]

        });
        
        Highcharts.chart('websearch3', {
        	credits:{ 
      	      enabled:false 
      	},
            chart: {
                type: 'scatter',
                zoomType: 'x'
            },
            plotOptions: {
                series: {
                    marker: {
                        radius: 1
                    }
                }
            },
            boost: {
                useGPUTranslations: true
            },
            xAxis: {
                
                tickPixelInterval: 150
            },
            title: {
                text: '无干扰下访问延迟分布'
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
                    return'<strong>'+this.series.name+'</strong><br/><br/>'+'响应时间：'+this.y+' ms';
                },
            },
            series: [${diffBean1.baseTimeStr}]
            
        });
        
        Highcharts.chart('websearch4', {
        	credits:{ 
      	      enabled:false 
      	},
            chart: {
                type: 'scatter',
                zoomType: 'x'
            },
            plotOptions: {
                series: {
                    marker: {
                        radius: 1
                    }
                }
            },
            boost: {
                useGPUTranslations: true
            },
            xAxis: {
               
                tickPixelInterval: 150
            },
            title: {
                text: '干扰下访问延迟分布'
            },
            legend: {                                                                    
                enabled: false                                                           
            } ,
            colors: ['#ff3300'],
            yAxis: {
                title: {
                    text: '响应时间/ms'
                },
            },
            tooltip: {
                formatter:function(){
                    return'<strong>'+this.series.name+'</strong><br/><br/>'+'响应时间：'+this.y+' ms';
                },
            },
            series: [${diffBean1.timeStr}]
        }); 
        Highcharts.chart('websearch5', {
        	credits:{ 
      	      enabled:false 
      		},
            chart: {
                type: 'scatter',
                zoomType: 'x'
            },
            plotOptions: {
                series: {
                    marker: {
                        radius: 1
                    }
                }
            },
            boost: {
                useGPUTranslations: true
            },
            xAxis: {
                
                tickPixelInterval: 150
            },
            title: {
                text: '开启隔离后访问延迟分布'
            },
            legend: {                                                                    
                enabled: false                                                           
            } ,
            colors: ['#12d423'],
            yAxis: {
                title: {
                    text: '响应时间/ms'
                },
            },
            tooltip: {
                formatter:function(){
                	 return'<strong>隔离后访问延迟分布</strong><br/><br/>'+'响应时间：'+this.y+' ms';
                },
            },
            series: [${diffBean2.timeStr}]
        }); 

});
</script>
 
</body>
</html>
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
<body style="height:1150px;">
<div >
    <ul class="nav nav-tabs" >
       <c:if test="${webSearch.enable==1}">
        <li class="active1" style="float: left;">
            <a  href="getWebSearchResult.do?testRecordId=${testRecordId}" target="_blank" id="xapian">webSearch</a>
        </li>
       </c:if>
       <c:if test="${webServer.enable==1}">
        <li class="" style="float: left;">
            <a  href="getWebServerResult.do?testRecordId=${testRecordId}" target="_blank" id="webserver">webServer</a>
        </li>
       </c:if>
       <c:if test="${silo.enable==1}">        
        <li class="" style="float: left;">
            <a  href="getSiloResult.do?testRecordId=${testRecordId}" target="_blank" id="silo">silo</a>
        </li>
       </c:if>
       <c:if test="${memcached.enable==1}">  
        <li class="" style="float: left;">
            <a  href="getMemcachedResult.do?testRecordId=${testRecordId}" target="_blank" id="memcached">memcached</a>
        </li>
       </c:if>
       <c:if test="${cassandra.enable==1}">
		<li class="" style="float: left;">
		    <a href="getCassandraResult.do?testRecordId=${testRecordId}"target="_blank" id="memcached">cassandra</a></li>
	   </c:if> 
	   <c:if test="${redis.enable==1}">
		<li class="" style="float: left;">
		    <a href="getRedisResult.do?testRecordId=${testRecordId}"target="_blank" id="memcached">redis</a></li>
	   </c:if>
	   <c:if test="${xapian.enable==1}">
		<li class="" style="float: left;">
		    <a href="getXapianResult.do?testRecordId=${testRecordId}"target="_blank" id="memcached">xapian</a></li>
	   </c:if>
    </ul>

</div>
<div>
    <!--图-->
    <div style="width: 900px;" id="chart">
        <div id="websearch1" style="width: 750px;height: 300px; position: absolute;top: 150px;left:150px;"></div>

    </div>
    <!--表-->
        <div style=" width: 1100px; position: absolute; top: 500px;left: 200px;" id="table">
        <form method="post" action="" id="">
            <div class="panel admin-panel">
                <div class="panel-head"><strong class="icon-reorder">计算同无干扰下的响应对比差异:memcached</strong> <a href="" style="float:right; display:none;">添加字段</a></div>

                <table class="table table-hover text-center">
                    <tr>
                        <th style="background:#f1f5fa" width="25%">指标</th>
                        <th style="background:#f9f9f9" width="25%">无干扰</th>
                        <th style="background:#f1f5fa" width="25%">干扰下</th>
                        <th style="background:#f9f9f9" width="25%">变化率</th>
                    </tr>
                    <tr>
                    	    <td style="background:#f1f5fa">响应时间90th /ms</td>
                            <td style="background:#f9f9f9">${MemcachedBaseResult.nintyTh}</td>
                            <td style="background:#f1f5fa" >${MemcachedResult.nintyTh}</td>
                            <c:choose>
                                <c:when test="${diffBean.nintyThDiff>0}">
                                    <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean.nintyThDiff}%</td>
                                </c:when>
                                <c:when test="${diffBean.nintyThDiff<0}">
                                    <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean.nintyThDiff}%</td>
                                </c:when>
                                <c:otherwise>
                                    <td style="background:#f9f9f9">${diffBean.nintyThDiff}%</td>
                                </c:otherwise>
                            </c:choose>
                    </tr>
                    <tr>
                    		<td style="background:#f1f5fa">响应时间95th /ms</td>	                            
                            <td style="background:#f9f9f9">${MemcachedBaseResult.nintyFiveTh}</td>
                            <td style="background:#f1f5fa" >${MemcachedResult.nintyFiveTh}</td>
                            <c:choose>
                                <c:when test="${diffBean.nintyFiveThDiff>0}">
                                    <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean.nintyFiveThDiff}%</td>
                                </c:when>
                                <c:when test="${diffBean.nintyFiveThDiff<0}">
                                    <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean.nintyFiveThDiff}%</td>
                                </c:when>
                                <c:otherwise>
                                    <td style="background:#f9f9f9">${diffBean.nintyFiveThDiff}%</td>
                                </c:otherwise>
                            </c:choose>
                    </tr>
                    <tr>
                    	<td style="background:#f1f5fa"> 响应时间99th /ms</td>
                        <td style="background:#f9f9f9">${MemcachedBaseResult.nintyNineTh}</td>
                        <td style="background:#f1f5fa">${MemcachedResult.nintyNineTh}</td>
                        <c:choose>
                            <c:when test="${diffBean.nintyNineThDiff>0}">
                                <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean.nintyNineThDiff}%</td>
                            </c:when>
                            <c:when test="${diffBean.nintyNineThDiff<0}">
                                <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean.nintyNineThDiff}%</td>
                            </c:when>
                            <c:otherwise>
                                <td style="background:#f9f9f9">${diffBean.nintyNineThDiff}%</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    <tr>
                   	 	<td style="background:#f1f5fa"> 响应时间方差 /ms</td>                          
                        <td style="background:#f9f9f9">${MemcachedBaseResult.var}</td>
                        <td style="background:#f1f5fa" >${MemcachedResult.var}</td>
                        <c:choose>
                            <c:when test="${diffBean.varDiff>0}">
                                <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean.varDiff}%</td>
                            </c:when>
                            <c:when test="${diffBean.varDiff<0}">
                                <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean.varDiff}%</td>
                            </c:when>
                            <c:otherwise>
                                <td style="background:#f9f9f9">${diffBean.varDiff}%</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    <tr>
                        <td style="background:#f1f5fa"> 平均延迟 /ms</td>
                        <td style="background:#f9f9f9">${MemcachedBaseResult.mean}</td>
                        <td style="background:#f1f5fa" >${MemcachedResult.mean}</td>
                        <c:choose>
                            <c:when test="${diffBean.meanDiff>0}">
                                <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean.meanDiff}%</td>
                            </c:when>
                            <c:when test="${diffBean.meanDiff<0}">
                                <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean.meanDiff}%</td>
                            </c:when>
                            <c:otherwise>
                                <td style="background:#f9f9f9">${diffBean.meanDiff}%</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    <tr>
                   	 	<td style="background:#f1f5fa"> 响应时间最小值 /ms</td>                           
                        <td style="background:#f9f9f9">${MemcachedBaseResult.min}</td>
                        <td style="background:#f1f5fa" >${MemcachedResult.min}</td>
                        <c:choose>
                            <c:when test="${diffBean.minDiff>0}">
                                <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean.minDiff}%</td>
                            </c:when>
                            <c:when test="${diffBean.minDiff<0}">
                                <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean.minDiff}%</td>
                            </c:when>
                            <c:otherwise>
                                <td style="background:#f9f9f9">${diffBean.minDiff}%</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    <tr>
                    	<td style="background:#f1f5fa"> 响应时间最大值 /ms</td>  
                        <td style="background:#f9f9f9">${MemcachedBaseResult.max}</td>
                        <td style="background:#f1f5fa" >${MemcachedResult.max}</td>
                        <c:choose>
                            <c:when test="${diffBean.maxDiff>0}">
                                <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean.maxDiff}%</td>
                            </c:when>
                            <c:when test="${diffBean.maxDiff<0}">
                                <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean.maxDiff}%</td>
                            </c:when>
                            <c:otherwise>
                                <td style="background:#f9f9f9">${diffBean.maxDiff}%</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    <tr>
                    	<td style="background:#f1f5fa"> 缺失率</td> 	                         
                        <td style="background:#f9f9f9">${MemcachedBaseResult.missRate}</td>
                        <td style="background:#f1f5fa" >${MemcachedResult.missRate}</td>
                        <c:choose>
                            <c:when test="${diffBean.missRateDiff>0}">
                                <td style="background:#f9f9f9"><img src="statics/images/up.png"/>${diffBean.missRateDiff}%</td>
                            </c:when>
                            <c:when test="${diffBean.missRateDiff<0}">
                                <td style="background:#f9f9f9"><img src="statics/images/down.png"/>${diffBean.missRateDiff}%</td>
                            </c:when>
                            <c:otherwise>
                                <td style="background:#f9f9f9">${diffBean.missRateDiff}%</td>
                            </c:otherwise>
                        </c:choose>  						
                    </tr>
                    <tr>
                    	<td style="background:#f1f5fa">每秒钟请求数</td>
                        <td style="background:#f9f9f9">${MemcachedBaseResult.rps}</td>
                        <td style="background:#f1f5fa" >${MemcachedResult.rps}</td>
						<td style="background:#f9f9f9"></td>
                    </tr>
                    <tr>						
						<td style="background:#f1f5fa">读写操作比</td>
                        <td style="background:#f9f9f9">${MemcachedBaseResult.getSetRate}</td>
                        <td style="background:#f1f5fa" >${MemcachedResult.getSetRate}</td>
                        <td style="background:#f9f9f9"></td>						
                    </tr>
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
    $(document).ready(function() {
    	  var message="${message}";
          if(message!=null&&message!=""){
       	   Showbo.Msg.alert(message)
          }
        Highcharts.chart('websearch1', {

            chart: {
                type: 'column'
            },
            title: {
                text: 'memcached各项指标变化率'
            },
            xAxis: {
                categories: ['90th', '95th', '99th', '方差', '平均值','最小值','最大值','缺失率']
            },
            yAxis: {
                title: {
                    text: '变化率/%'
                },
            },
            legend: {                                                                    
                enabled: false                                                           
            } ,
            tooltip: {
                formatter: function () {
                	return '<span style="color: '+ this.series.color + '">\u25CF</span> '+
                    this.series.name+': <br/><b>'+ this.x+'变化'+this.y+'%' +'</b><br/>.'
                  }
                }, 
            credits: {
                enabled: false
            },
            series: [{
            	name:'memcached',
                data: [${diffBean.nintyThDiff}, ${diffBean.nintyFiveThDiff}, ${diffBean.nintyNineThDiff},
                       ${diffBean.varDiff}, ${diffBean.meanDiff},${diffBean.minDiff},${diffBean.maxDiff},${diffBean.missRateDiff}]
            }]


        });
    });
</script>
</body>
</html>
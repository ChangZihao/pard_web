<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<!--测试控制模块-->
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />


    <link rel="stylesheet" href="statics/css/pintuer.css">
    <link rel="stylesheet" href="statics/css/admin.css">

    <link rel="stylesheet" type="text/css" href="statics/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="statics/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="statics/css/iconfont.css" />

    <link rel="stylesheet" type="text/css" href="statics/css/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="statics/css/style.css" />
	<link rel="stylesheet" href="statics/css/showBo.css"/> 

</head>
<body>
 
<div>
    <div class="new-page-container" style="position: absolute; top:-50px; ">
        <form action="" method="post" class="form form-horizontal" id="form-article-add">
            <!--在线-->
            <div id="online">
            <c:if test="${webSearch.enable+webServer.enable>=1}">
                <div class="row cl">
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" >请求总数</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">预热次数</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">请求策略</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">间隔单位</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                </div>
            </c:if>    
                <c:if test="${webSearch.enable==1}"> 
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">webSearch：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="${webSearch.requestCount}" placeholder="5000" id="config1-1" name="requestCount" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${webSearch.warmUpCount}" placeholder="" id="config1-2" name="warmUpCount">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${webSearch.pattern}" placeholder="定值/均匀/指数/泊松" id="config1-3" name="pattern" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${webSearch.intensity}" placeholder="2000" id="config1-4"name="intensity">
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="webSearchButton">
                        <input style="margin-left:20px; " type="button"  class="config" onclick="" value="基准采集" id="webSearchAverButton">
                    </div>
                </div> 
                </c:if>
                <c:if test="${webServer.enable==1}">
               <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">webServer：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="${webServer.requestCount}" placeholder="5000" id="config2-1" name="requestCount">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${webServer.warmUpCount}" placeholder="" id="config2-2" name="warmUpCount">
                        <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${webServer.pattern}" placeholder="10" id="config2-3" name="pattern" >
                        <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${webServer.intensity}" placeholder="2000" id="config2-4" name="intensity">
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="webServerButton">
                        <input style="margin-left:20px; " type="button"  class="config" onclick="" value="基准采集" id="webServerAverButton">
                    </div>
                </div>
                </c:if>
                <c:if test="${cassandra.enable==1}"> 
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">cassandra：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="${cassandra.requestCount}" placeholder="" id="config8-1" name="requestCount" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${cassandra.warmUpCount}" placeholder="" id="config8-2" name="warmUpCount" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${cassandra.pattern}" placeholder="定值/均匀/指数/泊松" id="" name="pattern">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${cassandra.intensity}" placeholder="" id="" name="intensity" >
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="cassandraButton">
                    	<input style="margin-left:20px; " type="button"  class="config" onclick="" value="基准采集" id="cassandraAverButton">
                    	
                    </div>
                </div>
                </c:if>
                <c:if test="${memcached.enable+silo.enable>=1}">
                <div class="row cl" id="title2">
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" >请求总数</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">预热次数</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">请求策略</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">QPS</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                </div>
                </c:if>
                <c:if test="${memcached.enable==1}">
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">memcached:</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="${memcached.requestCount}" placeholder="20000" id="config3-1" name="requestCount" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${memcached.warmUpCount}" placeholder="2000" id="config3-2" name="intensity" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="均匀" placeholder="" id="" name="" disabled="disabled">
						<input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${memcached.intensity}" placeholder="2000" id="config3-3" name="warmUpCount">
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="memcachedButton">
                        <input style="margin-left:20px; " type="button"  class="config" onclick="" value="基准采集" id="memcachedAverButton">
                    </div>
                </div>
                </c:if>
                <c:if test="${silo.enable==1}">
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">silo:</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="${silo.requestCount}" placeholder="20000" id="config4-1" name="requestCount">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${silo.warmUpCount}" placeholder="2000" id="config4-2" name="warmUpCount" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="均匀" placeholder="" id="" name="" disabled="disabled">
						<input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${silo.intensity}" placeholder="2000" id="config4-3" name="intensity">
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="siloButton">
                        <input style="margin-left:20px; " type="button"  class="config" onclick="" value="基准采集" id="siloAverButton">
                    </div>
                </div>
                </c:if>
                 <c:if test="${xapian.enable==1}">
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">xapian:</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="${xapian.requestCount}" placeholder="20000" id="config9-1" name="requestCount">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${xapian.warmUpCount}" placeholder="2000" id="config9-2" name="warmUpCount" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="均匀" placeholder="" id="" name="" disabled="disabled">
						<input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${xapian.intensity}" placeholder="2000" id="config9-3" name="intensity">
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="xapianButton">
                        <input style="margin-left:20px; " type="button"  class="config" onclick="" value="基准采集" id="xapianAverButton">
                    </div>
                </div>
                </c:if>
                <c:if test="${redis.enable==1}">
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">redis:</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="${redis.requestCount}" placeholder="20000" id="config10-1" name="requestCount">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${redis.warmUpCount}" placeholder="2000" id="config10-2" name="warmUpCount" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${redis.pattern}" placeholder="" id="" name="" disabled="disabled">
						<input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${redis.intensity}" placeholder="2000" id="config10-3" name="intensity">
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="redisButton">
                        <input style="margin-left:20px; " type="button"  class="config" onclick="" value="基准采集" id="redisAverButton">
                    </div>
                </div>
                </c:if>
            </div>

            <!--离线-->
            <div id="offline">
               <c:if test="${bonnie.enable==1}">
                <div class="row cl">
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">读取操作</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" >写入操作</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">负载策略</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">读写块大小</label>
					<label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">bonnie：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="" placeholder="按块读取" id="" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="" placeholder="按块写入" id="config5-1" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="循环" placeholder="" id="" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${bonnie.intensity}" placeholder="" id="" name="intensity" >
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="bonnieButton">
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="停止" disabled="disabled" id="bonnieAverButton">
                    </div>
                </div>
                </c:if>
                <c:if test="${scimark.enable==1}">
                <div class="row cl">
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" >--</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">--</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">负载策略</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">线程数量</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">scimark：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="" placeholder="" id="" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="" placeholder="" id="config6-1" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="循环" placeholder="" id="" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${scimark.intensity}" placeholder="" id="" name="intensity" >
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="scimarkButton">
                    </div>
                </div>
                </c:if>
                
                <c:if test="${hadoop.enable==1}">
                <div class="row cl">
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">负载类型</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">reduce数</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">hadoop：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="" placeholder="" id="config7-1" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="" placeholder="" id="config7-2" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${hadoop.pattern}" placeholder="IO密集型/CPU密集型/综合" id="" name="pattern" >
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${hadoop.intensity}" placeholder="" id="" name="intensity" >
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="hadoopButton">
                    </div>
                </div>
                </c:if>
                <c:if test="${dwarf.enable==1}">
                <div class="row cl">
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" >--</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">--</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">负载策略</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">线程数量</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">bigDataDwarf：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="margin-left:-20px; " class="input new-w50 new-col-sm-2 " type="text"  value="" placeholder="" id="" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="" placeholder="" id="config11-1" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="单次" placeholder="" id="" name="" disabled="disabled">
                        <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${dwarf.intensity}" placeholder="" id="" name="intensity" >
                        <input style="margin-left:20px; " type="button"  class="config " onclick="" value="开启" id="dwarfButton">
                    </div>
                </div>
                </c:if>
               
            </div>

        </form>
    </div>

    <div id="time" style="position: absolute; top:60px;right: 70px; width: 27%; ">
        <div class="row cl">
            <label style="width: 30%; float: left;text-align: right;" >开始时间：</label>
                <input style="margin-left:10px; width: 40%;" class="input new-w50 new-col-sm-2 " type="text"  value="${recordBean.startTime}" id="startTime" name="" >
                <input style="width:20%；" class="input new-w50" type="button" value="点击开始" id="startButton" >
        </div>
        <div class="row cl" style="margin-top: 30px;">
            <label style="width: 30%; float: left;text-align: right;" >结束时间：</label>
            <input style="margin-left:10px; width: 40%;" class="input new-w50 new-col-sm-2 " type="text"  value="${recordBean.endTime}" id="endTime" name="" >
            <input style="width:20%；" class="input new-w50" type="button" value="点击结束" id="endButton" >
        </div>
    </div>
    <div style="position: absolute; top:200px;right: 70px; width: 27%;">
       <label style="font-size: 18px; float: left;text-align: right; " >观察窗口</label>
<!--        <input type="button" id="startChartButton" class="editButton" style="float:right;" value="开始">
       <label style="font-size: 14px; float: right;text-align: middle;" >执行：</label> -->
    </div>

    <div id="chart1" style="position: absolute; top:250px;right: 70px; width: 400px; height: 200px;"></div>
    <div id="chart2" style="position: absolute;  top:460px;right: 70px; width: 400px; height: 200px;"></div>


</div>


<script src="statics/js/jquery.js"></script>
<script src="statics/js/pintuer.js"></script>
<script type="text/javascript" src="statics/js/highcharts.js"></script>
<script type="text/javascript" src="statics/js/highcharts-more.js"></script> 
<script type="text/javascript" src="statics/js/showBo.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    var appConfigSize="${appConfigSize}";
    if(appConfigSize!=null&&appConfigSize==0){
    	Showbo.Msg.alert("尚未进行应用参数配置!",function(){window.location='getAppConfig.do?testRecordId='+${testRecordId};});
    }
});
//开启chart按钮
	var flag1=false;
	var flag2=false;
	$("#startChartButton").click(function(){
		if(flag==true){
			flag=false;
			$("#startChartButton").val("继续");
		}else{
			flag=true;
			$("#startChartButton").val("暂停");
		}
	});

var isDoingStop=false;//定义标记 如果bonnie执行了stop按钮，则设置为true
//获取开始时间和结束时间
$("#startButton").click(function(){
	 var testRecordId=${webSearch.testRecordId};
	 $.ajax({
			async:true,
			type:"post",
			url:"modifyStartTime.do",
			data:{testRecordId:testRecordId},
			dataType:"text",
			success:function(returned){
				 $("#startTime").val(returned);
			}	
		});
});
$("#endButton").click(function(){
	 var testRecordId=${webSearch.testRecordId};
	 $.ajax({
			async:true,
			type:"post",
			url:"modifyEndTime.do",
			data:{testRecordId:testRecordId},
			dataType:"text",
			success:function(returned){
				$("#endTime").val(returned);
			}	
		});
});
/**
 * ajax控制判断所有按钮的状态 enable/disable
 */
 setInterval(function() {
		$.ajax({
			async:true,
			type:"post",
			url:"getAppStatus.do",
			data:{},
			dataType:"json",
			success:function(returned){  
					 if(returned.length==1){
							$("#webSearchButton").attr("disabled", returned[0].webSearch);
							$("#webSearchAverButton").attr("disabled", returned[0].webSearch);
							flag1=returned[0].webSearch;
							$("#webServerButton").attr("disabled", returned[0].webServer); 
							$("#webServerAverButton").attr("disabled", returned[0].webServer); 
							flag2=returned[0].webServer;
							$("#memcachedButton").attr("disabled", returned[0].memcached);
							$("#memcachedAverButton").attr("disabled", returned[0].memcached);
							$("#siloButton").attr("disabled", returned[0].silo);
							$("#siloAverButton").attr("disabled", returned[0].silo);
							$("#cassandraButton").attr("disabled", returned[0].cassandra);
							$("#cassandraAverButton").attr("disabled", returned[0].cassandra);
							$("#xapianButton").attr("disabled", returned[0].xapian);
							$("#xapianAverButton").attr("disabled", returned[0].xapian);
							$("#redisButton").attr("disabled", returned[0].redis);
							$("#redisAverButton").attr("disabled", returned[0].redis);
							if(isDoingStop==false){ 
								$("#bonnieButton").attr("disabled", returned[0].bonnie);
								$("#bonnieAverButton").attr("disabled",!returned[0].bonnie);
							}
							$("#scimarkButton").attr("disabled", returned[0].scimark);
							$("#hadoopButton").attr("disabled", returned[0].hadoop);
							$("#dwarfButton").attr("disabled", returned[0].dwarf);
							
					 } 
					//to do
					/*遍历json数组，获取并判断每个应有的状态，为true 则disable的按钮 为false 则相反*/ 
			}	
		});
},200);
 
/**
 * 8个应用正式测试和基准测试的控制按钮动作
 */
 //webSearch
$("#webSearchButton").click(function(){
	$("#webSearchButton").attr("disabled",true);
	$("#webSearchAverButton").attr("disabled",true);
	flag1=true;
		    $.ajax({
				async:true,
				type:"post",
				url:"executeWebSearchApp.do",
				data:{isBase:0},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
$("#webSearchAverButton").click(function(){
	$("#webSearchButton").attr("disabled",true);
	$("#webSearchAverButton").attr("disabled",true);
	flag1=true;
    $.ajax({
		async:true,
		type:"post",
		url:"executeWebSearchApp.do",
		data:{isBase:1},
		dataType:"text",
		success:function(returned){ 
		}	
	});
});
//webServer
$("#webServerButton").click(function(){
	$("#webServerButton").attr("disabled",true);
	$("#webServerAverButton").attr("disabled",true);
	flag2=true;
		    $.ajax({
				async:true,
				type:"post",
				url:"executeWebServerApp.do",
				data:{isBase:0},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
$("#webServerAverButton").click(function(){
	$("#webServerButton").attr("disabled",true);
	$("#webServerAverButton").attr("disabled",true);
	flag2=true;
    $.ajax({
		async:true,
		type:"post",
		url:"executeWebServerApp.do",
		data:{isBase:1},
		dataType:"text",
		success:function(returned){ 
		}	
	});
});
//memcached
$("#memcachedButton").click(function(){
	$("#memcachedButton").attr("disabled",true);
	$("#memcachedAverButton").attr("disabled",true);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeMemcachedApp.do",
				data:{isBase:0},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
$("#memcachedAverButton").click(function(){
	$("#memcachedButton").attr("disabled",true);
	$("#memcachedAverButton").attr("disabled",true);
    $.ajax({
		async:true,
		type:"post",
		url:"executeMemcachedApp.do",
		data:{isBase:1},
		dataType:"text",
		success:function(returned){ 
		}	
	});
});
//silo
$("#siloButton").click(function(){
	$("#siloButton").attr("disabled",true);
	$("#siloAverButton").attr("disabled",true);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeSiloApp.do",
				data:{isBase:0},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
$("#siloAverButton").click(function(){
	$("#siloAverButton").attr("disabled",true);
	$("#siloAverButton").attr("disabled",true);
    $.ajax({
		async:true,
		type:"post",
		url:"executeSiloApp.do",
		data:{isBase:1},
		dataType:"text",
		success:function(returned){ 
		}	
	});
});
//Cassandra
$("#cassandraButton").click(function(){
	$("#cassandraButton").attr("disabled",true);
	$("#cassandraAverButton").attr("disabled",true);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeCassandraApp.do",
				data:{isBase:0},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
$("#cassandraAverButton").click(function(){
	$("#cassandraButton").attr("disabled",true);
	$("#cassandraAverButton").attr("disabled",true);
	    $.ajax({
			async:true,
			type:"post",
			url:"executeCassandraApp.do",
			data:{isBase:1},
			dataType:"text",
			success:function(returned){ 
			}	
		});
});
//xapian
$("#xapianButton").click(function(){
	$("#xapianButton").attr("disabled",true);
	$("#xapianAverButton").attr("disabled",true);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeXapianApp.do",
				data:{isBase:0},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
$("#xapianAverButton").click(function(){
	$("#xapianAverButton").attr("disabled",true);
	$("#xapianAverButton").attr("disabled",true);
    $.ajax({
		async:true,
		type:"post",
		url:"executeXapianApp.do",
		data:{isBase:1},
		dataType:"text",
		success:function(returned){ 
		}	
	});
});
$("#redisButton").click(function(){
	$("#redisButton").attr("disabled",true);
	$("#redisAverButton").attr("disabled",true);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeRedisApp.do",
				data:{isBase:0},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
$("#redisAverButton").click(function(){
	$("#redisAverButton").attr("disabled",true);
	$("#redisAverButton").attr("disabled",true);
    $.ajax({
		async:true,
		type:"post",
		url:"executeRedisApp.do",
		data:{isBase:1},
		dataType:"text",
		success:function(returned){ 
		}	
	});
});
//startBonnie
$("#bonnieButton").click(function(){
	$("#bonnieButton").attr("disabled",true);
	$("#bonnieAverButton").attr("disabled",false);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeBonnieApp.do",
				data:{},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
//shutdownBonnie
$("#bonnieAverButton").click(function(){ 
	$("#bonnieAverButton").attr("disabled",true);
	$("#bonnieButton").attr("disabled",false);
	isDoingStop=true;
		    $.ajax({
				async:true,
				type:"post",
				url:"shutdownBonnieApp.do",
				data:{},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
//scimark
$("#scimarkButton").click(function(){
	$("#scimarkButton").attr("disabled",true);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeScimarkApp.do",
				data:{},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
//scimark
$("#dwarfButton").click(function(){
	$("#dwarfButton").attr("disabled",true);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeDwarfApp.do",
				data:{},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});
//Hadoop
$("#hadoopButton").click(function(){
	$("#hadoopButton").attr("disabled",true);
		    $.ajax({
				async:true,
				type:"post",
				url:"executeHadoopApp.do",
				data:{},
				dataType:"text",
				success:function(returned){ 
				}	
			});
});

</script>
<script type="text/javascript">
var flag=false;
$(document).ready(function (){
    Highcharts.setOptions({
        global: {
            useUTC: false
        }
    });
    /**
    * solrCloud
    */
    Highcharts.chart('chart1', {
        chart: {
            type: 'scatter',
            animation: Highcharts.svg, // don't animate in old IE
            marginRight: 10,
            events: {
                load: function () {
                    // set up the updating of the chart each second
                    var series = this.series[0];
                    var a=null;
                    setInterval(function (){
                    	if(flag1==true){  
			                $.ajax({
								async:true,
								type:"post",
								url:"getWebSearchQueryTime.do",
								data:{},
								dataType:"text",
								success:function(returned){
									 a=returned;
								}	
							});
			               if(a!=null){
			            		x=(new Date()).getTime(); // current time
	  							y=parseFloat(a);           
				                series.addPoint([x,y], true, true); 
			               }
                    	}
                    },1000);
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
        title: {
            text: 'webSearch服务响应时间'
        },
        xAxis: {
            type: 'datetime',
            tickPixelInterval: 150
        },
        yAxis: {
            title: {
                text: 'queryTime'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
           
        },
        tooltip: {
            formatter: function () {
                return '<b>' + this.series.name + '</b><br/>' +
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                    Highcharts.numberFormat(this.y,0)+'ms';
            }
        },
        legend: {
            enabled: false
        },
        exporting: {
            enabled: false
        },
        series:[${solrCloudStr}]
    });
    /**
     * webServer
     */
    Highcharts.chart('chart2', {
        chart: {
            type: 'scatter',
            animation: Highcharts.svg, // don't animate in old IE
            marginRight: 10,
            events: {
                load: function () {
                    // set up the updating of the chart each second
                    var series = this.series[0];
                    var a=null;
                    setInterval(function (){
                    	if(flag2==true){  
			                $.ajax({
								async:true,
								type:"post",
								url:"getWebServerQueryTime.do",
								data:{},
								dataType:"text",
								success:function(returned){
									 a=returned;
								}	
							});
			                if(a!=null){
			            		x=(new Date()).getTime(); // current time
	  							y=parseFloat(a);    
			            		if(y>0){
			            			 series.addPoint([x,y], true, true); 
			            		}
				              
			               }
                    	}
                    },1000);
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
        title: {
            text: 'webServer服务响应时间'
        },
        xAxis: {
            type: 'datetime',
            tickPixelInterval: 150,
        },
        yAxis: {
            title: {
                text: 'queryTime'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
           
        },
        tooltip: {
            formatter: function () {
                return '<b>' + this.series.name + '</b><br/>' +
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                    Highcharts.numberFormat(this.y,0)+'ms';
            }
        },
        legend: {
            enabled: false
        },
        exporting: {
            enabled: false
        },
        series:[${webServerStr}]
    });
 });
</script>
</body>
</html>
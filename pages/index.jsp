<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>课题五展示-混合负载基准SDCBench 1.0</title>  
    <link rel="stylesheet" href="statics/css/pintuer.css">
    <link rel="stylesheet" href="statics/css/admin.css">
</head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
  <div class="logo margin-big-left fadein-top">
    <h1>课题5展示系统-混合负载基准SDCbench 1.0</h1>
  </div>
    <div class="logo fadein-top" style="position: absolute; right:0px;">
    <img alt="" src="statics/images/logo.png" width="288" height="60">
  </div>
  <!-- <div class="head-l" style="color:#fff;font-size:17px;position: absolute; right:150px;top:20px">当前测试记录: <span id="recordValue"></span></div> -->
</div>
<div class="leftnav">
  <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
  <h2><span class="icon-user"></span>测试管理</h2>
  <ul style="display:block">
    <li><a href="searchRecord.do?page=1" target="right"><span class="icon-caret-right"></span>测试记录</a></li>
    <li><a href="addRecordBefore.do" target="right"><span class="icon-caret-right"></span>添加测试</a></li>
  </ul>
    <h2><span class="icon-user"></span>资源监控</h2>
    <ul style="display:block">
        <li><a href="phyMoniter.do?no=1" target="right"><span class="icon-caret-right"></span>物理机1实时监控</a></li>
        <li><a href="phyMoniter.do?no=2" target="right"><span class="icon-caret-right"></span>物理机2实时监控</a></li>
        <li><a href="containerMonitor.do" target="right"><span class="icon-caret-right"></span>容器资源监控</a></li>
        <li><a href="appMonitor.do" target="right"><span class="icon-caret-right"></span>应用资源监控</a></li>
    </ul>
    <h2><span class="icon-user"></span>历史查询</h2>
    <ul style="display:block">
        <li><a href="searchSysHistoryDataBefore.do" target="right"><span class="icon-caret-right"></span>物理机资源使用</a></li>
        <li><a href="searchAppHistoryDataBefore.do" target="right"><span class="icon-caret-right"></span>应用资源使用</a></li>
        <li><a href="searchContainerHistoryDataBefore.do" target="right"><span class="icon-caret-right"></span>容器资源使用</a></li>
        
	</ul>
  
</div>
<script src="statics/js/jquery.js"></script>
<script type="text/javascript">
	setInterval(function() {
		$.ajax({
			async:true,
			type:"post",
			url:"getCurRecordId.do",
			data:{},
			dataType:"text",
			success:function(returned){  
					 if(returned!="0"){
							document.getElementById("recordValue").innerHTML=returned; 
					 } 
					 
			}	
		});
},3000);
$(function(){
  $(".leftnav h2").click(function(){
	  $(this).next().slideToggle(200);	
	  $(this).toggleClass("on"); 
  })
  
  $(".bcd ").click(function(){
	  $(this).next("ul").slideToggle(200);	
	  $(this).toggleClass("on"); 
  })
  
 
  $(".leftnav ul li a").click(function(){
	    $("#a_leader_txt").text($(this).text());
  		$(".leftnav ul li a").removeClass("on");
		$(this).addClass("on");
  })
});
</script>
<ul class="bread">
  <li><a href="{:U('Index/info')}" target="right" class="icon-home"> 首页</a></li>
  <li><a href="##" id="a_leader_txt">管理中心</a></li>
  <li style="font-size:15px;position: absolute; right:150px;color:black"><strong>当前测试记录:</strong> <span id="recordValue"></span></li>
<!--     <div class="head-l" style="color:#fff;font-size:17px;position: absolute; right:150px;top:20px">当前测试记录: <span id="recordValue"></span></div> -->
  <!--<li><b>当前用户：</b><span style="color:red;">yanan</span>-->
</ul>
<div class="admin">
  <iframe scrolling="auto" rameborder="0" src="searchRecord.do?page=1" name="right" width="100%" height="100%"></iframe>
</div>
</body>
</html>
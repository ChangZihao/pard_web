<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<!--部署方案配置-->
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

    <link rel="stylesheet" type="text/css" href="statics/css/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="statics/css/style.css" />

    <link href="statics/css/webuploader.css" rel="stylesheet" type="text/css" />

</head>
<body>
<div >
    <ul class="nav nav-tabs" >
        <li class="active" style="float: left;">
             <a  href="#home" id="onlineControl">在线服务</a>
        </li>
        <li class="" style="float: left;">
            <a  href="#" id="offlineControl">离线服务</a>
        </li>
    </ul>

</div>
<div>
    <div class="new-page-container" >
        <form action="modifyAppConfig.do" method="post" class="form form-horizontal" id="appConfig-form">
           <!--在线-->
            <div id="online">
               <div class="row cl">
                   <label class="col-xs-4 col-sm-2 new-center"></label>
                   <label class="col-xs-4 new-col-sm-2 new-center1">请求总数</label>
                   <label class="col-xs-4 new-col-sm-2 new-center1">预热次数</label>
                   <label class="col-xs-4 new-col-sm-2 new-center1">请求策略</label>
                   <label class="col-xs-4 new-col-sm-2 new-center1" style="margin-left:-20px;">间隔单位/ms</label>
                   <label class="col-xs-4 new-col-sm-2 new-center1">启用状态</label>
               </div>
               <div class="row cl">
                   <label class="form-label col-xs-4 col-sm-2">webSearch：</label> 
                    <div class="formControls col-xs-8 col-sm-9"> 
                       <input  class="input new-w50 new-col-sm-2"  type="text"  value="${webSearch.requestCount}" id="config1-1" name="requestCount" >
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2"  type="text"  value="${webSearch.warmUpCount}" id="config1-2" name="warmUpCount">
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${webSearch.pattern}" placeholder="定值/均匀/指数/泊松" id="config1-3" name="pattern" >
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${webSearch.intensity}" id="config1-4" name="intensity">
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${webSearch.testRecordId}" id="config1-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${webSearch.applicationName}" id="config1-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${webSearch.enable}" id="config1-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${webSearch.applicationType}" id="config1-8" name="applicationType">
                          <c:choose>
							<c:when test="${webSearch.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config1">
							</c:when>
							<c:otherwise>
								<input style="background:#22cc77;margin-left:40px;" type="button" class="config" value="开启" id="config1">
							</c:otherwise>
						</c:choose> 
                   </div> 
               </div>
               <div class="row cl">
                   <label class="form-label col-xs-4 col-sm-2">webServer：</label>
                   <div class="formControls col-xs-8 col-sm-9">
                       <input class="input new-w50 new-col-sm-2" type="text"  value="${webServer.requestCount}" id="config2-1" name="requestCount" >
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${webServer.warmUpCount}" id="config2-2" name="warmUpCount">
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${webServer.pattern}" placeholder="定值/均匀/指数/泊松" id="config2-3" name="pattern" >
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${webServer.intensity}" id="config2-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${webServer.testRecordId}" id="config2-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${webServer.applicationName}" id="config2-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${webServer.enable}" id="config2-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${webServer.applicationType}" id="config2-8" name="applicationType">
                          <c:choose>
							<c:when test="${webServer.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config2">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config2">
							</c:otherwise>
						</c:choose>                    
						</div>
               </div>
               <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">cassandra：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input class="input new-w50 new-col-sm-2" type="text"  value="${cassandra.requestCount}" id="config8-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${cassandra.warmUpCount}" id="config8-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${cassandra.pattern}" placeholder="定值/均匀/指数/泊松" id="config8-3" name="pattern" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${cassandra.intensity}" id="config8-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${cassandra.testRecordId}" id="config8-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${cassandra.applicationName}" id="config8-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${cassandra.enable}" id="config8-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${cassandra.applicationType}" id="config8-8" name="applicationType">
                          <c:choose>
							<c:when test="${cassandra.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config8">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config8">
							</c:otherwise>
						</c:choose>                    
					</div>
                </div> 
                 <div class="row cl">
                   <label class="form-label col-xs-4 col-sm-2">redis:</label>
                   <div class="formControls col-xs-8 col-sm-9">
                       <input class="input new-w50 new-col-sm-2" type="text"  value="${redis.requestCount}" placeholder="" id="config10-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${redis.warmUpCount}" placeholder="" id="config10-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${redis.pattern}" readonly="true" id="config10-3" name="pattern" >
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${redis.intensity}" placeholder="" id="config10-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${redis.testRecordId}" id="config10-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${redis.applicationName}" id="config10-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${redis.enable}" id="config10-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${redis.applicationType}" id="config10-8" name="applicationType">
                          <c:choose>
							<c:when test="${redis.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config10">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config10">
							</c:otherwise>
						</c:choose>   
					</div>
               </div>
               <div class="row cl">
                   <label class="col-xs-4 col-sm-2 new-center"></label>
                   <label class="col-xs-4 new-col-sm-2 new-center1" >请求总数</label>
                   <label class="col-xs-4 new-col-sm-2 new-center1">预热次数</label>
                   <label class="col-xs-4 new-col-sm-2 new-center1">请求策略</label>
                   <label class="col-xs-4 new-col-sm-2 new-center1">QPS</label>
                   <label class="col-xs-4 new-col-sm-2 new-center1" style="margin-left:-20px;">启用状态</label>
               </div>
               <div class="row cl">
                   <label class="form-label col-xs-4 col-sm-2">memcached:</label>
                   <div class="formControls col-xs-8 col-sm-9">
                      <input  class="input new-w50 new-col-sm-2" type="text"  value="${memcached.requestCount}" id="config3-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${memcached.warmUpCount}" id="config3-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${memcached.pattern}" readonly="true" id="config3-3" name="pattern" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${memcached.intensity}" id="config3-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${memcached.testRecordId}" id="config3-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${memcached.applicationName}" id="config3-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${memcached.enable}" id="config3-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${memcached.applicationType}" id="config3-8" name="applicationType">
                          <c:choose>
							<c:when test="${memcached.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config3">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config3">
							</c:otherwise>
						</c:choose>                      
					</div>
               </div>
               <div class="row cl">
                   <label class="form-label col-xs-4 col-sm-2">silo:</label>
                   <div class="formControls col-xs-8 col-sm-9">
                       <input class="input new-w50 new-col-sm-2" type="text"  value="${silo.requestCount}" placeholder="" id="config4-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${silo.warmUpCount}" placeholder="" id="config4-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${silo.pattern}" readonly="true" id="config4-3" name="pattern" >
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${silo.intensity}" placeholder="" id="config4-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${silo.testRecordId}" id="config4-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${silo.applicationName}" id="config4-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${silo.enable}" id="config4-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${silo.applicationType}" id="config4-8" name="applicationType">
                          <c:choose>
							<c:when test="${silo.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config4">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config4">
							</c:otherwise>
						</c:choose>   
					</div>
               </div>
               <div class="row cl">
                   <label class="form-label col-xs-4 col-sm-2">xapian:</label>
                   <div class="formControls col-xs-8 col-sm-9">
                       <input class="input new-w50 new-col-sm-2" type="text"  value="${xapian.requestCount}" placeholder="" id="config9-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${xapian.warmUpCount}" placeholder="" id="config9-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${xapian.pattern}" readonly="true" id="config9-3" name="pattern" >
                       <input style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${xapian.intensity}" placeholder="" id="config9-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${xapian.testRecordId}" id="config9-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${xapian.applicationName}" id="config9-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${xapian.enable}" id="config9-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${xapian.applicationType}" id="config9-8" name="applicationType">
                          <c:choose>
							<c:when test="${xapian.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config9">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config9">
							</c:otherwise>
						</c:choose>   
					</div>
               </div>
              
           </div>

            <!--离线-->
            <div id="offline" style="display:none;">
                <div class="row cl">
                    <label class="col-xs-4 col-sm-2 new-center"></label> 
                    <label class="col-xs-4 new-col-sm-2 new-center1">读取操作</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">写入操作</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">负载策略</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" style="margin-left:-20px;">读写块大小/MB</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" >启用状态</label>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">bonnie：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                       <input  class="input new-w50 new-col-sm-2" type="text"  value="${bonnie.requestCount}" readonly="true" placeholder="按块读取" id="config5-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${bonnie.warmUpCount}" readonly="true" placeholder="按块写入" id="config5-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${bonnie.pattern}" readonly="true" id="config5-3" name="pattern" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${bonnie.intensity}" placeholder="单位:MB" id="config5-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${bonnie.testRecordId}" id="config5-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${bonnie.applicationName}" id="config5-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${bonnie.enable}" id="config5-7" name="enable">
                   	   <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${bonnie.applicationType}" id="config5-8" name="applicationType">
                   <c:choose>
							<c:when test="${bonnie.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config5">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config5">
							</c:otherwise>
						</c:choose>
                   </div>
                </div>
                <div class="row cl">
                    <label class="col-xs-4 col-sm-2 new-center"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">负载策略</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" style="margin-left:-20px;">线程数量</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">启用状态</label>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">scimark：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                       <input  class="input new-w50 new-col-sm-2" type="text"  value="${scimark.requestCount}" readonly="true" placeholder="" id="config6-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${scimark.warmUpCount}" readonly="true" placeholder="" id="config6-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${scimark.pattern}" readonly="true" id="config6-3" name="pattern" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${scimark.intensity}" placeholder="" id="config6-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${scimark.testRecordId}" id="config6-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${scimark.applicationName}" id="config6-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${scimark.enable}" id="config6-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${scimark.applicationType}" id="config6-8" name="applicationType">
                          <c:choose>
							<c:when test="${scimark.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config6">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config6">
							</c:otherwise>
						</c:choose>                     
					</div>
                </div>
                <div class="row cl">
                    <label class="col-xs-4 col-sm-2 new-center"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1"></label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">负载类型</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1" style="margin-left:-20px;">reduce数</label>
                    <label class="col-xs-4 new-col-sm-2 new-center1">启用状态</label>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">hadoop：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                       <input class="input new-w50 new-col-sm-2" type="text"  value="${hadoop.requestCount}" readonly="true" placeholder="" id="config7-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${hadoop.warmUpCount}" readonly="true" placeholder="" id="config7-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${hadoop.pattern}" placeholder="IO密集型/CPU密集型/综合" id="config7-3" name="pattern" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${hadoop.intensity}" placeholder="" id="config7-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${hadoop.testRecordId}" id="config7-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${hadoop.applicationName}" id="config7-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${hadoop.enable}" id="config7-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${hadoop.applicationType}" id="config7-8" name="applicationType">
                          <c:choose>
							<c:when test="${hadoop.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config7">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config7">
							</c:otherwise>
						</c:choose>                         
					</div>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">bigDataDwarf：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                       <input class="input new-w50 new-col-sm-2" type="text"  value="${dwarf.requestCount}" readonly="true" placeholder="" id="config11-1" name="requestCount" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${dwarf.warmUpCount}" readonly="true" placeholder="" id="config11-2" name="warmUpCount">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text"  value="${dwarf.pattern}" placeholder="IO密集型/CPU密集型/综合" id="config11-3" name="pattern" >
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="text" value="${dwarf.intensity}" placeholder="" id="config11-4" name="intensity">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${dwarf.testRecordId}" id="config11-5" name="testRecordId">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${dwarf.applicationName}" id="config11-6" name="applicationName">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${dwarf.enable}" id="config11-7" name="enable">
                       <input  style="margin-left:20px; " class="input new-w50 new-col-sm-2" type="hidden"  value="${dwarf.applicationType}" id="config11-8" name="applicationType">
                          <c:choose>
							<c:when test="${dwarf.enable==1}">
								<input style="margin-left:40px;" type="button" class="config" value="禁用" id="config11">
							</c:when>
							<c:otherwise>
								<input style="margin-left:40px; background:#22cc77;" type="button" class="config" value="开启" id="config11">
							</c:otherwise>
						</c:choose>                         
					</div>
                </div>
                
                <div class="row cl">
                    <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
                        <button style="float: right;" onclick="save();" class="btn btn-primary radius" ><i class="Hui-iconfont">&#xe632;</i>保存</button>
                    </div>
                </div>
            </div>



        </form>
    </div>
</div>

<script src="statics/js/jquery.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
   	
        $('#offlineControl').click(function(){
            $("#online").hide();   //隐藏
            $("#offline").show();
            })

            $("#onlineControl").click(function(){
                $("#online").show();   //隐藏
                $("#offline").hide();
            })
            


        //禁用与启动部分
        $("#config1").click(function(){
            if ($("#config1").val()=="禁用")
            { 
            	$("#config1").css("background","#22cc77");
                $("#config1").val("开启");
                $("#config1-7").val("0"); 
            }
            else if ($("#config1").val()=="开启")
            { 
            	$("#config1").css("background","#21A1D3");
                $("#config1").val("禁用"); 
                $("#config1-7").val("1");
            }
        })
        $("#config2").click(function(){
            if ($("#config2").val()=="禁用")
            { 
            	$("#config2").css("background","#22cc77");
                $("#config2").val("开启");
                $("#config2-7").val("0");
            }
            else if ($("#config2").val()=="开启")
            { 
            	$("#config2").css("background","#21A1D3");
                $("#config2").val("禁用"); 
                $("#config2-7").val("1");
            }
        })
        $("#config3").click(function(){
            if ($("#config3").val()=="禁用")
            { 
            	$("#config3").css("background","#22cc77");
                $("#config3").val("开启");
                $("#config3-7").val("0");
            }
            else if ($("#config3").val()=="开启")
            { 
            	$("#config3").css("background","#21A1D3");
                $("#config3").val("禁用"); 
                $("#config3-7").val("1");
            }
        })
        $("#config4").click(function(){
            if ($("#config4").val()=="禁用")
            { 
            	$("#config4").css("background","#22cc77");
                $("#config4").val("开启");
                $("#config4-7").val("0");
            }
            else if ($("#config4").val()=="开启")
            { 
            	$("#config4").css("background","#21A1D3");
                $("#config4").val("禁用"); 
                $("#config4-7").val("1");
            }
        })
        $("#config5").click(function(){
            if ($("#config5").val()=="禁用")
            { 
            	$("#config5").css("background","#22cc77");
                $("#config5").val("开启");
                $("#config5-7").val("0");
            }
            else if ($("#config5").val()=="开启")
            { 
            	$("#config5").css("background","#21A1D3");
                $("#config5").val("禁用"); 
                $("#config5-7").val("1");
            }
        })
        $("#config6").click(function(){
            if ($("#config6").val()=="禁用")
            { 
            	$("#config6").css("background","#22cc77");
                $("#config6").val("开启");
                $("#config6-7").val("0");
            }
            else if ($("#config6").val()=="开启")
            { 
            	$("#config6").css("background","#21A1D3");
                $("#config6").val("禁用"); 
                $("#config6-7").val("1");
            }
        })
        $("#config7").click(function(){
            if ($("#config7").val()=="禁用")
            { 
            	$("#config7").css("background","#22cc77");
                $("#config7").val("开启");
                $("#config7-7").val("0");
            }
            else if ($("#config7").val()=="开启")
            { 
            	$("#config7").css("background","#21A1D3");
                $("#config7").val("禁用"); 
                $("#config7-7").val("1");
            }
        })
        $("#config8").click(function(){
            if ($("#config8").val()=="禁用")
            { 
            	$("#config8").css("background","#22cc77");
                $("#config8").val("开启");
                $("#config8-7").val("0");
            }
            else if ($("#config8").val()=="开启")
            { 
            	$("#config8").css("background","#21A1D3");
                $("#config8").val("禁用"); 
                $("#config8-7").val("1");
            }
        })
        $("#config9").click(function(){
            if ($("#config9").val()=="禁用")
            { 
            	$("#config9").css("background","#22cc77");
                $("#config9").val("开启");
                $("#config9-7").val("0");
            }
            else if ($("#config9").val()=="开启")
            { 
            	$("#config9").css("background","#21A1D3");
                $("#config9").val("禁用"); 
                $("#config9-7").val("1");
            }
        }) 
        $("#config10").click(function(){
            if ($("#config10").val()=="禁用")
            { 
            	$("#config10").css("background","#22cc77");
                $("#config10").val("开启");
                $("#config10-7").val("0");
            }
            else if ($("#config10").val()=="开启")
            { 
            	$("#config10").css("background","#21A1D3");
                $("#config10").val("禁用"); 
                $("#config10-7").val("1");
            }
        })
        $("#config11").click(function(){
            if ($("#config11").val()=="禁用")
            { 
            	$("#config11").css("background","#22cc77");
                $("#config11").val("开启");
                $("#config11-7").val("0");
            }
            else if ($("#config11").val()=="开启")
            { 
            	$("#config11").css("background","#21A1D3");
                $("#config11").val("禁用"); 
                $("#config11-7").val("1");
            }
        })
    });
    function save(){
    	$("#appConfig-form").submit();

    }
</script>

</body>
</html>
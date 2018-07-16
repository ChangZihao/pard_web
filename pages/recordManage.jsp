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
    <title></title>
    <link rel="stylesheet" href="statics/css/pintuer.css">
    <link rel="stylesheet" href="statics/css/admin.css">
    <script src="statics/js/jquery.js"></script>
    <script src="statics/js/pintuer.js"></script>
</head>
<body>
<form method="post" action="" id="listform">
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 测试记录</strong> <a href="" style="float:right; display:none;">添加字段</a></div>
        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">
                <li> <a class="button border-main icon-plus-square-o" href="addRecordBefore.do"> 添加测试</a> </li>
                <li>
                    <input type="text" placeholder="请输入搜索关键字" name="keywords" class="input" style="width:250px; line-height:17px;display:inline-block" />
                    <a class="button border-main icon-search" > 搜索</a>
                </li>
                <li style="padding-right:10px;"><span class="r">共有数据：<strong>${totalCount}</strong> 条</span></li>
            </ul>
        </div>
        <table class="table table-hover text-center">
            <tr>
                <th width="10%">测试编号</th>
                <th width="30%x">描述</th>
                <th width="20%">开始时间</th>
                <th width="20%">截止时间</th>
                <th width="20%">操作</th>
                
            </tr>
            <c:forEach var="item" items="${recordList}">
            <tr>
            <td >${item.autoId}</td>
            <td >${item.recordDesc}</td>
            <td >${item.startTime}</td>
            <td >${item.endTime}</td>
            <td >
            <a href="getAppConfig.do?testRecordId=${item.autoId}"><input type="button" class="editButton" value="配置"></a>
            <a href="jobSchedulBefore.do?testRecordId=${item.autoId}"><input type="button" class="controlButton" value="控制"></a>
            <a href="resultAnalysis.do?testRecordId=${item.autoId}"><input type="button" class="viewButton" value="查看"></a>
            </td>
            
            </tr>
            </c:forEach>
            <tr>
                <td colspan="8"><div class="pagelist"> 
                     <c:choose>
							<c:when test="${curPage==1}">
								<a>上一页</a>
							</c:when>
							<c:otherwise>
								<a href="${prePageHref}">上一页</a>
							</c:otherwise>
						</c:choose>
						&nbsp;&nbsp;${curPage}/${maxPage}&nbsp;&nbsp;
						<c:choose>
							<c:when test="${curPage==maxPage}">
								<a>下一页</a>
							</c:when>
							<c:otherwise>
								<a href="${nextPageHref}">下一页</a>
							</c:otherwise>
						</c:choose>
						 </div></td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>
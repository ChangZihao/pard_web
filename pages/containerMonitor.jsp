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
<title>容器资源使用表</title>
<link rel="stylesheet" href="statics/css/pintuer.css">
<link rel="stylesheet" href="statics/css/admin.css">
<link rel="stylesheet" href="statics/css/physical.css">

<script type="text/javascript" src="statics/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="statics/js/highcharts.js"></script>
<script type="text/javascript" src="statics/js/highcharts-more.js"></script>
<script type="text/javascript">
	//实时数据表格
	var returnedData = null; 
	var lastTime = null;
	setInterval(function() {
		$.ajax({
			async : true,
			type : "post",
			url : "getContainerResourceUse.do",
			data : {},
			dataType : "json",
			success : function(returned) { 
				if (returned != null && returned != "" && returned != "null") { 
					returnedData = returned;  
					console.log(returned)
					ajaxTable();
				}
			}
		});
	}, 3000);

	//实时数据表格
	var tableTitle = "<table  class=\"table table-hover text-center\" >"
				+ "<tr><th width= \"200px\">容器名称</th><th width = \"340px\">CPU使用率/core</th><th  width = \"340px\">内存使用率(0,1)</th><th  width = \"340px\">内存使用量</th>"
				+ "<th  width = \"340px\">NET I/O</th><th  width = \"340px\">BLOCK I/O</th>"
				+ "</tr>"; 
	var tableContent = "";
	var tableClass = "";

	var containerName = null;
	var cpuusagerate = null;
	var memusagerate = null;
	var memamount = null;
	var netinput = null;
	var netoutput = null;
	var ioinput = null;
	var iooutput = null;
	var realTable = null;
	function ajaxTable() { 
		if (returnedData.length > 0) {
			if (lastTime == null) {
				for (var i = 0; i < returnedData.length; i++) {
					if (returnedData[i] != null && returnedData[i] != "") {
						containerName = returnedData[i].containername;
						cpuusagerate = returnedData[i].cpuusagerate ;
						memusagerate = returnedData[i].memusagerate ;
						memamount = returnedData[i].memusageamount;
						netinput = returnedData[i].netinput;
						netoutput = returnedData[i].netoutput;
						ioinput = returnedData[i].ioinput;
						iooutput = returnedData[i].iooutput;
						//第一次添加
						tableContent += "<tr align='center'  >" + "<td>"
								+ containerName + "</td>" + "<td>"
								+ cpuusagerate + "</td>" + "<td>"
								+ memusagerate + "</td>" + "<td>" + memamount
								+ "MB" + "</td>" + "<td>" + netinput + "MB/"
								+ netoutput + "MB" + "</td>" + "<td>" + ioinput
								+ "MB/" + iooutput + "MB" + "</td>" + "</tr>";

					}
				}
				lastTime = returnedData[0].collecttime.time; 
				realTable = tableTitle + tableContent + "</table>";
				document.getElementById('tableDiv').innerHTML = "";
				document.getElementById("tableDiv").innerHTML = realTable; 
				tableContent = "";
			}else { 
				if (lastTime < returnedData[0].collecttime.time) {
					for (var i = 0; i < returnedData.length; i++) {
						if (returnedData[i] != null && returnedData[i] != "") {
							containerName = returnedData[i].containername;
							cpuusagerate = returnedData[i].cpuusagerate ;
							memusagerate = returnedData[i].memusagerate ;
							memamount = returnedData[i].memusageamount;
							netinput = returnedData[i].netinput;
							netoutput = returnedData[i].netoutput;
							ioinput = returnedData[i].ioinput;
							iooutput = returnedData[i].iooutput;
							//时间戳不同的时候添加
							tableContent += "<tr align='center'  >" + "<td>"
									+ containerName + "</td>" + "<td>"
									+ cpuusagerate + "</td>" + "<td>"
									+ memusagerate + "</td>" + "<td>" + memamount
									+ "MB" + "</td>" + "<td>" + netinput + "MB/"
									+ netoutput + "MB" + "</td>" + "<td>" + ioinput
									+ "MB/" + iooutput + "MB" + "</td>" + "</tr>";
						}
					}
					lastTime = returnedData[0].collecttime.time; 
					realTable = tableTitle + tableContent + "</table>";
					document.getElementById('tableDiv').innerHTML = "";
					document.getElementById("tableDiv").innerHTML = realTable;
					tableContent = "";
				}
		}
	}
} 
</script>

</head> 
<body> 
	<div  id ="tableDiv"  class="panel admin-panel"  style="width: 1300px;height:2000px; margin: 0 auto; background-color: #FFF;"></div>
	 
</body>

</html>

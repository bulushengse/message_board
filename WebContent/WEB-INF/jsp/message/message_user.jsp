<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/css/chosen.css" /><!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
<script type="text/javascript">
	
	//保存
	function save(){
		if($("#MESSAGE_CONTENT").val()==""){
			$("#MESSAGE_CONTENT").tips({
				side:3,
	            msg:'请输入内容',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MESSAGE_CONTENT").focus();
			return false;
		}
		
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td rowspan="3" style="width:26px;height:50px;">
						<a href="javascript:void(0);"><img src="static/images/1.jpg" /></a>
					</td> 
					<td><span><img src='static/images/yonghu.png' />${pd.USER_IP }</span></td>
			    </tr>
			    <tr>
					<td style="display:none;"></td>
				</tr>
				<tr>
					<td><span><img src='static/images/dingwei.png'/>${pd.USER_ADDRESS }</span></td>
				</tr>
			</table>
		
			<div style="text-align:center;"> <img src="static/images/shouzhi.png"/>全部留言...</div><br/>
		
		
		<c:forEach items="${messages}" var="var" varStatus="vs">
			<table id="table_report" class="table table-striped table-bordered table-hover">
			
				<tr>
					<td rowspan="3" style="width:26px;height:50px;">
						&nbsp;<fmt:formatNumber value="${var.SEQ}" type="currency" pattern="0"/><br/>
						<a href="javascript:void(0);"><img src="static/images/1.jpg" /></a>
					</td>  
					
			    </tr>
				<tr>
					<td colspan="4" style="height:80px;">${var.MESSAGE_CONTENT}</td>
				</tr>
				<tr>
					<td>${var.MESSAGE_DATE}</td>
					<%-- <td><a style="cursor:pointer;" onclick="chakan('${var.MESSAGE_ID}','${var.SEQ}','${var.USER_IP}','${var.USER_ADDRESS}','${var.MESSAGE_CONTENT}','${var.MESSAGE_DATE}','${var.ZAN_NUM}','${var.COMMENT_NUM}');" >
						<img src="static/images/chakan.png"/></a>(${var.COMMENT_NUM})
					</td> --%>
					<td><a style="cursor:pointer;" onclick="dianzai('${var.MESSAGE_ID}');" ><img src="static/images/xingxing.png"/></a>(<span id="${var.MESSAGE_ID}">${var.ZAN_NUM}</span>)</td>
					<%--<td><a style="cursor:pointer;" onclick="pinglun('${var.MESSAGE_ID}');" ><img src="static/images/pinglun.png"/></a></td> --%>
				</tr>
			
			</table>
			</c:forEach>	
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		function dianzai(id){
			var map = {'MESSAGE_ID':id};
			$.post('<%=basePath%>message/editZAN_NUM.do',
					map,function(msg) {  
				if (msg == 1) {
					var z = parseInt($("#"+id).html())+1
					$("#"+id).html(z)
				}
			});
		}
		
		</script>
</body>
</html>

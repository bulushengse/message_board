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
		<form action="message/goComment.do" method="post" name="Form" id="Form">
			<input type="hidden" name="PAREHT_ID" value="${pd.PAREHT_ID}">
			<input type="hidden" name="cont" value="${pd.cont}">
			<input type="hidden" name="date" value="${pd.date}">
			<input type="hidden" name="zan" value="${pd.zan}">
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td rowspan="3" style="width:26px;height:50px;">
						&nbsp;${pd.PAREHT_ID}<br/>
						<img src="static/images/1.jpg" />
					</td>  
					
			    </tr>
				<tr>
					<td colspan="4" style="height:80px;">${pd.cont}</td>
				</tr>
				<tr>
					<td>${pd.date}</td>
					<td><a style="cursor:pointer;" onclick="dianzaimi('${pd.PAREHT_ID}');" ><img src="static/images/xingxing.png"/></a>(<span id="mi">${pd.zan}</span>)</td>
				</tr>
			</table>
		
			<div style="text-align:center;"> <img src="static/images/shouzhi.png"/>全部${pd.num }条评论...</div><br/>
		
		
		<c:forEach items="${messages}" var="var" varStatus="vs">
			<table id="table_report" class="table table-striped table-bordered table-hover">
			
				<tr>
					<td colspan="4" style="height:80px;">${var.MESSAGE_CONTENT}</td>
					<td rowspan="3" style="width:26px;height:50px;">
						&nbsp;${var.COMMENT_NUM}<br/>
						<a href="javascript:void(0);"><img src="static/images/1.jpg" /></a>
					</td> 
				</tr>
				<tr>
					<td><a style="cursor:pointer;" onclick="dianzai('${var.MESSAGE_ID}');" ><img src="static/images/xingxing.png"/></a>(<span id="${var.MESSAGE_ID}">${var.ZAN_NUM}</span>)</td>
					<td>${var.MESSAGE_DATE}</td>
				</tr>
				</table>
			</c:forEach>	
			
			<div class="page-header position-relative">
			<table style="min-width:100%;">
				<tr>
					<td style="vertical-align:top;"><div class="pagination" style="float: left;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
				</tr>
			</table>
			</div>
		</form>
		
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
		
		function dianzaimi(id){
			var map = {'MESSAGE_ID':id};
			$.post('<%=basePath%>message/editZAN_NUM.do',
					map,function(msg) {  
				if (msg == 1) {
					var z = parseInt($("#mi").html())+1
					$("#mi").html(z)
				}
			});
		}
		
		</script>
</body>
</html>

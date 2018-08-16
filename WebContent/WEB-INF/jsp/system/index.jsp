<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	<!-- jsp文件头和头部 -->
	<%@ include file="top.jsp"%>
	<style type="text/css">
	.commitopacity{position:absolute; width:100%; height:100px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.8; -khtml-opacity: 0.5; opacity: 0.5; top:0px; z-index:99999;}
	</style>
	
</head>
<body style="overflow-y:hidden;">
	<!-- 页面顶部 -->
	<div class="navbar navbar-inverse" >
		<div class="navbar-inner" >
			  <div class="container-fluid"  style="position:fixed;">
				  <div style="height:4px;"> </div>
				  <span class='label label-large label-success arrowed' id="ip"><i class="icon-user"></i>用户 &nbsp;I &nbsp;P：<img src="static/images/loadingi.gif" id="jiazai1"/></span><br/>
				  <div style="height:6px;"> </div>
				  <span class='label label-large label-success arrowed' id="address"><i class="icon-user"></i>登录地址：<img src="static/images/loadingi.gif" id="jiazai2"/></span>
				
			 </div><!--/.container-fluid-->
		</div><!--/.navbar-inner-->
	</div><!--/.navbar-->


	<!-- 页面内容 -->
	<div class="container-fluid" id="main-container">
	
			<div id="main-content" class="clearfix" >
			
			<div id="jzts" style="display:none; width:100%; position:fixed; z-index:99999999;">
			<div class="commitopacity" id="bkbgjz"></div>
			<div style="padding-left: 70%;padding-top: 1px;">
				<div style="float: left;margin-top: 3px;"><img src="static/images/loadingi.gif" /> </div>
				<div style="margin-top: 5px;"><h4 class="lighter block red">&nbsp;加载中 ...</h4></div>
			</div>
			</div>
			
			<div >
				<!-- 页面内容 -->
				<iframe name="mainFrame" id="mainFrame" frameborder="0" src="message/list.do" style="margin:0 auto;width:100%;height:100%;"></iframe>
			</div>

			<!-- 换肤 -->
			<div id="ace-settings-container">
				<div class="btn btn-app btn-mini btn-warning" id="ace-settings-btn">
					<i class="icon-cog"></i>
				</div>
				<div id="ace-settings-box">
					<div>
						<div class="pull-left">
							<select id="skin-colorpicker" class="hidden">
								<option data-class="default" value="#438EB9"
									<c:if test="${user.SKIN =='default' }">selected</c:if>>#438EB9</option>
								<option data-class="skin-1" value="#222A2D"
									<c:if test="${user.SKIN =='skin-1' }">selected</c:if>>#222A2D</option>
								<option data-class="skin-2" value="#C6487E"
									<c:if test="${user.SKIN =='skin-2' }">selected</c:if>>#C6487E</option>
								<option data-class="skin-3" value="#D0D0D0"
									<c:if test="${user.SKIN =='skin-3' }">selected</c:if>>#D0D0D0</option>
							</select>
						</div>
						<span>&nbsp; 选择皮肤</span>
					</div>
					<div>
						<button onclick="tell()">公告</button>
					</div>
				</div>
			</div>
			<!--/#ace-settings-container-->

		</div>
		<!-- #main-content -->
	</div>
	<!--/.fluid-container#main-container-->
	
	<!-- basic scripts -->
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/bootbox.min.js?aa=1"></script><!-- 确认窗口 -->
		<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
		<!--引入属于此页面的js -->
		<script type="text/javascript" src="static/js/myjs/index.js?ver=4"></script>

		<script type="text/javascript">
		window.onload = init;
		jzts();
		
		function tell(){
			bootbox.alert({ 
				  size: "small",
				  title: "温馨提示",
				  message: "富强，民主，文明，和谐，自由，平等，公正，法治，爱国，敬业，诚信，友善。<br/><br/>禁止约炮！<br/>", 
				  callback: function(){ /* your callback code */ }
			})
			
		}
		</script>
</body>
</html>

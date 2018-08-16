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
	<!-- jsp文件头和头部 -->
	<%@ include file="../system/top.jsp"%>

	</head> 
<body>
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
		<div style="position: fixed; top:55px; right:5px;" >
			
			<a href="javascript:void(0);" onclick="liuyan()" class="btn btn-mini btn-info"><img src="static/images/bi.png" /></a>
		</div>
	
		<form action="message/list.do" method="post" name="Form" id="Form">
		
		<c:forEach items="${messages}" var="var" varStatus="vs">
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td rowspan="3" style="width:26px;height:50px;">
						&nbsp;${var.MESSAGE_ID }<br/>
						<a href="javascript:void(0);" onclick="showUser('${var.USER_IP}','${var.USER_ADDRESS}')" >
						<img src="static/images/1.jpg" />查看
						</a>
					</td>  
					
			    </tr>
				<tr>
					<td colspan="4" style="height:80px;">${var.MESSAGE_CONTENT}</td>
				</tr>
				<tr>
					<td>${var.MESSAGE_DATE}</td>
					<td width="50px"><a style="cursor:pointer;;" onclick="chakan('${var.MESSAGE_ID}','${var.MESSAGE_CONTENT}','${var.MESSAGE_DATE}','${var.ZAN_NUM}','${var.COMMENT_NUM}');" >
						<img src="static/images/chakan.png"/></a>(${var.COMMENT_NUM})
					</td>
					<td width="50px"><a style="cursor:pointer;" onclick="dianzai('${var.MESSAGE_ID}','${var.ZAN_NUM}');" ><img src="static/images/xingxing.png"/></a>(<span id="${var.MESSAGE_ID}">${var.ZAN_NUM}</span>)</td>
					<td width="30px"><a style="cursor:pointer;" onclick="pinglun('${var.MESSAGE_ID}');" ><img src="static/images/pinglun.png"/></a></td>
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
   	 </div>
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
  
</div><!--/#page-content-->

</div><!--/.fluid-container#main-container-->	
 
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/bootbox.min.js?aa=1"></script><!-- 确认窗口 -->
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 --> 
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		
		<script type="text/javascript">
		$(top.hangge());
		
		function showUser(userip,address){
			
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="用户信息";
			 diag.URL = "<%=basePath%>message/goUser.do?USER_IP="+userip+"&USER_ADDRESS="+address;
			 diag.Width = 500;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				
				diag.close();
			 };
			 diag.show();
			
			
		}
		
		function chakan(id,cont,date,zan,num){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="第"+id+"条的全部评论";
			 diag.URL = "<%=basePath%>message/goComment.do?PAREHT_ID="+id+"&cont="+cont+"&date="+date+"&zan="+zan+"&num="+num;
			 diag.Width = 500;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件

				diag.close();
			 };
			 diag.show();
			
		}
		
		
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
		
		function pinglun(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="我要评论";
			 diag.URL = "<%=basePath%>message/goPinglun.do?id="+id;
			 diag.Width = 500;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage('${page.currentPage}');
				}
				diag.close();
			 };
			 diag.show();
		}
		
		
		function liuyan(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="我要留言";
			 diag.URL = "<%=basePath%>message/goLiuyan.do?tm="+new Date().getTime();
			 diag.Width = 500;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage('${page.currentPage}');
				}
				diag.close();
			 };
			 diag.show();
		}
		
		

		

		
		</script>
</body>
</html>
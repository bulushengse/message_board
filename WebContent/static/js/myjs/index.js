$(function() {
	if(typeof($.cookie('SKIN')) == "undefined"){
		hf('default');
	}else{
		var SkIN= $.cookie('SKIN');
		hf(SkIN);
	}
	
	
	//换肤
	$("#skin-colorpicker").ace_colorpicker().on("change", function() {
		var b = $(this).find("option:selected").data("class");
		hf(b);
		$.cookie('SKIN', b, { path: '/',expires: 30 });

	});
	
	
});

	
function cmainFrame() {
	var hmain = document.getElementById("mainFrame");
	var bheight = document.documentElement.clientHeight;
	hmain.style.width = '100%';
	hmain.style.height = (bheight - 51) + 'px';
	var bkbgjz = document.getElementById("bkbgjz");
	bkbgjz.style.height = (bheight - 41) + 'px';

}

cmainFrame();
window.onresize = function() {
	cmainFrame();
};
jzts();

//换肤
function hf(b) {
	var a = $(document.body);
	a.attr("class", a.hasClass("navbar-fixed") ? "navbar-fixed" : "");
	if (b != "default") {
		a.addClass(b);
	}
	if (b == "skin-1") {
		$(".ace-nav > li.grey").addClass("dark");
	} else {
		$(".ace-nav > li.grey").removeClass("dark");
	}
	if (b == "skin-2") {
		$(".ace-nav > li").addClass("no-border margin-1");
		$(".ace-nav > li:not(:last-child)").addClass("white-pink").find(
				'> a > [class*="icon-"]').addClass("pink").end().eq(0).find(
				".badge").addClass("badge-warning");
	} else {
		$(".ace-nav > li").removeClass("no-border").removeClass("margin-1");
		$(".ace-nav > li:not(:last-child)").removeClass("white-pink").find(
				'> a > [class*="icon-"]').removeClass("pink").end().eq(0).find(
				".badge").removeClass("badge-warning");
	}
	if (b == "skin-3") {
		$(".ace-nav > li.grey").addClass("red").find(".badge").addClass(
				"badge-yellow");
	} else {
		$(".ace-nav > li.grey").removeClass("red").find(".badge").removeClass(
				"badge-yellow");
	}
}

//清除加载进度
function hangge() {
	$("#jzts").hide();
}

//显示加载进度
function jzts() {
	$("#jzts").show();
}

function init() {
	//检查浏览器是否支持地理位置获取 
	if (navigator.geolocation) {
		//若支持地理位置获取,成功调用showPosition(),失败调用showError
		//alert("正在努力获取位置...");
		var config = { enableHighAccuracy: true, timeout: 5000, maximumAge: 30000 };
		navigator.geolocation.getCurrentPosition(showPosition, showError, config);

	} else {
		//alert("Geolocation is not supported by this browser.");
		alert("定位失败,用户已禁用位置获取权限");
	}
}

//地理位置获取调用成功
function showPosition(position){
	var lat = position.coords.latitude;
	var lng = position.coords.longitude;	
	//alert("您位置的纬度是："+lat+" 经度是："+lng);
	
	//GPS坐标转换腾讯地图坐标
	$.ajax({
		type: "POST",
		url: 'getLocationByGPS.do',
    	data: {'lat':lat,'lng':lng},
		dataType:'json',
		cache: false,
		success: function(data){
			//alert(JSON.stringify(data))
			$("#jiazai1").remove();
			$("#jiazai2").remove();
			
			$("#ip").append(data.ip);
			
			if(data.status1==0 && data.status2==0){
				$("#address").append(data.province+data.city+data.address)
			}else{
				$("#address").append("定位失败！")
			}
		}
	});
}

//地理位置获取调用失败
function showError(error){
	//根据IP获取腾讯地图坐标
	$.ajax({
		type: "POST",
		url: 'getLocationByIP.do',
    	data: {},
		dataType:'json',
		cache: false,
		success: function(data){
			//alert(JSON.stringify(data))
			$("#jiazai1").remove();
			$("#jiazai2").remove();
			
			$("#ip").append(data.ip);
		
			if(data.status1==0 && data.status2==0){
				$("#address").append(data.province+data.city+data.address)
			}else{
				$("#address").append("定位失败！")
			}
			
		}
	});
	
/* 	switch(error.code){
		case error.PERMISSION_DENIED:
			alert("User denied the request for Geolocation.");
			break;
		case error.POSITION_UNAVAILABLE:
 			alert("Location information is unavailable.");
			break;
		case error.TIMEOUT:
 			alert("The request to get user location timed out.");
			break;
		case error.UNKNOWN_ERROR:
 			alert("An unknown error occurred.");
			break;
	} */
};


		
		
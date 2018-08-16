package com.zhoubc.controller.system;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhoubc.controller.BaseController;
import com.zhoubc.util.https.HttpsUtil;
import com.zhoubc.util.PageData;

/** 
 * 类名称：IndexController
 * 创建人：研发中心 
 * 创建时间：2018-08-05
 */
@Controller
public class IndexController extends BaseController {
	

	/**
	 * 去主页面
	 */
	@RequestMapping(value="/index")
	public ModelAndView index(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("redirect:/main/index");
		return mv;
	}	
	
	
	/**
	 * 去主页面
	 */
	@RequestMapping(value="/main/index")
	public ModelAndView mindex(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("system/index");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	//GPS坐标转换腾讯地图坐标 并获取坐标地址描述
	@RequestMapping(value = "/getLocationByGPS",produces = {"application/text;charset=UTF-8"})
	@ResponseBody
	public Object getLocationByGPS() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = this.getRequest().getSession();
		if(session.getAttribute("ip") == null&&session.getAttribute("province") == null&&session.getAttribute("city") == null) {
			//GPS坐标转换腾讯地图坐标
			String location = HttpsUtil.httpsRequest("https://apis.map.qq.com/ws/coord/v1/translate?key=IPNBZ-44T64-PZZUL-XBOGR-TUSSE-NSBO5&type=1&locations="+pd.getString("lat")+","+pd.getString("lng"), "GET", null);
			
			JSONObject jsonObject=new JSONObject(location);
			
			//判断是否坐标转换成功
			if(jsonObject.getInt("status")==0) {
				JSONArray array=jsonObject.getJSONArray("locations");
				//System.out.println("转换后的纬度："+array.getJSONObject(0).getDouble("lat"));
		        //System.out.println("转换后的经度："+array.getJSONObject(0).getDouble("lng"));
		        //map.put("lat", array.getJSONObject(0).getDouble("lat"));
		        //map.put("lng", array.getJSONObject(0).getDouble("lng"));
		        map.put("status1",0);
		        //获取坐标位置描述
		        String address = HttpsUtil.httpsRequest("https://apis.map.qq.com/ws/geocoder/v1/?key=IPNBZ-44T64-PZZUL-XBOGR-TUSSE-NSBO5&location="+array.getJSONObject(0).getDouble("lat")+","+array.getJSONObject(0).getDouble("lng"), "GET", null);
		        
		        JSONObject jsonObject2=new JSONObject(address);

				//判断是否获取位置成功
				if(jsonObject2.getInt("status")==0) {
					JSONObject result=jsonObject2.getJSONObject("result");
					JSONObject formatted_addresses=result.getJSONObject("formatted_addresses");
					JSONObject ad_info=result.getJSONObject("ad_info");
					System.out.println("位置地址：" + ad_info.getString("province")+","+ad_info.getString("city")+","+formatted_addresses.getString("recommend"));
					map.put("address", formatted_addresses.getString("recommend"));
					map.put("province",ad_info.getString("province"));
					map.put("city",ad_info.getString("city"));
					map.put("status2",0);
				}else {
					map.put("status2",1);
				}
				
			}else {
				 map.put("status1",1);
			}
			String ip = getIP(this.getRequest());
			map.put("ip",ip);//获取IP
			saveSession(this.getRequest(),map);//ip,address保存到session
		}else {
			map.put("ip", session.getAttribute("ip"));
			map.put("address", session.getAttribute("address"));
			map.put("city", session.getAttribute("city"));
			map.put("province", session.getAttribute("province"));
			map.put("status1", 0);
			map.put("status2", 0);
		}
		net.sf.json.JSONObject json = net.sf.json.JSONObject.fromObject(map);
		System.out.println("获取用户信息："+json.toString());
		return json.toString();
	}
	
	//根据IP获取腾讯地图坐标，以及坐标描述
	@RequestMapping(value = "/getLocationByIP", produces = { "application/text;charset=UTF-8" })
	@ResponseBody
	public Object getLocationByIP() {
		//PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = this.getRequest().getSession();
		String ip = getIP(this.getRequest());
		if(session.getAttribute("ip") == null&&session.getAttribute("province") == null&&session.getAttribute("city") == null) {
			// 获取腾讯地图坐标
			String location = HttpsUtil.httpsRequest("https://apis.map.qq.com/ws/location/v1/ip?key=IPNBZ-44T64-PZZUL-XBOGR-TUSSE-NSBO5&ip="+ip, "GET", null);
			System.out.println("ip获取坐标："+location);
			JSONObject jsonObject = new JSONObject(location);

			// 判断是否坐标转换成功
			if (jsonObject.getInt("status") == 0) {
				JSONObject result = jsonObject.getJSONObject("result");
				JSONObject loca=result.getJSONObject("location");
				//System.out.println("坐标纬度：" + loca.getDouble("lat"));
				//System.out.println("坐标经度：" + loca.getDouble("lng"));
				//map.put("lat", loca.getDouble("lat"));
				//map.put("lng", loca.getDouble("lng"));
				map.put("status1", 0);
				// 获取坐标位置描述
				String address = HttpsUtil.httpsRequest("https://apis.map.qq.com/ws/geocoder/v1/?key=IPNBZ-44T64-PZZUL-XBOGR-TUSSE-NSBO5&location="+ loca.getDouble("lat") + "," + loca.getDouble("lng"),"GET", null);
				System.out.println("ip获取地址："+address);
				JSONObject jsonObject2 = new JSONObject(address);
				
				// 判断是否获取位置成功
				if (jsonObject2.getInt("status") == 0) {
					try {
						JSONObject result2 = jsonObject2.getJSONObject("result");
						JSONObject formatted_addresses = result2.getJSONObject("formatted_addresses");
						JSONObject ad_info=result2.getJSONObject("ad_info");
						System.out.println("位置地址：" + ad_info.getString("province")+","+ad_info.getString("city")+","+formatted_addresses.getString("recommend"));
						map.put("address", formatted_addresses.getString("recommend"));
						map.put("city",ad_info.getString("city"));
						map.put("province",ad_info.getString("province"));
						map.put("status2", 0);
					}catch (Exception e) {
						logger.error(e.toString(), e);
						map.put("status2", 1);
					}	
				} else {
					map.put("status2", 1);
				}
	
			} else {
				map.put("status1", 1);
			}
		
			map.put("ip",ip);//获取IP
			saveSession(this.getRequest(),map);//ip,address保存到session
		}else {
			map.put("ip", session.getAttribute("ip"));
			map.put("address", session.getAttribute("address"));
			map.put("city", session.getAttribute("city"));
			map.put("province", session.getAttribute("province"));
			map.put("status1", 0);
			map.put("status2", 0);
		}
		net.sf.json.JSONObject json = net.sf.json.JSONObject.fromObject(map);
		System.out.println("获取用户信息："+json.toString());
		return json.toString();
	}
	
	//获取IP
	public String getIP(HttpServletRequest request) {
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {
			ip = request.getRemoteAddr();
		} else {
			ip = request.getHeader("x-forwarded-for");
		}
		return ip;
	}
	
	//ip,addrss保存到session
	public void saveSession(HttpServletRequest request,Map<String, Object> map) {
		HttpSession session = request.getSession();
		session.setAttribute("ip", map.get("ip"));
		session.setAttribute("address", map.get("address"));
		session.setAttribute("city", map.get("city"));
		session.setAttribute("province", map.get("province"));
	}
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

package com.zhoubc.controller.message;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhoubc.controller.BaseController;
import com.zhoubc.bean.Page;
import com.zhoubc.util.DateUtil;
import com.zhoubc.util.PageData;

import com.zhoubc.service.message.MessageService;

/** 
 * 类名称：MessageController
 * 创建人：研发中心 
 * 创建时间：2018-08-05
 * 只要新增菜单url  message/list.do  代码生成的模块就完成了
 */
@Controller
@RequestMapping(value="/message")
public class MessageController extends BaseController {
	
	String menuUrl = "message/list.do"; //菜单地址(权限用)
	@Resource(name="messageService")
	private MessageService messageService;
	
	/**
	 * 新增留言
	 */
	@RequestMapping(value="/liuyan")
	public ModelAndView liuyan() throws Exception{
		logBefore(logger, "用户ID:"+getUserIp()+"新增留言");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		Integer maxId = messageService.getMaxid(pd);
		//System.out.println(maxId);
		
		pd.put("MESSAGE_ID", maxId+1);
		pd.put("PAREHT_ID", 0);
		pd.put("MESSAGE_DATE", DateUtil.getTime());
		pd.put("ZAN_NUM", 0);
		pd.put("TOP", -1);
		pd.put("COMMENT_NUM", 0);
		messageService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		logAfter(logger);
		return mv;
	}
	
	/**
	 * 新增评论
	 */
	@RequestMapping(value="/pinglun")
	public ModelAndView pinglun() throws Exception{
		logBefore(logger, "用户ID:"+getUserIp()+"新增评论");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String pid = pd.getString("pid");
		Integer maxId = messageService.getMaxid(pd);
		//System.out.println(maxId);
		Integer id = null;
		Integer COMMENT_NUM = null;
		if(maxId == null) {
			id = Integer.valueOf(pid+"001");
			COMMENT_NUM = 1;
		}else {
			id = maxId+1;
			String temp = String.valueOf(id);
			String res = null;
			if(temp.length()==4) {
				res = temp.substring(1,temp.length());
			}else if(temp.length()==5) {
				res = temp.substring(2,temp.length());
				System.out.println(res);
			}else if(temp.length()==6) {
				res = temp.substring(3,temp.length());
			}else if(temp.length()==7) {
				res = temp.substring(4,temp.length());
			}else if(temp.length()==8) {
				res = temp.substring(5,temp.length());
			}
			COMMENT_NUM = Integer.valueOf(res);
		}
		pd.put("MESSAGE_ID", id);
		pd.put("PAREHT_ID", pid);
		pd.put("MESSAGE_DATE", DateUtil.getTime());
		pd.put("ZAN_NUM", 0);
		pd.put("TOP", -1);
		
		pd.put("COMMENT_NUM", COMMENT_NUM);
		
		messageService.save(pd);
		messageService.editCPMMENT_NUM(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		logAfter(logger);
		return mv;
	}
	
	
	/**
	 * 点赞
	 */
	@RequestMapping(value="/editZAN_NUM",produces = {"application/text;charset=UTF-8"})
	@ResponseBody
	public String editZAN_NUM() throws Exception{
		logBefore(logger, "用户ID:"+getUserIp()+"点赞请求");
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String MESSAGE_ID = pd.getString("MESSAGE_ID");
			Integer i = Integer.valueOf(MESSAGE_ID);
			pd.put("MESSAGE_ID", i);
			messageService.editZAN_NUM(pd);
			
		} catch(Exception e){
			logger.error(e.toString(), e);
			return "error";
		}
		logAfter(logger);
		return "1";
	}
	
	/**
	 * 去查看留言页面
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "用户ID:"+getUserIp()+" 去查看留言页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			//System.out.println(pd);
			List<PageData>	varList = messageService.list1(page);	//列出Message列表
			mv.setViewName("message/message");
			mv.addObject("messages", varList);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		logAfter(logger);
		return mv;
	}
	
	/**
	 * 去查看评论页面
	 */
	@RequestMapping(value="/goComment")
	public ModelAndView goComment(Page page){
		logBefore(logger, "用户ID:"+getUserIp()+"去查看评论页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			//System.out.println(pd);
			page.setPd(pd);
			List<PageData>	varList = messageService.list2(page);	//列出Message列表
			mv.setViewName("message/message_comment");
			mv.addObject("messages", varList);
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		logAfter(logger);
		return mv;
	}
	
	/**
	 * 去查看用户页面
	 */
	@RequestMapping(value="/goUser")
	public ModelAndView goUser(Page page){
		logBefore(logger, "用户ID:"+getUserIp()+"去查看用户页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			//System.out.println(pd);
			page.setPd(pd);
			List<PageData>	varList = messageService.list3(page);	//列出Message列表
			mv.setViewName("message/message_user");
			mv.addObject("messages", varList);
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		logAfter(logger);
		return mv;
	}
	
	/**
	 * 去留言页面
	 */
	@RequestMapping(value="/goLiuyan")
	public ModelAndView goMessage(){
		logBefore(logger, "用户ID:"+getUserIp()+"去留言页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			HttpSession session = this.getRequest().getSession();
			pd.put("ip", session.getAttribute("ip"));
			pd.put("address", session.getAttribute("address"));
			pd.put("city", session.getAttribute("city"));
			pd.put("province", session.getAttribute("province"));
			mv.setViewName("message/message_liuyan");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		logAfter(logger);
		return mv;
	}	
	
	/**
	 * 去评论页面
	 */
	@RequestMapping(value="/goPinglun")
	public ModelAndView goPinglun(){
		logBefore(logger, "用户ID:"+getUserIp()+"去评论页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			HttpSession session = this.getRequest().getSession();
			pd.put("ip", session.getAttribute("ip"));
			pd.put("address", session.getAttribute("address"));
			pd.put("city", session.getAttribute("city"));
			pd.put("province", session.getAttribute("province"));
			mv.setViewName("message/message_pinglun");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		logAfter(logger);
		return mv;
	}	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

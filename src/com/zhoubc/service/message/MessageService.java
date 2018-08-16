package com.zhoubc.service.message;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhoubc.dao.impl.DaoSupport;
import com.zhoubc.bean.Page;
import com.zhoubc.util.PageData;


@Service("messageService")
public class MessageService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("MessageMapper.save", pd);
	}
	
	/**
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("MessageMapper.delete", pd);
	}
	
	/**
	* 修改
	*/
	public void editZAN_NUM(PageData pd)throws Exception{
		dao.update("MessageMapper.editZAN_NUM", pd);
	}
	
	/**
	* 修改
	*/
	public void editCPMMENT_NUM(PageData pd)throws Exception{
		dao.update("MessageMapper.editCPMMENT_NUM", pd);
	}
	
	/**
	* 修改
	*/
	public void editTOP(PageData pd)throws Exception{
		dao.update("MessageMapper.editTOP", pd);
	}
	
	/**
	*列表
	*/
	public List<PageData> list1(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MessageMapper.datalistPage1", page);
	}
	/**
	*列表
	*/
	public List<PageData> list2(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MessageMapper.datalistPage2", page);
	}
	/**
	*列表
	*/
	public List<PageData> list3(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MessageMapper.datalistPage3", page);
	}
	
	/**
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("MessageMapper.listAll", pd);
	}
	
	/**
	* 获取最大值ID
	*/
	public Integer getMaxid(PageData pd)throws Exception{
		List<PageData> list = (List<PageData>)dao.findForList("MessageMapper.getMaxid", pd);
		if(list.get(0) == null) {
			return null;
		}
		return Integer.valueOf((String) list.get(0).getToString("max"));
		 
	}
	
	
	
	/**
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MessageMapper.findById", pd);
	}
	
	
}


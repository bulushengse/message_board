package com.zhoubc.service.message;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhoubc.dao.impl.DaoSupport;
import com.zhoubc.bean.Page;
import com.zhoubc.util.PageData;


@Service("visitService")
public class VisitService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("VisitMapper.save", pd);
	}
	
	/**
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("VisitMapper.delete", pd);
	}
	
	/**
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("VisitMapper.edit", pd);
	}
	
	/**
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("VisitMapper.datalistPage", page);
	}
	
	/**
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VisitMapper.listAll", pd);
	}
	
	/**
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VisitMapper.findById", pd);
	}
	
	
}


package com.hotel.asia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hotel.asia.dto.Question;
import com.hotel.asia.mybatis.mapper.QuestionMapper;

@Service
public class QuestionboardServiceImpl implements QuestionboardService {
	
	private QuestionMapper dao;
	
	@Autowired
	public QuestionboardServiceImpl(QuestionMapper dao) {
		this.dao = dao;
	}

	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	@Override
	public List<Question> getQuestionList(int page, int limit) {
		HashMap<String, Object> map = new HashMap<String, Object>();		
		int startrow = (page-1) * limit + 1; 
		int endrow = startrow + limit - 1; 		
		
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		return dao.getQuestionList(map);
	}

	@Override
	public int write(Question question) {
		return dao.write(question);
	}

	@Override
	public int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}

	@Override
	public Question getDetail(int num) {
		return dao.getDetail(num);
	}

	@Override
	public int delete(int num) {
		return dao.delete(num);
	}

	@Override
	public int modify(Question question) {
		return dao.modify(question);
	}

	@Override
	public int answer(Question question) {
		return dao.answer(question);
	}

}

package com.hotel.asia.service;

import java.util.List;
import com.hotel.asia.dto.Question;

public interface QuestionboardService {

	public int getListCount();
	
	public List<Question> getQuestionList(int page, int limit);

	public int write(Question question);

	public int setReadCountUpdate(int num);

	public Question getDetail(int num);

	public int delete(int num);

	public int modify(Question question);

	public int answer(Question question);

}

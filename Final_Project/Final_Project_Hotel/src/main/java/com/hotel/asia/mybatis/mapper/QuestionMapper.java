package com.hotel.asia.mybatis.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Question;

@Mapper
public interface QuestionMapper {

	public int getListCount();

	public List<Question> getQuestionList(HashMap<String, Object> map);
	
	public int setReadCountUpdate(int num);

	public int write(Question question);

	public Question getDetail(int num);

	public int delete(int num);

	public int modify(Question question);

	public int answer(Question question);


}

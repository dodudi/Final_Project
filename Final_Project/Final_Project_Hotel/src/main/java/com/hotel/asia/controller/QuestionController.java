package com.hotel.asia.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.hotel.asia.dto.Question;
import com.hotel.asia.service.QuestionboardService;

@Controller
@RequestMapping(value="/question")
public class QuestionController {
    private static final Logger logger = LoggerFactory.getLogger(QuestionController.class);
	
	@Autowired
	private QuestionboardService questionboardservice;
	
	//리스트
		@RequestMapping(value="/list")
		public ModelAndView QuestionList(
				@RequestParam(value="page", defaultValue="1", required=false)int page,
				ModelAndView mv) {
			
			// 한 화면에 출력할 로우 갯수
			int limit = 10; 
					
			// 총 리스트 수를 받아옴
			int listcount = questionboardservice.getListCount();
					
			//총 페이지 수
			int maxpage = (listcount + limit - 1) / limit;
			
			//현재 페이지에 보여줄 시작 페이지 수
			int startpage = ((page-1)/10) * 10 + 1;
			
			//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30..)
			int endpage = startpage + 10 - 1;
					
			if(endpage > maxpage)
				endpage = maxpage;
					
			//리스트를 받아옴
			List<Question> questionlist = questionboardservice.getQuestionList(page, limit);
				
			mv.setViewName("question/question_list");
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.addObject("questionlist", questionlist);
			mv.addObject("limit", limit);
			return mv;
		}
		
		//글쓰기폼 이동
		@RequestMapping(value="/writeform")
		public ModelAndView Questionwriteform(ModelAndView mv, HttpSession session) {
			logger.info("문의사항 글쓰기 폼 이동");
			mv.setViewName("question/question_writeform");
			return mv;
		}
		
		//글쓰기
		@RequestMapping(value="/write")
		public String QuestionWrite(Question question, ModelAndView mv,
				 HttpSession session, RedirectAttributes rattr) {
				
				int result = questionboardservice.write(question); // 글 작성
				
				if(result == 0) {
					logger.info("글 작성 실패");
					return "redirect:detail";
				} else {
					logger.info("글 작성 성공");
					rattr.addAttribute("num", question.getQUESTIONS_NUM());
				}
				return "redirect:detail";
			}
		
		// 이미지 처리 - c드라이브에 hotelAsiaQuestionImage 폴더 만들기 (C:\hotelAsiaQuestionImage)
		@RequestMapping(value="/uploadImage", produces="application/json")
		@ResponseBody
		public JsonObject uploadImage(@RequestParam("file") MultipartFile multipartFile) {
			JsonObject jsonObject = new JsonObject();
			
			String fileRoot = "C:\\hotelAsiaQuestionImage\\";	//저장될 외부 파일 경로
			String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명
			String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); //파일 확장자
					
			String savedFileName = UUID.randomUUID() + extension; // 랜덤 UUID+확장자로 저장될 파일명
			
			File targetFile = new File(fileRoot + savedFileName);	
			
			try {
				InputStream fileStream = multipartFile.getInputStream();
				FileUtils.copyInputStreamToFile(fileStream, targetFile); //파일 저장
				jsonObject.addProperty("url", "/hotel/questionImage/"+savedFileName);
				jsonObject.addProperty("responseCode", "success");
				logger.info("*****파일 업로드 성공 => " + savedFileName);	
			} catch (IOException e) {
				FileUtils.deleteQuietly(targetFile); //저장된 파일 삭제
				jsonObject.addProperty("responseCode", "error");
				e.printStackTrace();
				logger.info("*****파일 업로드 실패 => " + savedFileName);
			}
			return jsonObject;
		}
		
		@RequestMapping("/detail")
		public ModelAndView QuestionDetail(
				int num, ModelAndView mv,
				HttpServletRequest request,
				@RequestHeader(value="referer")String beforeURL) {
			logger.info("referer:"+beforeURL);
			if(beforeURL.endsWith("questionlist")) {
				questionboardservice.setReadCountUpdate(num);
			}
				
			Question question = questionboardservice.getDetail(num);
				
			if(question == null) {
				logger.info("상세보기 실패");
				mv.setViewName("error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "상세보기 실패입니다.");
				} else {
					logger.info("상세보기 성공");
					mv.setViewName("question/question_detail");
					mv.addObject("question", question);
				}
			return mv;
		}
		
		@PostMapping("/delete")
		public String QuestionDelete(
				int num, Model mv, HttpServletRequest request,
				RedirectAttributes rattr)	{
		    
			int result = questionboardservice.delete(num);
			
			if (result == 0) {
				logger.info("문의사항 삭제 실패");
				mv.addAttribute("url", request.getRequestURL());
				mv.addAttribute("message", "삭제 실패");
				return "error/error";
			}
			
			logger.info("공지사항 삭제 성공");
			rattr.addFlashAttribute("result", "deleteSuccess");
			return "redirect:list";
		}
		
		@GetMapping("/modifyview")
		public ModelAndView QuestionModifyView(
				int num, ModelAndView mv,
				HttpServletRequest request	)	{
			
			Question question = questionboardservice.getDetail(num);
			if(question == null) {
				logger.info("수정 상세보기 실패");
				mv.setViewName("error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "수정 상세보기 실패입니다.");
				return mv;
			} 
			
		    logger.info("수정 상세보기 성공");
		    mv.addObject("question",question);
			mv.setViewName("question/question_modifyform");
			return mv;
		}
		
		//수정
		@RequestMapping(value="/modify")
		public String QuestionModify(
				Question question, Model mv,
				HttpServletRequest request,
				RedirectAttributes rattr
				) throws Exception 	{
			
			int result = questionboardservice.modify(question);
			if (result == 0) {
				logger.info("문의사항 수정 실패");
				mv.addAttribute("url", request.getRequestURL());
				mv.addAttribute("message", "문의사항 수정 실패");
				rattr.addFlashAttribute("result", "updateSuccess");
				return "redirect:detail";
			} else {
				logger.info("문의사항 수정 완료");
				rattr.addAttribute("num", question.getQUESTIONS_NUM());
				return "redirect:detail";
			}
		}
		
		@GetMapping("/answerview")
		public ModelAndView AnswerView(
				int num, ModelAndView mv,
				HttpServletRequest request	)	{
			
			Question question = questionboardservice.getDetail(num);
			if(question == null) {
				logger.info("답변 폼 이동 실패");
				mv.setViewName("error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "답변 폼 이동 실패입니다.");
				return mv;
			} 
			
		    logger.info("답변 폼 이동 성공");
		    mv.addObject("question",question);
			mv.setViewName("question/question_answerform");
			return mv;
		}
		
		//수정
		@RequestMapping(value="/answer")
		public String Answer(
				Question question, Model mv,
				HttpServletRequest request,
				RedirectAttributes rattr
				) throws Exception 	{
			
			int result = questionboardservice.answer(question);
			if (result == 0) {
				logger.info("답변 등록 실패");
				mv.addAttribute("url", request.getRequestURL());
				mv.addAttribute("message", "답변 등록 실패");
				rattr.addFlashAttribute("result", "updateSuccess");
				return "redirect:detail";
			} else {
				logger.info("답변 등록 성공");
				rattr.addAttribute("num", question.getQUESTIONS_NUM());
				return "redirect:detail";
			}
		}
}

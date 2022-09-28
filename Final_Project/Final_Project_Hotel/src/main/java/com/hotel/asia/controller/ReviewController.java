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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.google.gson.JsonObject;
import com.hotel.asia.dto.ReviewBoard;
import com.hotel.asia.service.ReviewBoardService;

@Controller
@RequestMapping(value="/review")
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewBoardService reviewBoardService; 
	
	// 리뷰 게시판 이동
	@GetMapping(value="/reviewList")
	public ModelAndView reviewList(@RequestParam(value="page", defaultValue="1", required=false) int page, ModelAndView mv) {
		logger.info("리뷰게시판 이동");
		
		int limit = 10; // 한 페이지에 보여줄 게시판 목록의 수 (한 화면에 출력할 로우 갯수)
		int listcount = reviewBoardService.getListCount(); // 총 리스트 수를 받아온다
		int maxpage = (listcount + limit - 1) / limit; // 총 페이지 수
		int startpage = ((page - 1) / 10) * 10 + 1; // 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등 ...)
		int endpage = startpage + 10 - 1; // 현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30 등 ...)
		if(endpage > maxpage) {
			endpage = maxpage; 
		}
		List<ReviewBoard> reviewList = reviewBoardService.getReviewList(page, limit);
		 
		logger.info("* 총 리뷰 수:" + listcount);
		
		mv.setViewName("review/reviewList");
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("limit", limit);
		mv.addObject("reviewList", reviewList);
		return mv;
	}
	
	
	// 리뷰 게시글 작성 폼
	@RequestMapping(value="/reviewWriteForm")
	public ModelAndView  reviewWriteForm(ModelAndView mv, HttpSession session) {
		logger.info("리뷰게시글 작성 폼 이동");
		//mv.addObject("id", session.getAttribute("id"));
		mv.setViewName("review/reviewWriteForm");
		return mv;
	}
	
	// 리뷰 게시글 작성
	@RequestMapping(value="/reviewWrite")
	public String reviewWrite(ReviewBoard rb, ModelAndView mv, HttpSession session, RedirectAttributes rattr) {
		logger.info("=====[reviewWrite]=====");
		logger.info("*제목: " + rb.getREVIEW_SUBJECT());
		logger.info("*비번: " + rb.getREVIEW_PASS());
		logger.info("*내용: " + rb.getREVIEW_CONTENT());
		logger.info("*작성자: " + (String)session.getAttribute("id"));
		
		rb.setMEM_ID((String)session.getAttribute("id"));
		
		int result = reviewBoardService.write(rb);
		
		if(result == 0) {
			logger.info("[글 작성 실패] result = " + result);
			rattr.addFlashAttribute("state","emptyId"); // 로그인페이지에 추가해달라고 하기 "로그인이 만료되었습니다. 본 서비스는 회원만 이용할 수 있습니다."
			return "로그인페이지";
		} else {
			logger.info("[글 작성 성공] result = " + result);
		}
		return "redirect:reviewList";
	}
	// 이미지 처리 
	@RequestMapping(value="/uploadImage", produces="application/json")
	@ResponseBody
	public JsonObject uploadImage(@RequestParam("file") MultipartFile multipartFile) {
		JsonObject jsonObject = new JsonObject();
		
		String fileRoot = "C:\\hotelAsiaReviewImage\\";	//저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); //파일 확장자
				
		String savedFileName = UUID.randomUUID() + extension; // 랜덤 UUID+확장자로 저장될 파일명
		
		File targetFile = new File(fileRoot + savedFileName);	
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); //파일 저장
			jsonObject.addProperty("url", "/hotel/reviewImage/"+savedFileName);
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

	
	// 리뷰글 보기
	@GetMapping(value="/reviewDetail")
	public ModelAndView reviewDetail(int num, ModelAndView mv,  HttpServletRequest request,
							         @RequestHeader(value="referer") String beforeURL) {
		logger.info("referer:" + beforeURL);
		if(beforeURL.endsWith("reviewList")) { // hotel/review/reviewList 에서 제목을 클릭한 경우 조회수 증가
			reviewBoardService.setReadCountUpdate(num);
		}
		ReviewBoard review = reviewBoardService.getDetail(num);
		
		if(review == null) {
			logger.info("상세보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "상세보기 실패입니다.");
		} else {
			logger.info("상세보기 성공");
			//int count = commentService.getListCount(num); // 댓글처리 할 때 주석 풀기
			mv.setViewName("review/reviewDetail");
			//mv.addObject("count", count); // 댓글처리 할 때 주석 풀기
			mv.addObject("review", review);
		}
		return mv;
	}
	
	
	
   
}

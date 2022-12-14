package com.hotel.asia.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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
import com.hotel.asia.dto.ReviewBoard;
import com.hotel.asia.service.MemberService;
import com.hotel.asia.service.ReviewBoardService;
import com.hotel.asia.service.ReviewCommService;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;

@Controller
@RequestMapping(value="/review")
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewBoardService reviewBoardService;
	@Autowired
	private ReviewCommService reviewCommService;
	@Autowired
	private MemberService memberService;
	
	
	// 리뷰 게시판 이동
	@RequestMapping(value="/reviewList")
	public ModelAndView reviewList(@RequestParam(value="page", defaultValue="1", required=false) int page, // 페이지
								   @RequestParam(value="sortBy", defaultValue="REVIEW_DATE", required=false) String sortBy, // 정렬기준
								   @RequestParam(value="search_field", defaultValue="-1", required=false) int index, // 검색 기준
								   @RequestParam(value="search_word", defaultValue="", required=false) String search_word, // 검색어
			                       ModelAndView mv) {
		logger.info("=====[reviewList] 리뷰게시판 이동=====");
		List<ReviewBoard> reviewList = new ArrayList<ReviewBoard>(); // 게시글 담을 리스트
		int limit = 10; // 한 페이지에 보여줄 게시판 목록의 수 (한 화면에 출력할 로우 갯수)
		int listcount = reviewBoardService.getListCount(index, search_word); // 총 리스트 수를 받아온다
		logger.info("*총 리뷰 수: " + listcount);
		
		// 1. 검색어 없을 때
		if(search_word.equals("")) {
			reviewList = reviewBoardService.getReviewList(page, limit, sortBy, index, search_word);
		}
		
        // 2. 검색어 있을 때
        if(index != -1) { // 검색 기준이 제목일 때 검색어 리스트에 들어간다
        	List<ReviewBoard> searchReviewList = new ArrayList<ReviewBoard>(); // 검색된 글 리스트
        	listcount = 0; // 검색된 리스트 수 초기화
			Komoran komoran = new Komoran(DEFAULT_MODEL.FULL);
			KomoranResult analyzeResultList = komoran.analyze(search_word);
			List<String> searchWordList = analyzeResultList.getNouns(); // 자연어 명사만 추출
			int addResult = 0;
			
			logger.info("==================== 검색어 갱신 결과 ====================");
			for(String searchWord : searchWordList) {
				addResult = reviewBoardService.addSearchWord(searchWord); // 검색어 리스트 추가 or 갱신
				logger.info(searchWord + "=> addResult=" + addResult + "(추가 or 갱신되면 1)" );
				searchReviewList.addAll(reviewBoardService.getReviewList(page, limit, sortBy, index, searchWord)) ; // 단어별 검색된 글 리스트 추가
			}
			
			reviewList = new ArrayList<ReviewBoard>(new HashSet<ReviewBoard>(searchReviewList)); // 검색된 리스트 중복 제거
			listcount = reviewList.size();
        }
		List<String> topSearchWordList = reviewBoardService.getTopSearchWordList(); // 인기검색어 리스트
		
		// 페이징 처리
		int maxpage = (listcount + limit - 1) / limit; // 총 페이지 수
		int startpage = ((page - 1) / 10) * 10 + 1; // 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등 ...)
		int endpage = startpage + 10 - 1; // 현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30 등 ...)
		if(endpage > maxpage) {
			endpage = maxpage; 
		}
		
		// 새 글 new 표시 하기 위한 하루 전 시각 구하기
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -1); // 하루 동안 보이도록 함
        String nowday = format.format(cal.getTime());
        logger.info("[하루 전 시각] "+ nowday);
		
		mv.setViewName("review/reviewList");
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("limit", limit);
		mv.addObject("search_field", index);
		mv.addObject("search_word", search_word);
		mv.addObject("reviewList", reviewList);
		mv.addObject("nowday", nowday); // 새 글 new 표시 하기 위한 하루 전 시각
		mv.addObject("topSearchWordList", topSearchWordList); // 인기검색어 리스트
		return mv;
	}
	// 리뷰 게시판 정렬
	@ResponseBody
	@RequestMapping(value="/reviewListSort")
	public Map<String, Object> reviewListSort(@RequestParam(value="page", defaultValue="1", required=false) int page, // page는 넘어올 수도 있고 안 올 수도 있으므로 defaultValue와 required=false 설정
											  @RequestParam(value="search_field", defaultValue="-1", required=false) int index, // 검색 기준
											  @RequestParam(value="search_word", defaultValue="", required=false) String search_word, // 검색어
											  String sortBy) {
		logger.info("=====[reviewListSort] 리뷰게시판 정렬=====");
		logger.info("정렬기준: " + sortBy);
		
		int limit = 10; // 한 페이지에 보여줄 게시판 목록의 수 (한 화면에 출력할 로우 갯수)
		int listcount = reviewBoardService.getListCount(index, search_word); // 총 리스트 수를 받아온다
		int maxpage = (listcount + limit - 1) / limit; // 총 페이지 수
		int startpage = ((page - 1) / 10) * 10 + 1; // 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등 ...)
		int endpage = startpage + 10 - 1; // 현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30 등 ...)
		if(endpage > maxpage) {
			endpage = maxpage; 
		}
		List<ReviewBoard> reviewList = reviewBoardService.getReviewList(page, limit, sortBy, index, search_word);
		
		// 새 글 new 표시 하기 위한 하루 전 시각 구하기
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -1); // 하루 동안 보이도록 함
        String nowday = format.format(cal.getTime());
        logger.info("[하루 전 시각] "+ nowday);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("limit", limit);
		map.put("listcount", listcount);
		map.put("page", page);
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("reviewList", reviewList);
		map.put("nowday", nowday); // 새 글 new 표시 하기 위한 하루 전 시각
		return map;
	}
	
	
	
	
	// 리뷰 게시글 작성 폼
	@RequestMapping(value="/reviewWriteForm")
	public ModelAndView  reviewWriteForm(ModelAndView mv, Principal userPrincipal) {
		// 로그인하지 않거나 만료된 경우 서비스 이용 불가
		if(userPrincipal == null) {
			logger.info("로그인 아이디 없음");
			mv.addObject("state", "emptyId");
			mv.setViewName("member/login");
			return mv;
		}
		
		logger.info("리뷰게시글 작성 폼 이동");
		mv.setViewName("review/reviewWriteForm");
		return mv;
	}
	
	// 리뷰 게시글 작성
	@RequestMapping(value="/reviewWrite")
	public String reviewWrite(ReviewBoard rb, ModelAndView mv, RedirectAttributes rattr, Principal userPrincipal) {
		logger.info("=====[reviewWrite]=====");
		logger.info("*제목: " + rb.getREVIEW_SUBJECT());
		logger.info("*비번: " + rb.getREVIEW_PASS());
		logger.info("*내용: " + rb.getREVIEW_CONTENT());
		logger.info("*작성자: " + userPrincipal.getName());
		
		rb.setMEM_ID(userPrincipal.getName()); // 작성자는 로그인된 계정
		int result = reviewBoardService.write(rb); // 글 작성
		
		if(result == 0) {
			logger.info("[글 작성 실패] result = " + result);
			rattr.addFlashAttribute("state","emptyId"); // 로그인페이지에 추가해달라고 하기 "로그인이 만료되었습니다. 본 서비스는 회원만 이용할 수 있습니다."
			return "로그인페이지";
		} else {
			logger.info("[글 작성 성공] result = " + result);
			logger.info("[작성된 글의 REVIEW_NUM] " + rb.getREVIEW_NUM());
			int ptResult = memberService.rewardPoint(userPrincipal.getName(), 500); // 리뷰 작성 시 포인트 적립
			logger.info("[리뷰포인트 적립여부] ptResult = " + ptResult);
			rattr.addAttribute("num", rb.getREVIEW_NUM());
		}
		return "redirect:reviewDetail";
	}
	// 이미지 처리 - c드라이브에 hotelAsiaReviewImage 폴더 만들기 (C:\hotelAsiaReviewImage)
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
	public ModelAndView reviewDetail(int num, ModelAndView mv, HttpServletRequest request, Principal userPrincipal,
							         @RequestHeader(value="referer") String beforeURL) {
		// 로그인하지 않거나 만료된 경우 리뷰 볼 수 없음
		if(userPrincipal == null) {
			logger.info("로그인 아이디 없음");
			mv.addObject("state", "emptyId");
			mv.setViewName("member/login");
			return mv;
		}
		
		
		logger.info("referer:" + beforeURL);
		if(beforeURL.endsWith("reviewList")) { // hotel/review/reviewList 에서 제목을 클릭한 경우 조회수 증가
			reviewBoardService.setReadCountUpdate(num);
		}
		ReviewBoard review = reviewBoardService.getDetail(num);
		
		// 이미 추천한 사람인지 확인
		int already = reviewBoardService.reviewRecommMem(num, userPrincipal.getName());
		logger.info("*reviewRecommMem => " + already + " (기존에 있으면 1, 없으면 0)");
		
		// 새 글 new 표시 하기 위한 하루 전 시각 구하기
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -1); // 하루 동안 보이도록 함
        String nowday = format.format(cal.getTime());
        logger.info("[하루 전 시각] "+ nowday);
		
		if(review == null) {
			logger.info("상세보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "상세보기 실패입니다.");
		} else {
			logger.info("상세보기 성공");
			int count = reviewCommService.getCommListCount(num); // 총 댓글 수
			mv.setViewName("review/reviewDetail");
			mv.addObject("loginId", userPrincipal.getName()); // 현재 로그인된 아이디
			mv.addObject("count", count);
			mv.addObject("review", review);
			mv.addObject("already", already); // 이미 추천한 사람인지 확인
			mv.addObject("nowday", nowday); // 새 글 new 표시 하기 위한 하루 전 시각
		}
		return mv;
	}
	
	
	// 리뷰글 수정 폼 이동
	@GetMapping(value="/reviewModifyForm")
	public ModelAndView reviewModifyForm(int num, ModelAndView mv, HttpServletRequest request) {
		ReviewBoard rb = reviewBoardService.getDetail(num);
		// 글 내용 불러오기 실패한 경우
		if(rb == null) {
			logger.info("수정 페이지 이동 실패");
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "수정보기 실패입니다.");
			return mv;
		}
		logger.info("수정 페이지 이동 성공");
		mv.addObject("review", rb);
		mv.setViewName("review/reviewModifyForm"); // 글 수정 폼 페이지로 이동하기 위해 경로 설정
		return mv;
	}
	// 리뷰글 수정
	@RequestMapping(value="/reviewModify")
	public String reviewModify(ReviewBoard rb, ModelAndView mv, RedirectAttributes rattr, Principal userPrincipal) {
		logger.info("=====[reviewModify]=====");
		logger.info("*번호: " + rb.getREVIEW_NUM());
		logger.info("*제목: " + rb.getREVIEW_SUBJECT());
		logger.info("*비번: " + rb.getREVIEW_PASS());
		logger.info("*내용: " + rb.getREVIEW_CONTENT());
		logger.info("*작성자: " + userPrincipal.getName());
		
		// 글 수정 시 비밀번호 맞는지 확인
		boolean usercheck = reviewBoardService.isReviewWriter(rb.getREVIEW_NUM(), rb.getREVIEW_PASS());

		// 비밀번호가 다른 경우
		if(usercheck == false) {
			rattr.addFlashAttribute("state", "passFail"); // 수정페이지에 보낼 state
			rattr.addAttribute("num", rb.getREVIEW_NUM());
			return "redirect:reviewModifyForm"; // 비밀번호 다른 경우 수정 폼으로 다시 돌아가서 alert("비밀번호가 다릅니다.");
		}
		
		rb.setMEM_ID(userPrincipal.getName());
		int result = reviewBoardService.modify(rb); // 리뷰 수정
		
		if(result == 0) {
			logger.info("[글 수정 실패] result = " + result);
			rattr.addFlashAttribute("state","emptyId"); // 로그인페이지에 추가해달라고 하기 "로그인이 만료되었습니다. 본 서비스는 회원만 이용할 수 있습니다."
			return "로그인페이지"; // 로그인페이지 경로 넣기~~
		} else {
			logger.info("[글 수정 성공] result = " + result);
			rattr.addFlashAttribute("state", "modifySuccess");
			rattr.addAttribute("num", rb.getREVIEW_NUM());
			return "redirect:reviewDetail"; // 수정성공 시 상세보기 페이지이로 이동
		}
	}
	
	
	// 리뷰 삭제
	@PostMapping("/reviewDelete")
	public String reviewDelete(String REVIEW_PASS, int REVIEW_NUM, Model mv, 
							   RedirectAttributes rattr, HttpServletRequest request) {
		// 일반회원이 글 삭제할 때는 비밀번호 검사
		if( REVIEW_PASS != null ) {
			boolean usercheck = reviewBoardService.isReviewWriter(REVIEW_NUM, REVIEW_PASS); // 글 삭제 시 비밀번호 맞는지 확인
			
			if(usercheck == false) { // 비밀번호가 일치하지 않는 경우
				rattr.addFlashAttribute("state", "passFail"); // 상세페이지에 보낼 state
				rattr.addAttribute("num", REVIEW_NUM);
				return "redirect:reviewDetail";
			}
		}
		
		// 일반회원 - 비밀번호 일치하는 경우 삭제 / 관리자 - 항상 삭제
		int result = reviewBoardService.reviewDelete(REVIEW_NUM);
		
		// 삭제 실패한 경우
		if(result == 0) {
			logger.info("게시판 삭제 실패");
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message", "삭제 실패");
			return "error/error";
		}
		// 삭제 성공한 경우 - 글 목록 보기 요청을 전송하는 부분
		logger.info("리뷰 삭제 성공");
		rattr.addFlashAttribute("state", "deleteSuccess");
		return "redirect:reviewList";
	}
	
	
	// 리뷰 추천
	@ResponseBody
	@RequestMapping(value="/reviewRecomm")
	public Map<String, Integer> reviewRecomm(int REVIEW_NUM, Principal userPrincipal) {
		logger.info("=====[reviewRecomm] 리뷰 추천=====");
		String id = userPrincipal.getName();
		
		// 이미 추천한 사람인지 확인
		int already = reviewBoardService.reviewRecommMem(REVIEW_NUM, id);
		logger.info("*reviewRecommMem => " + already + " (기존에 있으면 1, 없으면 0)");
		
		int tab = 0; // 추천 테이블에 추가 여부
		int tabDel = 0; // 추천 테이블에 삭제 여부
		int recomm = 0; // 추천 성공 여부
		int recommDel = 0; // 추천 해제 여부
		if(already == 0) {
			tab = reviewBoardService.reviewRecommTab(REVIEW_NUM, id);
			if(tab == 1) {
				recomm = reviewBoardService.reviewRecomm(REVIEW_NUM);
			}
		} else if(already == 1) {
			tabDel = reviewBoardService.reviewRecommTabDel(REVIEW_NUM, id);
			if(tabDel == 1) {
				recommDel = reviewBoardService.reviewRecommDel(REVIEW_NUM);
			}
		}
		logger.info("*reviewRecommTab => " + tab + " (추천 테이블에 삽입 성공 시 1, 실패 시 0)");
		logger.info("*reviewRecomm => " + recomm + " (추천 성공 시 1, 실패 시 0)");
		logger.info("*reviewRecommTabDel => " + tabDel + " (추천 테이블에 삭제 성공 시 1, 실패 시 0)");
		logger.info("*reviewRecommDel => " + recommDel + " (추천 해제 시 1, 실패 시 0)");
		
		// 게시글 추천수
		ReviewBoard rb= reviewBoardService.getDetail(REVIEW_NUM);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("already", already); // 이미 추천한 사람인지 확인
		map.put("recomm", recomm);   // 추천 성공 여부
		map.put("recommDel", recommDel);  // 추천 해제 여부
		map.put("recommCount", rb.getREVIEW_RECOMM()); // 게시글 추천수
		return map;
	}
	
	
	// 관리자 - 인기검색어 삭제
	@ResponseBody
	@RequestMapping(value="/searchWordDelete")
	public int searchWordDelete(String searchWord) {
		int result = reviewBoardService.deleteSearchWord(searchWord); // 인기검색어 삭제
		logger.info("[인기검색어 삭제 여부] '" + searchWord + "' => result=" + result);
		return result;
	}
	
	
   
}

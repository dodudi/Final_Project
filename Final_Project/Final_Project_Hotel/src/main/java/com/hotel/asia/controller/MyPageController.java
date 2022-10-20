package com.hotel.asia.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hotel.asia.dto.CouponMemberVO;
import com.hotel.asia.dto.CouponVO;
import com.hotel.asia.dto.Member;
import com.hotel.asia.dto.Option;
import com.hotel.asia.dto.OptionId;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Question;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.module.PageCalc;
import com.hotel.asia.module.PageData;
import com.hotel.asia.service.CouponService;
import com.hotel.asia.service.MemberServiceImpl;
import com.hotel.asia.service.MyPageServiceImpl;
import com.hotel.asia.service.OptionService;
import com.hotel.asia.service.QuestionboardService;

/*
 * MyPage에 관한 Controller입니다.
 * */
@Controller
public class MyPageController {
	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);
	@Autowired
	private MyPageServiceImpl myPageService;
	@Autowired
	private OptionService optionService;
	@Autowired
	private CouponService couponService;
	@Autowired
	private MemberServiceImpl memberService;
	
	@Autowired
	private QuestionboardService questService;
	// 객실예약확인 페이지
	@GetMapping("/mypage/reserve")
	public String reserve(Model model, Principal princiPal, HttpSession session) {
		String mem_id = princiPal.getName();
		session.setAttribute("id", mem_id);
		log.info(mem_id);
		List<Rez> rezs = myPageService.getRezDatas(mem_id);
		log.info(rezs.size() + "");
		
		model.addAttribute("rezData", rezs);
		return "mypage/mypage_reserve_check";
	}

	// 질문게시판 페이지
	@GetMapping("/mypage/question")
	public String question(Model model, PageData pageData, HttpSession session) {
		
		String mem_id = session.getAttribute("id").toString();
		Object itemLimitObject = session.getAttribute("itemLimit");
		int itemLimit;
		if (itemLimitObject == null)
			itemLimit = 10;
		else
			itemLimit = Integer.parseInt(itemLimitObject.toString());

		pageData.setItemLimit(itemLimit);

		//int total = myPageService.getQuestionBoardCount(mem_id);
		
		List<Question> questions = questService.getQuestionList(pageData.getPageNum(), pageData.getItemLimit());
		PageCalc pageCalc = new PageCalc(questions.size(), 10, pageData);
		model.addAttribute("pageCalc", pageCalc);
		model.addAttribute("itemLimit", pageData.getItemLimit());
		model.addAttribute("questions", questions);
		
		log.info(questions.size() +"");
		log.info(pageCalc.getEndPage()+"");
		log.info(pageCalc.getPageLimit()+ "");
		return "mypage/mypage_question_check";
	}

	@ResponseBody
	@PostMapping(value = "/mypage/listCountSet")
	public PageCalc listCountSet(HttpSession session, @RequestBody PageData pageData) {
		String mem_id = session.getAttribute("id").toString();

		int total = myPageService.getQuestionBoardCount(mem_id);
		PageCalc pageCalc = new PageCalc(total, 10, pageData);

		session.setAttribute("itemLimit", pageData.getItemLimit());
		return pageCalc;
	}

	// 회원정보 페이지
	@GetMapping("/mypage/member")
	public String member(Model model, HttpSession session) {
		String mem_id= session.getAttribute("id").toString();
		Member member = memberService.member_info(mem_id);
		model.addAttribute("member",member);
		return "mypage/mypage_member_check";
	}

	// 쿠폰|마일리지 페이지
	@GetMapping("/mypage/coupon")
	public String coupon(Model model, HttpSession session) {
		String mem_id = session.getAttribute("id").toString();

		// 사용자 보유 쿠폰 개수
		int memberCouponCount = couponService.getCouponMemberCount(mem_id);
		// 사용한 쿠폰 개수
		int useCouponCount = couponService.getUseCouponCount(mem_id);
		// 사용기간 만료된 쿠폰 개수
		int delCouponCount = couponService.getDelCouponCount(mem_id);
		// 발급받았던 쿠폰 개수
		int allCouponCount = memberCouponCount + useCouponCount + delCouponCount;

		List<CouponMemberVO> memberCoupons = couponService.getCouponMember(mem_id);
		List<CouponVO> memberCouponOpt = couponService.getCouponAboutId(memberCoupons);
		
		List<CouponMemberVO> useCoupons = couponService.getUseCoupon(mem_id);
		List<CouponVO> useCouponOpt = couponService.getCouponAboutId(useCoupons);
		
		List<CouponMemberVO> delCoupons = couponService.getDelCoupon(mem_id);
		List<CouponVO> delCouponOpt = couponService.getCouponAboutId(delCoupons);

		model.addAttribute("memberCouponCount", memberCouponCount);
		model.addAttribute("useCouponCount", useCouponCount);
		model.addAttribute("delCouponCount", delCouponCount);
		model.addAttribute("allCouponCount", allCouponCount);

		model.addAttribute("memberCoupons", memberCoupons);
		model.addAttribute("useCoupons", useCoupons);
		model.addAttribute("delCoupons", delCoupons);
		
		model.addAttribute("memberCouponOpt", memberCouponOpt);
		model.addAttribute("useCouponOpt", useCouponOpt);
		model.addAttribute("delCouponOpt", delCouponOpt);
		
		return "mypage/mypage_coupon";
	}

	// 즐겨찾기 게시판 페이지
	@GetMapping("/mypage/wishBoard")
	public String wishBoard() {
		return "mypage/mypage_wishboard";
	}
}

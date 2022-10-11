package com.hotel.asia.controller;

import java.io.PrintWriter;
import java.security.Principal;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.asia.dto.MailVO;
import com.hotel.asia.dto.Member;
import com.hotel.asia.service.MemberService;
import com.hotel.asia.task.NaverMessageAuth;
import com.hotel.asia.task.SendMail;

@Controller
@RequestMapping(value="/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	private MemberService memberservice;
	private PasswordEncoder passwordEncoder;
	private SendMail sendMail;
	
	@Autowired
	public MemberController(MemberService memberservice, PasswordEncoder passwordEncoder, SendMail sendMail) {
		this.memberservice=memberservice;
		this.passwordEncoder = passwordEncoder;
		this.sendMail = sendMail;
	}
	
	
	//로그인 폼 이동 
	//http://localhost:9000/hotel/member/login
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(Model m, 
							@CookieValue(value="remember-me", required=false) Cookie readCookie,
							Principal userPrincipal,
							HttpSession session,
							@RequestParam(value = "error", required = false)String error,   
							@RequestParam(value = "exception", required = false)String exception
								){
		if(readCookie != null) {
			logger.info("저장된 아이디 :" + userPrincipal.getName());	//principal.getName() : 로그인한 아이디 값을 알수있다. 
			return "/main/main";	
		} 
		String errorMsg = (String)session.getAttribute("errorMessage");
		if(errorMsg != null){
			m.addAttribute("error", true);
			m.addAttribute("exception", session.getAttribute("errorMessage"));
			session.removeAttribute("errorMessage");
		}
		return "/member/login";
	}
	
	//회원가입 폼 이동 
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		return "member/join";
	}
	
	//회원가입 POST
	@RequestMapping(value="/joinProcess", method=RequestMethod.POST)
	 public String joinProcess(Member member,
			 					RedirectAttributes rattr,
			 					Model model,
			 					HttpServletRequest request) {
		//비밀번호 암호화 추가 
		String encPassword = passwordEncoder.encode(member.getMEM_PASS());
		logger.info(encPassword);
		member.setMEM_PASS(encPassword);
		
		int result = memberservice.insert(member);
		
		if(result == 1) {
			MailVO vo = new MailVO();
			vo.setTo(member.getMEM_EMAIL());
			vo.setContent(member.getMEM_ID() + "님 회원 가입을 축하드립니다.");
			sendMail.sendMail(vo);
			
			rattr.addFlashAttribute("result", "joinSeccess");
			return "redirect:login";
		} else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "회원 가입 실패");
			return "error/error";
		}
	}
	
	
	//회원가입폼에서 아이디 검사
	@RequestMapping(value="/idcheck", method=RequestMethod.GET)
	public void idcheck(@RequestParam("id")String id,
					HttpServletResponse response) throws Exception {
		int result = memberservice.isId(id);
		response.setContentType("text/html; charsest=utf-8");
		PrintWriter out = response.getWriter();
		out.print(result);
	}
	
	//개인 정보수정 폼 
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public ModelAndView member_update(Principal principal,
										ModelAndView mv) {
		String id = principal.getName();
		
		if(id==null) {
			mv.setViewName("redirect:login");
			logger.info("id is null");
		} else {
			Member m = memberservice.member_info(id);
			mv.setViewName("member/member_updateForm");
			mv.addObject("memberinfo", m);
		}
		return mv;
	}
	
	//개인 정보수정 결과 
	@PostMapping("/updateProcess")
	public String updateProcess(Member member, Model model, 
									HttpServletRequest request,
									RedirectAttributes rattr) {
		
		int result = memberservice.update(member);
		
		if(result == 1) {
			rattr.addFlashAttribute("result", "updateSuccess");
			return "redirect:/board/list";
		} else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "정보 수정 실패");
			return "error/error";
		}
	}
	
	//회원정보 수정 폼 
	@RequestMapping(value="/list")
	public ModelAndView memberList (@RequestParam(value="page",defaultValue="1", required=false) int page,
									@RequestParam(value="limit",defaultValue="3", required=false) int limit,
									ModelAndView mv,
									@RequestParam(value="search_field",defaultValue="-1", required=false) int index,
									@RequestParam(value="search_word",defaultValue="", required=false)
									String search_word) {
		
		int listcount = memberservice.getSearchListCount(index, search_word);	//총 리스트 수 받아옴 
		
		List<Member> list = memberservice.getSearchList(index, search_word, page, limit);
		
		int maxpage = (listcount + limit -1) /limit;
		
		int startpage = ((page -1)/10) * 10 + 1;
		
		int endpage = startpage +10 -1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		mv.setViewName("member/member_list");
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("memberlist", list);
		mv.addObject("search_field", index);
		mv.addObject("search_word", search_word);
		return mv;
		
	}
	
	//회원정보 상세 
	@RequestMapping(value="/info", method=RequestMethod.GET)
	public ModelAndView member_info(@RequestParam("id") String id,
									ModelAndView mv,
									HttpServletRequest request) {
		
		Member m = memberservice.member_info(id);
		
		if(m!=null) {
			mv.setViewName("member/member_info");
			mv.addObject("memberinfo", m);
		} else {
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 정보가 없습니다.");
			mv.setViewName("error/error");
		}
		return mv;
	}
	
	//삭제 
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String member_delete(String id) {
		memberservice.delete(id);
		return "redirect:list";
	}
	
	
	
	
	
	// [현능] 22-10-11 없어져서 다시 추가
	// 휴대폰 번호 중복 검사 - ajax
	@ResponseBody
	@PostMapping("/phoneCheck")
	public int phoneCheck(int phone) {
		int result = memberservice.phoneCheck(phone);
		logger.info("*** 휴대폰 중복 검사 결과 => "+ result + " (휴대폰번호 있으면 1, 없으면 0, 뭔가 이상하면 -1)");
		return result;
	}
	
	// 휴대폰 번호 인증 문자
	@ResponseBody
	@PostMapping("/phoneAuth")
	public String phoneAuth(String phone) {
		// 인증번호 6자리 난수
		String random = "";
		int num = 0;
		while (num < 99999) {
			num = (int) (Math.random() * 1000000);
			random = String.valueOf(num); // 6자리 난수 발생
		}
		logger.info("*** 휴대폰번호 => " + phone);
		logger.info("***인증번호 => " + random);
		
		NaverMessageAuth message = new NaverMessageAuth();
		message.sendMessage(String. valueOf(phone), random);
		
		return random;
	}
	
}

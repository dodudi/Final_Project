package com.hotel.asia.controller;

import java.io.PrintWriter;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
import com.hotel.asia.dto.Notice;
import com.hotel.asia.service.MemberService;
import com.hotel.asia.task.NaverMessageAuth;
import com.hotel.asia.task.SendMail;
import com.hotel.asia.task.SendSms;

@Controller
@RequestMapping(value="/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	private MemberService memberservice;
	private PasswordEncoder passwordEncoder;
	private SendMail sendMail;
	private SendSms sendSms;
	
	@Autowired
	public MemberController(MemberService memberservice, PasswordEncoder passwordEncoder,
						SendMail sendMail, SendSms sendSms) {
		this.memberservice=memberservice;
		this.passwordEncoder = passwordEncoder;
		this.sendMail = sendMail;
		this.sendSms = sendSms;
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
		logger.info("mem_pass : " + member.getMEM_PASS());
		
		//비밀번호 암호화 추가 
		String encPassword = passwordEncoder.encode(member.getMEM_PASS());
		logger.info(encPassword);
		member.setMEM_PASS(encPassword);
		
		int result = memberservice.insert(member);
		
		if(result == 1) {
			MailVO vo = new MailVO();
			vo.setTo(member.getMEM_EMAIL());
			vo.setSubject("회원가입을 축하합니다.");
			vo.setContent("<br><br>"+member.getMEM_NAME() + " 님 회원 가입을 축하드립니다.");
			sendMail.sendMail(vo);
			
			rattr.addFlashAttribute("result", "joinSeccess");
			return "member/join2";
		} else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "회원 가입 실패");
			return "error/error";
		}
	}
	
	//이메일 인증 
	@RequestMapping(value="/mailCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> mailCheck(@RequestParam("MEM_EMAIL")String email, Member member) throws Exception {
		int serial = (int) ((Math.random() * (99999-10000 +1)) + 10000);
		
		MailVO vo =  new MailVO();
		vo.setTo(member.getMEM_EMAIL());
		vo.setSubject("호텔 아시아에서 발송한 인증번호입니다.");
		vo.setContent("<br><br>" + "[인증번호] " + serial + " 입니다.  인증번호 확인란에 기입해주세요.");
		
		sendMail.sendMail(vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("serial", serial);
		map.put("message", "success");
		return map;
	}
	
	//핸드폰 인증 
	@RequestMapping(value="/phoneCheckJn", method=RequestMethod.POST)
	@ResponseBody
	public String phoneCheck(@RequestParam("MEM_PHONE")String phone) throws Exception{
		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);//난수 생성
		String random = Integer.toString(randomNumber);
		
		sendSms.sendSms(phone, random);
		
		return random;
	}
	
	
	//회원가입폼에서 아이디 검사
	@RequestMapping(value="/idcheck", method=RequestMethod.GET)
	public void idcheck(@RequestParam("MEM_ID")String id,
					HttpServletResponse response) throws Exception {
		int result = memberservice.isId(id);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(result);
	}

	//아이디찾기폼 
	@RequestMapping(value="/findid", method=RequestMethod.GET)
	public String findid() {
		return "member/findid";
	}
	
	//아이디 찾기 
	@ResponseBody
	@RequestMapping(value="/findidProcess", method=RequestMethod.POST)
	public Map<String, Object> findidProcess(@RequestParam("MEM_NAME")String name,
							@RequestParam("MEM_EMAIL")String email) throws Exception {
		
		String mem_id = memberservice.findId(name, email);
		
		if(mem_id != null) {
			logger.info("아이디 찾기 성공");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mem_id", mem_id);
			map.put("message", "success");
			return map;
		}else {
			logger.info("아이디 찾기 실패");
			return null;
		}
	}
	
	//패스워드 찾기폼 
	@RequestMapping(value="/findpw", method=RequestMethod.GET)
	public String findpw() {
		return "member/findpw";
	}
		
	//패스워드 임의값 변경 
	@RequestMapping(value="/findpwProcess", method=RequestMethod.POST)
	public String findChangePw(@RequestParam("MEM_ID")String id, 
							@RequestParam("MEM_NAME")String name, 
							@RequestParam("MEM_EMAIL")String email, Member m, Model model,
							RedirectAttributes rattr, HttpServletRequest request) throws Exception {
		
		//임시비밀번호를 위한 난수 구하기 
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
	    int targetStringLength = 10;
	    Random random = new Random();
	    String serial = random.ints(leftLimit, rightLimit + 1)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
	    
		int mem_pw = memberservice.searchPw(name, id, email);
		logger.info("mem_pw: "+ mem_pw);
		
		if(mem_pw ==1) {
			MailVO vo =  new MailVO();
			vo.setTo(m.getMEM_EMAIL());
			vo.setSubject("호텔 아시아에서 발송한 임시 비밀번호입니다.");
			vo.setContent("<br><br>" + "임시발급된 비밀번호는 " + serial + " 입니다.<br>로그인 후 비밀번호 변경해주세요");
			sendMail.sendMail(vo);
			//비밀번호 암호화 추가 
			String encPassword = passwordEncoder.encode(serial);
	  		logger.info(encPassword);
	  		
			m.setMEM_PASS(encPassword);
			memberservice.updatePw(m);
			
			rattr.addFlashAttribute("result", "updatePwSuccess");
			return "member/login";
		} else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "passwordUpdateFail");
			return "member/findpw";
		}
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
	public ModelAndView member_info(@RequestParam("MEM_ID") String id,
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
	
	// ================================= 현능씨 부분! ================================
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
	   
	   @RequestMapping(value="/userlist")
		public ModelAndView MemberList(
				@RequestParam(value="page", defaultValue="1", required=false)int page,
				ModelAndView mv) {
			
			// 한 화면에 출력할 로우 갯수
			int limit = 10; 
					
			// 총 리스트 수를 받아옴
			int listcount = memberservice.getListCount();
					
			//총 페이지 수
			int maxpage = (listcount + limit - 1) / limit;
			
			//현재 페이지에 보여줄 시작 페이지 수
			int startpage = ((page-1)/10) * 10 + 1;
			
			//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30..)
			int endpage = startpage + 10 - 1;
					
			if(endpage > maxpage)
				endpage = maxpage;
					
			//리스트를 받아옴
			List<Member> userlist = memberservice.getUserList(page, limit);
				
			mv.setViewName("admin/user_list");
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.addObject("userlist", userlist);
			mv.addObject("limit", limit);
			return mv;
	   }
	   
	   @PostMapping("/userdelete")
		public String UserDelete(
				String id, Model mv, HttpServletRequest request,
				RedirectAttributes rattr)	{
		    
			int result = memberservice.Userdelete(id);
			
			if (result == 0) {
				logger.info("회원 정보 삭제 실패");
				mv.addAttribute("url", request.getRequestURL());
				mv.addAttribute("message", "삭제 실패");
				return "error/error";
			}
			
			logger.info("회원 정보 삭제 성공");
			rattr.addFlashAttribute("result", "deleteSuccess");
			return "redirect:userlist";
		}
}

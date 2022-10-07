<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Font online-->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
      
		<!-- Animate.css-->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project_css/member/join.css" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" >
        
        <!-- Google JQuery CDN -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
        	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/project_js/member/join.js"></script>
        
        <!-- 로고 -->
        <link rel="icon" href="${pageContext.request.contextPath}/static/image/favicon.png" type="image/png">
    	<title>Hotel Asia</title>
    	
    	<script>
    		
    	</script>
    </head>
    <body>
        <div>
           <div class="panel shadow1">
                <form name="joinform" action="joinProcess" method="post">
                	<div class="panel-switch animated">
                        <button type="button" id="step1" class="button1" >STEP1 <br>정보입력</button> 
                        <div class="icon">--- <i class="fa-solid fa-person-walking-dashed-line-arrow-right"></i> ---</div>
                        <button type="button" id="step2" class="button2">STEP2 <br>가입완료</button>
                    </div>
                    
                    <div class="animated fadeInUp animate1">
	                    <h3 class="terms">아시아 호텔 이용약관</h3>
	                    <div class="accordion accordion-flush " id="accordionFlushExample">
						  <div class="accordion-item">
						    <h4 class="accordion-header" id="flush-headingOne">
						      <input type="checkbox" class="accordion-ck" >
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
						       	아시아 호텔 리워즈 멤버십 이용약관(필수)
						      </button>
						    </h4>
						    <p class="error"> *멤버십 가입을 위해서는 동의하셔야 합니다</p>
						    <div id="flush-collapseOne" class="accordion-collapse collapse in" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
						      <div class="accordion-body">
							      <p>
							      	제 1장 총칙 <br>
									제1조 목적<br>
									이 약관은 아시아 호텔(이하 "호텔"이라 함)이 "멤버십" 가입 회원(이하 "회원"이라 함)에게 제공하는 서비스의 내용과 당사자의 권리·의무 및 책임사항을 규정하는 것을 목적으로 합니다.<br>
									
									제2조 용어의 정의<br>
									이 약관에서 사용하는 용어의 정의는 다음 각 호와 같습니다.<br>
									1. "멤버십"이란 "회원"에게 "호텔" 서비스 이용과 관련하여 다양한 혜택을 제공하는 아시아 호텔 리워즈 프로그램을 말합니다.<br>
									2. "회원"이란 이 약관에 정해진 가입 절차에 따라 정상적으로 "멤버십"에 "회원"등록을 한 자로서 "호텔"이 제공하는 서비스를 이용할 수 있는 자를 말합니다.<br>
									3. "포인트"란 "호텔"에서 재화/서비스 구매 시 적립/사용이 가능하도록 제공하는 점수를 말합니다.<br>
									4. "부정적립"이란 "호텔"에서 "회원"이 실제로 상품을 구매하거나 서비스를 이용하지 않았음에도 당해 "회원"에게 "포인트"가 적립된 경우("호텔"에서 상품을 구매하거나 서비스를 이용한 당사자의 동의가 있는 경우는 제외) 또는 실제 구입액 혹은 이용액 이상으로 "포인트"가 적립된 경우를 말합니다.<br>
									5. "부정사용"이란 "회원"이 "부정적립"한 "포인트"와 타 "회원"의 동의 없이 타 "회원"의 "포인트"를 임의로 사용한 경우를 말합니다.<br>
									6. 아시아 리워즈 스탬프"란 "회원"이 "호텔" 투숙 시 "멤버십"에서 규정한 유효한 거래 실적 건에 한하여 자동으로 발급되는 적립 수단이며 일정 횟수 달성 시 "멤버십" 정책에 따라 해당 혜택을 받을 수 있습니다.<br>
									7. "e쿠폰"은 전자적 바우처 형태로 "호텔"에서 사용할 수 있는 투숙권, 식사권, 할인권 등을 말합니다.<br>
									
									제3조 멤버십 서비스 개요<br>
									"호텔"이 이 약관에서 정한 제반 절차를 거쳐 가입한 "회원"에게 제공하는 "멤버십" 서비스의 내용은 아래와 같습니다.<br>
									적립 서비스<br>
									1. "회원"은 "호텔"의 상품 구매 또는 서비스 이용을 통하여 "포인트"를 적립 받을 수 있습니다. 단, "호텔"의 사정에 따라 지정된 일부 상품 또는 서비스는 제외될 수 있습니다.<br>
									사용 서비스<br>
									2. "회원"은 적립된 "포인트"를 사용하여 "호텔"의 상품을 구매하거나 서비스를 이용할 수 있습니다.<br>
									아시아 리워즈 스탬프 서비스<br>
									3. "회원"이 "호텔" 투숙 시 "멤버십"에서 규정한 유효한 거래 실적 건에 한하여 1박당 1개의 스탬프를 제공합니다.<br>
									기타 서비스<br>
									4. "호텔"는 상기 각 호의 서비스 이외에도 추가적인 서비스를 개발하여 "회원"에게 제공할 수 있습니다.<br>
									
									제4조 약관의 효력 및 개정<br>
									1. 이 약관은 "멤버십"에 가입한 "회원"을 포함하여 "멤버십" 혜택 및 "포인트" 등을 이용하고자 하는 모든 "회원"에 대하여 그 효력을 발휘합니다.<br>
									2. 이 약관은 수시로 개정 가능하며, 약관을 개정하고자 할 경우 "호텔"은 개정된 약관을 적용하고자 하는 날로부터 14일 이전에 약관이 개정된다는 사실과 개정된 내용 등을 전자우편(E-mail), 홈페이지 공지, 문자메시지 등의 방법 중 1 가지 이상의 방법으로 "회원"에게 통지합니다. 단, "회원"에게 불리하게 약관이 변경되는 경우 최소한 30일 이상의 사전 유예기간을 두고 고지합니다.<br>
									3. 이 약관의 개정과 관련하여 이의가 있는 "회원"은 "회원"탈퇴를 할 수 있으며 개정된 약관의 효력발생일까지 탈퇴하지 않거나 별도로 "호텔"에 이의를 제기하지 않는 경우 변경된 약관에 동의한 것으로 봅니다.<br>
									4. 본 조에 의하여 개정된 약관은 그 효력 발생일로부터 유효합니다.<br>
									5. 본 조의 고지방법 및 고지의 효력은 이 약관에서 달리 정하지 않는 한, 이 약관의 각 조항에서 규정하는 통지 또는 통보의 방식에도 준용합니다.<br>
									
									제 2장 회원 가입 및 탈퇴<br>
									제5조 회원 가입<br>
									1. "회원"으로 가입하고자 하는 고객은 "호텔" 홈페이지 또는 앱, "호텔" 내 전자태블릿을 통해 정해진 사항을 기입한 후 이 약관과 "개인정보의 수집, 제공 및 활용 동의서"에 동의함으로써 "회원"가입을 신청합니다. 단, 만 19세 미만, 법인, 단체 등은 "회원"가입이 불가합니다.
									2. 고객으로부터 "회원"가입 신청이 있는 경우, "호텔"은 자체 기준에 따른 심사를 거친 뒤, 기준을 만족하는 고객께 한 개의 "회원"번호를 부여하여 드립니다. "회원"번호는 "호텔" 홈페이지 또는 앱에서 확인이 가능합니다.<br>
									3. "회원"의 "멤버십" 중복 가입 시 하나의 "회원"번호를 제외한 나머지 "회원"번호는 해지 처리되며, 해지 처리되는 "회원"번호의 "포인트"는 잔존하는 "회원"번호에 이관됩니다<br>
									4. "회원"은 "호텔" 홈페이지에서 개인 계정을 발급받아 보유 "포인트", 적립내역, 프로모션, 개인정보 등을 확인 및 수정할 수 있습니다.<br>
									"회원"은 "회원"자격 및 그로부터 발생하는 권리를 타인에게 양도하거나 대여 또는 담보의 목적으로 제공할 수 없습니다.<br>
									
									제6조 멤버십이용 및 관리<br>
									1. "멤버십"서비스는 "회원" 본인만 사용 가능합니다. 단, "호텔"이 인정하는 적절한 절차를 따른 경우는 예외로 합니다.<br>
									2. "회원"이 "호텔"의 상품 구매 또는 서비스 이용을 통하여 "포인트"를 적립 받거나 또는 적립된 "포인트"를 사용하여 "호텔"의 상품을 구매하는 등 "멤버십" 서비스를 이용하고자 할 경우, "회원"은 "호텔"에 "멤버십" 모바일 카드 또는 신분증을 제시하여야 합니다.<br>
									3. 카드 및 비밀번호(홈페이지, 앱)는 "회원" 자신의 책임하에 관리하여야 합니다. "회원"의 고의 또는 과실로 카드 및 비밀번호의 분실, 도난, 유출 등의 사고가 발생한 경우, 당해 "회원"은 즉시 그 사실을 "호텔"에 통지하여야 하며, "호텔"은 "회원"으로부터 통지를 받은 즉시 사고 등록 및 해당 "회원"카드의 사용을 중지하는 등 필요한 제반조치를 취합니다. 
										단, "회원"이 사고에 대한 통지 시점 이전에 발생한 손해로서 "호텔"에 고의 또는 과실이 없는 경우, "호텔"은 이에 대해 어떠한 책임도 지지 않습니다.<br>
									
									제7조 회원 탈퇴 및 자격상실<br>
									1. "회원"은 언제든지 서면, 홈페이지 등 "호텔"이 정하는 방법으로 "회원" 탈퇴를 요청할 수 있으며, "호텔"은 영업일 기준 24시간 이내에 처리합니다. "회원"이 "멤버십"에서 탈퇴한 경우 "포인트", 이용실적, 혜택 등은 그 즉시 소멸합니다.<br>
									2. "회원"이 최종 거래일 이후 3년 간 실적이 없는 경우, "호텔"은 당해 "회원"을 "멤버십"에서 탈퇴 처리하며, 기존 "포인트" 및 거래 실적을 소멸시킬 수 있습니다. 이 경우 "호텔"은 해당 "회원"에게 탈퇴 처리 6개월 전에 전자 우편 및 문자 메시지를 통해 통보합니다.<br>
									3. "회원"의 자격은 다음 각 호의 경우에 즉시 상실됩니다.<br>
									① "회원"이 카드 및 "포인트"를 제 3자에게 양도 또는 판매한 경우<br>
									② "부정적립", "부정사용" 등 부정한 방법 또는 목적으로 이용한 경우<br>
									③ "회원"가입 신청 시 허위 내용을 등록, 기재 혹은 고지한 경우<br>
									④ "회원"이 부당이익을 취한 부분이 있거나, "부정적립"된 "포인트"로 상품을 구매하거나 서비스를 이용한 경우 "회원" 본인 또는 "부정적립"에 관여한 자는 관련 법령에 따라 민, 형사상의 책임을 부담할 수 있습니다. <br>
										단, "회원"은 "부정사용" 등의 사유가 자신의 고의 또는 과실에 기한 것이 아님을 소명할 수 있습니다. 이 경우 "호텔"은 "회원"의 소명 내용을 심사하여 "회원"의 주장이 타당하다고 판단하는 경우는 예외로 합니다.<br>
									⑤ "회원"이 사망한 경우, "호텔"에서 요구하는 관련 증빙서류를 제출하여 직계가족에게 1회에 한하여 "포인트"를 이관할 수 있습니다.<br>
									4. "호텔" 홈페이지 회원의 경우 1년간(최종 로그인 후 12개월) 웹사이트 이용 기록이 없을 시, 서비스 미이용 회원의 개인정보는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 29조 근거하여 해당 회원에게 사전 통지 후 개인정보는 별도 분리 보관되며 서비스 이용에 제한을 받을 수 있습니다.<br>
									
									제8조 해석 및 합의 관할<br>
									"호텔"은 이 약관과 관련하여 대한민국 법률을 준수합니다.<br>
									이 약관에서 정하지 않은 사항과 이 약관의 해석에 관하여는 상관례에 따릅니다.<br>
									이 약관에 의한 서비스 이용과 관련한 제반 분쟁 및 소송은 서울중앙지방법원을 전속관할법원으로 합니다.<br><br>
									
									이 약관은 2022년 10월 02일부터 시행합니다.
							      </p>
						      </div>
						    </div>
				 		 </div>
						  <div class="accordion-item">
						    <h4 class="accordion-header" id="flush-headingOne">
						      <input type="checkbox" class="accordion-ck" >
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
						       	아시아 호텔 사이트 이용약관(필수)
						      </button>
						    </h4>
						    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
						      <div class="accordion-body">
								<p>
									제1조 목적<br>
									이 약관은 아시아 호텔이 운영하는 홈페이지(이하 "아시아 홈페이지")에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 한다)를 이용함에 있어 홈페이지와 이용자의 권리의무 및 책임사항을 규정함을 목적으로 합니다.<br>
									
									제2조 정의<br>
									1. "아시아 홈페이지"란 아시아 호텔이 재화 또는 용역(이하 "재화 등"이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버 몰을 운영하는 사업자의 의미로도 사용합니다.<br>
									2. "이용자"란 "아시아 홈페이지"에 접속하여 이 약관에 따라 "아시아 홈페이지"가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.<br>
									3. '회원'이라 함은 '아시아 리워즈 회원'으로 "아시아 홈페이지"에 개인정보를 제공하여 아시아 리워즈 회원에 등록을 한 자로서, "아시아 홈페이지"의 정보를 지속적으로 제공받으며, "아시아 홈페이지"가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.<br>
									4. '비회원'이라 함은 회원에 가입하지 않고 "아시아 홈페이지"가 제공하는 서비스를 이용하는 자를 말합니다.<br>
									
									제3조 약관 등의 명시와 설명 및 개정<br>
									1. "아시아 홈페이지"는 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호, 모사전송번호, 전자우편주소, 사업자등록번호, 통신판매업신고번호, 개인정보 관리 책임자 등을 이용자가 쉽게 알 수 있도록 "아시아 홈페이지" 초기 서비스화면(전면)에 게시합니다.
										 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.<br>
									2. "아시아 홈페이지"는 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회, 배송책임, 환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.<br>
									3. "아시아 홈페이지"는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 전자문서 및 전자거래기본법, 전자금융거래법, 전자 서명법, 정보통신망 이용 촉진 및 정보보호 등에 관한 법률, 방문 판매 등에 관한 법률, 소비자기본법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br>
									4. "아시아 홈페이지"는 약관을 개정할 경우 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기 화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.
										이 경우 "아시아 홈페이지"는 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.<br>
									5. "아시아 홈페이지"가 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다.
										다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지 기간 내에 "아시아 홈페이지"에 송신하여 "아시아 홈페이지"의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.<br>
									이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래등에서의 소비자 보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래등에서의 소비자보호지침 및 관계법령 또는 상관례에 따릅니다.<br>
									
									제4조 서비스의 제공 및 변경<br>
									1. "아시아 홈페이지"는 다음과 같은 업무를 수행합니다.<br>
									①. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결<br>
									②. 구매계약이 체결된 재화 또는 용역의 배송<br>
									③. 아시아 리워즈 포인트 및 등급 확인, 멤버십 및 쿠폰 현황<br>
									④. 기타 "아시아 홈페이지"가 정하는 업무<br>
									2. "아시아 홈페이지"는 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. <br>
										이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.<br>
									3. "아시아 홈페이지"가 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화 등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.<br>
									4. 전항의 경우 "아시아 홈페이지"는 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, "아시아 홈페이지"가 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.<br>
									
									제5조 회원가입<br>
									1. 만 19세 미만의 미성년자는 "아시아 홈페이지"에 회원가입 하실 수 없습니다<br>
									2. 이용자는 "아시아 홈페이지"가 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.<br>
									3. "아시아 홈페이지"는 제12항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각호에 해당하지 않는 한 회원으로 등록합니다.<br>
									4. 가입신청자가 이 약관 제7조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 "아시아 홈페이지"의 회원재가입 승낙을 얻은 경우에는 예외로 한다.<br>
									①. 등록 내용에 허위, 기재누락, 오기가 있는 경우<br>
									②. 기타 회원으로 등록하는 것이 "아시아 홈페이지"의 기술상 현저히 지장이 있다고 판단되는 경우<br>
									5. 회원가입계약의 성립시기는 "아시아 홈페이지"의 승낙이 회원에게 도달한 시점으로 합니다.<br>
									6. 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 즉시 전자우편 기타 방법으로 "아시아 홈페이지"에 대하여 그 변경사항을 알려야 합니다<br>
									
									제6조 회원 탈퇴 및 자격 상실 등<br>
									1. 회원은 "아시아 홈페이지"에 언제든지 탈퇴를 요청할 수 있으며, 이 경우 "아시아 홈페이지"는 즉시 회원탈퇴를 처리합니다<br>
									2. 회원이 다음 각호의 사유에 해당하는 경우, "아시아 홈페이지"는 회원자격을 제한 및 정지시킬 수 있습니다.<br>
									①. 가입 신청시에 허위 내용을 등록한 경우<br>
									②. "아시아 홈페이지"를 이용하여 구입한 재화 등의 대금, 기타 "아시아 홈페이지"이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우<br>
									③. 다른 사람의 "아시아 홈페이지" 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우<br>
									④. "아시아 홈페이지"를 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우<br>
									3. "아시아 홈페이지"가 회원 자격을 제한/정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 "아시아 홈페이지"는 회원자격을 상실시킬 수 있습니다.<br>
									4. "아시아 홈페이지"가 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.<br><br>
									
									"아시아 홈페이지"와 이용자간에 제기된 전자상거래 소송에는 대한민국법을 적용합니다.
								</p>
						      </div>
						    </div>
						  </div>
						</div>
	                    
	                    <h3 class="terms">개인정보 수집 및 활용 동의서</h3>
	                    <p class="terms-label">아시아 호텔은 홈페이지를 통하여 적법하고 공정한 수단에 의하여 고객님의 개인정보를 수집합니다. </p>
	                     <div class="accordion accordion-flush" id="accordionFlushExample">
						  <div class="accordion-item">
						    <h4 class="accordion-header" id="flush-headingThree">
						      <input type="checkbox" class="accordion-ck" >
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
						       	개인정보의 수집 및 이용(필수)
						      </button>
						    </h4>
						    <div id="flush-collapseThree" class="accordion-collapse collapse in" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
						      <div class="accordion-body">
						      	<table>
						      		<tr>
						      			<th>필수항목</th>
						      			<th>수집 및 이용목적</th>
						      			<th>보유기간</th>
						      		</tr>
						      		<tr>
						      			<td>이메일(아이디), 비밀번호, 성명(한글/영문), <br> 휴대폰번호, 생년월일, 성별</td>
						      			<td>-회원제 서비스에 따른 본인확인 절차<br>-멤버십 혜택, 약관변경, 고지사항 전달,<br> 문의상담 및 불만 등에 대한 민원처리</td>
						      			<td><strong>최종 거래일로부터 3년</strong></td>
						      		</tr>
						      	</table>
						      	<p class="terms-label2">* 필수 항목에 대한 수집 및 이용에 동의하지 않을 권리는 있으나, 미동의시 멤버십에 가입할 수 없습니다.</p>
						      </div>
						     </div>
						   </div>
					      <div class="accordion-item">
						    <h4 class="accordion-header" id="flush-headingForth">
						      <input type="checkbox" class="accordion-ck" >
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseForth" aria-expanded="false" aria-controls="flush-collapseForth">
						       마케팅 활용 동의(선택)
						      </button>
						    </h4>
						    <div id="flush-collapseForth" class="accordion-collapse collapse in" aria-labelledby="flush-headingForth" data-bs-parent="#accordionFlushExample">
						      <div class="accordion-body">
						      	<table>
						      		<tr>
						      			<th>마케팅 활용 항목</th>
						      			<th>수집 및 이용목적</th>
						      			<th>보유기간</th>
						      		</tr>
						      		<tr>
						      			<td>성명(한글/영문),휴대폰번호, <br> 이메일주소, 생년월일, 성별</td>
						      			<td>-호텔 상품 및 프로모션, 이벤트에 대해 SMS, eDM, TM을 <br>통한 홍보, 리서치 등 마케팅 목적으로 활용</td>
						      			<td><strong>최종 거래일로부터 3년</strong></td>
						      		</tr>
						      	</table>
						      	<p class="terms-label2">* 마케팅 활용에 동의하지 않을 권리가 있으며, 미동의 시 멤버십 가입은 가능하나 서비스 이용에 제한이 있을 수 있습니다.</p>
						      </div>
						     </div>
						   </div>
						  </div>
	                    </div>
	                    
	                 <h3 class="re-info">필수정보 입력</h3>
	                 <fieldset id="login-fieldset" class="login animated fadeInUp animate2">
	                    <div class="reg-form">
	                    	<span class="regist">아이디<sup>*</sup></span>
	                        <input name="id" type="text" maxLength="12" required placeholder="아이디를 입력하세요">
	                       
	                    </div>
	                    <div class="reg-form">
	                     	<div id="idck" class="error2"></div>
	                    </div>
	                    <div class="reg-form">
	                    	 <span class="regist">비밀번호<sup>*</sup></span>
	                        <input name="password" type="password" required placeholder="영문(소문자),숫자,특수문자 포함 8~12자리">
	                    </div>
	                    <div class="reg-form">
	                     	<div id="passCk" class="error2"></div>
	                    </div>
	                    <div class="reg-form">
	                     	<span class="regist">비밀번호 확인<sup>*</sup></span>
	                        <input name="passwordRe" type="password" required>
	                    </div>
	                    <div class="reg-form">
	                     	<div id="passReCk" class="error2"></div>
	                    </div>
	                    <div class="reg-form">
	                     	 <span class="regist">성명(한글)<sup>*</sup></span>
	                        <input name="username" type="text" required placeholder="이름을 입력하세요">
	                    </div>
	                    <div class="reg-form">
	                      	<span class="regist">이메일</span>
	                        <input name="email" type="email">
	                    </div>
	                    <div class="reg-form">
	                    	 <span class="regist">휴대폰</span>
	                        <input  name="phone" type="text">
	                    </div>
	                </fieldset>
	                    
	                <div class="clearfix">
	                    <input type="reset" id="login-form-reset" class="login_form button animated fadeInUp animate3" 
	                    		value="취소" onclick="history.back()">
	                    <input type="submit" id="login-form-submit" class="login_form button animated fadeInUp animate3" value="회원가입">
                    </div>
                    
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                </form>
            </div>
        </div>
    </body>
</html>
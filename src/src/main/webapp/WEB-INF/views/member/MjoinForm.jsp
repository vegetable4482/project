<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  

<!-- 제이쿼리 -->
 <script src="${pageContext.request.contextPath }/webjars/jquery/3.4.1/dist/jquery.js" ></script>
 <!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath }/webjars/bootstrap/4.3.1/css/bootstrap.css" rel="stylesheet">
 <!-- form css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/form.css"/>
<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumBarunGothic@1.0/nanumbarungothicsubset.css">

<!-- 다음 주소 api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 <jsp:include page="../header.jsp"/>
<script>
(function(){
	window.addEventListener("load", init, false);
	function init() {
		
		let postBtn = document.getElementById("postBtn");
		postBtn.addEventListener("click",postBtnf,false);
					
	 	let idTag 			= document.getElementById("id");	//아이디  
		let pwTag 			= document.getElementById("pw");	//비밀번호
		let pwchkTag 		= document.getElementById("pwchk");	//비밀번호확인
		let nicknameTag = document.getElementById("name");	//성명
		let constpostnumTag 	= document.getElementById("postnum");//공사지주소[우편번호]
		let constbasicaddressTag 	= document.getElementById("basicaddress");//공사지주소[기본주소]
		let constrestaddressTag 	= document.getElementById("restaddress");//공사지주소[상세주소]
		let telTag 			= document.getElementById("phonenum");	//휴대전화
		let agreeTag 	= document.getElementsByName("policyagree");
		let joinBtn     = document.getElementById("joinBtn");

  	idTag.addEventListener("blur"				,checkId,false);		
		idTag.addEventListener("change"			,checkId,false);
		idTag.addEventListener("keydown"		,checkId,false); 
		 
		pwTag.addEventListener("blur"				,checkPw,false);		
		pwTag.addEventListener("change"			,checkPw,false);
		pwTag.addEventListener("keydown"		,checkPw,false);
				
		pwchkTag.addEventListener("blur"		,checkPwchk,false);
 		pwchkTag.addEventListener("change"	,checkPwchk,false);
		pwchkTag.addEventListener("keydown"	,checkPwchk,false);
		
		constpostnumTag.addEventListener("blur"			,checkConstPostnum,false);
		constpostnumTag.addEventListener("change"		,checkConstPostnum,false);
		constpostnumTag.addEventListener("keydown"		,checkConstPostnum,false);
		
		constbasicaddressTag.addEventListener("blur"		,checkConstbasicaddress,false);
		constbasicaddressTag.addEventListener("change"	,checkConstbasicaddress,false);
		constbasicaddressTag.addEventListener("keydown",checkConstbasicaddress,false);
		
		constrestaddressTag.addEventListener("blur"		,checkConstrestaddress,false);
		constrestaddressTag.addEventListener("change"	,checkConstrestaddress,false);
		constrestaddressTag.addEventListener("keydown",checkConstrestaddress,false);
			
		
		telTag.addEventListener("blur"			,checkTel,false);
		telTag.addEventListener("change"		,checkTel,false);
		telTag.addEventListener("keydown"		,checkTel,false);
		
		nicknameTag.addEventListener("blur"		,checkNickname,false);
		nicknameTag.addEventListener("change"	,checkNickname,false);
		nicknameTag.addEventListener("keydown",checkNickname,false);
		
		Array.from(agreeTag).forEach(function(item) {
			item.addEventListener("blur"	,checkAgree,false);
			item.addEventListener("change",checkAgree,false);
		});
		
		
		joinBtn.addEventListener("click",joinBtnf,false);
				
		function validFeedback(obj, result, msg) {
			if(result){
				if(!obj.classList.contains("is-valid")) {
					obj.classList.add("is-valid");
					obj.classList.remove("is-invalid")
					obj.nextElementSibling.innerHTML = msg;
					if(!obj.classList.contains("valid-feedback")) {
						obj.nextElementSibling.classList.add("valid-feedback");
						obj.nextElementSibling.classList.remove("invalid-feedback");
					}
				}				

			}else{
				if(!obj.classList.contains("is-invalid")) {
					obj.classList.add("is-invalid");
					obj.classList.remove("is-valid")
					obj.nextElementSibling.innerHTML = msg;
					if(!obj.classList.contains("invalid-feedback")) {
						obj.nextElementSibling.classList.add("invalid-feedback");
						obj.nextElementSibling.classList.remove("valid-feedback");
					}
				}
				if(obj.id != "pwchk") {
					obj.focus();
				}
			}
		}
		
				

 		//이메일 주소 체크   
		function checkId() {
				let emailReg = /^((?!\.)[\w-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$/;
				let status = emailReg.test(idTag.value);
				let msg = "";

				 
				   if(status){
						if(!idTag.classList.contains("is-valid")) {
							idTag.classList.add("is-valid");
							idTag.classList.remove("is-invalid")
							document.getElementById("errId").innerHTML = "OK";
							if(!idTag.classList.contains("valid-feedback")) {
								document.getElementById("errId").classList.add("valid-feedback");
			 					document.getElementById("errId").classList.remove("invalid-feedback"); 
							}
						}				

					}else{
						if(!idTag.classList.contains("is-invalid")) {
							idTag.classList.add("is-invalid");
							idTag.classList.remove("is-valid")
							document.getElementById("errId").innerHTML = "아이디 형식이 올바르지 않습니다";
							if(!idTag.classList.contains("invalid-feedback")) {
							document.getElementById("errId").classList.add("invalid-feedback"); 
 								document.getElementById("errId").classList.remove("valid-feedback"); 
							}
						}
					}
			return status;
				
				 
		}
 			
    // 비밀번호 체크 : 6~20이하, 소문자,숫자,대문자,특수문자가 들어가는 비밀번호		
		function checkPw() {
		  let pwdReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{6,20}$/;
			let status = pwdReg.test(pwTag.value);
			let msg = "";
			if(status) {
				validFeedback(pwTag,status,"OK");
			}else{
				validFeedback(pwTag,status,"비밀번호를 입력하세요.");
			}
			return status;
		}
		// 비밀번호 확인체크
		function checkPwchk() {
      let pwdReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{6,20}$/;
			let status = pwdReg.test(pwchkTag.value) && pwTag.value == pwchkTag.value;
			let msg = "";
			//console.log(pwTag.value, pwchkTag.value);
			if(status) {
				validFeedback(pwchkTag,status,"OK");
			}else{
				validFeedback(pwchkTag,status,"비밀번호를 잘못 입력하셨습니다.");
			}
			return status;
		}
		
		//공사지 우편번호 체크
		function checkConstPostnum() {
       
					let status = constpostnumTag.value.trim().length != 0;

		      if(status){
					if(!constpostnumTag.classList.contains("is-valid")) {
						constpostnumTag.classList.add("is-valid");
						constpostnumTag.classList.remove("is-invalid")
						document.getElementById("errPost").innerHTML = "OK";
						if(!constpostnumTag.classList.contains("valid-feedback")) {
							document.getElementById("errPost").classList.add("valid-feedback");
		 					document.getElementById("errPost").classList.remove("invalid-feedback"); 
						}
					}				

				}else{
					if(!constpostnumTag.classList.contains("is-invalid")) {
						constpostnumTag.classList.add("is-invalid");
						constpostnumTag.classList.remove("is-valid")
						document.getElementById("errPost").innerHTML = "우편번호를 입력해주세요";
						if(!constpostnumTag.classList.contains("invalid-feedback")) {
						document.getElementById("errPost").classList.add("invalid-feedback"); 
							document.getElementById("errPost").classList.remove("valid-feedback"); 
						}
					}
				}
		return status;
		      
			 
		}
		
		//공사지 기본주소 체크
		function checkConstbasicaddress(){
			  let status = constbasicaddressTag.value.trim().length != 0;

		      if(status) {
		    	  validFeedback(constbasicaddressTag,status,"OK");
		      }else{
		    	  validFeedback(constbasicaddressTag,status,"기본주소를 입력하세요");
		      }	
		      return status;
		}
		
		//공사지 나머제주소 체크
		function checkConstrestaddress() {
		  let status = constrestaddressTag.value.trim().length != 0;

      if(status) {
    	  validFeedback(constrestaddressTag,status,"OK");
      }else{
    	  validFeedback(constrestaddressTag,status,"나머지주소를 입력하세요");
      }	
      return status;
		}
				
		//전화번호 체크
		function checkTel() {
			let phoneReg = /(\d{3})-(\d{3,4})-(\d{4})/;
			let status = phoneReg.test(telTag.value);
			let msg = "";
			if(phoneReg.test(telTag.value)) {
				validFeedback(telTag,status,"OK");
			}else {
				validFeedback(telTag,status,"전화번호 형식이 올바르지 않습니다");
			}
			return status;
		}

				
		//이름 체크
		function checkNickname() {
      let status = nicknameTag.value.trim().length != 0;
      //console.log(nicknameTag.value, status);
      if(status) {
    	  validFeedback(nicknameTag,status,"OK");
      }else{
    	  validFeedback(nicknameTag,status,"이름을 입력해주세요");
      }			
      return status;
		}
		
		//약관 체크
		function checkAgree() {
			let status = false;
			Array.from(agreeTag).forEach(function(item){
				if(item.checked) {
					status = true;
				}
			});
      if(status) {
    	  validFeedback(agreeTag[0].parentElement.parentElement,status,"OK");
      }else{
    	  alert('약관을 선택하세요');
    	  validFeedback(agreeTag[0].parentElement.parentElement,status,"약관을 선택하세요!");
      }		

      return status;
		}
				
		//가입하기 버튼 클릭시
		function joinBtnf(e) {
			e.preventDefault();
			console.log('가입가입');
			
			let result = checkId() && checkPw() && 
									 checkPwchk() && checkTel() && 
									 checkConstPostnum() && checkConstbasicaddress() && checkConstrestaddress() && checkNickname() && checkAgree();
			if(result) {
      	alert('회원가입이완료되었습니다.');
      	document.getElementById("mdto").submit();
			}
		}			
}
		
	var idck = 0;
	var url = "${pageContext.request.contextPath }/member/idcheck"; //공통 URL요청		
	 $(function() {			  
	      //idck 버튼을 클릭했을 때 
	      $("#idck").click(function() { 
	          var userid =  $("#id").val(); 
	          $.ajax({
	        	  async: false,
	              type : 'POST',
	              data : userid,
	              url : url,
	              dataType : "json",
	              contentType: "application/json; charset=UTF-8",
	              success : function(data) {
	                  if (data.count == 1) {
	                     alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
	                    $("#id").val('');
	                  	$("#id").focus();
	                  } else {
	                      alert("사용가능한 아이디입니다.");
	                      //아이디가 중복하지 않으면  idck = 1 
	                      idck = 1;	    
	                  }
	              },
	              error : function(error) {                  
/* 	                  alert("error : " + error); */
	              }
	          });
	      });
	 });
	 
	function postBtnf() {
        new daum.Postcode({
            oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
               var extraRoadAddr = ''; // 도로명 조합형 주소 변수

               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraRoadAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraRoadAddr !== ''){
                   extraRoadAddr = ' (' + extraRoadAddr + ')';
               }
               // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
               if(fullRoadAddr !== ''){
                   fullRoadAddr += extraRoadAddr;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               console.log(data.zonecode);
               console.log(fullRoadAddr);
               
               
               $("[name=postnum]").val(data.zonecode);
               $("[name=basicaddress]").val(fullRoadAddr);              
           }
        }).open();
			}
})();
</script>
<body>
<hr>
   <form:form modelAttribute="mdto" action="${pageContext.request.contextPath }/member/memberJoin">
      <div id="joinHeader"> <span id="h1">회원가입</span><span id="msg"><span class="ast">*</span> 는 필수 입력사항입니다</span></div>
    <table id="joinTable">
    <tr>
        <th class="article">아이디 <span class="ast">*</span></th>
        <td>
        <div class="form-row">
          <div class="col-sm-12 ">
            <form:label path="id" cssClass="col-form-label-sm my-0 py-1"></form:label>
            <form:input  type="text" cssClass="form-control form-control-sm p-0 m-0" style="float:left;margin:0;" path="id" placeholder="이메일 형식 ex)zip@zoong.com" required="required"/>
          	<span><button type="submit" style="margin:0px 0px 0px 5px; height:30px;  border-radius:4px;" id="idck">중복확인</button></span>
            <span class="" id="errId"></span>
          </div>
        </div> 
      </td>
      </tr>
      <tr>
        <th class="article">비밀번호 <span class="ast">*</span></th>
        <td>
        <form:password cssClass="form-control form-control-sm " path="pw" placeholder="비밀번호 " required="required"/>
        <form:errors path="pw" cssClass="errMsg"></form:errors><div class=""></div>
      
        </td>
      </tr>
      <tr>
        <th class="article">비밀번호 확인 <span class="ast">*</span></th>
        <td> <input type="password" class="form-control form-control-sm " id="pwchk" name="pwchk" placeholder="비밀번호 재입력" required="required"/>
          <div class=""></div>
          </td>
      </tr>
      <tr>
        <th class="article">성명 <span class="ast">*</span></th>
        <td>
         <form:input type="text" cssClass="form-control form-control-sm " path="name" placeholder="실명을 입력해주세요" required="required"/>
           <form:errors path="name" cssClass="errMsg"></form:errors>
            <div class=""></div>
</td>
      </tr>
      <tr>
        <th class="article">주소 <span class="ast">*</span></th>
        <td>
             <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:label path="postnum" cssClass="col-form-label-sm my-0 py-1"></form:label>
            <form:input  type="text" cssClass="form-control form-control-sm "  style="float:left;margin:0;" path="postnum" placeholder="우편번호" required="required"/>
            <form:button id="postBtn" type="button" cssClass="btn btn-default" style="margin:0px 0px 0px 5px; height:30px; border-radius:4px;" ><i class="fa fa-search"></i>우편번호</form:button>                               
             <span class="" id="errPost"></span>
            <form:errors path="postnum" cssClass="errMsg"></form:errors>
            </div>
           <div class=""></div>
       </div>
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:label path="basicaddress" cssClass="col-form-label-sm my-0 py-1"></form:label>
            <form:input type="text" cssClass="form-control form-control-sm " style="width:305px;" path="basicaddress" placeholder="기본주소" required="required"/>
            <form:errors path="basicaddress" cssClass="errMsg"></form:errors>
            <div class=""></div>
          </div>
        </div> 
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:label path="restaddress" cssClass="col-form-label-sm my-0 py-1"></form:label>
            <form:input type="text" cssClass="form-control form-control-sm " style="width:305px;" path="restaddress" placeholder="상세주소" required="required"/>
            <form:errors path="restaddress" cssClass="errMsg"></form:errors>
            <div class=""></div>
          </div>
        </div> 
        </td>
      
          <tr>
            <th class="article">휴대 전화번호 <span class="ast">*</span></th>
            <td>
             <form:input type="text" cssClass="form-control form-control-sm " path="phonenum" placeholder="-포함 입력해주세요" required="required"/>
             <form:errors path="phonenum" cssClass="errMsg"></form:errors>
            <div class=""></div>
            </td>
          </tr>
        </table>
        <tr>

        <td width="100%" height="50%" align="center" >
        <p id="cont" >
        <span >
        집중 약관동의</span>
        </p>
        <textarea readonly="readonly" rows="8"  style="width:100%; font-size:12px;" id="contC">

개인정보 수집 및 이용에 대한 안내

집중 주식회사(이하 ‘집중’)는 파트너스 회원가입을 신청하시는 분께 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법령에 따라 개인정보의 수집·이용 목적, 수집하려는 개인정보의 항목, 개인정보의 보유 및 이용 기간에 대하여 안내드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 

1. 개인정보의 수집·이용 목적
이용자 가입의사 확인, 이용자 본인 식별·인증, 회원자격 유지.관리, 회원탈퇴 의사의 확인, 물품 또는 서비스 공급에 따른 금액 결제, 물품 또는 서비스의 공급.배송, 당사자간 계약이행사항 확인, 법령 및 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영, 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재, 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축 등 
2. 수집하려는 개인정보의 항목
이름/업체명, 휴대전화번호, 이메일, 영업장 주소 
3. 개인정보의 보유 및 이용 기간
원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기. 단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 아래 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 동의 내용 또는 법령의 규정의 내용 및 목적에 맞게 개인정보를 안전하게 보관. 
- 전자상거래 등에서 소비자 보호에 관한 법률
계약 또는 청약철회 등에 관한 기록: 5년 보관
 대금결제 및 재화 등의 공급에 관한 기록: 5년 보관
 소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관 
- 전자금융거래법
전자금융에 관한 기록: 5년 보관
- 통신비밀보호법
로그인 기록: 3개월
4. 개인정보의 수집·이용에 대한 동의를 거부·철회할 권리 및 그 경우의 불이익
이용자는 개인정보의 수집·이용에 대하여 동의를 하지 않을 수 있고, 언제든지 그 동의를 철회할 수 있습니다. 다만 동의를 거부·철회시 정상적인 집중 서비스 이용이 제한될 수 있습니다. 
 
회원가입

회사소개
 개인정보처리방침
 이용약관
 파트너스 문의
 
집중주식회사 대표이사 : 최집중
 주소 : 울산 남구 봉월로14번길 26-1 지번울산 남구 신정동 674-23
 사업자등록번호 : 123-22-50284
 통신판매번호 : 2018-울산남구-05921호

1400 - 1052
 월-토, 공휴일 09:00 - 18:00 /  
금요일 09:00 - 17:00 / 일요일 휴무
 팩스 : 01 - 5212 - 4313이메일  :  zipzoong.kr
        </textarea>
        <br>
              <div class="form-row">
          <div class="col-sm-12 mb-1">
            <label for="policyagree" class="col-form-label-sm my-0 py-1 mr-3"></label>
            <div >
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" id="pass" name="policyagree" value="p"/>
                <label class="form-check-label" for="pass">개인정보 처리방침에 동의합니다.</label>
              </div>
            </div>       
            <div class=""></div>
          </div>
        </div> 
        </td>

     </tr>
     <tr>
      <td align="center" valign="top">
      </td>
    </tr>
    <br>
    
    <div id="chkBtn">
      <input type="button" class="btn btn-outline-secondary" value="취소"/>&nbsp;&nbsp;&nbsp;
      <button type="submit" style="background-color: #ff8800; color:white;" class="btn btn-warning" id="joinBtn">확인</button>
          
    </div>
    <div class="row my-5"></div>
    </form:form>   



</body>
<jsp:include page="../footer.jsp"/>

</body>
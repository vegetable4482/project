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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/modify.css"/>
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
		let idTag 			= document.getElementById("id");
		let nicknameTag 			= document.getElementById("name");
		let constpostnumTag 	= document.getElementById("postnum");//공사지주소[우편번호]
		let constbasicaddressTag 	= document.getElementById("basicaddress");//공사지주소[기본주소]
		let constrestaddressTag 	= document.getElementById("restaddress");//공사지주소[상세주소]
		let telTag 	= document.getElementById("phonenum");//휴대전화

		idTag.addEventListener("blur"				,checkId,false);		
		idTag.addEventListener("change"			,checkId,false);
		idTag.addEventListener("keydown"		,checkId,false);		

		nicknameTag.addEventListener("blur"		,checkNickname,false);
		nicknameTag.addEventListener("change"	,checkNickname,false);
		nicknameTag.addEventListener("keydown",checkNickname,false);
		
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
		
		modiBtn.addEventListener("click",modiBtnf,false);
				
		function validFeedback(obj, result, msg) {
			//console.log(obj.id);
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

			return status;
		}
		
		//전화번호 체크
		function checkTel() {
			let phoneReg = /(\d{3}).*(\d{3}).*(\d{4})/;
			let status = phoneReg.test(telTag.value);
			let msg = "";
			if(phoneReg.test(telTag.value)) {
				validFeedback(telTag,status,"Pass");
			}else {
				validFeedback(telTag,status,"Wrong tel!");
			}
			return status;
		}

		
		//별칭 체크
		function checkNickname() {
      let status = nicknameTag.value.trim().length != 0;
      //console.log(nicknameTag.value, status);
      if(status) {
    	  validFeedback(nicknameTag,status,"Pass");
      }else{
    	  validFeedback(nicknameTag,status,"Insert Nickname");
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
		    	  validFeedback(constbasicaddressTag,status,"Pass");
		      }else{
		    	  validFeedback(constbasicaddressTag,status,"기본주소를 입력하세요");
		      }	
		      return status;
		}
		
		//공사지 나머제주소 체크
		function checkConstrestaddress() {
		  let status = constrestaddressTag.value.trim().length != 0;

      if(status) {
    	  validFeedback(constrestaddressTag,status,"Pass");
      }else{
    	  validFeedback(constrestaddressTag,status,"나머지주소를 입력하세요");
      }	
      return status;
		}
		
		//수정하기 버튼 클릭시
		function modiBtnf(e) {	
			e.preventDefault();
			
			let result = checkId() && checkTel() && checkNickname() && checkConstPostnum() && checkConstbasicaddress() &&
			checkConstrestaddress();
			if(result) {
      	document.getElementById("modiFrm").submit();
			}			
		}
	}
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
  <form id="modiFrm" action="${pageContext.request.contextPath }/member/memberModify" method="post">
    <input type="hidden" name="pw" value="${memberDTO.pw }" />   
      <div id="joinHeader"> <span id="h1">내정보관리</span></div>
    <div id="tipbox"><p id="tipboxH">회원 정보 수정</p>
    <ul>
      <li>아이디는 변경 할 수 없습니다.</li>
      <li>성명은 실명으로 입력 바랍니다.</li>
      <li><span class="ast">*</span> 는 필수 입력사항입니다</li>
    </ul></div>
      <table id="joinTable">
    <tr>
        <th class="article">아이디</th>
        <td>   
            <input type="email" class="form-control form-control-sm" id="id" name="id" 
            	readonly value="${memberDTO.id }"/>
            <div class=""></div>
        
      </td>
      </tr>
      <tr>
        <th class="article">성명 <span class="ast">*</span></th>
        <td>
         <div class="form-row">
          <div class="col-sm-12 mb-1">
             <input type="text" class="form-control form-control-sm " id="name" name="name" 
            	placeholder="실명을 입력하세요" required value="${memberDTO.name }"/>
            	
            <div class=""></div>
               </div>
           <div class=""></div>
       </div>
        </td>
      </tr>
      <tr>
        <th class="article">주소 <span class="ast">*</span></th>
        <td>
          <div class="form-row">
          <div class="col-sm-12 mb-1">                              
            <input  type="text" class="form-control form-control-sm " id="postnum" name="postnum" placeholder="우편번호" required="required"/>
            <button id="postBtn" type="button" class="">우편번호</button>
             <span class="" id="errPost"></span>
            </div>
           <div class=""></div>
       </div>
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <input type="text" class="form-control form-control-sm " id="basicaddress" name="basicaddress" placeholder="기본주소" required="required"/>
            <div class=""></div>
          </div>
        </div> 
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <input type="text" class="form-control form-control-sm " id="restaddress" name="restaddress" placeholder="상세주소" required="required"/>
            <div class=""></div>
          </div>
        </div> 
	</td>
      </tr>
      <tr>
        <th class="article">휴대 전화번호 <span class="ast">*</span></th>
        <td>
           <div class="form-row">
          <div class="col-sm-12 mb-1">
              <input type="text" class="form-control form-control-sm " id="phonenum" name="phonenum" 
            	placeholder="전화번호를입력하세요" required value="${memberDTO.phonenum }"/>
            <div class=""></div>
          </div>
        </div> 
      </tr>
    </table>

    <br>
    
    <div id="chkBtn">
      <input type="button" class="btn btn-outline-secondary" value="취소" onclick="chk()"/>&nbsp;&nbsp;&nbsp;
      <button type="submit" id="modiBtn" style="background-color: #ff8800; color:white;" class="btn btn-warning">수정</button>    
    </div>
   <div class="row my-5"></div>
    
  </form>



</body>
 <jsp:include page="../footer.jsp"/> 

</body>
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

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<jsp:include page="../header.jsp"/>
<script>
(function(){
	window.addEventListener("load", init, false);
	function init() {
		
		let postBtn = document.getElementById("postBtn");
		postBtn.addEventListener("click",postBtnf,false);
					
	 	let idTag 			= document.getElementById("cid");	//아이디  
		let pwTag 			= document.getElementById("cpw");	//비밀번호
		let pwchkTag 		= document.getElementById("pwchk");	//비밀번호확인
		let nicknameTag = document.getElementById("cname");	//성명
		let constpostnumTag 	= document.getElementById("cpostnum");//공사지주소[우편번호]
		let constbasicaddressTag 	= document.getElementById("cbasicaddress");//공사지주소[기본주소]
		let constrestaddressTag 	= document.getElementById("crestaddress");//공사지주소[상세주소]
		let telTag 			= document.getElementById("cphonenum");	//휴대전화
		let businessnumTag 			= document.getElementById("businessnum");	//사업자번호
		let constareaTag 			= document.getElementById("constarea");	//시공가능지역
		let consttypeTag 			= document.getElementsByName("consttype");	//시공대분류 체크박스
		let constspaceTag 			= document.getElementsByName("constspace");	//시공소분류 체크박스
		let conststyleTag 			= document.getElementsByName("conststyle");	//시공스타일 체크박스
		let cpolicyagreeTag 	= document.getElementsByName("cpolicyagree");
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
		
		businessnumTag.addEventListener("blur"		,checkBusinessnum,false);
		businessnumTag.addEventListener("change"	,checkBusinessnum,false);
		businessnumTag.addEventListener("keydown"	,checkBusinessnum,false);
		
		constareaTag.addEventListener("blur"		,checkConstarea,false);
		constareaTag.addEventListener("change"	,checkConstarea,false);
		constareaTag.addEventListener("keydown"	,checkConstarea,false);
				
		nicknameTag.addEventListener("blur"		,checkNickname,false);
		nicknameTag.addEventListener("change"	,checkNickname,false);
		nicknameTag.addEventListener("keydown",checkNickname,false);
		
		Array.from(cpolicyagreeTag).forEach(function(item) {
			item.addEventListener("blur"	,checkCpolicyagree,false);
			item.addEventListener("change",checkCpolicyagree,false);
		});
		
		
		Array.from(consttypeTag).forEach(function(item) {
			item.addEventListener("blur"	,checkConsttype,false);
			item.addEventListener("change",checkConsttype,false);
		});
		
		
		Array.from(constspaceTag).forEach(function(item) {
			item.addEventListener("blur"	,checkConstspace,false);
			item.addEventListener("change",checkConstspace,false);
		});
		
		
		Array.from(conststyleTag).forEach(function(item) {
			item.addEventListener("blur"	,checkConststyle,false);
			item.addEventListener("change",checkConststyle,false);
		});
		
		
		joinBtn.addEventListener("click",joinBtnf,false);
				
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
				validFeedback(pwTag,status,"Pass");
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
				validFeedback(pwchkTag,status,"Pass");
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
				
		//전화번호 체크
		function checkTel() {
			let phoneReg = /(\d{3})-(\d{3,4})-(\d{4})/;
			let status = phoneReg.test(telTag.value);
			let msg = "";
			if(phoneReg.test(telTag.value)) {
				validFeedback(telTag,status,"Pass");
			}else {
				validFeedback(telTag,status,"전화번호를 잘못 입력하셨습니다");
			}
			return status;
		}

		// 사업자번호 체크
		function checkBusinessnum() {
			let phoneReg = /(\d{3})-(\d{3,4})-(\d{4})/;
			let status = phoneReg.test(businessnumTag.value);
			let msg = "";
			if(phoneReg.test(businessnumTag.value)) {
				validFeedback(businessnumTag,status,"Pass");
			}else {
				validFeedback(businessnumTag,status,"사업자번호를 입력하세요");
			}
			return status;
		}
		

		// 시공가능지역 체크
		function checkConstarea() {
			  let regionText = constareaTag.options[constareaTag.selectedIndex].text;
			  let regionValue = constareaTag.options[constareaTag.selectedIndex].value;
			  
	      let status = regionValue != 0 ? true : false;
	      if(status) {
	    	  validFeedback(constareaTag,status,"유효성 통과");
	      }else{
	    	  validFeedback(constareaTag,status,"지역을 선택하세요!");
	      }	
	      return status;
		}
		
		// 시공 대분류 체크
		function checkConsttype() {
			let status = false;
			Array.from(consttypeTag).forEach(function(item){
				if(item.checked) {
					status = true;
				}
			});
      if(status) {
    	  validFeedback(consttypeTag[0].parentElement.parentElement,status,"유효성 통과");
      }else{
    	  validFeedback(consttypeTag[0].parentElement.parentElement,status,"시공 대분류를 선택하세요!");
      }		

      return status;
		}
		
		// 시공 소분류 체크
		function checkConstspace() {
			let status = false;
			Array.from(constspaceTag).forEach(function(item){
				if(item.checked) {
					status = true;
				}
			});
      if(status) {
    	  validFeedback(constspaceTag[0].parentElement.parentElement,status,"유효성 통과");
      }else{
    	  validFeedback(constspaceTag[0].parentElement.parentElement,status,"시공 소분류를 선택하세요!");
      }		

      return status;
		}
		
		// 시공 스타일 체크
		function checkConststyle() {
			let status = false;
			Array.from(conststyleTag).forEach(function(item){
				if(item.checked) {
					status = true;
				}
			});
      if(status) {
    	  validFeedback(conststyleTag[0].parentElement.parentElement,status,"유효성 통과");
      }else{
    	  validFeedback(conststyleTag[0].parentElement.parentElement,status,"시공 스타일을 선택하세요!");
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
    	  validFeedback(nicknameTag,status,"Insert nick!");
      }			
      return status;
		}
		
		//약관 체크
		function checkCpolicyagree() {
			let status = false;
			Array.from(cpolicyagreeTag).forEach(function(item){
				if(item.checked) {
					status = true;
				}
			});
      if(status) {
    	  validFeedback(cpolicyagreeTag[0].parentElement.parentElement,status,"유효성 통과");
      }else{
    	  validFeedback(cpolicyagreeTag[0].parentElement.parentElement,status,"약관을 선택하세요!");
      }		

      return status;
		}
				
		//가입하기 버튼 클릭시
		function joinBtnf(e) {
			e.preventDefault();
			let result = checkId() && checkPw() && checkPwchk() && checkConstPostnum() && 
			checkConstbasicaddress() && checkConstrestaddress() && checkTel() && checkBusinessnum() && checkConstarea() && checkNickname() && 
			checkCpolicyagree() && checkConsttype() && checkConstspace() && checkConststyle();		
			console.log(result);
			if(result) {
      	alert('회원가입이완료되었습니다.');
      	document.getElementById("cdto").submit();
			}
		}				
	}	
	var idck = 0;
	var url = "${pageContext.request.contextPath }/company/cidcheck"; //공통 URL요청		
	 $(function() {			  
	      //idck 버튼을 클릭했을 때 
	      $("#idck").click(function() {  
	          var userid =  $("#cid").val(); 
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
	                    $("#cid").val('');
	                  	$("#cid").focus();
	                  } else {
	                      alert("사용가능한 아이디입니다.");
	                      //아이디가 중복하지 않으면  idck = 1 
	                      idck = 1;	    
	                  }
	              },
	              error : function(error) {                  
	/*                   alert("error : " + error); */
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
               
               
               $("[name=cpostnum]").val(data.zonecode);
               $("[name=cbasicaddress]").val(fullRoadAddr);              
           }
        }).open();
			}
})();

</script> 

<body>
<hr>
<form:form modelAttribute="cdto" action="${pageContext.request.contextPath }/company/cmemberJoin">
     <div id="joinHeader"> <span id="h1">업체등록</span><span id="msg"><span class="ast">*</span> 는 필수 입력사항입니다</span></div>
    <table id="joinTable">
      <tr>
        <th class="article" >아이디 <span class="ast">*</span></th>
        <td>
         <div class="form-row">
          <div class="col-sm-12 ">
            <form:label path="cid" cssClass="col-form-label-sm my-0 py-1"></form:label>
            <form:input  type="text" style="float:left;margin:0;"  cssClass="form-control form-control-sm" path="cid" placeholder="이메일 형식 ex)zip@zoong.com" required="required"/>
          	<button type="submit" style="margin:0px 0px 0px 5px; height:30px;  border-radius:4px;" id="idck">중복확인</button>
            <span class="" id="errId"></span>
          </div>
        </div> 
      </td>
      </tr>
      <tr>
 			  <th class="article">비밀번호 <span class="ast">*</span></th>
        <td>
        <form:password cssClass="form-control form-control-sm " path="cpw" placeholder="비밀번호 " required="required"/>
        <form:errors path="cpw" cssClass="errMsg"></form:errors><div class=""></div>
        </td>
      </tr>
      <tr>
        <th class="article">비밀번호 확인 <span class="ast">*</span></th>
        <td> <input type="password" class="form-control form-control-sm " id="pwchk" name="pwchk" placeholder="비밀번호 재입력" required="required"/>
          <div class=""></div>
          </td>
      </tr>
      <tr>
        <th class="article">업체명 <span class="ast">*</span></th>
        <td>
         <form:input type="text" cssClass="form-control form-control-sm " path="cname" placeholder="업체명을 입력하세요" required="required"/>
         <form:errors path="cname" cssClass="errMsg"></form:errors>
         <div class=""></div>
				</td>
      </tr>
       <tr>
        <th class="article">주소 <span class="ast">*</span></th>
        <td>
             <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:label path="cpostnum" cssClass="col-form-label-sm my-0 py-1"></form:label>
            <form:input  type="text" cssClass="form-control form-control-sm " style="float:left;margin:0;"  path="cpostnum" placeholder="우편번호" required="required"/>
            <form:button id="postBtn" type="button" cssClass="btn btn-default" style="margin:0px 0px 0px 5px; height:30px;  border-radius:4px;"><i class="fa fa-search"></i>우편번호</form:button>                               
             <span class="" id="errPost"></span>
            <form:errors path="cpostnum" cssClass="errMsg"></form:errors>
            </div>
           <div class=""></div>
       </div>
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:label path="cbasicaddress" cssClass="col-form-label-sm my-0 py-1"></form:label>
            <form:input type="text" cssClass="form-control form-control-sm " style="width:305px;"  path="cbasicaddress" placeholder="기본주소" required="required"/>
            <form:errors path="cbasicaddress" cssClass="errMsg"></form:errors>
            <div class=""></div>
          </div>
        </div> 
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:input type="text" cssClass="form-control form-control-sm "  style="width:305px;"  path="crestaddress" placeholder="상세주소" required="required"/>
            <form:errors path="crestaddress" cssClass="errMsg"></form:errors>
            <div class=""></div>
          </div>
        </div> 
        </td>
      <tr>
      <tr>
        <th class="article">전화번호 <span class="ast">*</span></th>
        <td>
            <form:input type="text" cssClass="form-control form-control-sm " path="cphonenum" placeholder="-포함 입력해주세요" required="required"/>
            <form:errors path="cphonenum" cssClass="errMsg"></form:errors>
            <div class=""></div>
        </td>
      </tr>
      <tr>
        <th class="article">사업자번호 <span class="ast">*</span></th>
        <td>
			    <form:input type="text" cssClass="form-control form-control-sm " path="businessnum" placeholder="-포함 입력해주세요" required="required"/>
           <form:errors path="businessnum" cssClass="errMsg"></form:errors>
                <div class=""></div>
        </td>
      </tr>
      <tr>
     
					<th class="article">시공지역 <span class="ast">*</span></th>
           	<td>

            <form:label path="constarea"  cssClass="col-form-label-sm my-0 py-1"></form:label>
            <form:select path="constarea"  cssClass="form-control form-control-sm ">
              <option value=0>== 선 택 ==</option>
              <form:options path="constarea"  items="${constarea }" itemValue="code" itemLabel="label"/>
            </form:select>
            <form:errors path="constarea"  cssClass="errMsg"></form:errors>          
            <div class=""></div>
      	</td>

      </tr>
      <tr>
        <th class="article">시공 대분류 <span class="impos"> (중복선택가능)</span><span class="ast">*</span>
          </th>
        <td> 

           <div class="noborder form-control form-control-sm " style="height: auto; border:none; width:500px;">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="consttype" name="consttype" value="아파트"/>
                <label class="form-check-label" for="consttype">아파트</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="consttype" name="consttype" value="빌라"/>
                <label class="form-check-label" for="consttype">빌라</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="consttype" name="consttype" value="주택"/>
                <label class="form-check-label" for="consttype">주택</label>
              </div> 
   						</div>
            <div class=""></div> 
          </td>
      </tr>
      <tr>
          <th class="article">공사지 공간 <div class="impos"> (중복선택가능)</div><span class="ast">*</span></th>
          <td>
            <div class="noborder form-control form-control-sm " style="height: auto;  border:none; width:500px;">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="constspace" name="constspace" value="거실"/>
                <label class="form-check-label" for="constspace">거실</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="constspace" name="constspace" value="주방"/>
                <label class="form-check-label" for="constspace">주방</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="constspace" name="constspace" value="현관"/>
                <label class="form-check-label" for="constspace">현관</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="constspace" name="constspace" value="베란다/샷시"/>
                <label class="form-check-label" for="constspace">베란다/샷시</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="constspace" name="constspace" value="욕실"/>
                <label class="form-check-label" for="constspace">욕실</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="constspace" name="constspace" value="침실"/>
                <label class="form-check-label" for="constspace">침실</label>
              </div> 
  				 	</div>
            <div class=""></div>		
          </td>
     </tr>
      <tr>
        <th class="article">시공 스타일 <span class="impos"> (중복선택가능)</span><span class="ast">*</span></th>
        <td>
             <div class="noborder form-control form-control-sm " style="height: auto;  border:none; width:500px;">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="conststyle" name="conststyle" value="모던"/>
                <label class="form-check-label" for="conststyle">모던</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="conststyle" name="conststyle" value="클래식"/>
                <label class="form-check-label" for="conststyle">클래식</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="conststyle" name="conststyle" value="빈티지"/>
                <label class="form-check-label" for="conststyle">빈티지</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="conststyle" name="conststyle" value="인더스트리얼"/>
                <label class="form-check-label" for="conststyle">인더스트리얼</label>
              </div> 
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="conststyle" name="conststyle" value="미니멀리즘"/>
                <label class="form-check-label" for="conststyle">미니멀리즘</label>
              </div> 
   					</div>
            <div class=""></div>
          </td>
      </tr>
    </table>
    <tr>
      <td width="100%" height="50%" align="center">
      <p id="cont" >
      <span >집중 약관동의</span>
      </p>
      <textarea readonly="readonly" rows="5" style="width:100%;" id="contC" >
    
인테리어 정보 수신 동의

집중 주식회사는 회원들께 더 나은 서비스를 제공하고자 정보 제공  목 적의 개인정보 수집 및 이용에 대한 동의를 받고자 합니다. 내용을 자세히 읽으신 후, 동의를 원하시면 원래의 화면으로 돌아가 "동의"에 체크하신 후 다음 단계로 넘어가시면 됩니다. 보다 자세한 내용은 회사 홈페이지에 게시된 개인정보 처리방침을 참조하여 주시기 바랍니다.

목적
- 집중의 상품, 서비스에 대한 정보, 광고, 홍보
처리하는 개인정보 항목
- 이름, 휴대전화번호, 이메일 주소, 영업장 주소 
개인정보 보유 및 이용기간
정보 제공 목적의 개인정보 수집, 이용에 대한 동의 시부터 동의 철회 또는 회원 탈퇴시까지 (최대 2년간) 
정보 제공 항목은 선택 사항이므로 동의를 거부하는 경우에도 집중 서비스의 이용에는 영향이 없습니다. 또한 정보  수신 동의는 고객 센터를 통해 언제든지 철회할 수 있습니다. 

      </textarea>
      <br>
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <label for="cpolicyagree" class="col-form-label-sm my-0 py-1 mr-3"></label>
            <div >
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" id="pass" name="cpolicyagree" value="p"/>
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
</html>
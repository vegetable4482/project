<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumBarunGothic@1.0/nanumbarungothicsubset.css">
 <!-- form css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/form.css"/>
<!--Bootstrap-->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">

<!-- jQuery ui css -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<!-- jQuery 기본 js파일 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<!-- jQuery ui 라이브러리 js파일 -->
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<jsp:include page="../header.jsp"/>
<script>
// jQuery import 바로아래에 넣어 주면 됩니다.
// Cannot read property 'msie' of undefined 에러 나올때
jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();
</script>
<script>		
(function(){
	window.addEventListener("load", init, false);
	function init() {
		let postBtn = document.getElementById("postBtn");
		postBtn.addEventListener("click",postBtnf,false);
		
		$(function() {
			  $( "#constdate" ).datepicker({
			         changeMonth: true, 
			         changeYear: true,
			         nextText: '다음 달',
			         prevText: '이전 달' 
			  });
			});
		
		let custnameTag 			= document.getElementById("custname"); //성함
		let custphonenumTag 			= document.getElementById("custphonenum");//전화번호
		let consttypeTag 		= document.getElementById("consttype");//공사지유형
		let constspaceTag 		= document.getElementsByName("constspace");//공사지유형
		let constdateTag 			= document.getElementById("constdate");//공사예정날짜
		let constpostnumTag 	= document.getElementById("constpostnum");//공사지주소[우편번호]
		let constbasicaddressTag 	= document.getElementById("constbasicaddress");//공사지주소[기본주소]
		let constrestaddressTag 	= document.getElementById("constrestaddress");//공사지주소[상세주소]
		let intestyleTag = document.getElementById("conststyle");//인테리어스타일
		let custrequestTag = document.getElementById("custrequest");//요청사항
		let joinBtn     = document.getElementById("joinBtn");//신청하기버튼
		let cancelBtn   = document.getElementById("cancelBtn");//취소버튼
		
		
		custnameTag.addEventListener("blur"				,checkCustname,false);		
		custnameTag.addEventListener("change"			,checkCustname,false);
		custnameTag.addEventListener("keydown"		,checkCustname,false);
		
		custphonenumTag.addEventListener("blur"				,checkCustPhonenum,false);		
		custphonenumTag.addEventListener("change"			,checkCustPhonenum,false);
		custphonenumTag.addEventListener("keydown"		,checkCustPhonenum,false);
				
		consttypeTag.addEventListener("blur"		,checkConsttype,false);
		consttypeTag.addEventListener("change"	,checkConsttype,false);
		consttypeTag.addEventListener("keydown"	,checkConsttype,false);

		 
		constdateTag.addEventListener("blur"			,checkConstdate,false);
		constdateTag.addEventListener("change"		,checkConstdate,false);
		constdateTag.addEventListener("keydown"		,checkConstdate,false);
		
		constpostnumTag.addEventListener("blur"			,checkConstPostnum,false);
		constpostnumTag.addEventListener("change"		,checkConstPostnum,false);
		constpostnumTag.addEventListener("keydown"		,checkConstPostnum,false);
		
		constbasicaddressTag.addEventListener("blur"		,checkConstbasicaddress,false);
		constbasicaddressTag.addEventListener("change"	,checkConstbasicaddress,false);
		constbasicaddressTag.addEventListener("keydown",checkConstbasicaddress,false);
		
		constrestaddressTag.addEventListener("blur"		,checkConstrestaddress,false);
		constrestaddressTag.addEventListener("change"	,checkConstrestaddress,false);
		constrestaddressTag.addEventListener("keydown",checkConstrestaddress,false);
			
		intestyleTag.addEventListener("blur"		,checkIntestyle,false);
		intestyleTag.addEventListener("change"	,checkIntestyle,false);
		intestyleTag.addEventListener("keydown" ,checkIntestyle,false);
		
		custrequestTag.addEventListener("blur"		,checkRequest,false);
		custrequestTag.addEventListener("change"	,checkRequest,false);
		custrequestTag.addEventListener("keydown" ,checkRequest,false);
		
		Array.from(constspaceTag).forEach(function(item) {
			item.addEventListener("blur"	,checkConstspace,false);
			item.addEventListener("change",checkConstspace,false);
		});
		
		joinBtn.addEventListener("click",joinBtnf,false);
		cancelBtn.addEventListener("click",function(){
			
			document.location.href="${pageContext.request.contextPath }";
			
		},false);
		

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
		
		// 성함 체크   
		function checkCustname() {
			let emailReg = /^[가-힣]{2,5}$/;
			let status = emailReg.test(custnameTag.value);
			let msg = "";
			if(status) {
				validFeedback(custnameTag,status,"OK");
			}else{
				validFeedback(custnameTag,status,"성함을 입력하세요");
			}
			return status;
		}

    // 전화번호 체크 
		function checkCustPhonenum() {
		  let pwdReg =/(\d{3})-(\d{3,4})-(\d{4})/;
			let status = pwdReg.test(custphonenumTag.value);
			let msg = "";
			if(status) {
				validFeedback(custphonenumTag,status,"OK");
			}else{
				validFeedback(custphonenumTag,status,"전화번호를 입력하세요");
			}
			return status;
		}
    
		// 공사지유형 체크
		function checkConsttype() {
			 let consttypeText = consttypeTag.options[consttypeTag.selectedIndex].text;
			  let consttypeValue = consttypeTag.options[consttypeTag.selectedIndex].value;
			  
	      let status = consttypeValue != 0 ? true : false;
	      if(status) {
	    	  validFeedback(consttypeTag,status,"OK");
	      }else{
	    	  validFeedback(consttypeTag,status,"공사유형을 선택하세요");
	      }	
	      return status;
		}
		
 		// 공사지공간 체크
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
    	  validFeedback(constspaceTag[0].parentElement.parentElement,status,"공사지 공간을 선택하세요!");
      }		

      return status;
		}
 

		
		//공사예정날짜 체크
		function checkConstdate() {
			let phoneReg = /^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/;
			let status = phoneReg.test(constdateTag.value);
			let msg = "";
			if(phoneReg.test(constdateTag.value)) {
				validFeedback(constdateTag,status,"OK");
			}else {
				validFeedback(constdateTag,status,"공사 예정 날짜를 입력하세요");
			}
			return status;
		}
	
		//공사지 기본주소 체크
			  function checkConstbasicaddress() {
					let status = constbasicaddressTag.value.trim().length != 0;

				      if(status) {
				    	  validFeedback(constbasicaddressTag,status,"OK");
				      }else{
				    	  validFeedback(constbasicaddressTag,status,"기본주소 입력하세요");
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
		
		
		//인테리어 스타일 체크
		function checkIntestyle() {
			 let intestyleText = intestyleTag.options[intestyleTag.selectedIndex].text;
			  let intestyleValue = intestyleTag.options[intestyleTag.selectedIndex].value;
			  
	      let status = intestyleValue != 0 ? true : false;
	      if(status) {
	    	  validFeedback(intestyleTag,status,"OK");
	      }else{
	    	  validFeedback(intestyleTag,status,"인테리어 스타일을 선택하세요");
	      }	
	      return status;
		}
				
		//인테리어 요청사항 체크
		function checkRequest() {
      let status = custrequestTag.value.trim().length != 0;
      //console.log(nicknameTag.value, status);
      if(status) {
    	  validFeedback(custrequestTag,status,"OK");
      }else{
    	  validFeedback(custrequestTag,status,"요청사항을 입력하세요");
      }			
      return status;
		}
		
		
		//가입하기 버튼 클릭시
		function joinBtnf(e) {
			e.preventDefault();
			
			let result = checkCustname() && checkCustPhonenum() && 
			checkConsttype() && checkConstdate() && checkConstspace() &&
			checkConstPostnum() && checkConstrestaddress() && checkConstbasicaddress() && checkIntestyle() && checkRequest();
			if(result) {
      	alert('업체 매칭 서비스 신청이 완료되었습니다!');
      	document.getElementById("edto").submit();
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
               
               
               $("[name=constpostnum]").val(data.zonecode);
               $("[name=constbasicaddress]").val(fullRoadAddr);              
           }
        }).open();
	}
})();
</script>
<!-- jquery.ui datapicker 관련 css, js -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style>
   body  { font-family: 'NanumBarunGothic', sans-serif; }
  table {
    width: 100%;

    border-collapse: collapse;
  }
  th, td {
     border: 1px solid rgb(223, 223, 223); 
    padding: 10px;
    font-weight: 400
  }
  .article{
    background-color: rgb(245, 245, 245); 
    padding-left: 20px;
    color :rgb(70, 70, 70);
    width:150px;
    font-size: 0.9em;
  }
  #joinForm{
    margin: 0 25%;
  }
  input[type="text"] , input[type="email"],input[type="password"],input[type="tel"]{
      height: 30px;
      margin : 3px 0 ;
      width: 200px;
  }
  #postBtn{
    width:100px;
    background-color: white;
    border: 1px #ccc solid;
    padding: 3px 5px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    cursor: pointer;
  }
  #joinForm > #joinTable{
    border: 1px #ccc red;
    outline: 1px #ccc red;
  }
  #h1{
    color: #ff8800;
    font-size: 50px;
    font-family: 'NanumSquare', sans-serif; 
    font-weight: 800;

  }
  #joinForm > #chkBtn{
    text-align: right;
  }
  #cont{
    padding-top:20px;
    font-size: 20px;
    font-weight: 500;
  }
  #sample6_address , #sample6_detailAddress{
    width: 400px;
  }
  ::placeholder{
    font-size: 0.8em;
    padding-left: 10px;
  }
  span.ast{
    color:#ff8800;
  }
  span#msg{
    font-size: 0.9em;
    float: right;
    display: block;
    padding-top:50px;

  }
 
  @media screen and (max-width:768px) {
    th{
    border:none;
    display: block;
  }
  td{
    display: list-item;
    list-style: none;
  

  }
  .article{
    background-color: rgb(255, 255, 255); 
    padding-left: 20px;
    color :rgb(70, 70, 70);
    width:150px;
    font-size: 0.9em;
  }
  textarea#contC{
    width:308px;
  }
  #joinForm{
    margin: 0 2%;
  }
  input[type="text"] , input[type="password"],input[type="email"],input[type="tel"],#sample6_address , #sample6_detailAddress{
      height: 20px;
      margin : 3px 0 ;
      width: 290px;
      border:none;
  }
  #sample6_address , #sample6_detailAddress ,#sample6_extraAddress{
      border : 1px solid rgb(238, 238, 238);
      height:30px;
  }


  #sample6_postcode{
    width: 178px;
  }
  #joinHeader , #joinForm > #chkBtn{
    margin-top: 20px;
    text-align: center;
  }
  .btn{
    width:100px;
  }

  }


  
</style>
<body>
<hr>
  <form:form modelAttribute="edto" action="${pageContext.request.contextPath }/request/request">
      <input type="hidden" name="custid" value="${sessionScope.user.id }"/>
      <input type="hidden" name="csubmitstatus" value="W"/>
      <div id="joinHeader"> <span id="h1">업체추천받기</span><span id="msg"><span class="ast">*</span> 는 필수 입력사항입니다</span></div>
    <table id="joinTable">
    <tr>
        <th class="article">성함 <span class="ast">*</span></th>
        <td>
          <form:input  type="text" cssClass="form-control form-control-sm" path="custname" placeholder="성함" required="required"/>
         <form:errors path="custname" cssClass="errMsg"></form:errors>
            <div class=""></div>
      </td>
      </tr>
      <tr>
        <th class="article">전화번호 <span class="ast">*</span></th>
        <td>
        <form:input  type="text" cssClass="form-control form-control-sm " path="custphonenum" placeholder="-포함 입력해주세요" required="required"/>
        <form:errors path="custphonenum" cssClass="errMsg"></form:errors>
         <div class=""></div>          
        </td>
      </tr>
      <tr>
        <th class="article">공사지 유형 <span class="ast">*</span></th>
        <td>
            <form:select path="consttype" cssClass="EBcon form-control form-control-sm " style="height: auto; width:200px;">
              <option value=0>== 선택 ==</option>
              <form:options path="consttype" items="${consttype }" itemValue="code" itemLabel="label"/>
            </form:select>
            <form:errors path="consttype" cssClass="errMsg"></form:errors>          
            <div class=""></div>
        
          </td>
      </tr>
      <tr>
      	<th class="article">공사지 공간 <span class="ast">*</span></th>
      <td>
        <div class="form-row">
          <div class="col-sm-12 mb-1">
              <div class="form-control form-control-sm " style="height: auto; border:none;">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="constspace" name="constspace" value="전체"/>
                <label class="form-check-label" for="constspace">전체</label>
              </div>
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
          </div>
        </div> 
	   </td>
     
      <tr>
        <th class="article">공사 예정 날짜 <span class="ast">*</span></th>
        <td>
            <form:input type="text" cssClass="form-control form-control-sm "  path="constdate" placeholder="미정일시 금일자로 선택해주세요" required="required"/>
            <form:errors path="constdate" cssClass="errMsg"></form:errors>
            <div class=""></div>
				</td>
      </tr>
      <tr>
        <th class="article">공사지 주소 <span class="ast">*</span></th>
        <td>
              <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:input  type="text" cssClass="form-control form-control-sm m-0" style="float:left;margin:0;" path="constpostnum"  placeholder="우편번호" required="required"/>
            <form:button id="postBtn" type="button" cssClass="btn btn-default" style="margin:0px 0px 0px 5px; height:30px;  border-radius:4px;" ><i class="fa fa-search"></i>우편번호</form:button>                               
             <span class="" id="errPost"></span>
            <form:errors path="constpostnum"  cssClass="errMsg"></form:errors>
            </div>
           <div class=""></div>
       </div>
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:input type="text" cssClass="form-control form-control-sm " style="width:305px;" path="constbasicaddress"  placeholder="기본주소" required="required"/>
            <form:errors path="constbasicaddress"  cssClass="errMsg"></form:errors>
            <div class=""></div>
          </div>
        </div> 
          <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:input type="text" cssClass="form-control form-control-sm " style="width:305px;" path="constrestaddress" placeholder="상세주소" required="required"/>
            <form:errors path="constrestaddress" cssClass="errMsg"></form:errors>
            <div class=""></div>
          </div>
        </div> 

</td>
      </tr>
      <tr>
        <th class="article">인테리어 스타일 <span class="ast">*</span></th>
        <td>
                <div class="form-row">
          <div class="col-sm-12 mb-1">
            <form:select path="conststyle" cssClass="form-control form-control-sm " style="height: auto; width:200px;">
              <option value=0>== 인테리어스타일 ==</option>
              <form:options path="conststyle" items="${conststyle }" itemValue="code" itemLabel="label"/>
            </form:select>
            <form:errors path="conststyle" cssClass="errMsg"></form:errors>          
            <div class=""></div>
          </div>
        </div> 
        </td>
      </tr>
      <tr>
       <th class="article">요청 사항 <span class="ast">*</span></th>
       <td>
           <form:textarea  row="20" cssClass="form-control form-control-sm " path="custrequest" placeholder="요청사항" required="required"/>
            <form:errors path="custrequest" cssClass="errMsg"></form:errors>
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
        <textarea readonly="readonly" rows="5" style="width:100%;" id="contC">가. 수집하는 개인정보의 항목첫째, 회사는 회원가 입, 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다.
     회원가입
     - 이름, 생년월일, 성별, 아이디, 비밀번호, 별명, 연락처(메일주소, 휴대폰 번호 중 선택), 가입인증정보
     만14세 미만 아동 회원가입
     - 이름, 생년월일, 성별, 법정대리인 정보, 아이디, 비밀번호, 연락처 (메일주소, 휴대폰 번호 중 선택), 가입인증정보
     단체아이디 회원가입
     - 단체아이디, 회사명, 대표자명, 대표 전화번호, 대표 이메일 주소, 단체주소, 관리자 아이디, 관리자 연락처, 관리자 부서/직위
     - 선택항목 : 대표 홈페이지, 대표 팩스번호
     둘째, 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
     - IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록
     셋째, 네이버 아이디를 이용한 부가 서비스 및 맞춤식 서비스 이용 또는 이벤트 응모 과정에서 해당 서비스의 이용자에 한해서만 개인정보 추가 수집이 발생할 수 있으며, 이러한 경우 별도의 동의를 받습니다.
        </textarea>
        <br>
        <input type="checkbox" name="req"> 개인정보 수집 및 이용에 동의합니다.
        </td>

     </tr>
     <tr>
      <td align="center" valign="top">
      </td>
    </tr>
    <br>
    
    <div id="chkBtn">
      <input type="button" class="btn btn-outline-secondary" id="cancelBtn" value="취소"/>&nbsp;&nbsp;&nbsp;
      <input type="button" style="background-color: #ff8800; color:white;" class="btn btn-warning" value="업체매칭신청" id="joinBtn"/>    
    </div>
    <div class="row my-5"></div>
  </form:form>
</body>
<jsp:include page="../footer.jsp"/>
</html>
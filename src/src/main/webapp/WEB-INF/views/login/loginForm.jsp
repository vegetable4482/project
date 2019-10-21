<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>집중 :: 로그인</title>
<!--Bootstrap-->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumBarunGothic@1.0/nanumbarungothicsubset.css">
<jsp:include page="../header.jsp"/>

</head>
<style>
  /* *{
     outline: #ccc 1px solid; 
  } */
  
  /*  body  { font-family: 'NanumBarunGothic', sans-serif !important; } */

  #loginForm, #cloginForm{
    margin: 0px auto;
    width:580px;
    text-align: center;
  }
  input[type="text"] , input[type="password"],input[type="email"]{
      height: 50px;
      margin : 10px 0 ;
      width: 570px;
      border:none;
      border: 1px solid #ccc;
      border-radius: 0.5em;
  }
  
  #loginH {
    color: #585858;
    font-size: 50px;
    font-family: 'NanumSquare', sans-serif; 
    font-weight: 700;
    text-align: center;
    padding:50px;

  }

  ::placeholder{

    padding-left: 10px;
  }
  .full_login_wrap{
    outline: rgb(243, 243, 243) 2px solid; 

  }
  
  .full_login_wrap > div > div > ul >li >a{
    color: rgb(133, 133, 133);

  }
 
  #MpwFind , #CpwFind{
    border-left: 1px solid #ccc;
    border-right: 1px solid #ccc;

  }
  .linkrow > .row{
    padding :15px 0px;
    width: 580px;
  }
  .linkrow > .row > div{
    padding : 0;
  }
  .mdT {
	width: 290px;
	height: 60px;
	border: 0px;
	outline: 0;
	vertical-align: middle;
	background-color: #AAAAAA;
  margin:0px; padding: 0px;
}
 .login_btn_wrap{
   margin-top:40px;
 }

 .login_form01, .login_form02{
   margin-top:40px;
 }
 .linkrow{
 padding: 10px 0px;
 }

  @media screen and (max-width:767px) {
    #loginForm{
      width:310px;
    }
    .mdT {
      width: 155px;
    }
    input[type="text"] , input[type="password"],input[type="email"]{
      height: 40px;
      margin : 10px 0 ;
      width: 300px;
    }  
    .linkrow > .row{
    padding :10px 10px;
    margin:0px;
    width: 310px; 
  }
    #loginH {

      font-size: 40px;

    }
  }
</style>
<script>
   window.addEventListener("load", init, false);
   function init(){
	   
   var loginBtn = document.getElementById("loginBtn");
   var cloginBtn = document.getElementById("cloginBtn");
   var joinBtn = document.getElementById("joinBtn");
   var cjoinBtn = document.getElementById("cjoinBtn");
		  loginBtn.addEventListener("click",loginBtnf,false);
		  cloginBtn.addEventListener("click",cloginBtnf,false);
		  joinBtn.addEventListener("click",JoinBtnf,false);
		  cjoinBtn.addEventListener("click",CJoinBtnf,false);

		  function JoinBtnf(){
				document.location.href="${pageContext.request.contextPath }/member/memberJoinForm";		
			}
		  function CJoinBtnf(){
				document.location.href="${pageContext.request.contextPath }/company/companyJoinForm";		
			}

      var memberF = document.getElementById("loginForm");
      var companyF = document.getElementById("cloginForm");

      var md1 = document.getElementById("md1"); //회원 회원버튼
      var md2 = document.getElementById("md2"); //회원 업체버튼
      var md3 = document.getElementById("md3"); //업체 회원버튼
      var md4 = document.getElementById("md4"); //업체 업체 버튼
     	
      //초기 스타일
      md1.style ="background-color : orange; color:white;";
      md2.style ="border-bottom : 3px orange solid; background-color : white";
      memberF.style="display:block";
      companyF.style="display:none";
      
      md1.addEventListener("click",function(){
          md1.style ="background-color : orange; color:white;";
          md2.style ="border-bottom : 3px orange solid; background-color : white";
          memberF.style="display:block";
           companyF.style="display:none";
      },false);
      
      
      md2.addEventListener("click",function(){
          md4.style ="background-color : orange; color:white;";
          md3.style ="border-bottom : 3px orange solid; background-color : white";
          memberF.style="display:none";
           companyF.style="display:block";
        },false);
      
      
      md3.addEventListener("click",function(){
          md3.style ="background-color : orange; color:white;";
          md4.style ="border-bottom : 3px orange solid; background-color : white";
          memberF.style="display:block";
           companyF.style="display:none";
      },false);
      

}
      function loginBtnf() {
    	 console.log('로그인버튼');
  		//유효성 체크
  		//1) 아이디
  		let idTag = document.getElementById("id");
  		if(idTag.value.length == 0) {
  		  alert('아이디를 입력하세요');
  			return false;
  		}
  		
  		//2) 비밀번호
  		let pwTag = document.getElementById("pw");		
  		if(pwTag.value.length == 0) {
  			alert('비밀번호를 입력하세요');
  			return false;
  		}
  		//양식을 서버에 전송
  		document.getElementById("loginForm").submit();
  	}
 
      function cloginBtnf() {
    	 console.log('업체로그인');
  		//유효성 체크
  		//1) 아이디
  		let idTag = document.getElementById("cid");
  		if(idTag.value.length == 0) {
  		  alert('아이디를 입력하세요');
  			return false;
  		}
  		
  		//2) 비밀번호
  		let pwTag = document.getElementById("cpw");		
  		if(pwTag.value.length == 0) {
  			alert('비밀번호를 입력하세요');
  			return false;
  		}
  		
  		//양식을 서버에 전송
  		document.getElementById("cloginForm").submit();
  	}
	 
 
</script>
<body>
		<hr>
    <form name="login_form_member" id="loginForm" action="${pageContext.request.contextPath }/login/loginOk" method="post">
      <div id="loginH"> <span id="h1">회원 로그인</span></div>
      
      
      <div class="full_login_wrap">
   
          <input type="button" class="mdT md1 " id="md1" value="회원"><input type="button" class="mdT md2" id="md2" value="업체">

          <div class="login_form01" id="login_form01">
              <div class="id_input">
                  <input type="email" id="id" name="id" placeholder="회원 ID" title="회원 ID" />

              </div>
              <div class="pw_input"><input type="password" id="pw" name="pw" placeholder="비밀번호" /></div>
              <div class="login_btn_wrap"  id="loginBtn">
                 <img src="https://ssl.nx.com/s2/game/maplestory/renewal/login_full/login_btn02.png" width="100%"alt="로그인" />
              </div>
              <div class="linkrow">
                  <div class="row m-0 p-0">
                    <div class="col-4 text-center">
                      아이디 찾기
                    </div>
                    <div class="col-4 text-center "  id="MpwFind">
                     비밀번호 찾기
                    </div>
                    <div class=" col-4 text-center" id="joinBtn">              
                      회원가입
                    </div>
                  </div>
               </div>
          </div>
    </div>
  </form>
    <form name="login_form_member" id="cloginForm" action="${pageContext.request.contextPath }/login/companyloginOk" method="post">
      <div id="loginH"> <span id="h1">업체 로그인</span></div>
      <div class="full_login_wrap">
   
          <input type="button" class="mdT md1 " id="md3" value="회원"><input type="button" class="mdT md" id="md4" value="업체">

          <div class="login_form01" id="login_form01">
              <div class="id_input">
                  <input type="email" id="cid" name="cid" placeholder="업체ID" title="업체ID" />

              </div>
              <div class="pw_input"><input type="password" id="cpw" name="cpw" placeholder="비밀번호"  /></div>
              <div class="login_btn_wrap"  id="cloginBtn">
                 <img src="https://ssl.nx.com/s2/game/maplestory/renewal/login_full/login_btn02.png" width="100%"alt="로그인" />
              </div>
              <div class="linkrow">
                  <div class="row m-0 p-0">
                    <div class="col-4 text-center">
                      아이디 찾기
                    </div>
                    <div class="col-4 text-center "  id="MpwFind">
                     비밀번호 찾기
                    </div>
                    <div class=" col-4 text-center" id="cjoinBtn">              
                      업체등록
                    </div>
                  </div>
               </div>
          </div>
    </div>
  </form>
     <div class="row my-5" style="height: 50px;"></div>
     <div class="row my-5"></div>
	
<jsp:include page="../footer.jsp"/>
</body>


</html>
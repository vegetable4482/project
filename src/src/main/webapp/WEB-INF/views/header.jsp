
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- fontawesome -->
<link href="${pageContext.request.contextPath }/webjars/font-awesome/5.9.0/css/all.css"  rel="stylesheet">
<!-- 나눔스퀘어 (메인 폰트) -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<!-- 제이쿼리 -->
 <script src="${pageContext.request.contextPath }/webjars/jquery/3.4.1/dist/jquery.js" ></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<title>쉽고 빠른 인테리어 중개 플랫폼, 집중!</title>
<style>
/* *{outline:1px solid #ccc;} */
/* 배경 */
.menu {
  position: relative;
  height: 44px;
  background: white;
  width: auto;
  margin-bottom:30px;
}
.menu ul
/* ,#subMenu > div.myinfo > ul */
 {
  list-style: none;
  padding: 0;
  margin: 0;
  line-height: 1;
}
.mar{
 vergin-align: text-bottom;
}
.menu > ul {
  position: relative;
  display: block;
/*   background: orange; */
  width: 100%;
  z-index: 500;
}
.menu:after, .menu > ul:after,
#subMenu > div.myinfo > a:after,
#subMenu:after {
  content: ".";
  display: block;
  clear: both;
  visibility: hidden;
  line-height: 0;
  height: 0;
}
.menu.align-right > ul > li {
  float: right;
}
.menu.align-center ul {
  text-align: center;
}
.menu.align-center ul ul,
#subMenu > div.myinfo > ul {
  text-align: left;
}
.menu > ul > li {
  display: inline-block;
  position: relative;
  margin: 0;
  padding: 0;
}
.menu > ul > #menu-button {
  display: none;
}
.menu ul li a{
  display: block;
  font-family: 'NanumSquare', sans-serif;
  text-decoration: none;
  
}
.menu > ul > li > a {
  font-size: 17px;
  padding: 3px 20px;
  color: black;
  text-transform: uppercase;
  -webkit-transition: color 0.25s ease-out;
  -moz-transition: color 0.25s ease-out;
  -ms-transition: color 0.25s ease-out;
  -o-transition: color 0.25s ease-out;
  transition: color 0.25s ease-out;
}
.menu > ul > li.sub > a {
  padding-right: 32px;
}
.menu > ul > li:hover > a {
  color: orange;
  font-weight:bold;
  border-bottom:1px solid orange;
  padding-bottom:10px;
}
.menu > ul > li:hover > .logo{
border:none;
}

.menu ul ul,
#subMenu > div.myinfo > ul {
  position: absolute;
   left: -9999px; 
  top: 70px;
  opacity: 0;
  -webkit-transition: opacity .3s ease, top .25s ease;
  -moz-transition: opacity .3s ease, top .25s ease;
  -ms-transition: opacity .3s ease, top .25s ease;
  -o-transition: opacity .3s ease, top .25s ease;
  transition: opacity .3s ease, top .25s ease;
  z-index: 1000;
}
.menu ul ul ul {
  top: 37px;
  padding-left: 5px;
}
.menu ul ul li,
#subMenu > div.myinfo > ul > li {
  position: relative;
}
/*악의 근원 고치기*/
.menu > ul > li:hover > ul
 {
  left: auto;
  top: 31px;
  opacity: 1;
}
.menu.align-right > ul > li:hover > ul {
  left: auto;
  right: 0;
}
.menu ul ul li:hover > ul {
  left: 170px;
  top: 0;
  opacity: 1;
}
.menu.align-right ul ul li:hover > ul {
  left: auto;
  right: 170px;
  top: 0;
  opacity: 1;
  padding-right: 5px;
}
.menu ul ul li a {
  width: 140px;
  border-bottom: 1px solid #eeeeee;
  padding: 10px 20px;
  font-size: 17px;
  color: black;
  background: #f2f2f2;

  -webkit-transition: all .35s ease;
  -moz-transition: all .35s ease;
  -ms-transition: all .35s ease;
  -o-transition: all .35s ease;
  transition: all .35s ease;
}
.menu.align-right ul ul li a {
  text-align: right;
}
.menu ul ul li:hover > a {
  background: #f2f2f2;
  color: orange;
}
.menu ul ul li:last-child > a, .menu ul ul li.last > a {
  border-bottom: 0;
}
.menu.align-right > ul > li > ul::after {
  left: auto;
  right: 30px;
}
.menu ul ul li.sub::after {
  border: 4px solid transparent;
  border-left-color: #9ea2a5;
  right: 10px;
  top: 12px;
  -moz-transition: all .2s ease;
  -ms-transition: all .2s ease;
  -o-transition: all .2s ease;
  transition: all .2s ease;
  -webkit-transition: -webkit-transform 0.2s ease, right 0.2s ease;
}
.menu.align-right ul ul li.sub::after {
  border-left-color: transparent;
  border-right-color: #9ea2a5;
  right: auto;
  left: 10px;
}
.menu ul ul li.sub:hover::after {
  border-left-color: #ffffff;
  right: -5px;
  -webkit-transform: rotateY(180deg);
  -ms-transform: rotateY(180deg);
  -moz-transform: rotateY(180deg);
  -o-transform: rotateY(180deg);
  transform: rotateY(180deg);
}
.menu.align-right ul ul li.sub:hover::after {
  border-right-color: #ffffff;
  border-left-color: transparent;
  left: -5px;
  -webkit-transform: rotateY(180deg);
  -ms-transform: rotateY(180deg);
  -moz-transform: rotateY(180deg);
  -o-transform: rotateY(180deg);
  transform: rotateY(180deg);
}
#subMenu{
 margin-top:5px;
}
#subMenu div{
 text-align:center;
 width:50px;
}
#subMenu div a{
  font-size:13px; 
 font-family: 'Noto Sans KR', sans-serif;
 font-weight: 300;
 text-decoration:none;
 color:gray;
}
.join{
border-left: 1px #ccc solid;
border-right: 1px #ccc solid;
}
.ebBtn{
margin-left:360px !important;
width:152px;
}
.sub .sub1{
z-index:5000;
}

/*여기부터 메뉴 2*/
.menu2 {
  position: relative;
  height: 44px;
  background: white;
  width: auto;
/*   margin-bottom:30px; */
}
.menu2 ul
/* ,#subMenu > div.myinfo > ul */
 {
  list-style: none;
  padding: 0;
  margin: 0;
  line-height: 1;
}
.mar{
 vergin-align: text-bottom;
}
.menu2 > ul {
  position: relative;
  display: block;
/*   background: orange; */
  width: 100%;
  z-index: 500;
}
.menu2:after, .menu > ul:after,
#subMenu > div.myinfo > a:after,
#subMenu:after {
  content: ".";
  display: block;
  clear: both;
  visibility: hidden;
  line-height: 0;
  height: 0;
}
.menu2.align-right > ul > li {
  float: right;
}
.menu2.align-center ul {
  text-align: center;
}
.menu2.align-center ul ul {
  text-align: left;
}
.menu2 > ul > li {
  display: inline-block;
  position: relative;
  margin: 0;
  padding: 0;
}
.menu2 > ul > #menu-button {
  display: none;
}
.menu2 ul li a{
  display: block;
  text-decoration: none;
}
.menu2 > ul > li > .loginB {

  font-size: 17px;
 /*  padding: 3px 20px; */
  color: black;
  text-transform: uppercase;
  -webkit-transition: color 0.25s ease-out;
  -moz-transition: color 0.25s ease-out;
  -ms-transition: color 0.25s ease-out;
  -o-transition: color 0.25s ease-out;
  transition: color 0.25s ease-out;
}
.menu2 > ul > li.sub > a {
  padding:0px 12px;
}
.menu2 > ul > li:hover > a {
  color: orange;
  font-weight:bold;
/*   border-bottom:1px solid orange; */
  padding-bottom:10px;
}
.menu2 > ul > li:hover > .logo{
border:none;
}

.menu2 ul ul,
#subMenu > div.myinfo > ul {
  position: absolute;
   left: -9999px; 
  top: 70px;
  opacity: 0;
  -webkit-transition: opacity .3s ease, top .25s ease;
  -moz-transition: opacity .3s ease, top .25s ease;
  -ms-transition: opacity .3s ease, top .25s ease;
  -o-transition: opacity .3s ease, top .25s ease;
  transition: opacity .3s ease, top .25s ease;
  z-index: 1000;
}
.menu2 ul {
  top: 10px;

}
.menu2 ul ul li,
#subMenu > div.myinfo > ul > li {
  position: relative;
}
/*악의 근원 고치기*/
.menu2 > ul > li:hover > ul
 {
  left: auto;
  top: 20px;
  opacity: 1;
}
.menu2.align-right > ul > li:hover > ul {
  left: auto;
  right: 0;
}
.menu2 ul ul li:hover > ul {
  left: 170px;
  top: 0;
  opacity: 1;
}

.menu2 ul ul li a {
  width: 120px;
  border-bottom: 1px solid #eeeeee;
  padding: 5px 20px;
  font-size: 17px;
  color: black;
  background: #f2f2f2;

  -webkit-transition: all .35s ease;
  -moz-transition: all .35s ease;
  -ms-transition: all .35s ease;
  -o-transition: all .35s ease;
  transition: all .35s ease;
}
.menu2.align-right ul ul li a {
  text-align: center;
}
.menu2 ul ul li:hover > a {
  background: #f2f2f2;
  color: orange;
}
.menu2 ul ul li:last-child > a, .menu ul ul li.last > a {
  border-bottom: 0;
}
.menu2.align-right > ul > li > ul::after {
  left: auto;
/*   right: 30px; */
}
.menu2 ul ul li.sub::after {
  border: 4px solid transparent;
  border-left-color: #9ea2a5;
  right: 10px;
  top: 12px;
  -moz-transition: all .2s ease;
  -ms-transition: all .2s ease;
  -o-transition: all .2s ease;
  transition: all .2s ease;
  -webkit-transition: -webkit-transform 0.2s ease, right 0.2s ease;
}
.menu2.align-right ul ul li.sub::after {
  border-left-color: transparent;
  border-right-color: #9ea2a5;
  right: auto;
  left: 10px;
}
.menu2 ul ul li.sub:hover::after {
  border-left-color: #ffffff;
  right: -5px;
  -webkit-transform: rotateY(180deg);
  -ms-transform: rotateY(180deg);
  -moz-transform: rotateY(180deg);
  -o-transform: rotateY(180deg);
  transform: rotateY(180deg);
}
.menu2.align-right ul ul li.sub:hover::after {
  border-right-color: #ffffff;
  border-left-color: transparent;
  left: -5px;
  -webkit-transform: rotateY(180deg);
  -ms-transform: rotateY(180deg);
  -moz-transform: rotateY(180deg);
  -o-transform: rotateY(180deg);
  transform: rotateY(180deg);
}
</style>
	<body>
      <div class="container">
  		<!-- 로그인전후 -->
       <c:choose>
      <c:when test="${sessionScope.user eq null && sessionScope.user2 eq null }">
        
    		<div class='menu2 text-right' id="menu2">
					<ul style="z-index: 50px">
						<li class='active sub text-center'>
							<a class="loginB" href='${pageContext.request.contextPath }/login/login' style="font-size: 13px; color:gray; ">로그인</a>
						</li>
					<li class='active sub'>
						<a  class="loginB" href='${pageContext.request.contextPath }/member/memberJoinForm' style="font-size: 13px; color:gray;
						border-left:1px solid #ccc; border-right:1px solid #ccc;">회원가입</a>
					
					</li>
				<li class='active sub'>
					<a  class="loginB" href='${pageContext.request.contextPath }/company/companyJoinForm' style="font-size: 13px; color:gray;">업체등록</a>
				</li>
			</ul>
		</div>
	  		</c:when>
      	<c:when test="${sessionScope.user2 eq null}"> 
	  		<div class='menu2 text-right' style="margin-bottom:0px;">
					<ul>
						<li class='active sub'>
							<a href='${pageContext.request.contextPath }/member/PWchkForm/{id:.+}' style="font-size: 13px; color:gray;  font-family: 'NanumSquare', sans-serif;">내 정보관리</a>
							<ul>
								<li class='sub'>
									<a href='${pageContext.request.contextPath }/member/PWchkForm/{id:.+}' style="font-size: 13px; color:gray;  font-family: 'NanumSquare', sans-serif;">내 정보 수정</a>
								</li>
								
								<li class='sub'>
									<a href='${pageContext.request.contextPath }/member/PWmodifyForm' style="font-size: 13px; color:gray;  font-family: 'NanumSquare', sans-serif;">비밀번호 변경</a>
								</li>
								
								<li class='sub'>
									<a href='${pageContext.request.contextPath }/member/MoutForm' style="font-size: 13px; color:gray;  font-family: 'NanumSquare', sans-serif; ">회원탈퇴</a>
								</li>
						</ul>
				</li>
					<li class='active sub'>
					<a href='${pageContext.request.contextPath }/login/logout' style="font-size: 13px; border-left:1px solid #ccc; border-right:1px solid #ccc; color:gray;  font-family: 'NanumSquare', sans-serif;">회원로그아웃</a>
				</li>
				<li class='active sub'>
					<a href='${pageContext.request.contextPath }/request/requestMember/${sessionScope.user.id }' style="font-size: 13px; color:gray;  font-family: 'NanumSquare', sans-serif;">내 추천 업체 조회</a>
				</li>
			
			</ul>
		</div>
 			 </c:when>
		 	<c:when test="${sessionScope.user eq null}"> 
	  		<div class='menu2 text-right' style="margin-bottom:0px;">
					<ul>
						<li class='active sub'>
							<a href='${pageContext.request.contextPath }/member/cPWchkForm/{id:.+}' style="font-size: 13px; color:gray;  font-family: 'NanumSquare', sans-serif;">업체 정보관리</a>
							<ul>
								<li class='sub'>
									<a href='${pageContext.request.contextPath }/member/cPWchkForm/{id:.+}' style="font-size: 13px;  font-family: 'NanumSquare', sans-serif;">업체 정보 수정</a>
								</li>
								
								<li class='sub'>
									<a href='${pageContext.request.contextPath }/member/PWmodifyForm' style="font-size: 13px;  font-family: 'NanumSquare', sans-serif;">비밀번호 변경</a>
								</li>
								
								<li class='sub'>
									<a href='${pageContext.request.contextPath }/member/CoutForm' style="font-size: 13px;  font-family: 'NanumSquare', sans-serif;">회원탈퇴</a>
								</li>
						</ul>
				</li>
					<li class='active sub'>
					<a href='${pageContext.request.contextPath }/login/logout' style="font-size: 13px; color:gray; border-left:1px solid #ccc; border-right:1px solid #ccc;  font-family: 'NanumSquare', sans-serif;">업체로그아웃</a>
				</li>
				<li class='active sub'>
					<a href='${pageContext.request.contextPath }/request/requestMember2/${sessionScope.user2.cmembernum}' style="font-size: 13px;color:gray;  font-family: 'NanumSquare', sans-serif;">신청서 조회</a>
				</li>
			
			</ul>
		</div>
 			 </c:when>
			 </c:choose>
	      			<div class='menu'>
			<ul>
			<li>
            <a class="logo" href="${pageContext.request.contextPath }"><img src="${pageContext.request.contextPath }/resources/img/logo2.jpg" height="50px" alt="" /></a>
			</li>
				<li>
					<a class="mar" href='#'>회사소개</a>
				</li>
				<li class='active sub'>
					<a href='#'>주거공간</a>
					<ul>
						<li class='sub'>
							<a href='${pageContext.request.contextPath }/intbbs/intlist'>종합인테리어</a>
						</li>
						<li class='sub'>
							<a href='#'>부분인테리어</a>
						
						</li>
					</ul>
				</li>
					<li class='active sub'>
					<a href='#'>집중!톡</a>
					<ul>
						<li class='sub'>
							<a href='${pageContext.request.contextPath }/rebbs/list'>생생리뷰</a>
						</li>
						<li class='sub'>
							<a href='${pageContext.request.contextPath }/fbbs/list/${page}'>인테리어 토크</a>				
						</li>
					</ul>
				</li>
				<li class='last'>
					<a href='${pageContext.request.contextPath }/qna/main'>고객센터</a>
				</li>
				<li class=''>
		<!-- 로그인전후 -->
		  <c:choose>
      	<c:when test="${sessionScope.user eq null && sessionScope.user2 eq null }">
					<input type="button" value="빠른 업체 추천 받기" style="background:#FD8003; color:white; border:none; font-size:16px;  font-family: 'NanumSquare', sans-serif;" 
					onclick="location.href='${pageContext.request.contextPath }/login/login'" class="ebBtn btn " id="noebBtn"/>
				</c:when>
      	<c:when test="${sessionScope.user2 eq null}"> 
					<input type="button" value="빠른 업체 추천 받기" style="background:#FD8003; color:white; border:none; font-size:16px;  font-family: 'NanumSquare', sans-serif;" onclick="location.href='${pageContext.request.contextPath }/request/requestForm'" class="ebBtn btn btn-warning " id="ebBtn"/>	  	
	  	  </c:when>
        <c:when test="${sessionScope.user eq null}"> 
          </c:when>
       </c:choose>
				</li>
			
			</ul>
		</div>

		</div>

	</body>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.all {background: rgb(244, 244, 244)}
body#footer {
    font-size: 0.8rem;
}
.footerfirst{
    padding:10px;
    margin: 10px 0px;
}
.footerfirst > div > a {
    padding:0px 20px;
}
.footerfirst > div > .atag {
    border-left: 1px #ccc solid;
}
.snsicon{
    width:35px;
    opacity: 0.8;
    margin-top: 10px;
    margin: 5px;
}
.san{
    height:900px;
}

</style>
  <script type="text/javascript">
    $(document).ready(function(){
        var speed = 300; //스크롤속도
        $("#moveTop").css("cursor","pointer").click(function(){
            $('body,html').animate({scrollTop:0},speed);
        });
    });
  
  </script>
<body id="footer">
    <hr>
    <div class="footerfirst row p-0">
        <div class="col-1"></div>
        <div class="col"><a>집중(주)</a> <a class="atag">회사소개</a> <a class="atag">이용약관</a> <a class="atag">개인정보처리방침</a> <a class="atag">고객센터</a><a class="atag" id="moveTop">TOP△</a></div>
        <div class="col-5"></div>
    </div><!--첫 행 끝-->
    <div class="all">
        <hr>
        <div class="row">
        
        </div>
        <div class="row">
            <div class="col-1"></div>
        <div class="col-2 py-1">
            <img src="${pageContext.request.contextPath }/resources/img/logo.png" alt="ZIPZOONG LOGO" width="200px">
        </div>
        <!-- <div class="col">
                <div class="row">@zipzoong</div>
                <div class="row">집중 인스타그램을 팔로우하고 <br>
                    혜택,이벤트 등 다양한 소식을 빠르게 만나보세요!
                </div>
        </div> -->
        <div class="col-sm">
                <div class="row">집중 주식회사</div>
                <div class="row">집중(주) 대표이사 최중개, 서울시 0구 00동 0번지</div>
                <div class="row">사업자 등록번호 : 123-12-24578</div>
                <div class="row">개인정보보호 책임자 : 박중개</div>
                <div class="row-1"></div>
                <div class="row">Copyright 2019,ZIPZZONG Co., LTD. All rights reserved</div>
        </div>
        <div class="col-4">
            <div class="row">고객만족센터 : 1234-5678 (FAX:02-4545-7575)</div>
            <div class="row">E-mail : zipzoong@zoong.com</div>
            <div class="row">운영시간 : 월~토(09시-18시) 일요일/공휴일(휴무)</div>
            <div class="row"><img class="snsicon" src="${pageContext.request.contextPath }/resources/img/snslogoT.png" alt="트위터">
            <img class="snsicon" src="${pageContext.request.contextPath }/resources/img/snslogoI.png" alt="인스타">
            <img class="snsicon" src="${pageContext.request.contextPath }/resources/img/snslogoF.png" alt="페이스북"></div>
        </div>
        <div class="col-1"> </div>
         </div>
         <div class="row py-4"></div>
    </div>
</body>
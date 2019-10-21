<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <!-- fontawesome -->
   <link href="${pageContext.request.contextPath }/webjars/font-awesome/5.9.0/css/all.css"  rel="stylesheet">
   <!-- 나눔스퀘어 (메인 폰트) -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<!-- font-family: 'NanumSquare', sans-serif;  -->
</head>
<style>
*{
  font-family: 'NanumSquare', sans-serif;
}
#homeBtn{
  margin-right: 30px;
}
#subMenu> div{
  font-size: 0.8em;
}
.sample_image  img {
  -webkit-transform:scale(1);
  -moz-transform:scale(1);
  -ms-transform:scale(1);	
  -o-transform:scale(1);	
  transform:scale(1);
  -webkit-transition:.3s;
  -moz-transition:.3s;
  -ms-transition:.3s;
  -o-transition:.3s;
  transition:.3s;
}
.sample_image:hover img {
  -webkit-transform:scale(1.1);
  -moz-transform:scale(1.1);
  -ms-transform:scale(1.1);	
  -o-transform:scale(1.1);
  transform:scale(1.1);
}
.sample_image { 
  overflow: hidden; 
}
.box{
  height: 50px;
}
.border2{
  width: 250px;
}
.border3{
  width: 180px;
}
.border4{
  width: 150px;
}
.menubar a{
  font-size: 1.5em;
  -ms-flex-pack: center !important;
  justify-content: center !important
}
.menubar li ul{
  font-size: 0.8em;
  /* background: floralwhite; */
  display: none;
  height: auto;
  padding: 0px;
  margin: 0px;
  border: 0px;
  position: absolute;
  width: 180px;
  z-index: 200;
  list-style: none;
} 
.menubar li:hover ul{
  display: block;
}
.menubar li a{
  text-decoration: none; 
  color: black;
  padding: 0, 5px;
}
.dropdown:hover .dropdown-menu {
  display: block;
  margin-top: 0;
}
.pd{
  padding-left: 150px;
}
.reviewbox{
display: -webkit-box; display: -ms-flexbox; display: box; margin-top:1px; max-height:80px; overflow:hidden; vertical-align:top; text-overflow: ellipsis; word-break:break-all; -webkit-box-orient:vertical; -webkit-line-clamp:3

}
</style>

<body>

<!-- <div class="my-3">점보트론 영역 -->
 
   <div id="carouselExampleInterval" class="carousel slide carousel-fade" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active" data-interval="4000">
            <img src="${pageContext.request.contextPath }/resources/img/메인1.jpg" class="d-block w-100" alt="...">
          </div>
          <div class="carousel-item" data-interval="4000">
            <img src="${pageContext.request.contextPath }/resources/img/main3.jpg" class="d-block w-100" alt="...">
          </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleInterval" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleInterval" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
 
<!-- </div>점보트론 영역 끝 -->

<div class="container"><!--베스트 주거공간 영역-->
  <div class="row justify-content-center">
    <p class="h2 col-12 text-center" style="margin-top:60px;">BEST 주거공간</p>
  </div>
  
  
  <div class="" style="margin:20px 0px 100px 0px;"><!--바디 영역-->
    <div class="row justify-content-center "><!--1단 사진 영역-->
      <div class="mx-3 my-3">
          <div class="sample_image">
            <a href="./상업공간/1.html">
              <img src="${pageContext.request.contextPath }/resources/img/720x480_20190418142221169_p1YEPGCZXX.jpg" alt="" height="200px" width="250px">
            </a>
          </div>
          <div class="border border2">
            <div class="my-3 mx-3">
              <p class="" >평범했던 공간을 펜트하우스처럼, 42...</p> 
            </div>
          </div>
        </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/720x480_20190218153904931_lYCvtCQUCi.jpg" alt="" height="200px" width="250px">
          </a>
        </div>
        <div class="border border2">
          <div class="my-3 mx-3">
            <p class=""  >사무실이 주택으로 대변신! 30평 상가</p> 
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/720x480_20181206103804435_GnwoVColLs.jpg" alt="" height="200px" width="250px">
          </a>
        </div>
        <div class="border border2">
          <div class="my-3 mx-3">
            <p class=""  >모던함 속 화려한 주방이 돋보이는...</p> 
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/720x480_20190124152110971_LDR3yyOLaO.jpg" alt="" height="200px" width="250px">
          </a>  
        </div>
        <div class="border border2">
          <div class="my-3 mx-3">
            <p class=""  >깔끔한 시선과 골드로 포인트...</p> 
          </div>
        </div>
      </div>
    </div><!--1단 사진 영역 끝-->
  </div><!--바디 영역 끝-->
</div><!--베스트 주거공간 영역 끝-->
  
<div class="mainrequestselect"><!--내 견적 조회하기 영역-->
  <div class="alert" style="background-color: rgb(245, 245, 245);">
    <div class="blog-footer my-5 row ">
      <div class="col-3"></div>
      <div class="">
        <img src="${pageContext.request.contextPath }/resources/img/select icon.png" alt="select">
      </div>
      <div class="col-2">
      <p class="h2 col-sm">내 견적 조회하기</p>
    </div>
    <div class="col-5">
      <div class="row">
        <img src="${pageContext.request.contextPath }/resources/img/request icon.png" alt="">
        <p class="h4">&nbsp;매칭 진행도 조회 서비스</p>
      </div>
      <div class="row">
        <img src="${pageContext.request.contextPath }/resources/img/request icon.png" alt="">
        <p class="h4">&nbsp;내가 원하는 스타일의 인테리어 견적을 한눈에!</p>
    </div>
    </div>
    <div class="col"></div>
    </div>
  </div>
 <div class="col my-1">&nbsp;</div>
</div><!--내 견적 조회하기 영역-->

<div class="container"><!--스타일별 공간 영역-->
  <div class="row justify-content-center">
    <p class="col-text-center h2 my-5">스타일별 공간 인테리어</p>
    <!-- <p class="col-1 my-5">더보기</p> -->
  </div>
    
  <div class=""><!--바디 영역-->
    <div class="row justify-content-center my-5"><!--1단 사진 영역-->
      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/720x480_20190905173617888_ZH5CeWSGyT.jpg" alt="" height="180px" width="180px">
          </a>  
        </div>
        <div class="border border3">
          <div class="my-3 mx-3">
            <p class=""   >지저분했던 나의 공간을 깔끔한 화이트로 장식...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: paleturquoise">#모던</span></p>
          </div>
        </div>
      </div>
        
      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/720x480_20190905175235445_B6yH0qvmNI.jpg" alt="" height="180px" width="180px">
          </a>  
        </div>
        <div class="border border3">
          <div class="my-3 mx-3">
            <p class=""   >아기자기 취향을 담은 20평 소품샵 인...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: lightslategray">#클래식</span></p>
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/720x480_20181011144800804_Bkwq3Rs7z1.jpg" alt="" height="180px" width="180px">
          </a>  
        </div>
        <div class="border border3">
          <div class="my-3 mx-3">
            <p class=""   >낡지만 속 화려한 주방이 돋보이는...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: peru">#빈티지</span></p>
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/720x480_20180723170540360_5jUs2XmEfp.jpg" alt="" height="180px" width="180px">
          </a>
        </div>
        <div class="border border3">
          <div class="my-3 mx-3">
            <p class=""   >그레이와 블랙으로 연출한 현대적인 감...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: lavender">#인더스트리얼</span></p>
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/720x480_20190125115033025_7IGVpZ7XMN.jpg" alt="" height="180px" width="180px">
          </a>
        </div>
        <div class="border border3">
          <div class="my-3 mx-3">
            <p class=""   >다크 그레이 프레임으로 공간감을 강조...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: dimgrey">#미니멀리즘</span></p>
          </div>
        </div>
      </div>
    </div><!--1단 사진 영역 끝-->
  </div><!--바디 영역 끝-->
</div><!--스타일별 공간 영역 끝-->     
  <hr style="margin:70px 0px;">
  
<div class="container"><!--부분인테리어  영역-->
  <div class="row justify-content-center">
    <p class="col-text-center h2 my-2">부분 인테리어</p>
  </div>
   
  <div class=""><!--바디 영역-->
    <div class="row justify-content-center my-3"><!--1단 사진 영역-->
      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/거실.png" alt="" height="150px" width="150px">
          </a>
        </div>
        <div class="border border4">
          <div class="my-3 mx-3">
            <p class=""   >평범했던 거실을 깔끔하게</p> 
            <p class="text-center h5"><span class="mx-1" style="color: paleturquoise">#거실</span></p>
          </div>
        </div>
      </div>
       
      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/주방.png" alt="" height="150px" width="150px">
          </a>
        </div>
        <div class="border border4">
          <div class="my-3 mx-3">
            <p class=""   >나만의 주방을 만들어 보자...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: lightslategray">#주방</span></p>
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/현관.png" alt="" height="150px" width="150px">
          </a>
        </div>
        <div class="border border4">
          <div class="my-3 mx-3">
            <p class=""   >집을 들어올떄 가장 먼저 보이는...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: peru">#현관</span></p>
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/베란다.png" alt="" height="150px" width="150px">
          </a>
        </div>
        <div class="border border4">
          <div class="my-3 mx-3">
            <p class=""   >온갖 소품들과 많은것들이 장식...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: lightslategray">#베란다</span></p>
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/욕실.png" alt="" height="150px" width="150px">
          </a>
        </div>
        <div class="border border4">
          <div class="my-3 mx-3">
            <p class=""   >편안히 볼일을 볼수 있는 공간으로...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: lavender">#욕실</span></p>
          </div>
        </div>
      </div>

      <div class="mx-3 my-3">
        <div class="sample_image">
          <a href="./상업공간/1.html">
            <img src="${pageContext.request.contextPath }/resources/img/침실.png" alt="" height="150px" width="150px">
          </a>
        </div>
        <div class="border border4">
          <div class="my-3 mx-3">
            <p class=""   >하루의 고단함을 편안히 풀수 있게...</p> 
            <p class="text-center h5"><span class="mx-1" style="color: dimgrey">#침실</span></p>
          </div>
        </div>
      </div>
    </div><!--1단 사진 영역 끝-->
  </div><!--바디 영역 끝-->
</div><!--부분 인테리어 영역 끝-->     
 <hr style="margin:70px 0px;">

<div class="container"><!--후기 영역-->
  <div class="row justify-content-center">
    <p class="col-text-center h2 my-3">REVIEW</p>
  </div>
   
   
  
    <div class="row justify-content-center" style="padding-bottom:40px;"><!--리뷰 영역-->
    
    <div></div>
 		<c:forEach items="${reviewList }" var="reBbsDTO">
      <div class="alert col-5 mx-1"  style="background-color: rgb(245, 245, 245)">
 		 <a href="${pageContext.request.contextPath }/rebbs/read/${pc.rc.reqPage}/${rec.reviewbnum}">
        <span class="h4" style="color: #ce3537; padding-left:50px; ">♥${reBbsDTO.reviewbscore } </span>
      </a>
        <span class="h5">ㅣ${reBbsDTO.reviewbid }</span> 
        
        <p class="reviewbox mx-5" >${reBbsDTO.reviewbcontent } </p>
      </div>
		</c:forEach>

    </div><!--리뷰 영역 끝-->
   


</div><!--후기 영역 끝-->
  <footer class="blog-footer my-5">
  <img src="${pageContext.request.contextPath }/resources/img/광고배너.jpg">
  </footer>

</body>
</html>






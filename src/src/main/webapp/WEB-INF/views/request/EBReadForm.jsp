<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/form.css"/>
<title>내 추천 상세조회</title>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--Bootstrap-->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
</head>
  <jsp:include page="../header.jsp" />
<style>
.reAddress, .reTell{
  color:orange;
  font-weight:400;
}
.compResultA{
  font-size: 1.8rem;
  font-weight: 600;
  font-family: 'NanumSquare', sans-serif; 
}

.reResult{
  outline: 1px solid #ccc;
  padding:10px;
  width:261px;
}
.result .col-sm{
  height: 170px;
  padding: 20px;

}
.result .middle{
  margin:0 30px;
}
.finalBtn{
  padding-top: 10px;
}
.matchinCompany{
	width:33%;
}
</style>
<body>
<hr>
	 <form:form modelAttribute="requestDTO">
	<form:hidden path="custid" value="${requestDTO.custid }"/>
      <div id="joinHeader"> <span id="h1">추천 상세조회</span></div>
    <table id="joinTable">
    <tr>
        <th class="article">성함 <span class="ast">*</span></th>
        <td>
			<div>${requestDTO.custname }</div>
      </td>
      </tr>
      <tr>
        <th class="article">전화번호 <span class="ast">*</span></th>
        <td><div>${requestDTO.custphonenum }</div>
        <span id="pwMsg" class="subMsg">
          </span>
        </td>
      </tr>
      <tr>
        <th class="article">공사지 유형 <span class="ast">*</span></th>
        <td>
        <div>${requestDTO.consttype }</div>
        </td>
      </tr>
      <tr>
        <th class="article">공사지 공간 <span class="ast">*</span></th>
        <td>
          <div>${requestDTO.constspace }</div>
        </td>
      </tr>
      <tr>
        <th class="article">공사 예정 날짜 <span class="ast">*</span></th>
         <td>
          <div>${requestDTO.constdate }</div>
        </td>
      </tr>
      <tr>
        <th class="article">공사지 주소 <span class="ast">*</span></th>
        <td> 

            <div>(${requestDTO.constpostnum })&nbsp;${requestDTO.constbasicaddress }</div>
            <div>${requestDTO.constrestaddress }</div>
</td>
      </tr>
      <tr>
        <th class="article">인테리어 스타일 <span class="ast">*</span></th>
        <td>
           <div>${requestDTO.conststyle }</div>
        </td>
      </tr>
      <tr>
          <th class="article">요청 사항 </th>
          <td>
          <div>${requestDTO.custrequest }</div>
              <div class="row my-4"></div>
          </td>
        	
        </tr>
        
    </table>

    <div class="container result">
      <div class="row">
    <c:forEach items="${result }" var="resultDTO">
          <div class="matchinCompany my-3">
              <div class="container reResult">
                  <div class="row">
                    <div class="col compResultA">
                      ${resultDTO.mcname }
                    </div>
                  </div>
                  <div class="row">
                    <div class="col">
                      <span class="reAddress">주소</span><span>&nbsp;${resultDTO.mrestadd } ${resultDTO.mbasicadd }</span>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col">
                      <span class="reTell">전화번호</span><span>&nbsp;${resultDTO.mphonenum } </span>
                    </div>
                  </div>  
              </div>
                <div class="d-flex bd-highlight mb-3">
                    <div class="mr-auto p-2 bd-highlight"></div>
                    <div class="p-2 bd-highlight"></div>
                    <div class="bd-highlight finalBtn">
                        <input type="button" style="background-color: #ff8800; color:white; "
                        onclick="document.location.href ='${pageContext.request.contextPath}/rebbs/list/1/TC/${resultDTO.mcname }'"
                         id="review" class="lastbtn btn btn-warning mx-3" value="업체 리뷰 보기"/>    
                    </div>
                </div>
           </div>
		
         
      </c:forEach>
        </div>
      </div>

    <br>
 <div class="row" style="padding:50px;">&nbsp;</div>
 	</form:form>
 
</body>
 <jsp:include page="../footer.jsp" />
</html>
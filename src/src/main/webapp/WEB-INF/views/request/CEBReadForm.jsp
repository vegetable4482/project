<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/form.css"/>
<title>업체 견적 상세조회</title>
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
</style>
<body>
<hr>
	 <form:form modelAttribute="requestDTO">
	<form:hidden path="custid" value="${requestDTO.custid }"/>
      <div id="joinHeader"> <span id="h1">견적상세조회</span></div>
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
    <br>
 <div class="row" style="padding:50px;">&nbsp;</div>
 	</form:form>
 
</body>
 <jsp:include page="../footer.jsp" />
</html>
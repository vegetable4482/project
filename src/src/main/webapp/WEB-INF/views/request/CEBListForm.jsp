<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
 <jsp:include page="../header.jsp" />
 <hr>
<style>
  /* *{outline: 1px #ccc solid;} */
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
    margin: 0 20%;
  }
  input[type="text"] , input[type="email"],input[type="password"],input[type="tel"]{
      height: 30px;
      margin : 3px 0 ;
      width: 200px;
  }
  .checkbox{
      padding : 0px 5px;
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
  .Istyle{
    display: block;
  width: 200px;
  height: 30px;
  font-size: 0.8rem;
  }
  .form-control{
    display:inline-block;
  }
  .requestTitle{
  color:black;
  }
  .requestTitle:hover{
  color:#FF8800;
  text-decoration:none;  
  }
  
  @media screen and (max-width:768px) {
    th{
    border:none;
    display: block;
    text-align: left;
  }
  td{
    display: list-item;
    list-style: none;
    margin-bottom: 20px;

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
      width: 100%;
      border:none;
  }
  .checkbox{
      padding : 0px 10px;
  }
  #bathBox{
      padding-left: 29px;
  }
  #sample6_address , #sample6_detailAddress ,#sample6_extraAddress, #sample6_postcode{
      border : 1px solid rgb(238, 238, 238);
      height:30px;
  }


  #sample6_postcode{
    width: 173px;
  }
  #joinHeader , #joinForm > #chkBtn{
    margin-top: 20px;
    text-align: center;
  }
  .btn{
    width:100px;
  }
  .Istyle{
    width: 100%;
  }
  }
</style>
<body>
	 <form id="joinForm">
      <div id="joinHeader"> <span id="h1">내견적신청관리</span></div>
      <table>
          <tr style="background-color:rgb(238, 238, 238);">
            <th width="150px"  style="text-align: center;">NO</th>
            <th width="300px" style="text-align: center;">신청서</th>
            <th width="270px" style="text-align: center;">공사주소</th>
            <th width="150px" style="text-align: center;">신청일</th>
            <th width="200px" style="text-align: center;">신청진행도</th>
          </tr>
          <c:forEach items="${clist}" var="requestDTO">
						<a class="text-secondary" href="${pageContext.request.contextPath }/request/read/company/${requestDTO.formnum}"></a>
						<tr>					
            <td style="text-align: center;">${requestDTO.formnum }</td>
            <td><a class="requestTitle" href="${pageContext.request.contextPath }/request/read/company/${requestDTO.formnum}">[${requestDTO.custname }]님의 신청서</a></td>
            <td>${requestDTO.constbasicaddress }</td>
            <td  style="text-align: center;">${requestDTO.constdate }</td>
         		 <c:choose>
            <c:when test="${requestDTO.mstatus eq 'X'}">       
            <td style="text-align: center; color:red;">결과없음</td>
            </c:when>
            <c:when test="${requestDTO.mstatus eq 'O'}">       
            <td style="text-align: center; color:gray;">매칭완료</td>
            </c:when>
               <c:when test="${requestDTO.mstatus eq 'F'}">       
            <td style="text-align: center; color:gray;">매칭완료</td>
            </c:when> 
            </c:choose>
            </tr>
          </c:forEach>
        </table>
        <div class="row" style="padding:200px;">&nbsp;</div>
  </form>
</body>
 <jsp:include page="../footer.jsp" />
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
     #mateSection {
	     min-height: 800px;
	     width: 1280px;
	     margin: 0 auto;
	    
	}
    #mateList-container{ 
        text-align: center;
		margin: 0 auto;
		width: 1000px;
		height: 950px;
    }
     #font-container {
    	font-family: 'Noto Sans KR', sans-serif;
    }
    #mate-Title{
        text-align: left;
         font-family: 'Do Hyeon', sans-serif;
    }
    #mate-Title > a{
    	color: black;
    	text-decoration:none; 
 	       
    }
    #mate-Title > h2 {
    	text-decoration:line-through #b7ba41;
    	margin-left:100px;
    }
    #mate-Search{
    	text-align: right;
    }
     #mate-Search1{
    	float: left;
    }
    #mate-Search2{
    	text-align: right;    
    }
    #mateList-frm{
        text-align: center;    
        margin: auto;      
    }
  
    #mateList-tbl{           
        border-collapse: collapse;	   
	    text-align: center;       
        margin: 0 auto;
    }
    #mateList-tr{
   		border-bottom: 1px solid lightgray;
     	border-top: 1px solid lightgray;
    }
    #mateList-tr>td:nth-child(8){
    	width: 300px;
    }
    #mateList-tr>td:nth-child(3){
    	width: 130px;
    }
    #mateList-tr>td:nth-child(4){
    	width: 170px;
    }
    #mateList-tr>td:nth-child(6){
    	width: 130px;
    }
    #mateList-tr>td:nth-child(10){
    	width: 200px;
    }
    #mateList-tr>td{
    	padding: 6px;
    	width:100px;
    }
    .searchButton{
       vertical-align: top;
    } 
</style>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/0fe4d45686.js"
		crossorigin="anonymous"></script>
<section id="mateSection">
	
	<div id="mateList-container">
		<div id="mate-Title">
			        <a href="${path}/mate/list"><h1 style="font-size: 48pt;">????????????</h1></a>
			        <h2>- ?????? ??? ????????? ???</h4>
		    	</div>
		 <div id="mate-Search">
		
 <div id="mate-Search2">
	<form name="form1" method="post" action="${path}/mate/list.do">
		<select name="search" style="border-radius:5px;height:30px;">
            	<option value="userNick" ${pageInfo.search eq 'userNick'? 'selected' : '' }>
            			?????????</option>
            	<option value="mateTitle" ${pageInfo.search eq 'mateTitle'? 'selected' : '' }>
            			??????</option>
            	<option value="mateContent" ${pageInfo.search eq 'mateContent'? 'selected' : '' }>
            			??????</option>
	 		</select> 
	 		 <input style="border-radius:5px;border:0.5px solid;height:30px;" type="text" name="keyword" placeholder="????????? ???????????????" value="${pageInfo.keyword }">
		     <input class="searchButton" id="searchButton" type="submit"  style="border-radius:5px;border:0.5px solid;height:30px;width:50px;font-size:10pt;background-color: #6c757d; color:white;" value="??????" onclick="$('form1').submit()"></input>      
		</form>     	 	 
	</div>      
</div> 			    	
		    	
		    <hr>		
		<table id="mateList-tbl">
			<tr id="mateList-tr">
				<td>??????</td>
				<td>??????</td>
				<td>????????????</td>			
				<td>????????????</td>
				<td>?????????</td>
				<td>?????????</td>
				<td>??????</td>
				<td>??????</td>
				<td>?????????</td>
				<td>?????????</td>
				<td>?????????</td>
			</tr>
            <c:if test="${mateList == null}">
				<tr id="mateList-tr">
					<td colspan="11">
						????????? ???????????? ????????????.
					</td>
				</tr>	
			</c:if>
			<c:if test="${mateList != null}">
			<c:forEach var="mate" items="${mateList}">
			<c:if test="${mate.mateOpen == '????????????' }">
					<tr id="mateList-tr" style="background-color: #f2f2f7;color:#c7c7c9;">
						<td><c:out value="${mate.mateId}"/></td>
						<td><c:out value="${mate.mateShow}"/></td>						
                        <td><span id="mateOpen"><c:out value="${mate.mateOpen}"/></span></td>                       
                        <td><c:out value="${mate.mateGender}"/></td>
                        <td><c:out value="${mate.mateAge}"/></td>
                        <td><c:out value="${mate.mateNum}"/></td>
                        <td><c:out value="${mate.mateLoc}"/></td>
						<td>
							<a style="text-decoration: none;color:#c7c7c9;" href="${path}/mate/view?mateId=${mate.mateId}">
								<c:out value="${mate.mateTitle}"/>
							</a>
						</td>
						<td><c:out value="${mate.userNick}"/></td>
					<td><fmt:formatDate value="${mate.mateCreateDate}" pattern="yy/MM/dd HH:mm:ss"/></td>                     
                        <td><c:out value="${mate.mateCount}"/></td>
                        </tr>
                 </c:if>
                 <c:if test="${mate.mateOpen != '????????????' }">
                         <tr id="mateList-tr">
						<td><c:out value="${mate.mateId}"/></td>
						<td><c:out value="${mate.mateShow}"/></td>	
                        <td><span id="mateOpen"><c:out value="${mate.mateOpen}"/></span></td>                     
                        <td><c:out value="${mate.mateGender}"/></td>
                        <td><c:out value="${mate.mateAge}"/></td>
                        <td><c:out value="${mate.mateNum}"/></td>
                        <td><c:out value="${mate.mateLoc}"/></td>
						<td>
							<a style="text-decoration: none;color:black;" href="${path}/mate/view?mateId=${mate.mateId}">
								<c:out value="${mate.mateTitle}"/>
							</a>
						</td>
						<td><c:out value="${mate.userNick}"/></td>
					<td><fmt:formatDate value="${mate.mateCreateDate}" pattern="yy/MM/dd HH:mm:ss"/></td>                     
                        <td><c:out value="${mate.mateCount}"/></td>
                        </tr>
                        </c:if>
                        </c:forEach>
                     </c:if>    
                 </table>
		<br>
		<div id="pageBar">
			<!-- ??? ???????????? -->
			<button type="button" class="btn btn-light btn-sm" onclick="location.href='${path}/mate/list?page=1'"><i class="fas fa-angle-double-left"></i></button>
			
			<!-- ?????? ???????????? -->
			<button type="button" class="btn btn-light btn-sm" onclick="location.href='${path}/mate/list?page=${pageInfo.prvePage}'"><i class="fas fa-angle-left"></i></button>

			<!--  10??? ????????? ?????? -->
			<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
				<c:if test="${status.current == pageInfo.currentPage}">
					<button type="button" class="btn btn-light btn-sm" style="height:25px;font-size:7pt;font-weight:bold;" disabled><c:out value="${status.current}"/></button>
   				</c:if>
				<c:if test="${status.current != pageInfo.currentPage}">
					<button type="button" class="btn btn-light btn-sm" style="height:25px;font-size:7pt;font-weight:bold;" onclick="location.href='${path}/mate/list?page=${status.current}'"><c:out value="${status.current}"/></button>
   				</c:if>
			</c:forEach>
			
			<!-- ?????? ???????????? -->
			<button type="button" class="btn btn-light btn-sm" onclick="location.href='${path}/mate/list?page=${pageInfo.nextPage}'"><i class="fas fa-angle-right"></i></button>
			
			<!-- ??? ????????? -->
			<button type="button" class="btn btn-light btn-sm" onclick="location.href='${path}/mate/list?page=${pageInfo.maxPage}'"><i class="fas fa-angle-double-right"></i></button>
		</div>		
  </div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
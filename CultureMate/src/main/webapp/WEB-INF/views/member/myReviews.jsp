<%@ page import="com.kh.cm.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap');

	.list-group-item.active{
		background-color: #9DB81F;
		border-color: #9DB81F;
	}
	
    #title{
		font-family: 'Noto Sans KR', sans-serif;
	}


	th.td1 {
	    width: 10%;
	}
	
	th.td2 {
	    width: 15%;
	}
	
	th.td3 {
	    width: 16%;
	}
	
	th.td4 {
	    width: 20%;
	}
	
	.pagination{
		justify-content: center;
	}
</style>

<div class="container">
	<div class="row">
		<div class="col-md-3 ">
			<div class="list-group ">
              <a href="${ path }/member/myPage" class="list-group-item list-group-item-action">회원정보 수정</a>
              <a href="${ path }/member/updatePwd" class="list-group-item list-group-item-action">비밀번호 변경</a>
			  <a href="${ path }/member/ticket" class="list-group-item list-group-item-action">예매내역</a>
              <a href="${ path }/member/myPosts" class="list-group-item list-group-item-action">내가 쓴 글 조회</a>
              <a href="${ path }/member/myReviews" class="list-group-item list-group-item-action active">내가 쓴 리뷰 조회</a>
			</div>
		</div>
		<div class="col-md-9">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-md-12">
							<h4 id="title">내가 쓴 리뷰 조회</h4>
							<hr>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<table class="table table-hover">
							  <th class="td1">번호</th>
							  <th class="td2">작성일</th>
							  <th class="td3">별점</th>
							  <th class="td4">공연 이름</th>
							  <th class="th5">리뷰 내용</th>
							  <c:if test="${ review.size() < 1}">
							  	<tr>
							  		<td colspan="5">
							  			조회된 댓글이 없습니다.
							  		</td>
							  	</tr>
							  </c:if>
							   <c:if test="${ review.size() > 0}">
							  <c:forEach var="i" begin="0" end="${review.size()-1}">
							  	<tr>
							  		<td><c:out value="${i}"></c:out></td>
							  		<td>
										<c:out value="${review.get(i).reviewDate.substring(0,10)}"/>
									</td>
									<td>
										<c:forEach var="j" begin="1" end="${review.get(i).reviewRating}" >
										★
										</c:forEach>
									</td>
							  		<td><a href="${path}/show/restview?name=<c:out value="${review.get(i).mt20id}"/>">  <c:out value="${review.get(i).prfnm}"/> </a></td>  
							  		<td><c:out value="${review.get(i).reviewContent}"/> </td>     
							  	</tr>
							  </c:forEach>
							  </c:if>
							</table>
						</div>
					</div>
					<nav aria-label="Page navigation example">
					  <ul class="pagination">
					    <li class="page-item">
					      <a class="page-link" href="${path}/member/myReviews?page=1" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
								<c:if test="${status.current == pageInfo.currentPage}">
									<li class="page-item"><a class="page-link" href='${path}/member/myReviews?page=${status.current}'><c:out value="${status.current}"/></a></li>
				   				</c:if>
								<c:if test="${status.current != pageInfo.currentPage}">
									<li class="page-item"><a class="page-link" href='${path}/member/myReviews?page=${status.current}'><c:out value="${status.current}"/></a></li>
				   				</c:if>
						</c:forEach>
					    <li class="page-item">
					      <a class="page-link" href="${path}/member/myReviews?page=${pageInfo.nextPage}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.standalone.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js"></script>


<link rel="stylesheet" href="${path}/css/slick.css">
<link rel="stylesheet" href="${path}/css/slick-theme.css">
<script src="${path}/js/slick.js"></script>
<script src="${path}/js/index.js"></script>


<link rel="stylesheet" href="${ path }/resources/css/showview.css" />

			<section>
			<c:set var="show" value="${result.get(0)}"></c:set>
			
			<div class="title">
				<h1 class="hhh">[<c:out value="${show.genrenm}"/>] <c:out value="${show.prfnm}"/></h1>
				<br>
			</div>	
			<div class="rn-03"><!--상단-->
			<div class="first">
			<div class="rn-03-left"><!--포스터, 지역, 동영상-->
				<div class="rn-product-imgbox">
					<img src='${show.poster}' width="430px"/>
				</div>
				
			</div><!--rn-03-left-->
			
			<div class="rn-03-right"><!--상품정보-->
				
				<div class="rn-product-area1"><!--등급, 관람시간, 출연, 가격, 혜택-->
					<dl>
						<dt>장소</dt>
						<dd>&nbsp;<c:out value="${show.fcltynm}"/></dd>
						
						<br>
						
						<dt>기간</dt>
						<c:if test="${show.prfpdfrom != null}">
						<dd>&nbsp;<c:out value="${show.prfpdfrom}"/> ~ <c:out value="${show.prfpdto}"/></dd>
						</c:if>
						<c:if test="${show.prfpdfrom == null}">
						<dd><c:out value="정보가 없습니다."/> </dd>
						</c:if>
						<br>
						
						<dt>관람 시간&nbsp;</dt>
						<dd><c:out value="${show.prfruntime}"/></dd> 
						<c:if test="${prfruntimesize == 1}">
						<dd><c:out value="정보가 없습니다."/></dd> 
						</c:if>
						
						<br>
						
						<dt>관람 등급&nbsp;</dt>
						<c:if test="${show.prfruntime != null}"></c:if>
						<dd><c:out value="${show.prfage}"/></dd> 
							
						<br>
         			</dl>
				</div>
				
				<div class="rn-product-area3"><!--공연시간안내, 배송정보-->
					<dl>
						<br>
						<dt>가격</dt>
						<c:if test="${pcseguidancesize != 1}">
							<c:if test="${loginMember.userId == null || loginMember.rank == '친구'}">
								<div id="price_default"></div>
							</c:if>
							<c:if test="${loginMember.userId != null && loginMember.rank != '친구'}">
								<div id="price_before"></div>
								<div id="price_after"></div>
							</c:if>
						</c:if>
						<c:if test="${pcseguidancesize == 1}">
						<dd><c:out value="정보가 없습니다."/></dd> 
						</c:if>
						
						<br>
						<dt>출연진</dt>
						<dd><c:out value="${show.prfcast}"/> </dd>
						<c:if test="${show.prfcast.length() == 1}">
						<dd><c:out value="정보가 없습니다."/> </dd>
 						</c:if> 
						
						<br>
						<dt>제작사</dt>
						<dd><c:out value="${show.entrpsnm}"/></dd> 
						<c:if test="${show.entrpsnm.length() == 1}">
						<dd><c:out value="정보가 없습니다."/></dd> 
						</c:if>
						
						<br>
						<dt>공연상태</dt>
						<dd><c:out value="${show.prfstate}"/></dd> 
						<c:if test="${show.prfstate.length() == 1}">
						<dd><c:out value="정보가 없습니다."/></dd> 
						</c:if>
						
					</dl>
				</div>
			</div>
			<div id="cal">
			<div id="datepicker" ></div>
			<button id="ticketing" class="btn btn-primary" onclick="openSeatSelect()">예매하기</button>
			<c:if test="${!empty loginMember}">
			<a id="mateBtn" class="btn btn-secondary" href="${path}/mate/write?id=${show.mt20id}&title=${show.prfnm}">메이트</a>
			<br><br>
			<div class="matediv" style="width: 270px; float: right; color: #ec7d2c">
			* 메이트란? <br> &nbsp&nbsp&nbsp같이 가고싶은 사람들을 모집하기 <br>
			   &nbsp&nbsp&nbsp위한 게시판 입니다.
			</div>
			</c:if>
				<form id="ticketing_form" action='${path}/ticket/ticketing' method="post">
					<input type="hidden" id="form_mt20id" name="mt20id" value="${show.mt20id}">
					<input type="hidden" id="form_prfnm" name="prfnm" value="${show.prfnm}">
					<input type="hidden" id="form_ticket_date" name="ticket_date" value="">
					<input type="hidden" id="form_id" name="id" value="${ loginMember.id }">
					<input type="hidden" id="form_userId" name="user_id" value="${ loginMember.userId }">
					<input type="hidden" id="form_ticket_qty" name="ticket_qty" value="">
					<input type="hidden" id="form_pcseguidance" name="pcseguidance" value="">
					<input type="hidden" id="form_ticket_seat" name="ticket_seat" value="">
				</form>
			</div>
			</div>
			</div><!--rn-03-right-->
			



		
		
		
		
		<div class="bls_tbbk">
			<ul class="bls_tbls c3">
				<li class="on"><p><a href="#n" id="poster">소개</a></p></li>
				<li><p><a href="#n" id="perf">공연 시설</a></p></li>
				<li><p id="stat1"><a href="#n" id="stats">기대평/관람 후기(<span id="stats1"></span>)</a></p></li>
				<li><p><a href="#n" id="refund">환불 정보</a></p></li>
			</ul>
		</div>
		
		
		
		<!-- 소개 -->
		<div class="bxo_vcb">			
            <div class="detailArea">
            		<c:out value="${show.sty}"/>
            		<br>
					<c:forEach var="i" begin="1" end="${max}">
					<img alt="" src="${show.styurls.styurl[i-1]}" style="max-width: 100%"><br>
					</c:forEach>
			</div>
		</div>

		<!--공연장 정보-->
        <div class="bxo_vcb" style="display: none">
        	<div>
        		<h3 style="text-align: center;"><c:out value="${show.fcltynm}"></c:out></h3>
        	</div>
			<div class="tib">
				<h4 class="nb_tit1" >
				공연장 정보
				</h4>
				
		<table class="pt">
        <tr>
          <th>공연기간</th>
          <td>
          	<c:if test="${show.prfpdfrom != null}">
				<c:out value="${show.prfpdfrom}"/> ~ <c:out value="${show.prfpdto}"/>
			</c:if>
			<c:if test="${show.prfpdfrom == null}">
				<c:out value="정보가 없습니다."/> 
			</c:if>
		</td>
        </tr>
        <tr>
          <th>좌석수</th>
          <td>
          	<c:out value="${place.get(0).seatscale}"/> 
          </td>
        </tr>
        <tr>
          <th>시설특성</th>
          <td>
          	<c:out value="${place.get(0).fcltychartr}"/>
          </td>
        </tr>
          <tr>
          <th>주소</th>
          <td>
          	<c:out value="${place.get(0).adres}"/>
          </td>
        </tr>
        <tr>
          <th>연락처</th>
          <td>
          	<c:out value="${place.get(0).telno}"/>
          </td>
        </tr>
          <tr>
          <th>홈페이지</th>
          <td>
          	<a href="${place.get(0).relateurl}"><c:out value="${place.get(0).relateurl}"/></a>
          </td>
        </tr>
   		</table>
   		
			</div>
			<br>
			<h3  style="text-align: center;">공연장 위치</h3>
		</div>
		<div id="plcMap" style="width:100%;height:400px;" ></div>
		
		
		<div class="bxo_vcb" style="display: none">
			<div class="tib">
				<span class="nb_tit1" id="showreview">기대평/관람 후기</span>
			</div>
			<div id="comment-container">
				<div> 게시판 운영규정에 맞지 않는 글은 사전 통보없이 삭제될 수 있습니다.  </div>
				<form method="post" id="reply_form">
					<P id="star"> 
					<a id=star1 value=1>★</a> 
					<a id=star1 value=2>★</a> 
					<a id=star1 value=3>★</a> 
					<a id=star1 value=4>★</a> 
					<a id=star1 value=5>★</a> 
					별점을 선택해 주세요.
					</p>
					<textarea name="reviewContent" cols="130" rows="4" onfocus="" id="reviewContent" class="recontent" style="white-space: pre;"></textarea>
					<c:choose>
					 	<c:when test="${!empty loginMember}">
					 	<a href="#" id="btn-insert" onClick='fn_comment()' class="btn pull-right">등록</a>
					 	</c:when>
					 	<c:otherwise>
					 	<a  id="btn-insert"  onClick='fn_comment1()' class="btn pull-right disable ">등록</a>
					 	</c:otherwise>
					 </c:choose>
					<input type="hidden" id="mt20id" name="mt20id" value="${result.get(0).mt20id}">
					<input type="hidden" id="prfnm" name="prfnm" value="${result.get(0).prfnm}">
					<c:if test="${ !empty loginMember}">
					<input type="hidden" id="id" name="id" value="${loginMember.id}">
					<input type="hidden" id="userNick" name="userNick" value="${loginMember.userNick}">
					<div id="hstar" style="float: left">
					
					</div>
					</c:if>
				</form>
			</div>
			<br>
			
			<div id="editmodal">
       		
       		</div>
       		
			
			<div id="commentList">
       		
       		</div>
       		
			
		</div>
		
		<!-- 댓글 수정 모달창 -->
			<c:forEach var="review2"  items="${review}">
				<div class="modal fade" id="myModal${review2.reviewID}" role="dialog">
			    <div class="modal-dialog">
			      <!-- Modal content-->
			      <div class="modal-content">
			        <div class="modal-header">
			          <h4 class="modal-title">댓글 수정 <c:out value="${review2.reviewID}"/></h4>
			        </div>
			        <div class="modal-body">
			        별점수정
			        <P id="ustar"> 
					<a id=star1 value=1>★</a> 
					<a id=star1 value=2>★</a> 
					<a id=star1 value=3>★</a> 
					<a id=star1 value=4>★</a> 
					<a id=star1 value=5>★</a> 
					</p>
			        <input type="hidden" id="rname" value="reviewupdate${review2.reviewID}">
			        <form  method="post" id="reviewupdate${review2.reviewID}">
			           <input type="hidden" name="reviewID" id="reviewID" value="${review2.reviewID}"/>
			          <textarea name="reviewContent" cols="57" rows="4" onfocus="" id="reviewContent"><c:out value="${review2.reviewContent}"/></textarea>
			          <input type="hidden" id="reviewRating1" name="reviewRating1" value="">
			        <div class="modal-footer">
			          <a class="btn btn-default sb" data-dismiss="modal" href="">save </a>
			          <button type="button" class="btn btn-defaulrepltt" data-dismiss="modal">Close</button>
			        </div>
			         </form>
			        </div>
			      </div>
			    </div>
			  </div>
			</c:forEach>
		
		<div class="bxo_vcb" style="display: none" >
			<div class="tib">
			</div>
			<div class="rn">
			예매
			</div>
			<div class="rn-1">
			예매는 PC, 모바일, 고객센터 를 통해 신용카드, 가상계좌(무통장 입금), CM머니, CM상품권, 예치금 등으로 예매하실 수 있습니다.<br>
			(단, 상품마다 사용 가능한 결제 수단이 다르게 적용될 수 있으니 상품 상세페이지 안내 사항을 확인해주세요.)<br>
			무통장입금 결제 선택 시 입금 마감시간은 예매일 익일 밤 11시 29분까지입니다. 입금 마감시간 내 미입금 된 경우 예매가 자동 취소됩니다.<br>
			(단, 상품에 따라 예매 당일 밤 11시 29분에 마감되는 경우가 있으니 예매 전후 반드시 확인해주시기 바랍니다.)<br>
			예매수수료는 다음과 같습니다.<br>
			<div class="re-ta">
			<table >
				<tr> 
					<th>장르 </th>
					<th> PC / 모바일</th>
					<th> 전화예매</th>
				</tr>
				<tr> 
					<td>뮤지컬, 콘서트</td>
					<td>장당 1,000원</td>
					<td rowspan="2"> 장당 2,000원</td>
				</tr>
				<tr> 
					<td>연극</td>
					<td>장당 500원</td>
				</tr>
			</table>
			</div>
			
			</div>
			<hr>
			<!-- 티켓수령 방법  -->
			<div class="rn">
			티켓수령방법
			</div>
			<div class="rn-1">
			현장수령<br>
			티켓은 예매자 본인 수령이 기본 원칙입니다.<br>
			공연 당일 예매확인서와 예매자의 신분증 을 지참하신 후 공연장 매표소에서 티켓을 수령하시면 됩니다.<br>
			<br>
			배송<br>
			배송을 선택하신 경우 예매완료(결제익일) 기준 5~7일 이내에 예매 시 입력하신 주소로 배송됩니다.(영업일 기준)<br>
			일괄배송의 경우 각 상품의 지정된 배송일자 기준으로 배송이 시작됩니다. 배송 시작일은 상세정보 및 예매공지사항에서 확인할 수 있습니다.<br>
			지역 및 배송 서비스 사정에 따라 배송사가 변경될 수 있으며, 배송일이 추가적으로 소요될 수 있습니다.(CJ대한통운, 우체국 외 1개 업체)<br>
			* 티켓 수령과 관련된 정책은 상품별로 상이하니 자세한 내용은 각 상품 상세정보에서 확인 부탁드립니다.<br>
			</div>
			
			<hr>
			
			<!-- 취소마감시간 -->
			<div class="rn">
			취소마감시간
			</div>
			<div class="rn-1">
			<div class="re-ta">
			<table >
				<tr> 
					<th>공연 관람일 </th>
					<th> 취소 마감일</th>
				</tr>
				<tr> 
					<td>화요일 ~ 토요일 </td>
					<td>관람일 전일 평일 오후 5시</td>
				</tr>
				<tr> 
					<td>일요일 ~ 월요일 </td>
					<td>토요일 오전 11시</td>
				</tr>
				<tr> 
					<td>공휴일 및 공휴일 익일 </td>
					<td>공휴일 전일이 평일인 경우 - 오후 5시 <br>
						공휴일 전일이 토요일, 일요일인 경우 - 토요일 오전 11시 <br>
						공휴일에는 예매 취소 불가</td> 
				</tr>
			</table>
			</div>
			관람일 당일 예매하신 건은 취소, 변경, 환불 불가합니다. <br>
			배송이 시작된 티켓의 경우 티켓이 컬처메이트 공연 고객센터로 취소마감시간 이전까지 반송되어야 취소 가능합니다.(취소수수료는 도착일 기준으로 부과됩니다.) <br>
			결제수단을 복수로 선택한 경우 인터넷으로 부분취소가 불가하오니, 고객센터로 문의해주시기 바랍니다. <br>
			 <br>
			일부 공연에 한해, 취소 마감 정책이 달라질 수 있습니다. <br>
			각 상품 상세페이지에 안내되어 있는 취소 정책이 우선 적용되오니, 반드시 예매 전 확인해주시기 바랍니다. <br>
			</div>
			
			<hr>
			<!-- 취소수수료 -->
			<div class="rn">
			취소수수료
			</div>
			<div class="rn-1">
			<div class="re-ta">
			<table >
				<tr> 
					<th>취소일 </th>
					<th>취소수수료</th>
				</tr>
				<tr> 
					<td>예매 후 7일 이내 </td>
					<td>없음</td>
				</tr>
				<tr> 
					<td>예매 후 8일 ~ 관람일 10일 전까지 </td>
					<td>뮤지컬, 콘서트 : 장당 4,000원 / 연극 : 장당 2,000원(단, 티켓 금액의 10% 이내)</td>
				</tr>
				<tr> 
					<td>공관람일 9일 전 ~ 관람일 7일 전까지 </td>
					<td>티켓 금액의 10%</td> 
				</tr>
				<tr> 
					<td>관람일 6일 전 ~ 관람일 3일 전까지 </td>
					<td>티켓 금액의 20%</td> 
				</tr>
				<tr> 
					<td>관람일 2일 전 ~ 취소마감일시까지 </td>
					<td>티켓 금액의 30%</td> 
				</tr>
			</table>
			</div>
			예매 후 7일 이내라도 취소시점이 관람일로부터 10일 이내라면 그에 해당하는 취소수수료가 부과됩니다. <br>
			관람일 당일 취소 가능한 상품의 경우 관람일 당일 취소 시 티켓금액의 90%가 부과됩니다. <br>
			상품의 특성에 따라 취소수수료 정책이 달라질 수 있습니다.(각 상품 예매 시 취소수수료 확인) <br>
			</div>
			
			<hr>
		<!-- 환불  -->
		<div class="rn">
			환불
			</div>
			<div class="rn-1">
			예매수수료는 예매 당일 밤 12시 이전까지 환불되며, 그 이후 기간에는 환불되지 않습니다.<br>
			배송 및 반송처리 된 티켓의 배송비는 환불되지 않습니다.<br>
			<div class="re-ta">
			<table >
				<tr> 
					<th>결제수단 </th>
					<th>환불안내</th>
				</tr>
				<tr> 
					<td>신용카드 </td>
					<td>	
					일반적으로 취소완료 되고 4~5일(토, 공휴일 제외) 후 카드 승인 취소가 확인됩니다. <br>
					취소시점에 따라 취소수수료와 예매수수료, 배송 받으신 경우 배송비를 제외한 금액만큼 환불 처리 됩니다.<br>  
					(부분 취소 시에는 잔여 티켓 금액 + 수수료 등을 제외하고 환불 처리 됩니다.)<br>
					각 카드사의 취소 정책에 따라 승인취소 및 환급일에 차이가 있을 수 있습니다.<br>
					자세한 사항은 카드사로 문의 바랍니다.<br>
					</td>
				</tr>
				<tr> 
					<td>무통장입금 </td>
					<td>
					예매 취소 시 반드시 환불 받으실 계좌번호와 은행명을 입력하세요. <br> 
					취소수수료,예매수수료와 배송 받으신 경우 배송비를 제외한 후 환불 처리됩니다.<br> 
					취소 후 환불 처리는 영업일 기준 3~5일 정도 소요됩니다.<br> 
					환불진행상태는 MY공연>예매확인/취소 상세내역에서 확인할 수 있습니다.<br> 
					<br> 
					* 배송 받은 티켓의 취소를 위해 고객센터로 발송하실 때, 환불 받으실 계좌 정보를 기입하여 보내주시면 보다 빠른 환불 처리가 가능합니다.<br> 
					</td>
				</tr>
			</table>
			</div>
			</div>
			
		
		</div>
		
		<br><br><br>
		
		<div id="today_best">
		<h1 id="today_text">다른 추천 공연</h1><br>
		        <div id="today">
		         <c:forEach var="i"  begin="0" end="7">
		          <div class="list" >
		          <a href="${path}/show/restview?name=${slist.get(i).mt20id}"><img src="${slist.get(i).poster}" class="m_img" style="width: 250px; height: 250px; text-align: center;" t></a>
		          <br><strong id="title">11</strong>
		          </div>
		  			 </c:forEach>
		       </div>
		</div>
		
		
		</section>
			
<script type="text/javascript">
$('#reviewContent').val().replace(/\n/g, "<br>");
</script>


<!-- 달력 (datapciker) -->
<script type="text/javascript">

		 var minDate_before = "${show.prfpdfrom}";
		 var maxDate_before = "${show.prfpdto}";

		 var minDate_val = minDate_before.replace(/\./gi, '-');
		 var maxDate_val = maxDate_before.replace(/\./gi, '-');

		 var today = new Date().toISOString().substring(0, 10);;
		 $( 'datepicker' ).attr( 'data-date', today );

		 console.log(today);

		 var now = new Date();

		 var year= now.getFullYear();
		 var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
		 var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();

		 var today_value = year + '-' + mon + '-' + day;

		 var startDateArr = today_value.split('-');
		 var endDateArr = minDate_val.split('-');

		 var startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2]);
		 var endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2]);

		 if(startDateCompare.getTime() > endDateCompare.getTime()) {

			minDate_val = today_value;

		 }
		  
		$('#datepicker').datepicker({
			format : "yyyy-mm-dd", // 달력에서 클릭시 표시할 값 형식
			language : "kr",
			todayHighlight: true,
			startDate : minDate_val,
			endDate : maxDate_val
		});


		$('#datepicker').on('changeDate', function() {
		    $('#form_ticket_date').val(
		        $('#datepicker').datepicker('getFormattedDate')
		    );
		    console.log("$('#form_ticket_date').val() : " + $('#form_ticket_date').val());
		});
</script>
<!--var price = price_before.replace(/[^0-9]/g,'');-->
<script>
	var price_before = "${show.pcseguidance}";
	var price_step01 = price_before.split("원");
	var price_step02 = null;

	console.log("price_before : " + price_before);

	console.log("price_step01 : " + price_step01);

	price_step02 += price_step01[0];

	price = price_step02.replace(/[^0-9]/g,'');

	console.log("price_step02 : " + price_step02);

	console.log("price : " + price);

	var form_pcseguidance = document.getElementById("form_pcseguidance");

	var rank = "${loginMember.rank}";
	var price_default = document.getElementById("price_default");
	var price_before = document.getElementById("price_before");
	var price_after = document.getElementById("price_after");

	if(rank == "" || rank == "친구") {
		price_default.innerHTML = "전석 " + price + "원";

	}

	if (rank == "친한친구") {
		price_before.innerHTML = "전석 " + price + "원";

		price = price * 0.95;

		price_after.innerText = "전석 " + price + "원 \n [친한친구 등급 5% 할인!]";

		console.log(price);
	} else if(rank == "베스트프랜드") {
		price_before.innerHTML = "전석 " + price + "원";

		price = price * 0.9;

		price_after.innerText = "전석 " + price + "원 \n [베스트프랜드 등급 10% 할인!]";

		console.log(price);
	}

	form_pcseguidance.value = price;

	var logincheck = document.getElementById("form_userId").value;

	function openSeatSelect(){
		if(logincheck == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href="${path}/login";
		} else if($('#form_ticket_date').val() == "") {
			alert("날짜를 선택해 주세요!");
		}else {
			console.log("$('#form_ticket_date').val() : " + $('#form_ticket_date').val());

			window.open("${path}/ticket/ticketing/seat",
					"SeatSelect", "width=700, height=450, resizable = no, scrollbars = no");
		}
	}
</script>



	
<!-- 댓글 평점-->
<script type="text/javascript">
$('#star a').click(function(){ 
	$(this).parent().children("a").removeClass("on"); 
	$(this).addClass("on").prevAll("a").addClass("on"); 
	console.log($(this).attr("value"));
	
	var snum = $(this).attr("value");
	
	$.ajax({
		 type:'POST',
	     url : "<c:url value='/review/star.do'/>",
	     data: {"num" : $(this).attr("value")},
	     success: function(data) {
				html = '<input type="hidden" id="reviewRating" name="reviewRating" value="' + data + '">';
				 $("#hstar").html(html);
			}
	        
	});
	
});

//댓글 평점 수정 
$(document).on('click','#ustar a',function(){ 
	$(this).parent().children("a").removeClass("on"); 
	$(this).addClass("on").prevAll("a").addClass("on"); 
	console.log($(this).attr("value"));
	
	document.getElementById('reviewRating1').value = $(this).attr("value");
	
});
	

//댓글 작성
function fn_comment(){
    console.log("에이작스 호출");
   
    $.ajax({
        type:'POST',
        url : "<c:url value='/review/add.do'/>",
        data:$("#reply_form").serialize(),
        success : function(data){
        	console.log("불러오기 성공!!");
            if(data != null)
            {
            	getCommentList();
            	  var html1 = data;
                  $("#stats1").html(html1);
            	$("#reviewContent").val("");
            	console.log("불러오기 성공!!");
            }
            
        },
        error:function(request,status,error){
        	console.log("불러오기실패!!");
       }
        
    }); 	
   
}

// 처음 댓글 부르기
$(function(){
    
    getCommentList();
    
});

// 댓글 불러오기 
function getCommentList(){
	console.log("내댓글불러옴?");
	$.ajax({
		type:'GET',
        url : "<c:url value='/review/list.do'/>",
        data:$("#reply_form").serialize(),
        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
        success : function(data){
        	var html = "";
        	var html2 = "";
            var cCnt = data.length;
            var logincheck = document.getElementById("form_id").value;
          
            var date = new Date();
            var year = date.getFullYear();
            var month = ("0" + (1 + date.getMonth())).slice(-2);
            var day = ("0" + date.getDate()).slice(-2);
            
            var rtoday = year + "/" + month + "/" + day;
            console.log("수정될 날짜" + rtoday);            
            
            var html1 = data[0].reviewsize;
            $("#stats1").html(html1);
          
            console.log("댓글길이값 : " + cCnt);
            
            if(html1 > 0){
            
            html += '<table id="tbl-comment">';
            for(i=0; i<data.length; i++){
            	if(logincheck == data[i].userId){
            		html += "<tr class='level1'>";
            		html += "<td id='replytd'>";
            		
            		if(data[i].reserve == 'Y'){
            			html += '<sub class="rn-0904-tt1">관람평</sub>'; 
            		}else{
            			html += '<sub class="rn-0904-tt2">기대평</sub>'; 
            		}
            		
            		
            		
            		html += '<sub class="comment-writer">' +data[i].userNick+ ' | </sub>'; 
            		html += '<sub class="comment-date">' + data[i].reviewDate + ' | </sub>';
	               
            		for(j = 0; j < data[i].reviewRating; j++){
             		html += '<img alt="" src="http://tkfile.yes24.com/imgNew/common/rn-ico-tt4-1.png">'
    					}
            		
             		html += '<a id="deletereply" href="#" onclick="del(' + data[i].reviewID +')" ><img alt="삭제" src="${ path }/resources/images/view/trash-fill.svg"></a>';
            		html += '<a id="updatereply" data-toggle="modal" href="#myModal' +data[i].reviewID+ '"><img alt="수정" src="${ path }/resources/images/view/pencil-square.svg"></a>';
	            	html += '<br><br>' +data[i].reviewContent+ '<br><br></td></tr>';
            	  }
            	 else{
            		html += "<tr class='level1'>";
            		html += "<td id='replytd'>";
             		
            		if(data[i].reserve == 'Y'){
            			html += '<sub class="rn-0904-tt1">관람평</sub>'; 
            		}else{
            			html += '<sub class="rn-0904-tt2">기대평</sub>'; 
            		}
             		
             		html += '<sub class="comment-writer">' +data[i].userNick+ ' | </sub>'; 
             		html += '<sub class="comment-date">' + data[i].reviewDate + ' | </sub>';
             		for(j = 0; j < data[i].reviewRating; j++){
                 	html += '<img alt="" src="http://tkfile.yes24.com/imgNew/common/rn-ico-tt4-1.png">';
        			}
 	            	html += '<br><br>' +data[i].reviewContent+ '<br><br></td></tr>';
            	  }
            }
            html += "</table>";
            
            for(i=0; i<data.length; i++){
            html2 += '<div class="modal fade" id="myModal' +data[i].reviewID+ '" role="dialog">';
            html2 += '<div class="modal-dialog">';
            html2 += '<div class="modal-content">';
            html2 += '<div class="modal-header">';
            html2 += '<h4 class="modal-title">댓글 수정'  +data[i].reviewID+ '</h4>';
            html2 += '</div>';
            html2 += '<div class="modal-body"> 별점수정';
            html2 += '<p id="ustar">';
           	html2 += '<a id=star1 value=1>★</a>';
           	html2 += '<a id=star1 value=2>★</a>';
        	html2 += '<a id=star1 value=3>★</a>';
        	html2 += '<a id=star1 value=4>★</a>';
        	html2 += '<a id=star1 value=5>★</a>';
        	html2 += '</p>';
            html2 += '<input type="hidden" id="rname" value="reviewupdate' +data[i].reviewID+ '">';
            html2 += '<form  method="post" id="reviewupdate' +data[i].reviewID+ '">';
            html2 += '<input type="hidden" name="reviewID" id="reviewID" value="' +data[i].reviewID+ '"/>';
            html2 += '<textarea id="reviewContent" name="reviewContent" cols="57" rows="4" onfocus="" >' +data[i].reviewContent+ '</textarea>';
            html2 += '<input type="hidden" id="reviewRating1" name="reviewRating1" value="">'
            html2 += '<input type="hidden" id="reviewDate1" name="reviewDate1" value="' +rtoday+ '">';
            html2 += '<div class="modal-footer">';
            html2 += '<a class="btn btn-default sb" data-dismiss="modal" href="#">수정</a>';
            html2 += '<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>';
            html2 += '</div></form></div></div></div></div>';
            
            }
           
            
            
            }else{
            	html += "<p id='noreply'>작성된 댓글이 없습니다.</p>";
            }
            
            $("#commentList").html(html);
            $("#editmodal").html(html2);
        }
	});
	
	
}


function fn_comment1(){
	var logincheck = document.getElementById("form_userId").value;

	if(!logincheck) {
		alert("로그인 후 이용 가능합니다.");
		location.href="${path}/login";
	} 
}

//댓글삭제
function del(no) {  
	var rlt = confirm("삭제하시겠습니까?");
	if(rlt){
	console.log("del실행" + no);
  $.ajax({
      type : 'GET',
      url : "<c:url value='/review/delete.do?no=" + no + "'/>",
    success : function (data) {
    	console.log("삭제카운트");
    	var html1 = data;
        $("#stats1").html(html1);
    	getCommentList();
	}
  });
  	alert("삭제되었습니다.");
	}else{
		alert("취소하였습니다.");
	}
}

// 댓글 수정

 $(document).on("click", ".sb",function(){
	
	var va1 = $(this).parent().parent().children('#reviewContent').val();
	var va2 = $(this).parent().parent().children('#reviewID').val();
	var va3 = document.getElementById("reviewRating1").value;
	var va4 = $(this).parent().parent().children('#reviewDate1').val();
	
	if(!va3){
		alert('별점을 다시 입력해주세요');
	}
	console.log("!!" + va1 +"@@" + va2 + "##" + va3);
	 
	var data = {
			reviewID :  va2,
			reviewContent :  va1,
			reviewRating : va3,
			reviewDate : va4
		    };  
	 
	
	$.ajax({
	      type : 'POST',
	      url : "<c:url value='/review/update.do'/>",
	      data : data,
	      success : function(data){
	        	console.log("업데이트 성공!!");
	        	getCommentList();
	        }
	  });
	
	});
	
</script>

	
<!-- 카카오 지도 API -->		
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3350da83d3aa1ab8eefb3c639de15502"></script>
		
<script>
		var mapContainer = document.getElementById('plcMap'), // 지도를 표시할 div 
		    mapOption = {
				center: new kakao.maps.LatLng(${place.get(0).la}, ${place.get(0).lo}), // 지도의 중심좌표
		        level: 4, // 지도의 확대 레벨
		        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
		    }; 

		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 지도에 마커를 생성하고 표시한다
		var marker = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng(${place.get(0).la}, ${place.get(0).lo}), // 마커의 좌표
		    map: map // 마커를 표시할 지도 객체
		});

		// 마커 위에 표시할 인포윈도우를 생성한다
		var infowindow = new kakao.maps.InfoWindow({
			content : '<div style="padding:5px; width:max-content;"><c:out value="${result.get(0).fcltynm}"/>&nbsp</div>' // 인포윈도우에 표시할 내용
		});

		// 인포윈도우를 지도에 표시한다
		infowindow.open(map, marker);
		
		
		</script>
	
	

<script type="text/javascript">
//탭 메뉴	
var tabMenu = ["poster","perf","stats","refund"];
$.each(tabMenu, function(index, value) {
	$("#" + value).click(function () {
		$(".bls_tbls li").eq(index).addClass("on");
		
		//내용보이기
		if (value == "poster") {
			$("#plcMap").hide(); 
			$(".bxo_vcb").eq(0).show();
		}else if(value == "perf") {
			$("#plcMap").show();
			$(".bxo_vcb").eq(1).show();
			
		}else if(value == "stats") {
			$("#plcMap").hide();
			$(".bxo_vcb").eq(2).show();
			
			$("#plcMap").hide();
		}else if(value == "refund") {
			$("#plcMap").hide();
			$(".bxo_vcb").eq(3).show();
			
		}
		//나머지 항목
		for (var i in tabMenu) {
			if (tabMenu[i] != value) {  
				$(".bls_tbls li").eq(i).removeClass();
				$(".bxo_vcb").eq(i).hide();
			}
		};
	});
	
});



$("#plcMap").hide();


</script>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>좌석 선택</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${path}/resources/css/seat.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js" ></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>

    <div id="pop_container">
        <div id="seat_container">
            <div class="left">
                <div class="text">A</div>
                <div class="text">B</div>
                <div class="text">C</div>
                <div class="text">D</div>
                <div class="text">E</div>
                <div class="text">F</div>
                <div class="text">G</div>
                <div class="text">H</div>
            </div>
            <div class="screen">screen</div>
            <div class="right">
                <div class="list list01">
                    <div class="box"></div>
                    <div class="text">선택</div>
                </div>
                <div class="list list02">
                    <div class="box"></div>
                    <div class="text">선택가능</div>
                </div>
                <div class="list list03">
                    <div class="box"></div>
                    <div class="text">선택불가</div>
                </div>
            </div>
            <div class="seat_box">
                <div class="line line01">
                    <div class="seat able">A1</div>
                    <div class="seat none">B1</div>
                    <div class="seat able">C1</div>
                    <div class="seat none">D1</div>
                    <div class="seat able">E1</div>
                    <div class="seat none">F1</div>
                    <div class="seat able">G1</div>
                    <div class="seat none">H1</div>
                </div>
                <div class="line line02">
                    <div class="seat none">A2</div>
                    <div class="seat able">B2</div>
                    <div class="seat none">C2</div>
                    <div class="seat able">D2</div>
                    <div class="seat none">E2</div>
                    <div class="seat able">F2</div>
                    <div class="seat none">G2</div>
                    <div class="seat able">H2</div>
                </div>
                <div class="line line03">
                    <div class="seat able">A3</div>
                    <div class="seat none">B3</div>
                    <div class="seat able">C3</div>
                    <div class="seat none">D3</div>
                    <div class="seat able">E3</div>
                    <div class="seat none">F3</div>
                    <div class="seat able">G3</div>
                    <div class="seat none">H3</div>
                </div>
                <div class="line line04">
                    <div class="seat none">A4</div>
                    <div class="seat able">B4</div>
                    <div class="seat none">C4</div>
                    <div class="seat able">D4</div>
                    <div class="seat none">E4</div>
                    <div class="seat able">F4</div>
                    <div class="seat none">G4</div>
                    <div class="seat able">H4</div>
                </div>
                <div class="line line05">
                    <div class="seat able">A5</div>
                    <div class="seat none">B5</div>
                    <div class="seat able">C5</div>
                    <div class="seat none">D5</div>
                    <div class="seat able">E5</div>
                    <div class="seat none">F5</div>
                    <div class="seat able">G5</div>
                    <div class="seat none">H5</div>
                </div>
                <div class="line line06">
                    <div class="seat none">A6</div>
                    <div class="seat able">B6</div>
                    <div class="seat none">C6</div>
                    <div class="seat able">D6</div>
                    <div class="seat none">E6</div>
                    <div class="seat able">F6</div>
                    <div class="seat none">G6</div>
                    <div class="seat able">H6</div>
                </div>
                <div class="line line07">
                    <div class="seat able">A7</div>
                    <div class="seat none">B7</div>
                    <div class="seat able">C7</div>
                    <div class="seat none">D7</div>
                    <div class="seat able">E7</div>
                    <div class="seat none">F7</div>
                    <div class="seat able">G7</div>
                    <div class="seat none">H7</div>
                </div>
                <div class="line line08">
                    <div class="seat none">A8</div>
                    <div class="seat able">B8</div>
                    <div class="seat none">C8</div>
                    <div class="seat able">D8</div>
                    <div class="seat none">E8</div>
                    <div class="seat able">F8</div>
                    <div class="seat none">G8</div>
                    <div class="seat able">H8</div>
                </div>
                <div class="line line09">
                    <div class="seat able">A9</div>
                    <div class="seat none">B9</div>
                    <div class="seat able">C9</div>
                    <div class="seat none">D9</div>
                    <div class="seat able">E9</div>
                    <div class="seat none">F9</div>
                    <div class="seat able">G9</div>
                    <div class="seat none">H9</div>
                </div>
                <div class="line line10">
                    <div class="seat none">A10</div>
                    <div class="seat able">B10</div>
                    <div class="seat none">C10</div>
                    <div class="seat able">D10</div>
                    <div class="seat none">E10</div>
                    <div class="seat able">F10</div>
                    <div class="seat none">G10</div>
                    <div class="seat able">H10</div>
                </div>
            </div>
        </div>
        <form id="result_view" action="">
            <label>좌석번호 : <input id="seat_num_view" class="list list01" type="text" readonly></label> <br>
            <label>티켓수 : <input id="seat_count_view" class="list list02" type="text" value="" readonly></label> <br>
            <label>가격 : <input id="seat_price_view" class="list list03" type="text" value="" readonly></label>
        </form>
        <div id="btn_container">
            <button id="reset" class="font btn" onclick="remove()">초기화</button>
            <button id="complete" class="font btn" onclick="payment()">결제하기</button>
        </div>
        <form id="result" action="">
            <label>좌석번호 : <input id="seat_num" class="list list01" type="text" readonly></label> <br>
            <label>개수 : <input id="seat_count" class="list list02" type="text" value="0" readonly></label> <br>
            <label>가격 : <input id="seat_price" class="list list03" type="text" value="0" readonly></label>
        </form>
    </div>

    <script>
        var price = opener.document.getElementById("form_pcseguidance").value;
        var price_view = null;
        var seat_count = document.getElementById('seat_count');
        var seat_price = document.getElementById('seat_price');
        var seat_num = document.getElementById('seat_num');
        var seat_count_view = document.getElementById('seat_count_view');
        var seat_price_view = document.getElementById('seat_price_view');
        var seat_num_view = document.getElementById('seat_num_view');

        // 좌석 클릭 이벤트
        const container = document.querySelector(".seat_box");

        container.addEventListener("click", (e) => {
           if(
               e.target.classList.contains("seat") &&
               !e.target.classList.contains("none")
           ) {
               e.target.classList.toggle("click");
           }
        });

        // 좌석번호, 가격, 개수 구하기

        container.addEventListener("click", (e) => {
            if(
                e.target.classList.contains("seat") &&
                !e.target.classList.contains("none")
            ) {

                var count = document.getElementsByClassName('click').length;
                var seat_num_arr = [];
                var seat_num_for = document.getElementsByClassName('click');

                if(count < 1) {
                    seat_count.value = null;
                    seat_price.value = null;
                    seat_num.value = null;

                    seat_count_view.value = null;
                    seat_price_view.value = null;
                    seat_num_view.value = null;
                } else{
                    for(let i = 0; i < count; i++) {
                        seat_num_arr[i] = seat_num_for[i].innerHTML;
                    }

                    seat_count.value = count;
                    seat_price.value = price * count;
                    seat_num.value = seat_num_arr;

                    price_view = (price * count).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');

                    seat_count_view.value = count;
                    seat_price_view.value = price_view + "원";
                    seat_num_view.value = seat_num_arr;

                    console.log(seat_num_arr);
                }
            }
        });

        var reset = document.getElementById('reset');
        var complete = document.getElementById('complete');

        // 초기화
        function remove() {
            $('.seat.click').removeClass('click');

            seat_count.value = null;
            seat_price.value = null;
            seat_num.value = null;

            seat_count_view.value = null;
            seat_price_view.value = null;
            seat_num_view.value = null;
        }
        
     	// 결제하기
        function payment() {
            if(seat_count.value < 1) {
                alert('좌석을 선택해 주세요!');
            } else {
                opener.document.getElementById("form_ticket_qty").value = seat_count.value;
                opener.document.getElementById("form_pcseguidance").value = seat_price.value;
                opener.document.getElementById("form_ticket_seat").value = seat_num.value;

                opener.document.getElementById("ticketing_form").submit();

                self.close();
            }
        }
    </script>

</body>
</html>































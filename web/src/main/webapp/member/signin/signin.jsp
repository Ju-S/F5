<%--
  Created by IntelliJ IDEA.
  User: keduit
  Date: 25. 8. 27.
  Time: 오후 8:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/common/Head.jsp"/>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: white;
            height: 100%;
            overflow: hidden;
        }

        #container1 {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        /*호버 액티브 모음*/
        .btn.btn-primary:hover {
            border: 1px solid #3E459D !important;
            background-color: #262a59 !important;
        }
        .btn-outline-light:hover {
            background-color: #3E459D;
            border: 1px solid #3E459D ;
            color:white  !important;
        }


        /*오른쪽*/
        #right {
            float: left;
            width: 50%;
            height: 100%;

            position: relative;
        }

        /*웰컴이미지*/
        #rightZindex2 {
            position: absolute; /* 부모 기준 */
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
        }

        #rightZindex2 img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /*블러이미지*/
        #rigthZindex3 {
            position: absolute; /* 부모 기준 */
            top: 7.5%; /* 원하는 만큼 내리기 */
            left: 10%;

            width: 80%;
            height: 85%;
            background-color: #ffffff70;
            z-index: 3;
        }

        #rightText {
            font-family: 'Taenada', sans-serif;
            font-size: 90px;
            font-weight: 600;

            margin-top: 35%;
            margin-left: 5%;
        }


        /*왼쪽*/
        #left {
            float: left;
            width: 50%;
            height: 100%;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        #leftBox {
            /*border: 1px solid red;*/

            width: 55%;
            height: 70%;
        }

        /*1층 텍스트*/
        #leftText {
            /*border: 1px solid red;*/

            padding-top: 8%;
            width: 100%;
            height: 20%;

            font-family: 'Taenada', sans-serif;
            font-size: 40px;
            font-weight: 600;
        }

        /*2층 아이디*/
        #idRow {
            /*border: 1px solid red;*/

            width: 100%;
            height: 10%;
        }

        #idRowBox {
            /*border: 1px solid red;*/
            width: 100%;
            height: 70%;

            display: flex;
            align-items: stretch; /* 높이 동일하게 */
        }

        #idRow input {
            width: 65%;
            height: 100%;

            border-radius: 11px;
            padding-left: 4%;
            background-color: white;
            border: 1.5px solid #949494;
        }

        #idBtn {
            margin-left: 5%;
            width: 30%;
            height: 100%;

            background-color:#3E459D;
            border:1px solid #3E459D;
            border-radius: 8px;
        }

        #idRowText {
            /*border: 1px solid red;*/
            width: 100%;
            height: 30%;
        }

        /*3층 닉네임*/
        #nicknameRow {
           /* border: 1px solid red;*/

            width: 100%;
            height: 10%;
        }

        #nicknameRowBox {
            /*border: 1px solid red;*/

            width: 100%;
            height: 70%;

            display: flex;
            align-items: stretch; /* 높이 동일하게 */
        }

        #nickname {
            width: 65%;
            height: 100%;

            border-radius: 11px;
            padding-left: 4%;
            background-color: white;
            border: 1.5px solid #949494;
        }

        #nicknameRowBox button {
            margin-left: 5%;
            width: 30%;
            height: 100%;

            background-color:#3E459D;
            border:1px solid #3E459D;
            border-radius: 8px;
        }

        #nicknameRowText {
            /*border: 1px solid red;*/

            width: 100%;
            height: 30%;
        }


        /*4층 비밀번호*/
        #pwRow {
            /*border: 1px solid red;*/

            width: 100%;
            height: 10%;
        }

        #pwRowBox {
           /* border: 1px solid red;*/
            width: 100%;
            height: 70%;
            display: flex;
            justify-content: space-between; /* 아이템 사이 간격 자동 */
        }

        #pwRowBox input {
            width: 48%;
            height: 100%;

            border-radius: 11px;
            padding-left: 4%;
            background-color: white;
            border: 1.5px solid #949494;
        }

        #pwRowText {
            /*border: 1px solid red;*/
            width: 100%;
            height: 30%;
        }

        /*5층 이름*/
        #nameRow {
            /*border: 1px solid red;*/

            width: 100%;
            height: 10%;
        }

        #nameRowBox {
            /*border: 1px solid red;*/
            width: 100%;
            height: 70%;
        }

        #name {
            width: 100%;
            height: 100%;

            border-radius: 11px;
            padding-left: 4%;
            background-color: white;
            border: 1.5px solid #949494;
        }

        #nameRowText {
            /*border: 1px solid red;*/
            width: 100%;
            height: 30%;
        }

        /*6층 이메일*/
        #emailRow {
            /*border: 1px solid red;*/

            width: 100%;
            height: 10%;
        }

        #emailRowBox {
            /*border: 1px solid red;*/

            width: 100%;
            height: 70%;

            display: flex;
            align-items: stretch; /* 높이 동일하게 */
        }

        #email {
            width: 65%;
            height: 100%;

            border-radius: 11px;
            padding-left: 4%;
            background-color: white;
            border: 1.5px solid #949494;
        }

        #emailBtn {
            margin-left: 5%;
            width: 30%;
            height: 100%;

            background-color:#3E459D;
            border:1px solid #3E459D;

            border-radius: 8px;
        }

        #emailRowText {
            /*border: 1px solid red;*/

            width: 100%;
            height: 30%;
        }

        /*7층 대시보드*/
        #dashboardRow {
            /*border: 1px solid red;*/

            width: 100%;
            height: 10%;
        }

        #dashboardRowBox {
            /*border: 1px solid red;*/
            display: flex;

            width: 100%;
            height: 70%;
        }

        #genderBox {
            /*border: 1px solid red;*/
            width: 50%;
            height: 100%;
            display: inline-block;
        }

        #yearBox {
            /*border: 1px solid red;*/
            width: 50%;
            height: 100%;
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */

        }

        #dropdownMenuButton2 {
            width: 60%; /* 부모 요소의 절반 너비 */
            text-align: center;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            border-radius: 8px;
        }

        .dropdown-menu {
            max-height: 200px; /* 원하는 높이 설정 */
            overflow-y: auto; /* 세로 스크롤 활성화 */
        }

        #birthYear option {
            text-align: center;
        }

        #dashboardRowText {
           /* border: 1px solid red;*/

            width: 100%;
            height: 30%;
        }

        #agreeRow {
            /*border: 1px solid red;*/

            width: 100%;
            height: 20%;
        }
        #agreeBtnBox {
            margin-top: 11%;
            /*border: 1px solid red;*/

            width: 100%;
            height: 35%;

            display: flex;
            align-items: stretch; /* 높이 동일하게 */
        }
        #completeBtn {
            width: 65%;
            height: 100%;
            border-radius: 8px;
            background-color:#3E459D;
            border:1px solid #3E459D;
        }
        #delBtn {
            margin-left: 5%;
            width: 30%;
            height: 100%;
            color:#3E459D;
            border:1px solid #3E459D;
            border-radius: 8px;
        }



    </style>
</head>
<body>

<div id="container1">

    <form>
        <%--왼쪽--%>
        <div id="left">
            <div id="leftBox">

                <div id="leftText">Create Account</div>


                <div id="idRow">
                    <div id="idRowBox">
                        <input type="text" placeholder="id" id="id">

                        <button class="btn btn-primary" id="idBtn" type="button">중복확인</button>
                        <%--모달 창--%>
                        <div class="modal" tabindex="-1" id="idModal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <%--타이틀--%>
                                    <div class="modal-header">
                                        <h5 class="modal-title"> 아이디 중복 확인 </h5>
                                        <%--x버튼--%>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>

                                    <%--바디--%>
                                    <div class="modal-body">
                                        <p><%--사용가능한 아이디 입니다 / 사용 불가한 아이디 입니다--%></p>
                                    </div>


                                    <%--푸터버튼--%>
                                    <div class="modal-footer">
                                        <%--true(중복): 닫기버튼 /false(사용가능):취소/사용하기--%>
                                    </div>


                                </div>
                            </div>
                        </div>


                    </div>
                    <div id="idRowText"></div>
                </div>


                <div id="nicknameRow">
                    <div id="nicknameRowBox">
                        <input type="text" placeholder="nickname" id="nickname">
                        <button class="btn btn-primary" id="nicknameBtn" type="button">중복확인</button>

                        <%--모달 창--%>
                        <div class="modal" tabindex="-1" id="nicknameModal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <%--타이틀--%>
                                    <div class="modal-header">
                                        <h5 class="modal-title"> 닉네임 중복 확인 </h5>
                                        <%--x버튼--%>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>

                                    <%--바디--%>
                                    <div class="modal-body">
                                        <p><%--사용가능한 닉네임 입니다 / 사용 불가한 닉네임 입니다--%></p>
                                    </div>

                                    <%--푸터버튼--%>
                                    <div class="modal-footer">
                                        <%--true(중복): 닫기버튼 /false(사용가능):취소/사용하기--%>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div id="nicknameRowText">

                    </div>
                </div>


                <div id="pwRow">
                    <div id="pwRowBox">
                        <input type="text" placeholder="pw" id="pw">
                        <input type="text" placeholder="pw check" id="pwCheck">
                    </div>
                    <div id="pwRowText"></div>
                </div>


                <div id="nameRow">
                    <div id="nameRowBox">
                        <input type="text" placeholder="name" id="name">
                    </div>
                    <div id="nameRowText"></div>
                </div>


                <div id="emailRow">
                    <div id="emailRowBox">
                        <input type="text" placeholder="email" id="email">
                        <button class="btn btn-primary" id="emailBtn">email인증</button>
                    </div>
                    <div id="emailRowText"></div>
                </div>


                <div id="dashboardRow">
                    <div id="dashboardRowBox">
                        <div id="genderBox">
                            <input type="radio" name="sex" value="male"> 남
                            <input type="radio" name="sex" value="female"> 여
                        </div>
                        <div id="yearBox">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                태어난 연도
                            </button>

                            <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuButton2"></ul>
                            <%--스크립트로 드롭다운 내용 가져옴--%>

                        </div>

                    </div>
                    <div id="dashboardRowText"></div>
                </div>


                <div id="agreeRow">
                    <div id="agreeBtnBox">
                        <button class="btn btn-primary" id="completeBtn" type="submit">회원가입</button>
                        <button class="btn-outline-light" id="delBtn" type="button">취소</button>

                    </div>
                </div>


            </div>


        </div>
    </form>

    <%--오른쪽--%>
    <div id="right">
        <div id="rigthZindex3">
            <div id="rightText">Let's Get<br>Started!</div>
        </div>

        <div id="rightZindex2">
            <img src="/member/login/loginimg.jpg"/> <%--영서가 이미지 주면 바꿀거임--%>
        </div>


    </div>
</div>


<script>
    //중복검사 되었는지 아닌지 확인
    let dupliIdCheck = false;
    let dupliNicknameCheck = false;
    //이메일 인증되었는지 확인
    //true / false로 받으면 될듯

    // 성별 체크 값 저장 (value값 male, female)
    let selectedGender = null;
    $("input[name='sex']").on("change", function () {
        selectedGender = $(this).val();
    });


    // 아이디 중복 확인 버튼 눌렀을때
    $(document).ready(function () {
        $("#idBtn").on("click", function () {

            let id = $("#id").val();//아이디 값을 가져오고

            $.ajax({ //ajax로 id보냄
                url: "/dupliIdCheck.member",
                type: "post",
                data: {
                    id: id
                }
            }).done(function (response) { //response true(중복) /false(사용가능) string값으로 받음
                let modal = new bootstrap.Modal(document.getElementById('idModal'));//인스턴스생성
                if (response === "true") { //중복되었다면
                    let str = "사용 불가한 아이디 입니다";
                    $(".modal-body p").html(str); //모달바디 안에 스트링 넣고

                    let $btn1 = $("<button>").attr({
                        "type": "button",
                        "class": "btn btn-secondary",
                        "data-bs-dismiss": "modal",
                        "id": "btn1"
                    }).html("닫기"); //닫기 버튼 만들고
                    //닫기 버튼 눌렀을 때, 포커스 주기
                    $btn1.on("click", function () {
                        dupliIdCheck = false;
                        $("#id").val("").focus();
                        console.log(dupliIdCheck); //false뜸
                    });

                    $(".modal-footer").html("").append($btn1);//모달 푸터에 닫기 버튼 넣기

                } else if (response === "false") { //중복 안되었다면
                    let str = "사용 가능한 아이디 입니다";
                    $(".modal-body p").html(str); //모달바디 안에 스트링 넣고

                    let $btn2 = $("<button>").attr({
                        "type": "button",
                        "class": "btn btn-secondary",
                        "data-bs-dismiss": "modal",
                        "id": "btn2"
                    }).html("취소"); //취소버튼
                    let $btn3 = $("<button>").attr({
                        "type": "button",
                        "class": "btn btn-primary",
                        "data-bs-dismiss": "modal",
                        "id": "btn3"
                    }).html("사용하기"); //사용하기 버튼

                    //취소 버튼 눌렀을 때 값 지우고, 포커스 주기
                    $btn2.on("click", function () {
                        dupliIdCheck = false;
                        $("#id").val("").focus();
                        console.log(dupliIdCheck); //false뜸
                    });
                    //사용하기 버튼 눌렀을 때 검사 값 true로 바꾸기
                    $btn3.on("click", function () {
                        dupliIdCheck = true;
                        console.log(dupliIdCheck);//true뜸
                    });


                    $(".modal-footer").html("").append($btn2).append($btn3);//모달 푸터에 닫기 버튼 넣기
                }
                modal.show(); // Ajax 완료 후 모달 띄우기
                console.log(dupliIdCheck);
            });
        })
    })
    // 닉네임 중복 확인 버튼 눌렀을때
    $(document).ready(function () {
        $("#nicknameBtn").on("click", function () {

            let nickname = $("#nickname").val();//닉네임 값을 가져오고

            $.ajax({ //ajax로 닉네임보냄
                url: "/dupliNicknameCheck.member",
                type: "post",
                data: {
                    nickname: nickname
                }
            }).done(function (response) { //response true(중복) /false(사용가능) string값으로 받음

                let modal = new bootstrap.Modal(document.getElementById('nicknameModal'));//인스턴스생성
                if (response === "true") { //중복되었다면
                    let str = "사용 불가한 닉네임 입니다";
                    $(".modal-body p").html(str); //모달바디 안에 스트링 넣고

                    let $btn1 = $("<button>").attr({
                        "type": "button",
                        "class": "btn btn-secondary",
                        "data-bs-dismiss": "modal",
                        "id": "btn1"
                    }).html("닫기"); //닫기 버튼 만들고
                    //닫기 버튼 눌렀을 때, 포커스 주기
                    $btn1.on("click", function () {
                        dupliNicknameCheck = false;
                        $("#nickname").val("").focus();
                        console.log(dupliNicknameCheck); //false뜸
                    });

                    $(".modal-footer").html("").append($btn1);//모달 푸터에 닫기 버튼 넣기

                } else if (response === "false") { //중복 안되었다면
                    let str = "사용 가능한 닉네임 입니다";
                    $(".modal-body p").html(str); //모달바디 안에 스트링 넣고

                    let $btn2 = $("<button>").attr({
                        "type": "button",
                        "class": "btn btn-secondary",
                        "data-bs-dismiss": "modal",
                        "id": "btn2"
                    }).html("취소"); //취소버튼
                    let $btn3 = $("<button>").attr({
                        "type": "button",
                        "class": "btn btn-primary",
                        "data-bs-dismiss": "modal",
                        "id": "btn3"
                    }).html("사용하기"); //사용하기 버튼

                    //취소 버튼 눌렀을 때 값 지우고, 포커스 주기
                    $btn2.on("click", function () {
                        dupliNicknameCheck = false;
                        $("#nickname").val("").focus();
                        console.log(dupliNicknameCheck); //false뜸
                    });
                    //사용하기 버튼 눌렀을 때 검사 값 true로 바꾸기
                    $btn3.on("click", function () {
                        dupliNicknameCheck = true;
                        console.log(dupliNicknameCheck);//true뜸
                    });


                    $(".modal-footer").html("").append($btn2).append($btn3);//모달 푸터에 닫기 버튼 넣기
                }
                modal.show(); // Ajax 완료 후 모달 띄우기
                console.log(dupliNicknameCheck);
            });
        })
    })


    // 연도 체크 값 저장
    let selectedYear = null; // 선택된 연도를 저장할 변수
    //드롭다운 내용 채우기
    let $ul = $(".dropdown-menu");
    let currentYear = new Date().getFullYear(); // 현재 년도 가져오기
    for (let i = currentYear; i >= 1900; i--) {
        let $li = $("<li>");
        let $a = $("<a>").addClass("dropdown-item").attr("href", "#").text(i);

        // 클릭 이벤트 추가
        $a.on("click", function (e) {
            selectedYear = $(this).text(); // 선택된 연도 저장
            e.preventDefault(); // 링크 이동 방지
            $("#dropdownMenuButton2").text($(this).text()); // 버튼 텍스트 변경
        });
        $li.append($a);
        $ul.append($li);
    }


    //비어있는 칸 있으면 채우라고 alert 띄우기


    //닫기 누르면 뒤로가기
    $("#delBtn").on("click",function(){
        location.href = "/index.jsp";
    })

</script>


</body>
</html>

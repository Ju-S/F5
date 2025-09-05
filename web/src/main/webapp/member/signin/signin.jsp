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
    <jsp:include page="/common/Mcommon/MHead.jsp"/>
    <link rel="stylesheet" href="/member/signin/signin.css">

</head>
<body>

<div id="container1">

    <form action="/signin.member" method="post" accept-charset="UTF-8">
        <%--왼쪽--%>
        <div id="left">
            <div id="leftBox">

                <div id="leftText">Create Account</div>


                <div id="idRow">
                    <div id="idRowBox">
                        <input type="text" placeholder="id (영어 대소문자,숫자 4~16자)" id="id" name="id">

                        <button class="btn btn-primary btns" id="idBtn" type="button">중복확인</button>
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
                        <input type="text" placeholder="nickname (영어 대소문자, 숫자, 한글 1~12자)" id="nickname" name="nickname">
                        <button class="btn btn-primary btns" id="nicknameBtn" type="button">중복확인</button>

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
                        <input type="password" name="pw" placeholder="pw (영어대소문자, 숫자, 특수문자 필수 포함 4~12자)" id="pw">
                        <input type="password" placeholder="pw check" id="pwCheck">
                    </div>
                    <div id="pwRowText"></div>
                </div>


                <div id="nameRow">
                    <div id="nameRowBox">
                        <input type="text" placeholder="name" id="name" name="name">
                    </div>
                    <div id="nameRowText"></div>
                </div>


                <div id="emailRow">
                    <div id="emailRowBox">
                        <input type="text" placeholder="email (.com이나 .co.kr)" id="email" name="email">
                        <button class="btn btn-primary btns" id="emailBtn" type="button">email인증</button>
                    </div>
                    <div id="emailRowText"></div>
                </div>

                <div id="emailCodeRow">
                    <div id="emailCodeRowBox">
                        <input type="text" placeholder="email code" id="emailCode" disabled>
                        <button class="btn btn-primary btns disabled" id="emailCodeBtn" type="button" disabled>인증 코드 확인</button>
                    </div>

                    <%--모달 창--%>
                    <div class="modal" tabindex="-1" id="emailCodeModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <%--타이틀--%>
                                <div class="modal-header">
                                    <h5 class="modal-title"> 이메일 인증 확인 </h5>
                                    <%--x버튼--%>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>

                                <%--바디--%>
                                <div class="modal-body">
                                    <p><%--이메일이 인증되었습니다 / 이메일이 인증되지 않았습니다--%></p>
                                </div>

                                <%--푸터버튼--%>
                                <div class="modal-footer">
                                    <%--false(인증실패): 닫기 /true(인증성공):확인--%>
                                </div>
                            </div>
                        </div>
                    </div>






                    <div id="emailCodeRowText"></div>
                </div>


                <div id="dashboardRow">
                    <div id="dashboardRowBox">
                        <div id="genderBox">
                            <input type="radio" name="sex" value="0"> 남
                            <input type="radio" name="sex" value="1"> 여
                        </div>
                        <div id="yearBox">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                태어난 연도
                            </button>

                            <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuButton2" id="yearMenu"></ul>
                            <%--스크립트로 드롭다운 내용 가져옴--%>
                            <input type="hidden" id="targetYear" name="targetYear">
                        </div>

                    </div>
                    <div id="dashboardRowText"></div>
                </div>


                <div id="agreeRow">
                    <div id="agreeBtnBox">
                        <button class="btn btn-primary" id="completeBtn" type="submit">회원가입</button>
                        <button class="btn btn-primary" id="delBtn" type="button">취소</button>

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
            <img src="/member/signin/login.png"/> <%--영서가 이미지 주면 바꿀거임--%>
        </div>


    </div>
</div>


<script src="/member/signin/signin.js"></script>


</body>
</html>

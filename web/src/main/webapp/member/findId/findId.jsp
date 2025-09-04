
    <%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <html>
    <head>
        <jsp:include page="/common/Mcommon/MHead.jsp"/>
        <link rel="stylesheet" href="/member/findId/findId.css">
    </head>


    <body>
    <div id="container1">
        <div id="left">
            <div id="leftZindex3">
                <div id="leftText">Find<br>ID</div>
            </div>

            <div id="leftZindex2">
                <img src="/member/signin/login.png"/> <%--영서가 이미지 주면 바꿀거임--%>
            </div>


        </div>
        <div id="right">
            <div id="rightBox">


                <div id="findIdText">아이디 찾기</div>

                <div id="findIdBox">
                    <input type="text" placeholder="name" id="name" name="name">
                    <input type="text" placeholder="email" id="email" name="email">
                    <input type="hidden" id="hiddenEmail" name="hiddenEmail">
                    <input type="hidden" id="hiddenName" name="hiddenName">
                    <button class="mainGameBtn btn btn-primary slide-right" type="button" id="emailBtn">email 인증
                    </button>
                </div>

                <div id="emailCodeBox">
                    <input type="text" placeholder="code" id="code" name="code" disabled>
                    <button type="button" id="codeBtn" class="mainGameBtn btn btn-primary slide-right disabled" disabled>인증 코드
                    </button>
                </div>

                <div id="yourId"> <br><br>
                <%--여기에 아이디 써짐--%>
                </div>

                <button type="button" id="backToLogin" class="mainGameBtn btn btn-primary slide-right" type="button">로그인 페이지로 돌아가기</button>

            </div>
        </div>

    </div>

    <%--스크립트 임포트--%>


    <script src="/member/findId/findId.js"></script>


    </body>
    </html>
</>

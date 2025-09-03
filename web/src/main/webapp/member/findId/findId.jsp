<%--
  Created by IntelliJ IDEA.
  User: keduit
  Date: 25. 8. 27.
  Time: 오후 3:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <jsp:include page="/common/Mcommon/MHead.jsp"/>
    <link rel="stylesheet" href="/member/findId/findId.css">
</head>


<body>
<div id="container1">
    <div id="left">
        <div id="leftZindex3">
            <div id="leftText">Welcome<br>Back</div>
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
                    <input type="password" placeholder="email" id="email" name="email">

                    <button class="mainGameBtn btn btn-primary slide-right" type="submit">email 인증</button>
                </div>











        </div>
    </div>

</div>

<%--스크립트 임포트--%>
<script src="/member/login/login.js"></script>





</body>
</html>

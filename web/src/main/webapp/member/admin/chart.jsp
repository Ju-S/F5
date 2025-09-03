<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/common/common.css">
    <!-- 1. Google Chart API 로드 -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <link rel="stylesheet" href="css/chart-style.css">
</head>
<body>
<!-- Header -->
<jsp:include page="/common/header/Header.jsp"/>

<div class="container">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-1">
            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
        </div>

        <!-- main 내용 -->
        <div class="col-11 main-content">
            <div class="chart-dashboard">
                <!-- 왼쪽 콤보 차트 영역 -->
                <div class="chart-left">
                    <h3>차트 api - 콤보 차트<br>(각 게임 플레이 횟수)</h3>
                    <div id="combo_chart" class="chart-box"></div>
                </div>

                <!-- 오른쪽 원형 차트 2개 -->
                <div class="chart-right">
                    <div class="chart-small-box">
                        <h4>차트 api - 원형 차트<br>(남,여 비율)</h4>
                        <div id="gender_piechart" class="chart-box"></div>
                    </div>
                    <div class="chart-small-box">
                        <h4>차트 api - 원형 차트<br>(년도별 비율)</h4>
                        <div id="year_piechart" class="chart-box"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 여기서 서버 데이터 JS 변수에 담아주기 -->
<script>
    var maleCount = ${maleCount};
    var femaleCount = ${femaleCount};
    var yearStats = [
        <c:forEach var="entry" items="${yearStats}" varStatus="st">
        ['${entry.key}', ${entry.value}]<c:if test="${!st.last}">, </c:if>
        </c:forEach>
    ];
</script>

<!-- 외부 js 불러오기 -->
<script src="/js/chart-api.js"></script>

</body>
</html>

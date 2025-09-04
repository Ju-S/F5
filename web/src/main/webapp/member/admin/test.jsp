<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <style>
        body {
            background-color: #1c1c1c; /* 전체 배경 */
            color: #fff;
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        h2 {
            color: #fff;
        }

        .chart-dashboard {
            display: flex;
            gap: 20px;
        }

        .chart-left, .chart-right {
            background-color: #2c2c2c;
            padding: 20px;
            border-radius: 15px;
        }

        .chart-left {
            flex: 2;
        }

        .chart-right {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .chart-right .chart-box {
            width: 100%;
            height: 300px;
        }
        #combo_chart{
            width: 100%;
            height: 600px;
        }
    </style>
</head>
<body>

<h2>게임 & 회원 통계 대시보드</h2>
<div class="chart-dashboard">
    <!-- 왼쪽 큰 콤보 차트 -->
    <div class="chart-left">
        <h3>게임별 플레이 수 및 평균 점수</h3>
        <div id="combo_chart" class="chart-box"></div>
    </div>

    <!-- 오른쪽 원형 차트 -->
    <div class="chart-right">
        <div>
            <h4>성별 비율</h4>
            <div id="gender_piechart" class="chart-box"></div>
        </div>
        <div>
            <h4>출생년도 비율</h4>
            <div id="year_piechart" class="chart-box"></div>
        </div>
    </div>
</div>

<script>
    google.charts.load('current', {'packages': ['corechart']});
    google.charts.setOnLoadCallback(drawCharts);

    function drawCharts() {
        // --- 콤보 차트 ---
        var comboData = google.visualization.arrayToDataTable([
            ['게임', '플레이 수', '평균 점수'],
            ['남극탐험', 1000, 400],
            ['팩맨', 1170, 460],
            ['지오메트리', 660, 1120],
            ['버블슈터', 1030, 540]
        ]);
        var comboChart = new google.visualization.ComboChart(document.getElementById('combo_chart'));
        comboChart.draw(comboData, {
            title: '게임별 플레이 수 및 평균 점수',
            titleTextStyle: {color: '#fff', fontSize: 16, bold: true},
            vAxis: {title: '수치', textStyle: {color: '#fff'}},
            hAxis: {title: '게임', textStyle: {color: '#fff'}},
            seriesType: 'bars',
            series: {1: {type: 'line', color: '#ff9800', lineWidth: 3}},
            colors: ['#4caf50', '#ff9800'],
            backgroundColor: 'transparent',
            chartArea: {left: '10%', top: '10%', width: '80%', height: '90%'},
            legend: {textStyle: {color: '#fff', fontSize: 12}}
        });

        // --- 성별 차트 ---
        var maleCount = 60;
        var femaleCount = 40;
        var genderData = google.visualization.arrayToDataTable([
            ['성별', '비율'],
            ['남자', maleCount],
            ['여자', femaleCount]
        ]);
        var genderChart = new google.visualization.PieChart(document.getElementById('gender_piechart'));
        genderChart.draw(genderData, {
            title: '성별 비율',
            titleTextStyle: {color: '#fff', fontSize: 14},
            pieHole: 0.4,
            colors: ['#3f51b5', '#e91e63'],
            backgroundColor: 'transparent',
            legend: {textStyle: {color: '#fff', fontSize: 12}}
        });

        // --- 출생년도 차트 ---
        var yearStats = [
            ['1990년대', 10],
            ['2000년대', 20],
            ['2010년대', 50],
            ['2020년대', 20]
        ];
        var yearDataArr = [['출생년도', '비율']].concat(yearStats);
        var yearData = google.visualization.arrayToDataTable(yearDataArr);
        var yearChart = new google.visualization.PieChart(document.getElementById('year_piechart'));
        yearChart.draw(yearData, {
            title: '출생년도 비율',
            titleTextStyle: {color: '#fff', fontSize: 14},
            pieHole: 0.4,
            colors: ['#ff5722', '#009688', '#ffc107','#9C27B0'],
            backgroundColor: 'transparent',
            legend: {textStyle: {color: '#fff', fontSize: 12}}
        });
    }
</script>

</body>
</html>
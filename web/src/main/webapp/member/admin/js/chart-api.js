google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawCharts);

function drawCharts() {
    // 콤보 차트 (예시 데이터)
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
        titleTextStyle: { color: '#fff', fontSize: 16, bold: true },
        vAxis: { title: '수치', textStyle: { color: '#fff' } },
        hAxis: { title: '게임', textStyle: { color: '#fff' } },
        seriesType: 'bars',
        series: { 1: { type: 'line', color: '#3e459d', lineWidth: 3 } },
        colors: ['#3e459d', '#EC6333'],
        backgroundColor: 'transparent',
        chartArea: { width: '90%', height: '70%' },
        legend: { textStyle: { color: '#fff', fontSize: 12 } }
    });

    // 성별 차트
    var genderData = google.visualization.arrayToDataTable([
        ['성별', '비율'],
        ['남자', maleCount],
        ['여자', femaleCount]
    ]);
    var genderChart = new google.visualization.PieChart(document.getElementById('gender_piechart'));
    genderChart.draw(genderData, {
        title: '성별 비율',
        titleTextStyle: { color: '#fff', fontSize: 14 },
        pieHole: 0.4, // 도넛 스타일
        colors: ['#3e459d', '#e91e63'],
        backgroundColor: 'transparent',
        legend: { textStyle: { color: '#fff', fontSize: 12 } }
    });

    // 출생년도 차트
    var yearDataArr = [['출생년도', '비율']].concat(yearStats); // JSP에서 내려준 yearStats 사용
    var yearData = google.visualization.arrayToDataTable(yearDataArr);
    var yearChart = new google.visualization.PieChart(document.getElementById('year_piechart'));
    yearChart.draw(yearData, {
        title: '출생년도 비율',
        titleTextStyle: { color: '#fff', fontSize: 14 },
        pieHole: 0.4,
        colors: ['#ff5722','#009688','#ffc107','#9c27b0','#607d8b'], // 필요한 만큼 색상 추가
        backgroundColor: 'transparent',
        legend: { textStyle: { color: '#fff', fontSize: 12 } }
    });
}

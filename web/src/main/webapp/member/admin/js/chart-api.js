google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawCharts);
// ✅ 2. Chart 패키지 로드 (corechart: 파이/막대/선 차트 등 포함)
// ✅ 3. 차트 그리기 콜백 등록

function drawCharts() {
    // 콤보 차트
    // ✅ 4. 차트에 사용할 데이터 (2차원 배열)
    var comboData = google.visualization.arrayToDataTable([
        ['게임', '플레이 수', '평균 점수'],
        ['남극탐험', 1000, 400],
        ['팩맨', 1170, 460],
        ['지오메트리', 660, 1120],
        ['버블슈터', 1030, 540]
    ]);

    // ✅ 5. 차트 옵션 설정 (제목 등)
    var comboOptions = {
        title: '게임별 플레이 수 및 평균 점수',
        vAxis: {title: '수치'},
        hAxis: {title: '게임'},
        seriesType: 'bars',
        series: {1: {type: 'line'}}
    };

    // ✅ 6. 차트 객체 생성 (div 아이디에 그림)
    var comboChart = new google.visualization.ComboChart(document.getElementById('combo_chart'));
    // ✅ 7. 차트 그리기
    comboChart.draw(comboData, comboOptions);

    // 원형 차트 1 - 성별
    var genderData = google.visualization.arrayToDataTable([
        ['성별', '비율'],
        ['남자', 70],
        ['여자', 30]
    ]);

    var genderChart = new google.visualization.PieChart(document.getElementById('gender_piechart'));
    genderChart.draw(genderData, {title: '성별 비율'});

    // 원형 차트 2 - 연도별
    var yearData = google.visualization.arrayToDataTable([
        ['출생년도', '비율'],
        ['1990년대', 40],
        ['2000년대', 35],
        ['2010년대', 25]
    ]);

    var yearChart = new google.visualization.PieChart(document.getElementById('year_piechart'));
    yearChart.draw(yearData, {title: '출생년도 비율'});
}
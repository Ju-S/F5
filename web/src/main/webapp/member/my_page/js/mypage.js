//연도 드롭다운 내용 채우기 + 클릭하면 selectedYear에 저장
$(document).ready(function () {
    let currentYear = new Date().getFullYear(); // 현재 년도 가져오기
    for (let i = currentYear; i >= 1900; i--) {
        // <option value="1990">1990년</option>
        yearOption = $("<option>").val(i).text(i + "년");

        if(i == memberInfo.birthyear) {
            yearOption.attr("selected", true);
        }

        $("#birthYear").append(yearOption);
    }
})

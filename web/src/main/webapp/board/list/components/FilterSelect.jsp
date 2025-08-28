<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<select class="form-select" id="filterSelect">
    <option value="-1">filter</option>
    <option value="1">정보/공략</option>
    <option value="2">질문</option>
    <option value="3">후기</option>
</select>
<script>
    $("#filterSelect").on("change", (e) => {
        let filter = e.target.value;
        setBoardListAndNav(filter);
    });
</script>

<!-- option의 value는 board_category의 id에 해당 -->
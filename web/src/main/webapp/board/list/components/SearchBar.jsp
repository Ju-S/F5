<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<input id="searchBar" class="form-control h-100" type="text" placeholder="검색어 입력...">
<script>
    $("#searchBar").on("input", (e) => {
        let filter = $("#filterSelect").val();
        let searchQuery = e.target.value;
        setBoardListAndNav(filter, null, searchQuery);
    });
</script>

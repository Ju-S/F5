<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<select id="filterSelect">
    <option>filter</option>
    <option value="1">정보/공략</option>
    <option value="2">질문</option>
    <option value="3">후기</option>
</select>
<script>
    $("#filterSelect").on("change", (e) => {
        $.ajax({
            url:"/get_board_list.board" + "?filter=" + e.target.value,
            dataType:"json"
        }).done((data) => {
            let postList = data.list;
            let itemPerPage = data.itemPerPage;
            createBoardList(postList, itemPerPage);

            let maxPage = data.maxPage;
            let curPage = data.curPage;
            let naviPerPage = data.naviPerPage;
            let filter = data.filter;
            createPageNavigation(maxPage, curPage, naviPerPage, filter);
        });
    });
</script>

<!-- option의 value는 board_category의 id에 해당 -->
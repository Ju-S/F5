function setBoardListAndNav(filter, page=1) {
    let url = "/get_board_list.board";
    url += page ? "?page=" + page : "";
    if (filter) {
        url += page ? "&" : "?";
        url += "filter=" + filter;
    }

    $.ajax({
        url: url,
        dataType: "json"
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
}
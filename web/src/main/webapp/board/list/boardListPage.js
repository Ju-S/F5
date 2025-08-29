function setBoardListAndNav(filter, page, searchQuery) {
    let url = "/get_board_list.board";
    url += page ? "?page=" + page : "";
    if (filter) {
        url += page ? "&" : "?";
        url += "filter=" + filter;
    }
    if (searchQuery) {
        url += page || filter ? "&" : "?";
        url += "searchQuery=" + searchQuery;
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
        let searchQuery = data.searchQuery;
        createPageNavigation(maxPage, curPage, naviPerPage, filter, searchQuery);
    });
}
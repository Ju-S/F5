function createBoardList(postList, itemPerPage) {
    $(".item-list-view").html("");
    if (postList.length === 0) {
        let emptyAlert = $("<td>").attr({
            "colspan": "5",
            "align": "center"
        }).html("표시할 내용이 없습니다.");

        $(".item-list-view").append($("<tr>").append(emptyAlert));
        for (let i = 0; i < itemPerPage - 1; i++) {
            let emptyItem = $("<p>").css("color", "transparent");
            let emptyItemTd = $("<td>").attr("colspan", "5");
            $(".item-list-view").append($("<tr>").append(emptyItemTd.append(emptyItem)));
        }
    } else {
        for (let post of postList) {
            createBoardItem(post);
        }
        if (postList.length % itemPerPage !== 0) {
            for (let i = 0; i < itemPerPage - postList.length % itemPerPage; i++) {
                let emptyItem = $("<p>").css("color", "transparent");
                let emptyItemTd = $("<td>").attr("colspan", "5");
                $(".item-list-view").append($("<tr>").append(emptyItemTd.append(emptyItem)));
            }
        }
    }
}

function createBoardItem(post) {
    let tr = $("<div>").addClass("row item-div");
    let profileImg = $("<div>").addClass("col col-1 profile-img").append($("<img>"));
    let title = $("<div>").addClass("col col-12 title")
        .append($("<a>").attr({
            "title": post.title,
            "href": "/get_board_detail.board?boardId=" + post.id
        }).html(post.title));
    let writer = $("<div>").addClass("col col-12 writer").html(post.writer);
    let boardSummary = $("<div>").addClass("col col-3 board-summary");
    let replyCount = $("<div>").html("<i class=\"bi bi-chat-left-dots-fill me-2\"></i>" + post.viewCount);
    let viewCount = $("<div>").html("<i class=\"bi bi-eye ms-3 me-2\"></i>" + post.viewCount);

    let reportBox = $("<div>").addClass("reportBox ms-2");
    let reportBtn = $("<button>").addClass("btn btn-sm dropdown-toggle")
        .attr({"id":"reportPost", "data-bs-toggle":"dropdown", "aria-expanded":"false"});
    let reportBtnIcon = $("<i>").addClass("bi bi-three-dots-vertical vertical-dots");
    let dropdownMenu = $("<ul>").addClass("dropdown-menu dropdown-menu-end report-menu")
    let dropdownItem = $("<li>").addClass("dropdown-item text-danger").html("신고하기");

    let writerTitleRow = $("<div>").addClass("col col-8 writer-title").append(
        $("<div>").addClass("row").append(title).append(writer)
    );

    dropdownMenu.append(dropdownItem);

    reportBtn.append(reportBtnIcon);

    reportBox.append(reportBtn);
    reportBox.append(dropdownMenu);

    boardSummary.append(replyCount);
    boardSummary.append(viewCount);
    boardSummary.append(reportBox);

    $(".item-list-view").append(tr
        .append(profileImg)
        .append(writerTitleRow)
        .append(boardSummary)
    );
}

function milliToDate(millis) {
    let date = new Date(millis);
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();

    return year + "." + month + "." + day;
}
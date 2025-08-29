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
    let tr = $("<tr>").attr("align", "center");
    // let id = $("<td>").attr("width", "5%").html(post.id);
    let title = $("<td>").attr("width", "30%").addClass("title")
        .append($("<a>").attr({
            "title": post.title,
            "href": "/item.board?seq=" + post.id
        }).html(post.title));
    // let writer = $("<td>").attr("width", "15%").html(post.writer);
    // let writerDate = $("<td>").attr("width", "30%").html(milliToDate(post.writeDate));
    // let viewCount = $("<td>").attr("width", "20%").html(post.viewCount);
    let modifyBtn = $("<td>").attr("width", "30%").addClass("modify")
        .append($("<button>").addClass("btn btn-primary modifyBtn").html("수정"));

    $(".item-list-view").append(tr
        // .append(id)
        .append(title)
        // .append(writer)
        // .append(writerDate)
        // .append(viewCount)
        .append(modifyBtn)
    );
}

function milliToDate(millis) {
    let date = new Date(millis);
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();

    return year + "." + month + "." + day;
}
function createBoardList(postList, itemPerPage) {
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
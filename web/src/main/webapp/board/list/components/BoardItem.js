function createBoardItem(post) {
    let tr = $("<tr>").attr("align", "center");
    let id = $("<td>").attr("width", "5%").html(post.id);
    let title = $("<td>").attr("width", "30%").addClass("title")
        .append($("<a>").attr({
            "title": post.title,
            "href": "/item.board?seq=" + post.id
        }).html(post.title));
    let writer = $("<td>").attr("width", "15%").html(post.writer);
    let writerDate = $("<td>").attr("width", "30%").html(milliToDate(post.writeDate));
    let viewCount = $("<td>").attr("width", "20%").html(post.viewCount);

    $(".item-list-view").append(tr
        .append(id)
        .append(title)
        .append(writer)
        .append(writerDate)
        .append(viewCount));
}

function milliToDate(millis) {
    let date = new Date(millis);
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();

    return year + "." + month + "." + day;
}
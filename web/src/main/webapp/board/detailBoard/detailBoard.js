// JS 에 CSS 파일 부를 때
let link = document.createElement("link");
link.rel = "stylesheet";
link.href = "/board/detailBoard/detailBoard.css";
document.head.appendChild(link);

$(document).ready(function () {
// 댓글 등록 할 때
    $("#sendBtn").click(function () {
        console.log("댓글작성버튼클릭");
        let contents = $("#commentContents").val().trim();
        if (contents === "") {
            alert("댓글을 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/write.reply",
            type: "POST",
            data: {
                boardId: boardId,
                contents: contents
            },
            success: function (res) {
                $("#commentContents").val(""); // 입력창 비우기
                loadComments(boardId); // 댓글 목록 다시 불러오기
            },
            error: function () {
                alert("댓글 등록 실패");
            }
        });
    });
    loadComments(boardId, loginId);
});

// 댓글 수정 기능
function updateComment(id, writer, contents) {
    $.ajax({
        url: "/update_reply.reply",
        type: "post",
        data: {id: id, writer:writer, contents:contents},
        dataType: "json",
        success: function () {
            loadComments(boardId, loginId);
        },
        error: function () {
            alert("댓글 수정 실패");
        }
    });
}

// 댓글 수정 기능
function deleteComment(id, writer) {
    $.ajax({
        url: "/delete_reply.reply",
        type: "post",
        data: {id: id, writer:writer},
        dataType: "json",
        success: function () {
            loadComments(boardId, loginId);
        },
        error: function () {
            alert("댓글 수정 실패");
        }
    });
}

// 댓글 불러오는 기능
function loadComments(boardId, loginId) {
    $.ajax({
        url: "/get_reply_list.reply",
        type: "get",
        data: {boardId: boardId},
        dataType: "json",
        success: function (res) {
            $("#comment-box").empty();
            res.forEach((comment) => {
                // 최상위 row
                let rowComments = $("<div>").addClass("row comments");

                // col-2 profile
                let profileImg = $("<img>")
                    .attr("src", "/board/detailBoard/profile_img/replyProfile.jpg")
                    .addClass("rounded-circle profile-img");

                let profileCol = $("<div>").addClass("col-2 profile").
                css({display:"flex",justifyContent:"center",alignItems:"center"}).append(profileImg);

                // col-8 댓글 내용
                let commentWriter = $("<div>").addClass("col-12 comment-writer").text(comment.writer);
                let commentContents = $("<div>").addClass("col-12 comment-contents").text(comment.contents);

                let commentRow = $("<div>").addClass("row").append(commentWriter, commentContents);
                let commentCol = $("<div>").addClass("col-8").
                css({display:"flex",alignItems:"center"}).append(commentRow);

                // col-2 신고 버튼
                let reportIcon = $("<i>").addClass("bi bi-three-dots-vertical vertical-dots");

                let reportButton = $("<button>")
                    .attr("type", "button")
                    .addClass("btn btn-sm btn-dark dropdown-toggle")
                    .attr("id", "reportPost")
                    .attr("data-bs-toggle", "dropdown")
                    .attr("aria-expanded", "false")
                    .attr("style", "background: transparent; border: none; padding: 0;")
                    .append(reportIcon);

                let reportMenu = $("<ul>")
                    .addClass("dropdown-menu dropdown-menu-end report-menu")
                    .append(
                        $("<li>").append(
                            $("<a>").addClass("dropdown-item text-danger").attr("href", "#").text("신고하기")
                        )
                    );

                let modifyItem = $("<button id='commentUpdate'>").addClass("btn btn-primary btn-sm").
                css({backgroundColor:"#EC6333", border:"none",marginBottom:"10px"}).html("수정");

                let deleteItem = $("<button id='commentDelete'>").addClass("btn btn-primary btn-sm").
                css({backgroundColor:"#888",border:"none"}).html("삭제");

                let modifyBtn = $("<button id='commentUpdate'>").addClass("btn btn-primary btn-sm").
                css({"display": "none", backgroundColor:"#EC6333", border:"none",marginBottom:"10px"}).html("완료");

                let deleteBtn = $("<button id='commentDelete'>").addClass("btn btn-primary btn-sm").
                css({"display": "none", backgroundColor:"#888",border:"none"}).html("취소");

                modifyItem.on("click", function() {
                    commentContents.attr("contenteditable","true");
                    deleteBtn.css("display", "inline-block");
                    modifyBtn.css("display", "inline-block");
                    modifyItem.css("display", "none");
                    deleteItem.css("display", "none");
                });


                deleteItem.on("click", function() {
                   //삭제 시 발생할 함수
                });

                let reportBox = $("<div>").addClass("reportBox").append(reportButton);


                // 구분선
                let hr = $("<hr>").css({"margin-top": "8px", "margin-bottom": "8px"});

                let reportCol;
                console.log(comment.writer);
                if (loginId == comment.writer) {
                    reportCol = $("<div>").addClass("col-2").append(modifyItem, deleteItem, modifyBtn, deleteBtn);
                } else {
                    reportBox.append(reportMenu);
                    reportCol = $("<div>").addClass("col-2").append(reportBox);
                }

                // 최종 조립
                rowComments.append(profileCol, commentCol, reportCol, hr);

                // DOM에 추가
                $("#comment-box").append(rowComments);
            });
        },
        error: function () {
            alert("댓글 등록 실패");
        }
    });
}
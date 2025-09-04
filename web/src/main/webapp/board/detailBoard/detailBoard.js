// JS 에 CSS 파일 부를 때
let link = document.createElement("link");
link.rel = "stylesheet";
link.href = "/board/detailBoard/detailBoard.css";
document.head.appendChild(link);

$(document).ready(function () {
// 댓글 등록 할 때
    $.ajax({
        url: "/add_view_count.board",
        type: "post",
        data: {id: boardId}
    });

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
                loadComments(boardId, loginId); // 댓글 목록 다시 불러오기
            },
            error: function () {
                alert("댓글 등록 실패");
            }
        });
    });

    $(".post-report-btn").on("click", function() {
        $.ajax({
            url: "/add_report_count.board",
            type: "post",
            data: {id: boardId}
        });
    });

    loadComments(boardId, loginId);
});

// 댓글 수정 기능
function updateComment(id, writer, contents) {
    $.ajax({
        url: "/update_reply.reply",
        type: "post",
        data: {id: id, writer: writer, contents: contents},
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
        data: {id: id, writer: writer},
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
                    .attr({"src":`/downloadImgFile.member?memberId=${comment.writer}`, "onError":"this.onerror=null; this.src='/member/my_page/img/profile.svg';"})
                    .addClass("rounded-circle profile-img");

                let profileCol = $("<div>").addClass("col-2 profile").css({
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "flex-start"
                }).append(profileImg);

                // col-8 댓글 내용
                let commentWriter = $("<div>").addClass("col-12 comment-writer").text(comment.writer);
                let commentContents = $("<span>")
                    .addClass("comment-contents")
                    .text(comment.contents);

                let moreOption = $("<a>")
                    .css({
                        "text-decoration": "none",
                        "color": "var(--sub-btn-color)",
                        "cursor": "pointer",
                        "margin-left": "4px"
                    })
                    .text("...더보기")
                    .on("click", function () {
                        commentContents.toggleClass("expanded");
                        if (commentContents.hasClass("expanded")) {
                            $(this).text(" 접기");
                        } else {
                            $(this).text("...더보기");
                        }
                    });

                // commentContents 뒤에 바로 붙임
                let contentsWrapper = $("<div>")
                    .addClass("col-12 comment-contents-wrapper")
                    .append(commentContents, moreOption);

                setTimeout(() => {
                    if (commentContents[0].scrollHeight <= commentContents[0].clientHeight) {
                        // 내용이 짧으면 ...더보기 숨김
                        moreOption.hide();
                    }
                }, 0);

                let commentRow = $("<div>").addClass("row").append(commentWriter, contentsWrapper);
                let commentCol = $("<div>").addClass("col-7").css({
                    display: "flex",
                    alignItems: "center"
                }).append(commentRow);

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

                let reportItem = $("<a>").addClass("dropdown-item text-danger").text("신고하기").css("cursor", "pointer");

                reportItem.on("click", function() {
                    $.ajax({
                        url: "/add_report_count.reply",
                        type: "post",
                        data: {id: comment.id}
                    });
                });

                let reportMenu = $("<ul>")
                    .addClass("dropdown-menu dropdown-menu-end report-menu")
                    .append($("<li>").append(reportItem));

                let modifyItem = $("<button id='commentUpdate'>").addClass("btn btn-primary btn-sm").css({
                    backgroundColor: "#EC6333",
                    border: "none",
                    marginBottom: "10px"
                }).html("수정");

                let deleteItem = $("<button id='commentDelete'>").addClass("btn btn-primary btn-sm").css({
                    backgroundColor: "#888",
                    border: "none"
                }).html("삭제");

                let modifyBtn = $("<button id='commentUpdate'>").addClass("btn btn-primary btn-sm").css({
                    "display": "none",
                    backgroundColor: "#EC6333",
                    border: "none",
                    marginBottom: "10px"
                }).html("완료");

                let deleteBtn = $("<button id='commentDelete'>").addClass("btn btn-primary btn-sm").css({
                    "display": "none",
                    backgroundColor: "#888",
                    border: "none"
                }).html("취소");

                modifyItem.on("click", function () {
                    commentContents.attr("contenteditable", "true");
                    commentContents.focus();
                    deleteBtn.css("display", "inline-block");
                    modifyBtn.css("display", "inline-block");
                    modifyItem.css("display", "none");
                    deleteItem.css("display", "none");
                });

                modifyBtn.on("click", function () {
                    //삭제 시 발생할 함수
                    $.ajax({
                        url: "/update_reply.reply",
                        type: "post",
                        data: {id: comment.id, writer: comment.writer, contents: commentContents.html()},
                        success: function () {
                            loadComments(boardId, loginId);
                        },
                        error: function () {
                            alert("댓글 수정 실패");
                        }
                    });
                });


                deleteItem.on("click", function () {
                    //삭제 시 발생할 함수
                    $.ajax({
                        url: "/delete_reply.reply",
                        type: "post",
                        data: {id: comment.id, writer: comment.writer},
                        success: function () {
                            loadComments(boardId, loginId);
                        },
                        error: function () {
                            alert("댓글 삭제 실패");
                        }
                    });
                });

                let reportBox = $("<div>").addClass("reportBox").append(reportButton);


                // 구분선
                let hr = $("<hr>").css({"margin-top": "8px", "margin-bottom": "8px"});

                let reportCol;
                let reportColSub;
                console.log(comment.writer);
                if (loginId == comment.writer) {
                    reportCol = $("<div>").addClass("col-auto mt-1 pe-0 ps-0").append(modifyItem, modifyBtn);
                    reportColSub = $("<div>").addClass("col-auto mt-1 pe-0").append(deleteItem, deleteBtn);
                } else {
                    reportBox.append(reportMenu);
                    reportCol = $("<div>").addClass("col-1 d-flex justify-content-end align-items-start").append(reportBox);
                    commentCol.removeClass("col-6");
                    commentCol.addClass("col-9");
                }

                // 최종 조립
                rowComments.append(profileCol, commentCol, reportCol);

                if(reportColSub) {
                    rowComments.append(reportColSub);
                }

                rowComments.append(hr);

                // DOM에 추가
                $("#comment-box").append(rowComments);
            });
        },
        error: function () {
            alert("댓글 등록 실패");
        }
    });
}
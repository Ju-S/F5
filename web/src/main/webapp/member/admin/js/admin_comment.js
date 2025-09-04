const rowsPerPage = 10;
let currentPage = 1;

const tableBody = document.getElementById("table-body");
const pagination = document.getElementById("pagination");

async function fetchReplies(page) {
    try {
        const response = await fetch(`/getReplies.admin?page=${page}`);
        if (!response.ok) throw new Error("서버 응답 오류");

        const data = await response.json();

        renderTable(data.replyList);
        renderPagination(data.totalPage, page);
    } catch (err) {
        console.error("댓글 데이터 불러오기 실패:", err);
        tableBody.innerHTML = `<tr><td colspan="5" class="text-center">불러오는 데 실패했습니다.</td></tr>`;
        pagination.innerHTML = "";
    }
}

function renderTable(replyList) {
    tableBody.innerHTML = "";

    if (!replyList || replyList.length === 0) {
        tableBody.innerHTML = `<tr><td colspan="5" class="text-center">신고된 댓글이 없습니다.</td></tr>`;
        return;
    }

    for (const reply of replyList) {
        const tr = document.createElement("tr");
        tr.innerHTML = `
            <td>${reply.contents}</td>
            <td>${reply.writer}</td>
            <td>${reply.writeDate}</td>
            <td>${reply.reportCount || 1}</td>
            <td>
                <button class="btn btn-sm btn-delete text-white" data-id="${reply.id}">삭제</button>
            </td>
        `;
        tableBody.appendChild(tr);
    }

    attachDeleteHandlers();
}

function renderPagination(totalPage, currentPage) {
    pagination.innerHTML = "";

    for (let i = 1; i <= totalPage; i++) {
        const li = document.createElement("li");
        li.className = `page-item ${i === currentPage ? "active" : ""}`;
        const btn = document.createElement("button");
        btn.className = "page-link";
        btn.textContent = i;

        btn.addEventListener("click", () => {
            fetchReplies(i);
        });

        li.appendChild(btn);
        pagination.appendChild(li);
    }
}

function attachDeleteHandlers() {
    const buttons = document.querySelectorAll(".btn-delete");

    buttons.forEach(btn => {
        btn.onclick = async () => {
            const id = btn.getAttribute("data-id");
            if (!confirm("정말 삭제하시겠습니까?")) return;

            try {
                const response = await fetch(`/deleteReply.admin?id=${id}`, {
                    method: "POST"
                });
                if (!response.ok) throw new Error("삭제 실패");

                alert("삭제 완료");
                fetchReplies(currentPage);
            } catch (err) {
                console.error("삭제 오류:", err);
                alert("삭제 중 오류 발생");
            }
        };
    });
}

// 최초 호출
fetchReplies(currentPage);

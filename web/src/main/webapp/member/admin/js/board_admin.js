const rowsPerPage = 10;
let currentPage = 1;

async function fetchReportedPosts(page) {
    try {
        const res = await fetch(`/getReportedPosts.admin?page=${page}`);
        if (!res.ok) throw new Error("데이터 불러오기 실패");

        const data = await res.json();
        currentPage = page;
        renderTable(data.reportList);
        renderPagination(data.totalPage);
    } catch (err) {
        console.error("에러:", err);
        const tbody = document.getElementById('table-body');
        tbody.innerHTML = `<tr><td colspan="5" class="text-center">불러오는 데 실패했습니다.</td></tr>`;
    }
}

function renderTable(reportList) {
    const tbody = document.getElementById('table-body');
    tbody.innerHTML = '';

    if (!reportList || reportList.length === 0) {
        tbody.innerHTML = `<tr><td colspan="5" class="text-center">신고된 게시글이 없습니다.</td></tr>`;
        return;
    }

    reportList.forEach(report => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td><a href="/viewReportedPost.admin?id=${report.id}" class="text-white text-decoration-none">${report.title}</a></td>
          <td>${report.nickname}</td>
          <td>${report.reportDate}</td>
          <td>${report.reportCount}</td>
          <td><button class="btn btn-sm btn-delete text-white" data-id="${report.id}">삭제</button></td>
        `;
        tbody.appendChild(tr);
    });

    attachDeleteHandlers();
}

function renderPagination(totalPage) {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';

    for (let i = 1; i <= totalPage; i++) {
        const li = document.createElement('li');
        li.className = `page-item ${i === currentPage ? 'active' : ''}`;

        const btn = document.createElement('button');
        btn.className = 'page-link';
        btn.textContent = i;

        btn.addEventListener('click', () => fetchReportedPosts(i));

        li.appendChild(btn);
        pagination.appendChild(li);
    }
}

function attachDeleteHandlers() {
    document.querySelectorAll('.btn-delete').forEach(btn => {
        btn.onclick = async () => {
            const id = btn.getAttribute('data-id');
            if (!confirm('정말 삭제하시겠습니까?')) return;

            try {
                const res = await fetch(`/deletePost.admin?id=${id}`, {
                    method: "POST"
                });
                if (!res.ok) throw new Error("삭제 실패");

                fetchReportedPosts(currentPage);
            } catch (err) {
                console.error("삭제 오류:", err);
                alert("삭제 실패");
            }
        };
    });
}

// 초기 로드
fetchReportedPosts(1);

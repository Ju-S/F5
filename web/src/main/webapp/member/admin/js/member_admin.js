const rowsPerPage = 10;
let currentPage = 1;

function fetchBlackList(page = 1) {
    fetch(`/getBlackList.admin?page=${page}`)
        .then(res => {
            if (!res.ok) throw new Error("데이터 불러오기 실패");
            return res.json();
        })
        .then(data => {
            currentPage = page;
            renderBlackListTable(data.blackList);
            renderPagination(data.totalPage);
        })
        .catch(err => {
            console.error(err);
            const tbody = document.getElementById('table-body');
            tbody.innerHTML = `<tr><td colspan="4" class="text-center">데이터를 불러오는데 실패했습니다.</td></tr>`;
        });
}

function renderBlackListTable(list) {
    const tbody = document.getElementById('table-body');
    tbody.innerHTML = '';

    if (!list || list.length === 0) {
        tbody.innerHTML = `<tr><td colspan="4" class="text-center">블랙리스트가 없습니다.</td></tr>`;
        return;
    }

    list.forEach(item => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
      <td>${item.memberId}</td>
      <td>${new Date(item.startDate).toLocaleString()}</td>
      <td>${new Date(item.endDate).toLocaleString()}</td>
      <td><button class="btn btn-sm btn-danger btn-delete" data-memberid="${item.memberId}">해제</button></td>
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
        btn.addEventListener('click', () => fetchBlackList(i));

        li.appendChild(btn);
        pagination.appendChild(li);
    }
}

function attachDeleteHandlers() {
    document.querySelectorAll('.btn-delete').forEach(btn => {
        btn.onclick = () => {
            const memberId = btn.getAttribute('data-memberid');
            if (confirm(`정말 ${memberId} 블랙리스트를 해제하시겠습니까?`)) {
                fetch(`/deleteBlacklist.admin?memberId=${encodeURIComponent(memberId)}`, {
                    method: 'POST',
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.success) {
                            alert('블랙리스트 해제 완료');
                            fetchBlackList(currentPage);
                        } else {
                            alert('해제 실패했습니다.');
                        }
                    })
                    .catch(() => alert('서버 요청 실패'));
            }
        };
    });
}

// 초기 로드
fetchBlackList();

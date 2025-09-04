const rowsPerPage = 10;
let currentPage = 1;

function fetchReportedPosts(page) {
    fetch(`/getReportedPosts.admin?page=${page}`)
        .then(response => response.json())
        .then(data => {
            currentPage = page;
            renderTable(data.reportList);
            renderPagination(data.totalPage);
        })
        .catch(err => console.error('Error fetching reports:', err));
}

function renderTable(reportList) {
    const tbody = document.getElementById('table-body');
    tbody.innerHTML = '';
    reportList.forEach(report => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
      <td><a href="/post/view?id=${report.id}" class="text-white text-decoration-none">${report.title}</a></td>
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
        btn.onclick = () => {
            if(confirm('정말 삭제하시겠습니까?')) {
                const id = btn.getAttribute('data-id');
                fetch(`/deletePost.admin?id=${id}`)
                    .then(() => fetchReportedPosts(currentPage))
                    .catch(err => alert('삭제 실패'));
            }
        };
    });
}

// 초기 로드
fetchReportedPosts(1);

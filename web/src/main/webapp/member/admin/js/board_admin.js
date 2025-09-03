const reports = [
    { title: '#1번 게임 #', nickname: 'Nickname', date: '2025/08/28', count: 20 },
    { title: '#1번 게임 #', nickname: 'Nickname', date: '2025/08/28', count: 10 },
    { title: '#1번 게임 #', nickname: 'Nickname', date: '2025/08/28', count: 10 },
    { title: '#1번 게임 #', nickname: 'Nickname', date: '2025/08/28', count: 8 },
    { title: '#1번 게임 #', nickname: 'Nickname', date: '2025/08/28', count: 5 },
    { title: '#1번 게임 #', nickname: 'Nickname', date: '2025/08/28', count: 2 },
];

// 게시물 예시
const rowsPerPage = 10;
let currentPage = 1;

function renderTable() {
    const tbody = document.getElementById('table-body');
    tbody.innerHTML = '';
    const start = (currentPage - 1) * rowsPerPage;
    const end = start + rowsPerPage;
    const pageData = reports.slice(start, end);

    for (const report of pageData) {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>${report.title}</td>
          <td>${report.nickname}</td>
          <td>${report.date}</td>
          <td>${report.count}</td>
          <td><button class="btn btn-sm btn-delete text-white">삭제</button></td>
        `;
        tbody.appendChild(tr);
    }
}


function renderPagination() {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';
    const pageCount = Math.ceil(reports.length / rowsPerPage);

    for (let i = 1; i <= pageCount; i++) {
        const li = document.createElement('li');
        li.className = `page-item ${i === currentPage ? 'active' : ''}`;
        const btn = document.createElement('button');
        btn.className = 'page-link';
        btn.textContent = i;

        btn.addEventListener('click', () => {
            currentPage = i;
            renderTable();
            renderPagination();
        });
        li.appendChild(btn);
        pagination.appendChild(li);
    }
}

// 초기 렌더링
renderTable();
renderPagination();
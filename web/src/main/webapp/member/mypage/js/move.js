document.addEventListener('DOMContentLoaded', function () {
    // 마이페이지 수정, 랭킹, 로그아웃 버튼 용
    const buttons = document.querySelectorAll('.menu-button');
    const contents = document.querySelectorAll('.content-box');

    buttons.forEach(button => {
        button.addEventListener('click', () => {
            const target = button.dataset.target;

            buttons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            contents.forEach(content => {
                if (content.dataset.content === target) {
                    content.classList.add('active');
                    content.style.display = 'block';
                } else {
                    content.classList.remove('active');
                    content.style.display = 'none';
                }
            });
        });
    });
});

//아이콘 색상 이미지 변경
const buttons = document.querySelectorAll('.menu-button');

function updateActiveButton(clickedButton) {
    buttons.forEach(btn => {
        const img = btn.querySelector('img');
        const defaultSrc = btn.getAttribute('data-img-default');
        const activeSrc = btn.getAttribute('data-img-active');

        if (btn === clickedButton) {
            btn.classList.add('active');
            if (img && activeSrc) img.src = activeSrc;
        } else {
            btn.classList.remove('active');
            if (img && defaultSrc) img.src = defaultSrc;
        }
    });
}

// 초기에 active 버튼 찾아서 이미지 맞춰주기
document.addEventListener('DOMContentLoaded', () => {
    const initiallyActive = document.querySelector('.menu-button.active');
    if (initiallyActive) {
        updateActiveButton(initiallyActive);
    }
});

// 클릭 시 업데이트
buttons.forEach(button => {
    button.addEventListener('click', () => {
        updateActiveButton(button);
    });
});


//수정, 수정완료, 취소 버튼
document.querySelectorAll('.dropdown-menu a').forEach(item => {
    item.addEventListener('click', function (e) {
        e.preventDefault();
        const selectedYear = this.textContent;
        this.closest('.dropdown').querySelector('button').textContent = selectedYear;
        // 필요시 숨겨진 input 등에 값 넣기 가능
    });
});

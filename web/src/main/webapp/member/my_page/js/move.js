document.addEventListener('DOMContentLoaded', function () {
    // 마이페이지 수정, 랭킹, 로그아웃 버튼 용
    const buttons = document.querySelectorAll('.menu-button');
    const contents = document.querySelectorAll('.content-box');

    buttons.forEach(button => {
        button.addEventListener('click', () => {
            const target = button.dataset.target;

            // 버튼 활성화 상태 및 이미지 변경
            updateActiveButton(button);

            // 콘텐츠 영역 전환
            contents.forEach(content => {
                if (content.dataset.content === target) {
                    content.classList.add('active');
                } else {
                    content.classList.remove('active');
                }
            });
        });
    });

    // 프로필 이미지 업로드 관련
    const imgFileBtn = document.getElementById("imgFileBtn");
    const fileInput = document.getElementById("fileInput");

    if (imgFileBtn && fileInput) {
        imgFileBtn.addEventListener("click", () => fileInput.click());

        fileInput.addEventListener("change", () => {
            const file = fileInput.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = (e) => {
                const previewImg = document.querySelector("#profileUploadForm img");
                if (previewImg) {
                    previewImg.src = e.target.result;
                }
            };
            reader.readAsDataURL(file);

            const formData = new FormData();
            formData.append("file", file);

            fetch("/uploadImgFile.member", {
                method: "POST",
                body: formData
            }).then(res => {
                if (res.ok) {
                    console.log("업로드 성공");
                } else {
                    alert("업로드 실패");
                }
            }).catch(err => {
                console.error(err);
                alert("에러 발생");
            });
        });
    }

    // 수정 버튼 클릭 시
    document.querySelector("#edit .button-primary").addEventListener("click", function () {
        document.querySelectorAll("#name, #nickname, #email").forEach(el => el.removeAttribute("readonly"));
        document.querySelector("#birthYear").disabled = false;
        document.querySelectorAll('input[name="sex"]').forEach(el => el.disabled = false);

        document.getElementById("edit").style.display = "none";
        document.getElementById("edit_check").style.display = "flex";
    });

    // 수정 완료 버튼 클릭 시
    document.querySelector("#edit_check .button-primary").addEventListener("click", function () {
        document.getElementById("profileForm").submit();
    });

    // 취소 버튼 클릭 시
    document.querySelector("#edit_check .button-secondary").addEventListener("click", function () {
        location.reload();
    });
});

// 아이콘 이미지 변경 함수
function updateActiveButton(clickedButton) {
    const buttons = document.querySelectorAll('.menu-button');

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

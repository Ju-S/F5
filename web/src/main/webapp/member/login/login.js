//로그인 실패시
const urlParams = new URLSearchParams(window.location.search);
const msg = urlParams.get("msg");
if (msg === "loginfail") {
    alert("로그인에 실패했습니다. 아이디 / 비밀번호를 다시 확인해 주세요");
}


//수정중
//아이디 중복검사
let dupliIdCheck = false;
//닉네임 중복검사
let dupliNicknameCheck = false;
//이메일 인증되었는지 확인
let dupliEmailCheck =false;
// 연도 체크 값 저장
let selectedYear = null; // 선택된 연도를 저장할 변수
// 성별 체크 값 저장 (value값 male, female)
let selectedGender = null;
// input 입력후 중복검사 완료 된것 객체로 저장
let checkedList ={
    id : null,
    nickname :null,
    email:null
}





let code = "";  /*인증번호 저장할 곳*/
$('#emailBtn').click(function() {
    let email = $('#email').val();
    console.log('완성된 이메일 : ' + email);
    let checkInput = $('#emailCode');

    $.ajax({
        type: 'GET',
        url: '/mailCheck.member',
        data: { email: email },           // ★ 파라미터는 data로 보내는 게 안전
        success: function (res) {
            try { res = typeof res === 'string' ? JSON.parse(res) : res; } catch (e) {}
            if (res && res.ok) {
                checkInput
                    .prop('disabled', false)
                    .val('')
                    .removeClass('input-error')
                    .focus();
                $('#emailCodeBtn').prop('disabled', false).removeClass('disabled');
                alert('인증번호가 전송되었습니다.');
            } else {
                alert('이메일 전송 실패. 잠시 후 다시 시도해주세요.');
            }
        }
    });
});


// 이메일을 인풋에 무언가를 쓸 때
$(document).on('input', '#email', function () {
    dupliEmailCheck = false;
    checkedList.email = null;

    //이메일 코드
    $('#emailCode')
        .val('')
        .prop('readonly', false)
        .prop('disabled', true)
        .removeClass('input-error');

    console.log("이메일인풋 침"+"중복이메일체크불리언"+dupliEmailCheck+"이메일"+ checkedList.email);
 /*   $('#emailCodeBtn')
        .prop('disabled', true)
        .removeClass('disabled');*/
/*    $('#emailBtn').prop('disabled', false).removeClass('disabled');*/
});


// ★ 인증 코드 확인 버튼 클릭
$('#emailCodeBtn').on('click', function () {
    const emailVal = $('#email').val().trim();      // 이메일은 email 입력칸에서
    const codeVal  = $('#emailCode').val().trim();  // 코드는 emailCode 입력칸에서

    if (!emailVal) { alert('이메일을 먼저 입력하세요.'); $('#email').focus(); return; }
    if ($('#emailCode').prop('disabled')) { alert('이메일 인증을 먼저 요청하세요.'); return; }
    if (codeVal.length !== 6) { $('#emailCode').addClass('input-error'); alert('6자리 코드를 입력하세요.'); return; }

    // 클릭 중복 방지
    const $btn = $(this);
    $btn.prop('disabled', true);

    $.ajax({
        type: 'POST',
        url: '/verifyEmailCode.member',
        data: { email: emailVal, code: codeVal },
        dataType: 'json'
    }).done(function (res) {
        try { res = (typeof res === 'string') ? JSON.parse(res) : res; } catch(e) {}
        const ok = (res && (res.ok === true)) || res === true || res === "true";

        // ✅ emailCode 전용 모달 사용
        const modalEl = document.getElementById('emailCodeModal');
        const modal   = new bootstrap.Modal(modalEl);
        const $bodyP  = $('#emailCodeModal .modal-body p');
        const $footer = $('#emailCodeModal .modal-footer');

        if (ok) { // 이메일 인증 완료
            let str = "이메일이 인증되었습니다";
            $bodyP.html(str);

            $('#emailCode').removeClass('input-error');

            let $btn3 = $("<button>").attr({
                "type": "button",
                "class": "btn btn-primary modalBtn",
                "data-bs-dismiss": "modal",
                "id": "btn3"
            }).html("인증완료")
                .on("click",function(){
                    dupliEmailCheck = true;
                    checkedList.email = emailVal;
                    $('#emailCode').prop('readonly', true);
                    $('#emailCodeBtn').prop('disabled', true).addClass("disabled");
                    console.log("이메일 인증완료버튼 침"+"중복이메일체크불리언"+dupliEmailCheck+"이메일"+ checkedList.email);
                });

            $footer.html("").append($btn3);


        } else { // 이메일 인증 실패
            let str = "이메일이 인증되지 않았습니다";
            $bodyP.html(str);

            $('#emailCode').addClass('input-error');

            let $btn1 = $("<button>").attr({
                "type": "button",
                "class": "btn btn-secondary",
                "data-bs-dismiss": "modal",
                "id": "btn1"
            }).html("인증실패")
                .on("click", function(){
                    dupliEmailCheck = false;
                    console.log("이메일인증 실패 버튼 침"+"중복이메일체크불리언"+dupliEmailCheck+"이메일"+ checkedList.email);

                });

            $footer.html("").append($btn1);
        }
        modal.show(); // Ajax 완료 후 모달 띄우기


    }).fail(function () {
        dupliEmailCheck = false;
        $('#emailCode').addClass('input-error');
        alert('서버 통신 중 오류가 발생했습니다. 이메일 인증을 다시 시도해주세요.');
    }).always(function () {
        $btn.prop('disabled', false);
    });
});




// 아이디 중복 확인 버튼
$(document).ready(function () {
    dupliCheck("#idBtn", "/dupliIdCheck.member"); /*아이디 중복 버튼 눌리면*/
    dupliCheck("#nicknameBtn", "/dupliNicknameCheck.member"); /*닉네임 중복버튼 누르면*/
    //To-DO : 여기다가 이메일 체크 함수도 바인딩해놓기
})

//중복 버튼에 관하여 함수 만들기
function dupliCheck(button, url) {
    /*어떤 버튼 눌렸을때*/
    $(button).on("click", function () {
        let $target = $(this).parent().children().first(); //input의 val
        let target = $target.attr('id');// input의 아이디를 스트링으로 가져옴(id 또는 nickname)


        let isOk = applyRegex(target, rules, {strict: true}); // ★ dirty: 중복검사 전에 엄격 검증
        if (!isOk) {
            alert(rules["#" + target].msg);
            $target.focus();
            return;  // ★ 여기서 종료: 모달/서버호출 안 함
        }


        $.ajax({
            url: url,
            type: "post",
            dataType: "text",
            data: { [target]: ($target.val() || "").trim() }


        }).done(function (response) {
            response = String(response || "").trim().toLowerCase();
            console.log("response["+response+"]");

            //모달 인스턴스 생성
            const modalId = target + "Modal";
            const $modal  = $("#" + modalId);
            const modal   = new bootstrap.Modal($modal[0]);
            const $bodyP  = $modal.find(".modal-body p");
            const $footer = $modal.find(".modal-footer");



            //중복된 아이디일경우
            if (response === "true") {
                $bodyP.html("사용 불가한 " + target + " 입니다");
                const $btn1 = $("<button>", { type:"button", class:"btn btn-secondary", "data-bs-dismiss":"modal", id:"btn1" })
                    .text("닫기")
                    .on("click", function () {
                        if (target === "id") { dupliIdCheck = false; $("#id").val("").focus(); }
                        else { dupliNicknameCheck = false; $("#nickname").val("").focus(); }
                    });
                $footer.empty().append($btn1); //푸터에 버튼 1 추가


                //중복되지 않은 아이디일경우
            } else if (response === "false") {
                $bodyP.html("사용 가능한 " + target + " 입니다");
                const $btn2 = $("<button>", { type:"button", class:"btn btn-secondary", "data-bs-dismiss":"modal", id:"btn2" })
                    .text("취소")
                    .on("click", function () {
                        if (target === "id") { dupliIdCheck = false; $("#id").val("").focus(); }
                        else { dupliNicknameCheck = false; $("#nickname").val("").focus(); }
                    });

                const $btn3 = $("<button>", { type:"button", class:"btn btn-primary modalBtn", "data-bs-dismiss":"modal", id:"btn3" })
                    .text("사용하기")
                    .on("click", function () {
                        if (target === "id") { dupliIdCheck = true; checkedList.id = $("#id").val(); }
                        else { dupliNicknameCheck = true; checkedList.nickname = $("#nickname").val(); }
                        setTimeout(() => { target === "id" ? $("#nickname").focus() : $("#pw").focus(); }, 0);
                    });
                $footer.empty().append($btn2, $btn3); //푸터에 버튼 2,3 추가


            } else {
                $bodyP.text("예상치 못한 응답: " + response);
                $footer.empty();
            }

            modal.show();
        });
    })
}

// 정규식 규칙 & 메시지
const rules = {
    "#id": {
        regex: /^[A-Za-z0-9]{4,16}$/,
        msg: "아이디는 4~16자이며, 영어 대소문자와 숫자만 가능합니다."
    },
    "#nickname": {
        regex: /^[가-힣a-zA-Z0-9]{1,12}$/,
        msg: "닉네임은 1~12자이며, 한글/영문/숫자만 가능합니다."
    },
    "#pw": {
        regex: /^(?=.*\d)(?=.*[!@#$%^&*()\-_=+{}[\]\\:;"'<>,.?])[0-9a-zA-Z`~!@#$%^&*()\-_=+{}[\]\\:;"'<>,.?]{4,12}$/,
        msg: "비밀번호는 4~12자이며, 숫자와 특수문자를 각각 하나 이상 포함해야 합니다."
    },
    "#pwCheck": {
        // pwCheck는 pw 동일성으로 별도 처리
        msg: "동일한 비밀번호가 아닙니다."
    },
    "#name": {
        regex: /^[가-힣]{2,5}$/,
        msg: "이름은 2~5자리 한글만 입력 가능합니다."
    },
    "#email": {
        regex: /^[^@]+@[a-zA-Z0-9.-]+\.(com|co\.kr)$/,
        msg: "올바른 형식의 이메일이 아닙니다."
    }
};


// 인풋결과 regex와 다르면 error 보더 띄우는 함수
function setErrorBorder($target, ok) {
    $target.toggleClass("input-error", !ok);
}


// 현재 input 쓰여진 결과 검사해주는 함수
function applyRegex(target, rules, opts = {}) { // ★ dirty: 엄격검증 옵션 추가
    let $target = $("#" + target);
    const strict = !!opts.strict;            // ★

    // ★ dirty: 라이브 검증에서 빈 값은 보더 제거하고 통과로 취급
    if (!strict && $target.val().trim() === "") {
        $target.removeClass("input-error");
        return true;
    }

    if (target === "pwCheck") {
        let ok = $target.val().length > 0 && $target.val() === $("#pw").val().trim();
        setErrorBorder($target, ok);
        return ok;
    }


    const rule = rules["#" + target];
    if (!rule || !rule.regex) return true; //regex 없는경우는 true 리턴


    const ok = rule.regex.test($target.val().trim()); // ★ dirty: trim 후 검사
    setErrorBorder($target, ok);// 스타일 바꾸고
    return ok;
}


// document에서 일어나는 모든 인풋에 잇는 input blur 대하여 바인딩하기
$(document).on("input blur", "input", function (e) {
    const id = $(this).attr("id"); // 현재 입력된 input의 id로 선택자 만들기
    if (!id) return;

    // ★ dirty: input 시에는 dirty 표시
    if (e.type === "input") {
        $(this).data("dirty", true);
    }

    // ★ dirty: blur 시, 입력한 적 없거나 값이 비어있으면 보더 제거 후 검증 스킵
    if (e.type === "blur") {
        const val = $(this).val().trim();
        if (!$(this).data("dirty") || val === "") {
            $(this).removeClass("input-error");
            if (id === "pw") {
                $("#pwCheck").removeClass("input-error");
            }
            return;
        }
    }

    applyRegex(id, rules);

    if (id === "pw") applyRegex("pwCheck", rules);

    if (id === "id") {
        dupliIdCheck = ($(this).val().trim() === checkedList.id);
    }
    if (id === "nickname") {
        dupliNicknameCheck = ($(this).val().trim() === checkedList.nickname);
    }


});


//닫기 누르면 뒤로가기
$("#delBtn").on("click", function () {
    location.href = "/index.jsp";
})
//연도 드롭다운 내용 채우기 + 클릭하면 selectedYear에 저장
let $ul = $("#yearMenu");
let currentYear = new Date().getFullYear(); // 현재 년도 가져오기
for (let i = currentYear; i >= 1900; i--) {
    let $li = $("<li>");
    let $a = $("<a>").addClass("dropdown-item").attr("href", "#").text(i);

    // 클릭 이벤트 추가
    $a.on("click", function (e) {
        selectedYear = $(this).text(); // 선택된 연도 저장
        console.log(selectedYear);
        $("#targetYear").val(selectedYear);
        e.preventDefault(); // 링크 이동 방지
        $("#dropdownMenuButton2").text($(this).text()); // 버튼 텍스트 변경
    });
    $li.append($a);
    $ul.append($li);
}


// 성별 체크 값 selectedGender에 넣어놓기
$("input[name='sex']").on("change", function () {
    selectedGender = $(this).val();
})



//제출버튼 눌렀을 때
$("form").on("submit", function () {
    let fields = ["#id", "#nickname", "#pw", "#pwCheck", "#name", "#email"];

    // 1. 비어있는 칸 있으면 채우라고 alert 띄우기
    let emptyInput = fields.find(target => $(target).val().trim() === ""); //비어져 잇는 선택자 가져오고, 아니면 undefinded
    if (emptyInput || selectedYear === null || selectedGender === null) {
        alert("모든 입력 완료후 회원가입이 가능합니다");// 안채워진 칸 있으면 먼저 채우라고 alert
        if (emptyInput) $(emptyInput).focus();
        else if (selectedYear === null) $("#dropdownMenuButton2").focus();
        else if (selectedGender === null) $("input[name='sex']").first().focus();
        return false;
    }


    // 2.regex 검사는 document의 input blur에 바인딩 되어있으나, 수정하지 않고 submit하면 다시 알리고 return하기
    if ($(fields[0]).hasClass("input-error")) {
        alert(rules["#id"].msg);
        return false;
    } else if ($(fields[1]).hasClass("input-error")) {
        alert(rules["#nickname"].msg);
        return false;
    } else if ($(fields[2]).hasClass("input-error")) {
        alert(rules["#pw"].msg);
        return false;
    } else if ($(fields[3]).hasClass("input-error")) {
        alert(rules["#pwCheck"].msg);
        return false;
    } else if ($(fields[4]).hasClass("input-error")) {
        alert(rules["#name"].msg);
        return false;
    } else if ($(fields[5]).hasClass("input-error")) {
        alert(rules["#email"].msg);
        return false;
    }


    //3. 인증 안했으면 인증하라고 alert
    if (dupliIdCheck === false) {
        alert("아이디 중복체크를 진행해주세요");
        $("#idBtn").focus();
        return false;
    }
    if (dupliNicknameCheck === false) {
        alert("닉네임 중복체크를 진행해주세요");
        $("#nicknameBtn").focus();
        return false;
    }
    if (dupliEmailCheck === false) {
        alert("이메일 인증을 진행해주세요");
        $("#emailBtn").focus();
        return false;
    }



})

//취소 버튼 누르면
$("#delBtn").on("click", async function(){
    try {
        await fetch("/cancelFindPw.member", { method: "POST" }); //세션에 저장 한 키 지우기
    } catch(e) {
    } finally {
        window.location.href = "/index.jsp";
    }
});


// 공통: 에러 보더 토글 함수 : 인자값 true: 에러보더 x , false:에러보더 o
function setErrorBorder($el, ok) {
    $el.toggleClass("input-error", !ok);
}

// 1) 이메일 버튼: 존재 확인 → 입력 잠금 → 메일 발송
$("#emailBtn").on("click", function () {
    const idVal = $("#id").val();
    const emailVal = $("#email").val();


    $.ajax({
        url: "/isIdEmailExist.member", //존재한는 아이디, 이메일인지 확인
        type: "post",
        dataType: "text",
        data: { email: emailVal.trim(), id: idVal.trim() }
    }).done(function (response) {
        if (response === "false") {
            alert("이메일 전송 실패. 아이디와 이메일을 다시 확인해 주세요.");
            return;
        }

        // 입력 잠금 & 코드 입력 활성화
        $("#emailCode").prop("disabled", false).val("").removeClass("input-error").focus();
        $("#emailCodeBtn").prop("disabled", false).removeClass("disabled");
        $("#id, #email, #emailBtn").prop("disabled", true).addClass("disabled");

        // hidden에 email 저장(혹시 모를 변경 대비)
        $("#emailHidden").val(emailVal.trim());

        // 실제 메일 발송
        $.ajax({
            type: "GET",
            url: "/mailCheck.member",  //인증 이메일 보내기
            data: { email: emailVal.trim() }
        }).done(function (res) {
            try { res = (typeof res === "string") ? JSON.parse(res) : res; } catch (e) {}
            if (res && res.ok) alert("인증번호가 전송되었습니다.");
            else alert("이메일 전송 실패. 잠시 후 다시 시도해주세요.");
        });
    });
});


// 2) 인증코드 받기전에 hidden 값 세팅(버튼 클릭/Enter 모두 커버)
$('form[action="/IdEmailCode.member"]').on("submit", function () {
    $("#code").val($("#emailCode").val().trim());
    $("#emailHidden").val($("#email").val().trim()); // 이메일 히든에 이메일 저장
    $('#idHidden').val($('#id').val().trim());   // 아이디 히든에 아이디 저장
});


// regex
const rules = {
    "#pw": {
        regex: /^(?=.*\d)(?=.*[!@#$%^&*()\-_=+{}[\]\\:;"'<>,.?])[0-9a-zA-Z`~!@#$%^&*()\-_=+{}[\]\\:;"'<>,.?]{4,12}$/,
        msg: "비밀번호는 4~12자이며, 숫자와 특수문자를 각각 하나 이상 포함해야 합니다."
    },
    "#pwCheck": {
        msg: "동일한 비밀번호가 아닙니다."
    }
};

//검증 함수
function applyRegex(targetId, rules, opts = {}) {
    const $target = $("#" + targetId);
    const val = $target.val().trim();

    /*// 공백이면 에러 처리
    if (val === "") {
        setErrorBorder($target, false);
        return false;
    }*/

    if (targetId === "pwCheck") {
        const pwValue = $("#pw").val().trim();
        const ok = val === pwValue; // pw와 pwCheck이 같으면 true저장 다르면 false 저장
        setErrorBorder($target, ok);
        return ok;
    }

    const rule = rules["#" + targetId];
    if (!rule || !rule.regex) return true;

    const ok = rule.regex.test(val);
    setErrorBorder($target, ok);
    return ok;
}

// 비번 재설정할때
$(document).on("input blur", "#pw, #pwCheck", function (e) {
    const id = $(this).attr("id");
    if (!id) return;

    if (e.type === "input") $(this).data("dirty", true);

    if (e.type === "blur") {
        const val = $(this).val().trim();
        if (!$(this).data("dirty") || val === "") {
            $(this).removeClass("input-error");
            if (id === "pw") $("#pwCheck").removeClass("input-error");
            return;
        }
    }
    applyRegex(id, rules);
    if (id === "pw") applyRegex("pwCheck", rules);
});

// 비밀번호 변경 폼 제출 전에 확인
$("#change").on("submit", function (e) {
    // 공란 체크 (기존 오타 .val("") 수정!)
    if ($("#pw").val().trim() === "" || $("#pwCheck").val().trim() === "") {
        alert("변경할 비밀번호를 먼저 입력해주세요.");
        e.preventDefault();
        return;
    }

    // 엄격 검증
    const ok1 = applyRegex("pw", rules, { strict: true });
    const ok2 = applyRegex("pwCheck", rules, { strict: true });

    if (!ok1 || !ok2) {
        e.preventDefault();
        alert(!ok1 ? rules["#pw"].msg : rules["#pwCheck"].msg);
        return;
    }
});
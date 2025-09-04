// 1) 이메일 버튼: 존재 확인 → 입력 잠금 → 메일 발송
$("#emailBtn").on("click", function () {
    const nameVal = $("#name").val();
    const emailVal = $("#email").val();

    $.ajax({
        url: "/isNameEmailExist.member",
        type: "post",
        dataType: "text",
        data: {email: emailVal.trim(), name: nameVal.trim()}
    }).done(function (response) {
        if (response === "false") {
            alert("이메일 전송 실패. 이름과 이메일을 다시 확인해 주세요.");
            return;
        }

        // 이메일 입력 잠금 & 코드 입력 활성화
        $("#hiddenEmail").val($("#email").val());// 히든에 옮겨 담아놓기
        $("#hiddenName").val($("#name").val());

        $("#code").prop("disabled", false).val("").removeClass("input-error").focus();
        $("#codeBtn").prop("disabled", false).removeClass("disabled");
        $("#name, #email, #emailBtn").prop("disabled", true).addClass("disabled");


        // 실제 메일 발송
        $.ajax({
            type: "GET",
            url: "/mailCheck.member",
            data: {email: emailVal.trim()}
        }).done(function (res) {
            try {
                res = (typeof res === "string") ? JSON.parse(res) : res;
            } catch (e) {
            }
            if (res && res.ok) alert("인증번호가 전송되었습니다.");
            else alert("이메일 전송 실패. 잠시 후 다시 시도해주세요.");
        });
    });
});


// 2) 코드 맞는지 확인 → 아이디 조회
$("#codeBtn").on("click", function (e) {
    e.preventDefault();

    let emailVal = $("#hiddenEmail").val();
    let nameVal  = $("#hiddenName").val();
    let codeVal  = $("#code").val();

    // 코드 비었으면 alert
    if (!codeVal || !codeVal.trim()) {
        alert("인증 코드를 입력해 주세요.");
        return;
    }

    $.ajax({
        type: "POST",
        url: "/verifyEmailCode.member",
        data: { email: emailVal, code: codeVal },
        dataType: "json"
    })
        .done(function (res) {
            try { res = (typeof res === "string") ? JSON.parse(res) : res; } catch (e) {}
            const ok = (res && (res.ok === true)) || res === true || res === "true";

            if (!ok) {//인증코드 이상할시
                alert("인증 코드가 올바르지 않습니다.");
                return;
            }

            // 이메일 인증 완료 → 아이디 조회
            $.ajax({
                type: "POST",
                url: "/findIdByNameEmail.member",
                data: { email: emailVal, name: nameVal },
                dataType: "json"
            })
                .done(function (res2) {
                    try { res2 = (typeof res2 === "string") ? JSON.parse(res2) : res2; } catch (e) {}


                    if ((res2 && (res2.ok === true) && res2.id ) || (res2 && res2.id)) {
                        $("#yourId").append("아이디는 " + res2.id + " 입니다");

                    } else {
                        $("#yourId").append("아이디를 찾을 수 없습니다. 다시 인증을 진행해주세요");
                    }
                })
                .fail(function (xhr, status, err) {
                    console.error("[findIdByNameEmail] fail:", status, err);
                    alert("아이디 조회 중 오류가 발생했습니다.");
                });
        })
        .fail(function (xhr, status, err) {
            console.error("[verifyEmailCode] fail:", status, err);
            alert("코드 검증 중 오류가 발생했습니다.");
        });
});


//3) 로그인 페이지로 돌아가기 버튼
$("#backToLogin").on("click", function(){
    window.location.href = "/toLoginPage.member";
})


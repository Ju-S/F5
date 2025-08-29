

//중복검사 되었는지 아닌지 확인
let dupliIdCheck = false;
let dupliNicknameCheck = false;
//이메일 인증되었는지 확인
//true / false로 받으면 될듯



//중복 버튼에 관하여 함수 만들기
function dupliCheck(button, url){
    /*어떤 버튼 눌렸을때*/
    $(button).on("click", function () {
        let $target =$(this).parent().children().first(); //input의 val
        let target =$target.attr('id');// input의 아이디를 스트링으로 가져옴(id 또는 nickname)


        $.ajax({ //ajax로 id보냄
            url: url,
            type: "post",
            data: { [target]: $target.val() }

        }).done(function (response) { //response true(중복) /false(사용가능) string값으로 받음
            let modalId = target + "Modal";
            let modal = new bootstrap.Modal(document.getElementById(modalId));//인스턴스생성


            //결과가 중복되었다면
            if (response === "true") {
                let str = "사용 불가한 "+target+" 입니다";
                $(".modal-body p").html(str); //모달바디 안에 스트링 넣고


                let $btn1 = $("<button>").attr({
                    "type": "button",
                    "class": "btn btn-secondary",
                    "data-bs-dismiss": "modal",
                    "id": "btn1"
                }).html("닫기"); //닫기 버튼 만들고

                //닫기 버튼 눌렀을 때, 포커스 주기
                $btn1.on("click", function () {

                    if(target==="id"){ //아이디중복 버튼 눌렀으면
                        dupliIdCheck = false;
                        $("#id").val("").focus();
                        console.log(dupliIdCheck);

                    }else if(target==="nickname"){//닉네임중복 버튼 눌렀으면
                        dupliNicknameCheck = false;
                        $("#nickname").val("").focus();
                        console.log(dupliNicknameCheck);
                    }
                });

                $(".modal-footer").html("").append($btn1);//모달 푸터에 닫기 버튼 넣기


                //결과가 중복 안되었다면
            } else if (response === "false") {
                let str = "사용 가능한"+target+" 입니다";

                $(".modal-body p").html(str); //모달바디 안에 스트링 넣고

                let $btn2 = $("<button>").attr({
                    "type": "button",
                    "class": "btn btn-secondary",
                    "data-bs-dismiss": "modal",
                    "id": "btn2"
                }).html("취소"); //취소버튼

                let $btn3 = $("<button>").attr({
                    "type": "button",
                    "class": "btn btn-primary",
                    "data-bs-dismiss": "modal",
                    "id": "btn3"
                }).html("사용하기"); //사용하기 버튼


                //취소 버튼 눌렀을 때 값 지우고, 포커스 주기
                $btn2.on("click", function () {

                    if(target==="id"){ //아이디중복 버튼 눌렀으면
                        dupliIdCheck = false;
                        $("#id").val("").focus();
                        console.log(dupliIdCheck);
                    } else if(target==="nickname"){//닉네임 중복 버튼 눌렀으면
                        dupliNicknameCheck = false;
                        $("#nickname").val("").focus();
                        console.log(dupliNicknameCheck);
                    }
                });

                //사용하기 버튼 눌렀을 때 검사 값 true로 바꾸기
                $btn3.on("click", function () {
                    if(target==="id"){//아이디중복 버튼 눌렀으면
                        dupliIdCheck = true;
                        console.log(dupliIdCheck);//true뜸
                    }else if(target==="nickname"){
                        dupliNicknameCheck = true;
                        console.log(dupliNicknameCheck);//true뜸
                    }

                    setTimeout(() => {
                        if (target === "id") {
                            $("#nickname").focus();
                        } else if (target === "nickname") {
                            $("#name").focus(); // 예시
                        }

                    }, 0);

                });

                $(".modal-footer").html("").append($btn2).append($btn3);//모달 푸터에 닫기 버튼 넣기
            }
            modal.show(); // Ajax 완료 후 모달 띄우기
        });
    })

// 아이디 중복 확인 버튼 눌렀을때
$(document).ready(function () {


    dupliCheck("#idBtn", "/dupliIdCheck.member"); /*아이디 중복 버튼 눌리면*/
    dupliCheck("#nicknameBtn", "/dupliNicknameCheck.member"); /*닉네임 중복버튼 누르면*/


})




// 연도 체크 값 저장
let selectedYear = null; // 선택된 연도를 저장할 변수
//드롭다운 내용 채우기
let $ul = $(".dropdown-menu");
let currentYear = new Date().getFullYear(); // 현재 년도 가져오기
for (let i = currentYear; i >= 1900; i--) {
    let $li = $("<li>");
    let $a = $("<a>").addClass("dropdown-item").attr("href", "#").text(i);

    // 클릭 이벤트 추가
    $a.on("click", function (e) {
        selectedYear = $(this).text(); // 선택된 연도 저장
        e.preventDefault(); // 링크 이동 방지
        $("#dropdownMenuButton2").text($(this).text()); // 버튼 텍스트 변경
    });
    $li.append($a);
    $ul.append($li);
}


//닫기 누르면 뒤로가기
$("#delBtn").on("click",function(){
    location.href = "/index.jsp";
})


// 성별 체크 값 저장 (value값 male, female)
let selectedGender = null;
$("input[name='sex']").on("change", function () {
    selectedGender = $(this).val();
})

//비어있는 칸 있으면 채우라고 alert 띄우기


$(document).ready(function() {
    $('#summernote').summernote({
        width: 800,
        height: 200,
        lang: 'ko-KR',
        placeholder: '최대 2048자까지 입력 가능합니다',
        callbacks: {
            onImageUpload: function(files) {
                uploadImage(files[0]);
            }
        }

    });
});

function uploadImage(file) {
    var formData = new FormData();
    formData.append("file", file);

    $.ajax({
        url: '/upload_image.board',   // 이미지 업로드 처리할 컨트롤러
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        type: 'POST',
        success: function(url) {
            // 업로드 성공하면 URL을 이미지로 삽입
            $('#summernote').summernote('insertImage', url);
        }
    });
}
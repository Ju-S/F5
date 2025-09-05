<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/common/common.css">
    <link rel="stylesheet" href="/member/admin/css/view_post.css">
</head>
<body>

<!-- Header -->
<jsp:include page="/common/header/Header.jsp"/>

<div class="container">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-1">
            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
        </div>

        <!-- main 내용 -->
        <div class="col-11 main-content">
            <div class="card p-4 bg-dark text-white">
                <div class="mb-3">
                    <label class="form-label">제목</label>
                    <p class="form-control-plaintext text-white">${post.title}</p>
                </div>
                <div class="mb-3">
                    <label class="form-label">작성자</label>
                    <p class="form-control-plaintext text-white">${post.nickname}</p>
                </div>
                <div class="mb-3">
                    <label class="form-label">작성일</label>
                    <p class="form-control-plaintext text-white">${post.reportDate}</p>
                </div>
                <div class="mb-3">
                    <label class="form-label">신고 횟수</label>
                    <p class="form-control-plaintext text-danger fw-bold">${post.reportCount}</p>
                </div>
                <div class="mb-3">
                    <label class="form-label">내용</label>
                    <p class="form-control-plaintext text-white" style="white-space: pre-line;">${post.contents}</p>
                </div>
            </div>

            <!-- 관리자 조치 버튼 -->
            <div class="mt-4 d-flex gap-2">
                <form action="/deletePost.admin" method="get" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                    <input type="hidden" name="id" value="${post.id}"/>
                    <button type="submit" class="btn btn-danger">게시글 삭제</button>
                </form>
                <a href="/reportedPosts.admin?page=1" class="btn btn-secondary">목록으로</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>

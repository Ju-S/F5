# F5Web 프로젝트

## 프로젝트 자료

- **[0. 프로젝트 Google Drive](https://drive.google.com/drive/folders/1eTx9sml-5wobjM1_xlHuNHPITeIqizmw)**
- **[1. 요구사항 정의서](https://docs.google.com/spreadsheets/d/1ahWepoCayDJ5XrUp2FLt1lsOSSY-aj6o4qnHbF8Rusc)**
- **[2. 요구사항 명세서](https://docs.google.com/spreadsheets/d/1efOPRSfEhhDyHO4KDAJj_WZoIR8ASWskb0GQBm5FC08)**
- **[3. ERD](https://www.erdcloud.com/d/frfp7FXRHMmLrErGH)**
- **[4. 회의록](https://www.notion.so/24e7ad5c63f7807ebd19f3e58502fdf1?v=24e7ad5c63f781d9ac91000c0023811c)**

---
** 수정할 사항 **
** 회원 가입
비밀번호안에 패스워드 글씨 잘려서 나옴
비밀번호 암호화가 안돼어져 있음


로그인
로그인 화면 뒤로가기 버튼 + 로그인 밑에 홈페이지->로그 아웃 index.jsp 만들어달라는 요청도 있음

홈페이지
</div> </input> 쓰면 웹 사이트 터짐


게임
게임페이지 이동시 위에 사이트 이름이 게임 네임이 아닌 game2 등으로 나옴
댓글 수정이 작동이 안됨
댓글 수정하고 취소누르면 작동안됌
게임 이동시 게임 플레이 화면만 나오고 무슨 게임인지를 모름 이미지 넣는게 좋을거 같음
</div> </input> 쓰면 웹 사이트 터짐


게임 조작 설명이 나와줬으면 좋겠음

게시물 목록
게시글 작성한거 태그로 어디에 썻는지 볼 수 있으면 좋겠음


게시물 & 댓글
게시글 들어가면 뒤로가기 가는 기능이 없음
게시글 내용 없어도 등록이 가능함
글작성 취소버튼이 작동하지 않음



마이페이지
수정에서 수정은 안되는 부분은 클릭이 안나오게 수정해야 함
정규식 넣기, 인증확인 기능 넣어야함
인증확인 기능 넣어야 함(그리고 클릭하면 리로딩 되는듯-> 출생년도+성별 초기화됨)+ 중복확인(리로딩 되는듯-> 출생년도+성별 초기화됨)
게임 랭킹 이미지가 안나옴
로그아웃 클릭시 로그아웃하시겠습니까? 문구 나왔으면 좋겠음.
**

## **규칙**
- **이름**
  - Controller의 cmd는 `행위_자원.도메인`으로 작성한다. ex)`get_memberlist.member`
  - session에 저장될 member의 id는 `loginId`키값을 통해 저장. ex)`request.getSession().setAttribute("loginId", "ID")`

## **공통CSS사용법**

- **📁 구조**

```css
  /* /common/common.css */
:root {
    /* 색상 변수 */
    --primary-color: #101012; /* 검정 바탕색 */
    --primary-subcolor: #2a2a2a; /* 회색 바탕 서브색 */
    --secondary-color: #3E459D; /* 청보라 컬러 */
    --danger-color: #EC6333; /* 주황색 포인트 컬러 */
    --sub-btn-color: #888; /* 서브 버튼 컬러(회색) */

    /* 폰트 변수 */
    --title-font: 'Taenada', sans-serif;
    --sub-font: 'Pretendard', sans-serif;
}

html,
body {
    margin: 0;
    padding: 0;
    height: 100%;
    overflow: hidden;
    /* 스크롤 차단 */
    background-color: var(--primary-color); /* 이런 식으로 사용 */
    color: #fff;
}
```

- **📄 적용 예시 (다른 CSS 파일에서)**

```css
/* example/example.css */
body {
    font-family: var(--main-font);
    background-color: var(--primary-color);
    color: white;
}

button {
    background-color: var(--secondary-color);
    border-radius: var(--border-radius);
    font-family: var(--heading-font);
}
```

---

## Java Util 설명

### 1. DataUtil - 데이터베이스 연결

- DataSource 관련 보일러플레이트 제공

```java
Connection conn = DataUtil.getConnection();
```

---

### 2. FileUtil - 파일 업로드/다운로드/삭제

- **업로드**

```java
MultipartRequest multi = FileUtil.fileUpload(request, "subDir");
String sysFileName = multi.getFilesystemName("fileInputName");
String oriFileName = multi.getOriginalFileName("fileInputName");
```

- `subDir`:`upload` 하위 폴더명 지정

- **다운로드**

```java
FileUtil.fileDownload(request, response, "subDir","sysFileName","oriFileName");
```

- **삭제**

```java
FileUtil.deleteFile(request, "subDir","sysFileName");
```

---

### 3. SecurityUtil - 암호화

- 문자열 암호화

```java
String encryptedText = SecurityUtil.encrypt("text");
```

---

### 공용 컴포넌트

- `webapp/common` 폴더에 위치
- 프론트 전반에서 재사용 가능한 코드

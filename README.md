# F5Web 프로젝트

## 프로젝트 자료

- **[0. 프로젝트 Google Drive](https://drive.google.com/drive/folders/1eTx9sml-5wobjM1_xlHuNHPITeIqizmw)**
- **[1. 요구사항 정의서](https://docs.google.com/spreadsheets/d/1ahWepoCayDJ5XrUp2FLt1lsOSSY-aj6o4qnHbF8Rusc)**
- **[2. 요구사항 명세서](https://docs.google.com/spreadsheets/d/1efOPRSfEhhDyHO4KDAJj_WZoIR8ASWskb0GQBm5FC08)**
- **[3. ERD](https://www.erdcloud.com/d/frfp7FXRHMmLrErGH)**

---

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

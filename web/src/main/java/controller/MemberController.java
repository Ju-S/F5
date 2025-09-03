package controller;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import dao.board.BoardCategoryDAO;
import dao.board.BoardDAO;
import dao.board.BoardFileDAO;
import dao.board.ReplyDAO;
import dao.game.GameDAO;
import dao.game.GameReplyDAO;
import dao.game.GameScoreDAO;
import dao.member.BlackListDAO;
import dao.member.MemberDAO;
import dao.member.MemberGameTierDAO;
import dao.member.MemberProfileFileDAO;
import dto.member.MemberDTO;
import dto.member.MemberProfileFileDTO;
import enums.Authority;
import util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet("*.member")
public class MemberController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //region 임시적 모든 dao 선언
            BoardCategoryDAO boardCategoryDAO = BoardCategoryDAO.getInstance();
            BoardDAO boardDAO = BoardDAO.getInstance();
            BoardFileDAO boardFileDAO = BoardFileDAO.getInstance();
            ReplyDAO replyDAO = ReplyDAO.getInstance();
            GameDAO gameDAO = GameDAO.getInstance();
            GameReplyDAO gameReplyDAO = GameReplyDAO.getInstance();
            GameScoreDAO gameScoreDAO = GameScoreDAO.getInstance();
            BlackListDAO blackListDAO = BlackListDAO.getInstance();
            MemberDAO memberDAO = MemberDAO.getInstance();
            MemberGameTierDAO memberGameTierDAO = MemberGameTierDAO.getInstance();
            MemberProfileFileDAO memberProfileFileDAO = MemberProfileFileDAO.getInstance();
            //endregion

            String cmd = request.getRequestURI();
            Gson g = new Gson();
            switch (cmd) {
                // 행위 + 자원 (e.g, /get_memberList.member로 작성 요망)
                //TODO: 회원 관련 기능

                //아이디 중복일때
                //아래메소드는 단순확인용 수정예정 - 0829작성
                case "/dupliIdCheck.member":
                    response.setContentType("text/html; charset=UTF-8");
                    System.out.println("cmd = " + cmd);
                    String id = request.getParameter("id"); // 클라이언트에서 넘어온 id
                    System.out.println("입력된 ID = " + id);

                    //  여기 밑에 submit이랑 pw 겹쳐져서 수정해놓음 참고바람.
                    PrintWriter out = response.getWriter();
                    out.append("false");
                    out.close();
                    break;

                //닉네임 중복일때
                //아래메소드는 단순확인용 수정예정 - 0829작성
                case "/dupliNicknameCheck.member":
                    response.setContentType("text/html; charset=UTF-8");
                    System.out.println("cmd = " + cmd);
                    String nickname = request.getParameter("nickname"); // 클라이언트에서 넘어온 id
                    System.out.println("입력된 nickname = " + nickname);

                    //  여기 밑에 submit이랑 pw 겹쳐져서 수정해놓음 참고바람.
                    out = response.getWriter();
                    out.append("false");
                    out.close();
                    break;

                // 회원정보 조회 - 회원 가입 보고 수정 예정
                case "/submit.member":
                    id = request.getParameter("id");
                    String pw = request.getParameter("pw");
                    String name = request.getParameter("name");
                    nickname = request.getParameter("nickname");
                    String email = request.getParameter("email");

                    // enums/Authority에서 권한 정의(ADMIN, MEMBER 등)
                    String authStr = request.getParameter("authority");
                    Authority authority = null;
                    if (authStr != null) {
                        authority = Authority.valueOf(authStr.toUpperCase());
                    }

                    // 출생년도 (숫자 변환)
                    int birthyear = 0;
                    try {
                        birthyear = Integer.parseInt(request.getParameter("birthyear"));
                    } catch (NumberFormatException e) {
                        // 기본값 유지
                    }

                    // 성별 가져오기
                    String sex = request.getParameter("sex"); // "male" / "female"
                    int sexValue = 0; // 기본값
                    if (sex != null) {
                        if (sex.equalsIgnoreCase("male")) sexValue = 1;
                        else if (sex.equalsIgnoreCase("female")) sexValue = 2;
                    }

                    // 확인용
                    System.out.println("폼 데이터 확인 : " + id + "," + pw + "," + name + "," + nickname + "," + email + "," + authority + "," + birthyear + "," + sex);

                    if (id != null && pw != null && name != null && nickname != null && email != null && authority != null && birthyear > 0 && sex != null) {
                        MemberDTO memberDTO = MemberDTO.builder()
                                .id(id)
                                .pw(pw)
                                .name(name)
                                .nickname(nickname)
                                .email(email)
                                .authority(authority)
                                .birthyear(birthyear)
                                .sex(sexValue)
                                .build();

                        int result = memberDAO.inserMember(memberDTO);
                        if (result > 0) {
                            response.sendRedirect("/login"); //로그인창으로 이동 화면 수정
                            break;
                        } else {
                            response.sendRedirect("/error.jsp"); //에러 페이지 이동
                        }
                    }

                    // 회원 아이디 확인 과정 - 마이페이지
                case "/mypage.member":
                    HttpSession session = request.getSession();
                    String memberId = (String) session.getAttribute("loginId");

                    if (memberId != null) {
                        MemberDTO memberDAOMemberById = memberDAO.getMemberById(memberId);
                        response.setContentType("application/json; charset=UTF-8");
                        out = response.getWriter();

                        String json = g.toJson(memberDAOMemberById);
                        out.println(json);
                    }
                    break;

                // 회원 정보 수정 - update
                case "/updateMember.member":
                    id = request.getParameter("id");
                    name = request.getParameter("name");
                    nickname = request.getParameter("nickname");
                    email = request.getParameter("email");
                    // 출생년도 (숫자 변환)
                    birthyear = 0;
                    try {
                        birthyear = Integer.parseInt(request.getParameter("birthyear"));
                    } catch (NumberFormatException e) {
                        // 기본값 유지
                    }
                    // 성별 가져오기
                    sex = request.getParameter("sex"); // "male" / "female"
                    sexValue = 0; // 기본값
                    if (sex != null) {
                        if (sex.equalsIgnoreCase("male")) sexValue = 1;
                        else if (sex.equalsIgnoreCase("female")) sexValue = 2;
                    }

                    MemberDTO dto = MemberDTO.builder()
                            .id(id)
                            .name(name)
                            .nickname(nickname)
                            .email(email)
                            .birthyear(birthyear)
                            .sex(sexValue) // int 타입 성별
                            .build();

                    int result = memberDAO.updateMember(dto);

                    if (result > 0) {
                        response.sendRedirect("/member/my_page/mypage.jsp");
                    } else {
                        response.sendRedirect("/error.jsp");
                    }
                    break;

                // 회원 탈퇴
                case "/deleteMember.member":
                    id = request.getParameter("id");
                    session = request.getSession();
                    memberId = (String) session.getAttribute("loginId");

                    if (memberId != null && memberId.equals(id)) {
                        result = memberDAO.deleteDateMember(id);

                        if (result > 0) {
                            System.out.println("탈퇴성공");
                            session.removeAttribute("loginId");
                            response.sendRedirect("/index.jsp"); // 홈 페이지로 이동
                        } else {
                            response.sendRedirect("/error.jsp"); // 에러 페이지로 이동
                        }
                    } else {
                        // 로그인된 사용자가 아니거나 ID가 일치하지 않으면 에러 페이지로 리다이렉트
                        response.sendRedirect("/error.jsp");
                    }
                    break;

                // 마이페이지 회원 이미지 파일 저장 & 업데이트
                // FileUtil 사용해서 업로드 처리
                case "/uploadImgFile.member":
                    try {
                        // FileUtil.java 사용
                        MultipartRequest multi = FileUtil.fileUpload(request, "profile");

                        String oriName = multi.getOriginalFileName("file");
                        String sysName = multi.getFilesystemName("file");
                        // 받았는지 확인용
                        System.out.println("oriName: " + oriName);
                        System.out.println("sysName: " + sysName);


                        // 세션에서 로그인한 사용자 ID 가져오기
                        session = request.getSession();
                        memberId = (String) session.getAttribute("loginId");

                        if (oriName != null && sysName != null && memberId != null) {
                            MemberProfileFileDTO profileDto = MemberProfileFileDTO.builder()
                                    .memberId(memberId)
                                    .oriName(oriName)
                                    .sysName(sysName)
                                    .build();

                            result = memberProfileFileDAO.insertProfileImage(profileDto);
                            System.out.println("DB INSERT result = " + result);
                        } else {
                            System.out.println("파일 또는 로그인 정보 누락 - 업로드 실패");
                        }

                        response.sendRedirect("/member/my_page/mypage.jsp"); // 마이페이지로 이동
                        break;

                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendRedirect("/error.jsp");
                    }

                    // 마이페이지에 이미지 출력
                case "/downloadImgFile.member":
                    try {
                        session = request.getSession();
                        memberId = (String) session.getAttribute("loginId");

                        MemberProfileFileDTO profileDto = memberProfileFileDAO.getProfileImagePath(memberId);
                        String sysName = (profileDto != null) ? profileDto.getSysName() : null;

                        String basePath = request.getServletContext().getRealPath("/upload/profile");
                        String defaultImgPath = request.getServletContext().getRealPath("/member/my_page/img/profile.svg");

                        File targetFile = (sysName == null || !(new File(basePath, sysName)).exists())
                                ? new File(defaultImgPath)
                                : new File(basePath, sysName);

                        FileUtil.streamFile(request, response, targetFile);
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendRedirect("/error.jsp");
                    }
                    break;

                case "/chartdate.member":
                    Map<String, Integer> genderStats = memberDAO.getGenderStats();
                    Map<String, Integer> yearStats = memberDAO.getYearStats();

                    request.setAttribute("maleCount", genderStats.getOrDefault("male", 0));
                    request.setAttribute("femaleCount", genderStats.getOrDefault("female", 0));
                    request.setAttribute("yearStats", yearStats);

                    request.getRequestDispatcher("/chart/dashboard.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
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

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
import java.util.Properties;

@WebServlet("*.member")
public class MemberController extends HttpServlet {
    private static final long EMAIL_CODE_TTL = 10 * 60 * 1000L;  // 10분
    // sendGrid 계정
    private String SMTP_USER;   // ← web.xml에서 주입
    private String SMTP_PASS;   // ← web.xml에서 주입
    private String SMTP_FROM;   // ← web.xml에서 주입

    @Override
    public void init() throws ServletException {
        SMTP_USER = getServletContext().getInitParameter("SMTP_USER");
        SMTP_PASS = getServletContext().getInitParameter("SMTP_PASS");
        SMTP_FROM = getServletContext().getInitParameter("SMTP_FROM");

        if (SMTP_USER == null || SMTP_PASS == null || SMTP_FROM == null) {
            throw new ServletException("SMTP config missing: check web.xml (SMTP_USER/SMTP_PASS/SMTP_FROM)");
        }
    }

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

                case "/toLoginPage.member": {
                    //로그인 페이지로 이동
                    response.sendRedirect("/member/login/login.jsp");
                    return; //리다이렉트 후에 리턴넣어야 작동되네
                }


                case "/toSigninPage.member": {
                    //회원가입 페이지로 이동
                    response.sendRedirect("/member/signin/signin.jsp");
                    return;//리다이렉트 후에 리턴넣어야 작동되네
                }


                case "/isLoginOk.member": {
                    //로그인 해도 되는지?
                    String id = request.getParameter("id");
                    String pw = request.getParameter("pw");
                    System.out.println(id + ":" + pw);

                    boolean isLoginOk = memberDAO.isLoginOk(id, pw);
                    System.out.println("로그인성공 여부:" + isLoginOk);

                    if (isLoginOk) {
                        request.getSession().setAttribute("loginId", id); // 로그인 인증 정보를 세션에다 담음
                        response.sendRedirect("/index.jsp");
                        return;
                    } else {
                        // 실패 시에도 반드시 응답을 보냄(로그인 페이지로 보내면서 alert 뜨게 만들기)
                        response.sendRedirect("/member/login/login.jsp?msg=loginfail");
                        return;
                    }
                }


                case "/toFindIdPage.member": {
                    // 아이디 찾기 페이지로 이동 (forward)
                    response.sendRedirect("/member/findId/findId.jsp");
                    return;
                }


                case "/toFindPwPage.member": {
                    // 비번 찾기 페이지로 이동 (forward)
                    response.sendRedirect("/member/findPw/findPw.jsp");
                    return;
                }


                case "/dupliIdCheck.member": {
                    //아이디 중복검사
                    response.setContentType("text/plain; charset=UTF-8"); // text/plain 권장
                    String id = request.getParameter("id");
                    if (id != null) id = id.trim();                        // ★ 공백 방지

                    boolean exists = memberDAO.isIdExist(id);
                    System.out.println("아이디중복검사 컨트롤러 id=\"" + id + "\", exists=" + exists);

                    PrintWriter out = response.getWriter();
                    out.append("false");
                    out.close();

                    PrintWriter pw = response.getWriter();
                    pw.print(exists);   // println/append 대신 print
                    pw.flush();
                    pw.close();
                    break;
                }

                case "/dupliNicknameCheck.member": {
                    //닉네임 중복검사
                    response.setContentType("text/html; charset=UTF-8");
                    String nickname = request.getParameter("nickname");
                    String isNicknameExist = String.valueOf(memberDAO.isNicknameExist(nickname));

                    PrintWriter pw = response.getWriter();
                    pw.print(isNicknameExist);
                    pw.flush();
                    pw.close();
                    break;
                }

                // 이메일 확인
                case "/mailCheck.member": {

                    //이메일 인증: 코드 발송
                    response.setContentType("application/json; charset=UTF-8");

                    //request에 담긴 email을 null인지 체크후 빈공간 있으면 지우기(trim)
                    String emailParam = request.getParameter("email");
                    if (emailParam == null || emailParam.trim().isEmpty()) {
                        response.getWriter().write("{\"ok\":false,\"msg\":\"email required\"}");
                        break;
                    }
                    String email = emailParam.trim();

                    // 6자리 코드 생성 (111111~999999)
                    String code = String.valueOf(new java.util.Random().nextInt(888_888) + 111_111);

                    // SMTP 설정
                    Properties props = new Properties();
                    props.put("mail.transport.protocol", "smtp");
                    props.put("mail.smtp.host", "smtp.sendgrid.net");
                    props.put("mail.smtp.port", "587");
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.starttls.enable", "true");
                    props.put("mail.smtp.from", SMTP_FROM);// Envelope MAIL FROM(리턴패스)도 동일하게
                    props.put("mail.smtp.ssl.protocols", "TLSv1.2");

                    Session mailSession = Session.getInstance(props, new Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(SMTP_USER, SMTP_PASS); // "apikey", "SG...."
                        }
                    });

                    try {
                        // 메일 메시지 작성
                        MimeMessage msg = new MimeMessage(mailSession);
                        msg.setFrom(new InternetAddress(SMTP_FROM)); // SendGrid에서 'Verified'된 주소와 정확히 일치해야 함
                        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                        msg.setSubject("회원가입 이메일 인증번호");
                        msg.setContent("<p>인증 번호는 <b>" + code + "</b> 입니다. 10분 이내에 입력해주세요.</p>", "text/html; charset=utf-8");

                        Transport.send(msg);

                        // 세션에 코드 + 타임스탬프 저장
                        HttpSession session = request.getSession();
                        session.setAttribute("emailCode:" + email, code);
                        session.setAttribute("emailCode:" + email + ":ts", System.currentTimeMillis());

                        response.getWriter().write("{\"ok\":true}"); //성공하면 ok객체에 true 담기
                    } catch (MessagingException e) {
                        e.printStackTrace();
                        response.getWriter().write("{\"ok\":false,\"msg\":\"send fail\"}"); // 실패하면 okr객체에 false 담기
                    }
                    break;

                }

                // 이메일 인증
                case "/verifyEmailCode.member": {
                    //이메일 인증: 코드 발송
                    response.setContentType("application/json; charset=UTF-8");
                    //request에 담긴 email과 code를 받기
                    String vEmail = request.getParameter("email");
                    String inputCode = request.getParameter("code");

                    //이메일이나 코드가 null이면 종료후 공백 trim으로 지우기
                    if (vEmail == null || inputCode == null) {
                        response.getWriter().write("{\"ok\":false}");
                        break;
                    }
                    vEmail = vEmail.trim();
                    inputCode = inputCode.trim();

                    //세션에서 email 코드, 타임스탬프 가져오기
                    HttpSession vSession = request.getSession();
                    Object savedObj = vSession.getAttribute("emailCode:" + vEmail);
                    Object tsObj = vSession.getAttribute("emailCode:" + vEmail + ":ts");

                    //통과여부 불리언 설정
                    boolean ok = false;
                    if (savedObj != null && tsObj != null) { //세션에 저장된 savedObj 와 tsObj가 있다면
                        String saved = savedObj.toString();
                        long ts = (long) tsObj; //형 변환해서
                        //현재 시간과 저장된 시간을 비교했을때 작으면 && saved와(세션에 저장되었던 코드) inputCode(request에서 방금 받은 코드)비교해서 같다면
                        ok = (System.currentTimeMillis() - ts) <= EMAIL_CODE_TTL && saved.equals(inputCode);
                        if (ok) {
                            // 1회성 사용 후 제거
                            vSession.removeAttribute("emailCode:" + vEmail);
                            vSession.removeAttribute("emailCode:" + vEmail + ":ts");
                        }
                    }

                    //성공하면 ok true 담고 실패하면 false담기
                    response.getWriter().write(ok ? "{\"ok\":true}" : "{\"ok\":false}");
                    break;

                }

                // 회원 정보
                case "/signin.member": {
                    request.setCharacterEncoding("UTF-8");

                    String id = request.getParameter("id");
                    String pw = request.getParameter("pw");
                    String name = request.getParameter("name");
                    String nickname = request.getParameter("nickname");
                    String email = request.getParameter("email");
                    /*authority member*/
                    int birthyear = Integer.parseInt(request.getParameter("targetYear"));
                    int sex = Integer.parseInt(request.getParameter("sex"));
                    /*sysdate*/

                    MemberDTO temp = MemberDTO.builder()
                            .id(id)
                            .email(email)
                            .pw(pw)
                            .name(name)
                            .nickname(nickname)
                            .authority(Authority.MEMBER)
                            .birthyear(birthyear)
                            .sex(sex)
                            .joinDate(null)
                            .build();

                    memberDAO.inserMember(temp); //dao 에 넣기
                    //region read
                    //TODO: 여기서 그냥 response 바로 index.jsp로 가도 되는지
                    //endregion
                    response.sendRedirect("/index.jsp");
                }


                default: {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.setContentType("application/json; charset=UTF-8");
                    response.getWriter().write("{\"ok\":false,\"msg\":\"unknown endpoint\"}");
                    break;
                }

                /*  // 회원정보 조회 - 회원 가입 보고 수정 예정
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
                    }*/

                // 회원 탈퇴
                case "/deleteMember.member": {
                    String id = request.getParameter("id");
                    HttpSession session = request.getSession();
                    String memberId = (String) session.getAttribute("loginId");

                    if (memberId != null && memberId.equals(id)) {
                        int result = memberDAO.deleteDateMember(id);

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
                }

                // 회원 아이디 확인 과정 - 마이페이지
                case "/mypage.member": {
                    HttpSession session = request.getSession();
                    String memberId = (String) session.getAttribute("loginId");

                    if (memberId != null) {
                        MemberDTO memberDAOMemberById = memberDAO.getMemberById(memberId);
                        response.setContentType("application/json; charset=UTF-8");
                        PrintWriter out = response.getWriter();

                        String json = g.toJson(memberDAOMemberById);
                        out.println(json);
                    }
                    break;
                }
                // 회원 정보 수정 - update
                case "/updateMember.member": {
                    String id = request.getParameter("id");
                    String name = request.getParameter("name");
                    String nickname = request.getParameter("nickname");
                    String email = request.getParameter("email");
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
                }

                // 마이페이지 회원 이미지 파일 저장 & 업데이트
                // FileUtil 사용해서 업로드 처리
                case "/uploadImgFile.member": {
                    // FileUtil.java 사용
                    MultipartRequest multi = FileUtil.fileUpload(request, "profile");

                    String oriName = multi.getOriginalFileName("file");
                    String sysName = multi.getFilesystemName("file");
                    // 받았는지 확인용
                    System.out.println("oriName: " + oriName);
                    System.out.println("sysName: " + sysName);


                    // 세션에서 로그인한 사용자 ID 가져오기
                    HttpSession session = request.getSession();
                    String memberId = (String) session.getAttribute("loginId");

                    if (oriName != null && sysName != null && memberId != null) {
                        MemberProfileFileDTO profileDto = MemberProfileFileDTO.builder()
                                .memberId(memberId)
                                .oriName(oriName)
                                .sysName(sysName)
                                .build();

                        int result = memberProfileFileDAO.insertProfileImage(profileDto);
                        System.out.println("DB INSERT result = " + result);
                    } else {
                        System.out.println("파일 또는 로그인 정보 누락 - 업로드 실패");
                    }

                    response.sendRedirect("/member/my_page/mypage.jsp"); // 마이페이지로 이동
                    break;

                }

                // 마이페이지에 이미지 출력
                case "/downloadImgFile.member": {
                    HttpSession session = request.getSession();
                    String memberId = (String) session.getAttribute("loginId");

                    MemberProfileFileDTO profileDto = memberProfileFileDAO.getProfileImagePath(memberId);
                    String sysName = (profileDto != null) ? profileDto.getSysName() : null;

                    String basePath = request.getServletContext().getRealPath("/upload/profile");
                    String defaultImgPath = request.getServletContext().getRealPath("/member/my_page/img/profile.svg");

                    File targetFile = (sysName == null || !(new File(basePath, sysName)).exists())
                            ? new File(defaultImgPath)
                            : new File(basePath, sysName);

                    FileUtil.streamFile(request, response, targetFile);
                    break;
                }

                //차트 정보
                case "/chartdate.member": {
                    Map<String, Integer> genderStats = memberDAO.getGenderStats();
                    Map<String, Integer> yearStats = memberDAO.getYearStats();

                    request.setAttribute("maleCount", genderStats.getOrDefault("male", 0));
                    request.setAttribute("femaleCount", genderStats.getOrDefault("female", 0));
                    request.setAttribute("yearStats", yearStats);

                    request.getRequestDispatcher("/chart/dashboard.jsp").forward(request, response);
                    break;
                }
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
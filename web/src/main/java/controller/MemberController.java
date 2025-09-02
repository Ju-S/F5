package controller;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
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
import dto.member.MemberProfileFileDTO;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;

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
                case "/dupliIdCheck.member" :
                    response.setContentType("text/html; charset=UTF-8");
                    System.out.println("cmd = " + cmd);
                    String id = request.getParameter("id"); // 클라이언트에서 넘어온 id
                    System.out.println("입력된 ID = " + id);

                    PrintWriter pw = response.getWriter();
                    pw.append("false");
                    pw.close();
                    break;

                //닉네임 중복일때
                //아래메소드는 단순확인용 수정예정 - 0829작성
                case "/dupliNicknameCheck.member" :
                    response.setContentType("text/html; charset=UTF-8");
                    System.out.println("cmd = " + cmd);
                    String nickname = request.getParameter("nickname"); // 클라이언트에서 넘어온 id
                    System.out.println("입력된 nickname = " + nickname);

                    pw = response.getWriter();
                    pw.append("false");
                    pw.close();


                // 마이페이지 회원 이미지 파일 저장 & 업데이트
                case "/uploadImgFile.member":
                    try {
                        int maxSize = 10 * 1024 * 1024; // 10MB

                        // 저장 경로
                        String savePath = request.getServletContext().getRealPath("/upload/profile");
                        System.out.println("savePath: " + savePath);

                        File filePath = new File(savePath);
                        if (!filePath.exists()) {
                            filePath.mkdirs();
                        }

                        // 파일 업로드
                        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

                        String oriName = multi.getOriginalFileName("file");
                        String sysName = multi.getFilesystemName("file");
                        System.out.println("oriName: " + oriName);
                        System.out.println("sysName: " + sysName);

                        // 세션에서 로그인한 사용자 ID 가져오기
                        HttpSession session = request.getSession();
                        String memberId = (String) session.getAttribute("loginId");

                        if (oriName != null && sysName != null && memberId != null) {
                            MemberProfileFileDTO profileDto = MemberProfileFileDTO.builder().memberId(memberId).oriName(oriName).sysName(sysName).build();

                            int result = memberProfileFileDAO.insertProfileImage(profileDto);
                            System.out.println("DB INSERT result = " + result);
                        } else {
                            System.out.println("파일 또는 로그인 정보 누락 - 업로드 실패");
                        }

                        response.sendRedirect("/member/my_page/mypage.jsp"); // 업로드 후 마이페이지로
                        break;

                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendRedirect("/error.jsp"); // 오류 발생 시 오류 페이지로 이동
                    }

                // 마이페이지에 이미지 출력
                case "/downloadImgFile.member":
                    try {
                        HttpSession session = request.getSession();
                        String memberId = (String) session.getAttribute("loginId");

                        MemberProfileFileDTO profileDto = memberProfileFileDAO.getProfileImagePath(memberId);

                        String sysName = (profileDto != null) ? profileDto.getSysName() : null;

                        // 파일 경로 설정
                        String basePath = request.getServletContext().getRealPath("/upload/profile");
                        File targetFile = null;

                        if (sysName != null) {
                            targetFile = new File(basePath, sysName);
                        }

                        // 프로필 이미지가 없거나, 파일이 존재하지 않으면 기본 이미지로 대체
                        if (targetFile == null || !targetFile.exists()) {
                            String defaultImgPath = request.getServletContext().getRealPath("/member/my_page/img/profile.svg");
                            targetFile = new File(defaultImgPath);
                        }

                        // MIME 타입 설정
                        String mimeType = getServletContext().getMimeType(targetFile.getName());
                        if (mimeType == null) {
                            mimeType = "application/octet-stream";
                        }
                        response.setContentType(mimeType);
                        response.setContentLength((int) targetFile.length());

                        // 이미지 스트리밍 출력
                        try (FileInputStream fis = new FileInputStream(targetFile);
                             ServletOutputStream sos = response.getOutputStream()) {

                            byte[] buffer = new byte[4096];
                            int bytesRead;
                            while ((bytesRead = fis.read(buffer)) != -1) {
                                sos.write(buffer, 0, bytesRead);
                            }
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendRedirect("/error.jsp");
                    }
                    break;

                    // 회원정보 조회 할 예정 - 작성만 한부분
                case "":
                    HttpSession session = request.getSession();
                    String memberId = (String) session.getAttribute("loginId"); //로그인 회원

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
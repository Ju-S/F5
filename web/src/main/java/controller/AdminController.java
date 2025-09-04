package controller;

import com.google.gson.Gson;
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
import dto.admin.ReportedPostDTO;
import dto.board.ReplyDTO;
import dto.member.MemberDTO;
import enums.Authority;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import static java.nio.file.Files.setAttribute;

@WebServlet("*.admin")
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
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
            Gson gson = new Gson();
            // 이후 처리 계속

            switch (cmd) {

                // 게시글용..
                // JSP 페이지 렌더링용
                case "/reportedPosts.admin": {
                    int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
                    int rowsPerPage = 10;
                    int offset = (page - 1) * rowsPerPage + 1;
                    int limit = page * rowsPerPage;

                    List<ReportedPostDTO> reportList = boardDAO.getReportedPosts(offset, limit);
                    int total = boardDAO.getReportedPostsCount();
                    int totalPage = (int) Math.ceil((double) total / rowsPerPage);

                    request.setAttribute("reportList", reportList);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPage", totalPage);

                    request.getRequestDispatcher("/member/admin/board.jsp").forward(request, response);
                    break;
                }

                // AJAX JSON 데이터 응답용
                case "/getReportedPosts.admin": {
                    int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
                    int rowsPerPage = 10;
                    int offset = (page - 1) * rowsPerPage + 1;
                    int limit = page * rowsPerPage;

                    List<ReportedPostDTO> reportList = boardDAO.getReportedPosts(offset, limit);
                    int total = boardDAO.getReportedPostsCount();
                    int totalPage = (int) Math.ceil((double) total / rowsPerPage);

                    response.setContentType("application/json;charset=UTF-8");
                    PrintWriter out = response.getWriter();

                    StringBuilder json = new StringBuilder();
                    json.append("{");
                    json.append("\"reportList\": [");

                    for (int i = 0; i < reportList.size(); i++) {
                        ReportedPostDTO r = reportList.get(i);
                        json.append("{");
                        json.append("\"id\":").append(r.getId()).append(",");
                        json.append("\"title\":\"").append(escapeJson(r.getTitle())).append("\",");
                        json.append("\"nickname\":\"").append(escapeJson(r.getNickname())).append("\",");
                        json.append("\"reportDate\":\"").append(r.getReportDate()).append("\",");
                        json.append("\"reportCount\":").append(r.getReportCount());
                        json.append("}");
                        if (i < reportList.size() - 1) json.append(",");
                    }

                    json.append("],");
                    json.append("\"totalPage\":").append(totalPage);
                    json.append("}");

                    out.print(json.toString());
                    out.close();
                    break;
                }

                // 게시글 삭제 처리
                case "/deletePost.admin": {
                    long id = Long.parseLong(request.getParameter("id"));
                    boardDAO.deletePost(id);
                    response.sendRedirect("/reportedPosts.admin?page=1");
                    break;
                }

                // AjAX 이용코드...
                // 댓글용..
                // 위 댓글 리스트 JSON 응답 처리 코드 삽입
                case "/getReplies.admin": {
                    try {
                        String boardIdStr = request.getParameter("boardId");
                        if (boardIdStr == null) {
                            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "boardId is required");
                            return;
                        }

                        long boardId = Long.parseLong(boardIdStr);
                        int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
                        int rowsPerPage = 5;
                        int offset = (page - 1) * rowsPerPage + 1;
                        int limit = page * rowsPerPage;

                        replyDAO = ReplyDAO.getInstance();
                        List<ReplyDTO> replyList = replyDAO.getRepliesByBoardId(boardId, offset, limit);
                        int total = replyDAO.getReplyCountByBoardId(boardId);
                        int totalPage = (int) Math.ceil((double) total / rowsPerPage);

                        response.setContentType("application/json;charset=UTF-8");
                        PrintWriter out = response.getWriter();

                        StringBuilder json = new StringBuilder();
                        json.append("{");
                        json.append("\"replyList\": [");

                        for (int i = 0; i < replyList.size(); i++) {
                            ReplyDTO r = replyList.get(i);
                            json.append("{");
                            json.append("\"id\":").append(r.getId()).append(",");
                            json.append("\"writer\":\"").append(escapeJson(r.getWriter())).append("\",");
                            json.append("\"contents\":\"").append(escapeJson(r.getContents())).append("\",");
                            json.append("\"writeDate\":\"").append(r.getWriteDate()).append("\"");
                            json.append("}");
                            if (i < replyList.size() - 1) json.append(",");
                        }

                        json.append("],");
                        json.append("\"currentPage\":").append(page).append(",");
                        json.append("\"totalPage\":").append(totalPage);
                        json.append("}");

                        out.print(json.toString());
                        out.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "댓글 데이터를 불러오는 중 오류 발생");
                    }
                    break;
                }

                // 위 댓글 삭제 JSON 응답 처리 코드 삽입
                case "/deleteReply.admin": {
                    long id = Long.parseLong(request.getParameter("id"));
                    replyDAO = ReplyDAO.getInstance();
                    boolean success = replyDAO.deleteReply(id);

                    response.setContentType("application/json;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print("{\"success\":" + success + "}");
                    out.close();
                    break;
                }
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);

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

    // JSON 문자열 내 특수문자 이스케이프 처리
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"")
                .replace("\\", "\\\\")
                .replace("/", "\\/")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}

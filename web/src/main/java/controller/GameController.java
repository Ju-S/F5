package controller;

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
import dto.game.GameReplyDTO;
import dto.game.GameScoreDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("*.game")
public class GameController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

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

            String cmd = request.getRequestURI();

            switch (cmd) {


                case "/gameover.game": { // 게임 오버시 발생
                    //게임오버 시 sql game_score 테이블에 스코어 insert 점수를 받아서 알맞는 tier 구분 sql 값 score만 넣은상태
                    int gameId = Integer.parseInt(request.getParameter("gameId")); // 이후
                    int score = Integer.parseInt(request.getParameter("score"));
                    // String memberId =(String) request.getSession().getAttribute("loginId");
                    int result = gameScoreDAO.insertScore(gameId, score);


                    if (0 < score && score < 1000) {
                        String tier = "BRONZE";
                        gameScoreDAO.insertTier(gameId, tier);
                    } else if (1000 < score && score < 2000) {
                        String tier = "SILVER";
                        gameScoreDAO.insertTier(gameId, tier);
                    } else if (2000 < score) {
                        String tier = "GOLD";
                        gameScoreDAO.insertTier(gameId, tier);
                    }

                    response.setContentType("application/json; charset=utf-8"); // json 응답
                    response.getWriter().write("{\"result\":\"success\"}");

                    break;
                }

                case "/go_gamepage.game": { //게임페이지 입장시 , 댓글목록 및 랭킹 목록 출력

                    int gameId = Integer.parseInt(request.getParameter("gameId"));

                    List<GameReplyDTO> list = gameReplyDAO.selectAll(gameId);
                    List<GameScoreDTO> listranking = gameScoreDAO.selectRanking(gameId);

                    request.setAttribute("list", list);
                    request.setAttribute("listranking", listranking);

                    request.getRequestDispatcher("/game/gamepage.jsp").forward(request, response);
                    break;
                }

                case "/write_reply.game": { // 댓글 작성 (작성자)

                    String writer = request.getParameter("writer");
                    // String writer = (String)request.getSession().getAttribute("loginId");
                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    String contents = request.getParameter("contents");

                    gameReplyDAO.insertReply(gameId, writer, contents);
                    response.sendRedirect("/go_gamepage.game?gameId=" + gameId);

                    break;
                }
                case "/delete_reply.game": { // 댓글 삭제 (작성날짜)

                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    String writer = request.getParameter("writer");
                    // String writer = (String)request.getSession().getAttribute("loginId");
                    int id = Integer.parseInt(request.getParameter("id"));

                    gameReplyDAO.deleteReply(writer, id);
                    response.sendRedirect("/go_gamepage.game?gameId=" + gameId);
                    break;

                }
                case "/update_reply.game": { // 댓글 수정 (작성날짜)
                    String contents = request.getParameter("contents");
                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    String writer = request.getParameter("writer");
                    // String writer = (String)request.getSession().getAttribute("loginId");
                    int id = Integer.parseInt(request.getParameter("id"));

                    gameReplyDAO.updateReply(contents, writer, id);
                    response.sendRedirect("/go_gamepage.game?gameId=" + gameId);
                    break;

                }
                case "/report_reply.game": {

                    String writer = request.getParameter("writer");
                    // String writer = (String)request.getSession().getAttribute("loginId");
                    int reportcount = Integer.parseInt(request.getParameter("reportcount"));
                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    gameReplyDAO.insertReportCount(writer, reportcount);

                    response.sendRedirect("/go_gamepage.game?gameId=" + gameId);
                    break;

                }

                case "/toGamePage.game": {
                    String gameId = request.getParameter("gameId");
                    request.setAttribute("gameId", gameId);
                    //request.getRequestDispatcher().forward(request, response); 어디로 보내야 하는지 논의 필요~
                    break;
                }

                // 마이페이지에 랭킹 정보 전달
                case "/allGameRankings.game":
                    try {
                        // DAO 인스턴스 가져오기
                        gameScoreDAO = GameScoreDAO.getInstance();

                        // 모든 게임 랭킹 Map 받아오기
                        Map<Integer, List<GameScoreDTO>> gameRankings = memberGameTierDAO.selectAllGameRankings();
                        request.setAttribute("gameRankings", gameRankings);

                        // JSP로 forward
                        request.getRequestDispatcher("/member/my_page/mypage.jsp").forward(request, response);
                        break;
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendRedirect("/error.jsp");
                    }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        doGet(request, response);
    }
}


//region read
//TODO:
//endregion
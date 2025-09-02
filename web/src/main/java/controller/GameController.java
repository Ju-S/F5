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
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

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

                    int score = Integer.parseInt(request.getParameter("score"));
                    System.out.println("score: " + score);
                    int result = gameScoreDAO.insert_score(score);


                    if (0 < score && score < 1000) {
                        String tier = "BRONZE";
                        gameScoreDAO.insert_tier(tier);
                    } else if (1000 < score && score < 2000) {
                        String tier = "SILVER";
                        gameScoreDAO.insert_tier(tier);
                    } else if (2000 < score) {
                        String tier = "GOLD";
                        gameScoreDAO.insert_tier(tier);
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

                    System.out.println("랭킹 리스트: " + listranking);
                    request.getRequestDispatcher("/game/gamepage.jsp").forward(request, response);

                    break;

            }


                case "/write_reply.game" : { // 댓글 작성 (작성자)

                    String writer = request.getParameter("writer");
                    // String writer = (String)request.getSession().getAttribute("loginId");
                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    String contents = request.getParameter("contents");

                    gameReplyDAO.insert_reply(gameId, writer, contents);
                    response.sendRedirect("/go_gamepage.game?gameId=" + gameId);

                    break;
                }
                case "/delete_reply.game" : { // 댓글 삭제 (작성날짜)

                   int gameId = Integer.parseInt(request.getParameter("gameId"));
                    String thedate = request.getParameter("writedate");
                    Timestamp writedate = Timestamp.valueOf(thedate);

                    gameReplyDAO.deleteReply(writedate);
                    response.sendRedirect("/go_gamepage.game?gameId=" + gameId);
                    break;

                }
                case "/update_reply.game" : { // 댓글 수정 (작성날짜)
                    String contents = request.getParameter("contents");
                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    String writeDAte = request.getParameter("writedate");
                    Timestamp write_date = Timestamp.valueOf(writeDAte);

                    gameReplyDAO.updateReply(contents, write_date);
                    response.sendRedirect("/go_gamepage.game?gameId=" + gameId);
                    break;


                }



            }

        } catch(Exception e) {
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
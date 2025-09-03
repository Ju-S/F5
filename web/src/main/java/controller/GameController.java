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

                case "/go_gamepage.game": { //댓글출력

                    int GAME_ID = Integer.parseInt(request.getParameter("game_id"));

                    List<GameReplyDTO> list = gameReplyDAO.selectAll(GAME_ID);
                    List<GameScoreDTO> list_ranking = gameScoreDAO.selectRanking(GAME_ID);

                    request.setAttribute("list", list);
                    request.setAttribute("list_ranking", list_ranking);

                    System.out.println("랭킹 리스트: " + list_ranking);
                    request.getRequestDispatcher("/game/pmg/pmg_gamepage.jsp").forward(request, response);

                    break;

            }

                
                case "/write_reply.game" : { // 댓글 작성

                    String writer = request.getParameter("writer");
                    // String writer = (String)request.getSession().getAttribute("loginId");
                    int GAME_ID_reply = Integer.parseInt(request.getParameter("game_id"));
                    String contents = request.getParameter("contents");

                    gameReplyDAO.insert_reply(GAME_ID_reply, writer, contents);
                    response.sendRedirect("/go_gamepage.game?game_id=" + GAME_ID_reply);

                    break;
                }
                case "/delete_reply.game" : {

                    String gameId = request.getParameter("gameId");
                    String writeDAte = request.getParameter("write_date");
                    Timestamp write_date = Timestamp.valueOf(writeDAte);

                    gameReplyDAO.deleteReply(write_date);
                    response.sendRedirect("/go_gamepage.game?game_id=" + gameId);
                    break;

                }
                case "/update_reply.game" : {
                    String contents = request.getParameter("contents");
                    String gameId = request.getParameter("gameId");
                    String writeDAte = request.getParameter("write_date");
                    Timestamp write_date = Timestamp.valueOf(writeDAte);

                    gameReplyDAO.updateReply(contents, write_date);
                    response.sendRedirect("/go_gamepage.game?game_id=" + gameId);
                    break;


                }


                case "/toGamePage.game" :{
                    String gameId = request.getParameter("gameId");
                    request.setAttribute("gameId", gameId);
                    //request.getRequestDispatcher().forward(request, response); 어디로 보내야 하는지 논의 필요~
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
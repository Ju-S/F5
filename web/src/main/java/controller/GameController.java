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

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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


            GameScoreDAO dao_gamescore = GameScoreDAO.getInstance();

            GameReplyDAO dao_reply = GameReplyDAO.getInstance();
            String cmd = request.getRequestURI();


            switch (cmd) {

                case "/gameover.game":

                    int score = Integer.parseInt(request.getParameter("score"));
                    System.out.println("cmd : " + cmd);
                    System.out.println("score:" + score);
                    int result =  dao_gamescore.insert_score(score);


                    if(0 < score && score < 10000){ //TODO 점수를 받아서 알맞는 tier 구분
                        String tier = "BRONZE";
                        dao_gamescore.insert_tier(tier);
                    }else if(10000 < score && score < 20000){
                    String tier = "SILVER";
                        dao_gamescore.insert_tier(tier);
                    }else if(20000 < score ){
                        String tier = "GOLD";
                        dao_gamescore.insert_tier(tier);
                    }




                    response.setContentType("application/json; charset=utf-8");
                    response.getWriter().write("{\"result\": " + result + "}");


                    break;

                // 행위 + 자원 (e.g, /getMemberList.member로 작성 요망)
                //TODO: 게임오버 시 sql game_score 테이블에 스코어 insert
                //TODO: sql 값 score만 넣은상태



                case "/go_gamepage1.game" :

                    List<GameReplyDTO> list = dao_reply.selectAll();

                    request.setAttribute("list", list);
                    System.out.println("댓글 개수: " + list.size());
                    request.getRequestDispatcher("/game/pmg/pmg_gamepage.jsp").forward(request, response);



                    break;

                case "/write_reply.game" :

                    String writer = request.getParameter("writer");
                    // String writer = (String)request.getSession().getAttribute("loginId");
                    int game_id = Integer.parseInt(request.getParameter("game_id"));
                    String contents = request.getParameter("contents");

                    dao_reply.insert_reply(game_id,writer,contents);
                    response.sendRedirect("/game/pmg/pmg_gamepage.jsp");

                    break;




                //TODO : 댓글 작성
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
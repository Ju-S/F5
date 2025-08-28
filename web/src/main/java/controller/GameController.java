package controller;

import dao.game.GameReplyDAO;
import dao.game.GameScoreDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("*.game")
public class GameController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        try {
            GameScoreDAO dao_gamescore = GameScoreDAO.getInstance();

            GameReplyDAO dao_reply = GameReplyDAO.getInstance();
           String cmd = request.getRequestURI();


            switch (cmd) {

                case "/gameover.game":

                   int score = Integer.parseInt(request.getParameter("score"));
                    System.out.println("cmd : " + cmd);
                    System.out.println("score:" + score);
                 int result =  dao_gamescore.insert_score(score);
                    response.setContentType("application/json; charset=utf-8");
                    response.getWriter().write("{\"result\": " + result + "}");
                    break;
                // 행위 + 자원 (e.g, /getMemberList.member로 작성 요망)
                //TODO: 게임오버 시 sql game_score 테이블에 스코어 insert
                //TODO: sql 값 score만 넣은상태

                case "/write_reply.game" :

                    String writer = request.getParameter("writer");
                   // String writer = (String)request.getSession().getAttribute("loginId");
                    int game_id = Integer.parseInt(request.getParameter("game_id"));
                    String contents = request.getParameter("contents");

                    dao_reply.insert_reply(game_id,writer,contents);
                    response.sendRedirect("/game/pmg/pmg_gamepage.jsp");
                   //request.getRequestDispatcher("/game/pmg/pmg_gamepage.jsp").forward(request, response);
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

        doGet(request, response);
    }
}
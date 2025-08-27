package controller;

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
            GameScoreDAO dao = GameScoreDAO.getInstance();
           String cmd = request.getRequestURI();


            switch (cmd) {

                case "/gameover.game":

                   int score = Integer.parseInt(request.getParameter("score"));
                    System.out.println("cmd : " + cmd);
                    System.out.println("score:" + score);
                 int result =  dao.insert_score(score);
                    response.setContentType("application/json; charset=utf-8");
                    response.getWriter().write("{\"result\": " + result + "}");
                    break;
                // 행위 + 자원 (e.g, /getMemberList.member로 작성 요망)
                //TODO: 게임 관련 기능
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
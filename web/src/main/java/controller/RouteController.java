package controller;

import dto.board.BoardDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("*.page")
public class RouteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String cmd = request.getRequestURI();

            switch (cmd) {
                //TODO: .page에 따른 페이지 라우팅(페이지 이동 관련)
                case "/board_list.page": {
                    request.getRequestDispatcher("/board/list/boardListPage.jsp").forward(request, response);
                    break;
                }
                case "/write_board.page": {
                    request.getRequestDispatcher("/board/writeBoard/writeBoard.jsp").forward(request, response);
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
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
import dto.board.BoardDTO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.List;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
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
            Gson gson = new Gson();

            switch (cmd) {
                // 행위 + 자원 (e.g, /getMemberList.member로 작성 요망)
                //TODO: 게시글 관련 기능

                // 게시글 목록 확인.(pagination)
                case "/get_board_list.board" : {
                    int naviPerPage = 10;
                    int itemPerPage = 10;
                    int curPage = 1;
                    try {
                        curPage = Integer.parseInt(request.getParameter("page"));
                    } catch (Exception ignored) {}

                    int filter = -1;
                    try {
                        filter = Integer.parseInt(request.getParameter("filter"));
                    } catch (Exception ignored) {}

                    List<BoardDTO> boardDTOList = boardDAO.getBoardPage(curPage, itemPerPage, filter);

                    request.setAttribute("list", gson.toJson(boardDTOList));
                    request.setAttribute("itemPerPage", itemPerPage);

                    request.setAttribute("maxPage", boardDAO.getMaxPage(itemPerPage));
                    request.setAttribute("curPage", curPage);
                    request.setAttribute("naviPerPage", naviPerPage);
                    request.setAttribute("filter", filter);

                    request.getRequestDispatcher("/board/list/boardListPage.jsp").forward(request, response);
                }
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
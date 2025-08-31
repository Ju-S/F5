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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
                case "/get_board_list.board": {
                    int naviPerPage = 10;
                    int itemPerPage = 10;
                    int curPage = 1;
                    try {
                        curPage = Integer.parseInt(request.getParameter("page"));
                    } catch (Exception ignored) {
                    }

                    int filter = -1;
                    try {
                        filter = Integer.parseInt(request.getParameter("filter"));
                    } catch (Exception ignored) {
                    }

                    String searchQuery = request.getParameter("searchQuery");

                    List<BoardDTO> boardDTOList = boardDAO.getBoardPage(curPage, itemPerPage, filter, searchQuery);

                    Map<String, Object> data = new HashMap<>();

                    data.put("list", boardDTOList);
                    data.put("itemPerPage", itemPerPage);

                    data.put("maxPage", boardDAO.getMaxPage(itemPerPage, filter, searchQuery));
                    data.put("curPage", curPage);
                    data.put("naviPerPage", naviPerPage);
                    data.put("filter", filter);
                    data.put("searchQuery", searchQuery);

                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(gson.toJson(data));
                    break;
                }
                case "/write.board": {
                    long boardCategory = Long.parseLong(request.getParameter("boardCategory"));
                    String writer = request.getParameter("writer");
                    long gameId = Long.parseLong(request.getParameter("gameId"));
                    String title = request.getParameter("title");
                    String contents = request.getParameter("contents");

                    BoardDTO boardDTO = BoardDTO.builder()
                            .boardCategory(boardCategory)
                            .writer(writer)
                            .gameId(gameId)
                            .title(title)
                            .contents(contents)
                            .build();

                    int write = boardDAO.write(boardDTO);
                    response.sendRedirect("/board/writeBoard/writeBoard.jsp");
                    break;
                }
                // 게시글 하나의 아이템에 대한 세부 속성 조회 및 출력
                case "/get_board_detail.board": {
                    long boardId = Long.parseLong(request.getParameter("boardId"));

                    // 게시글 정보
                    BoardDTO detail = boardDAO.getBoardDetail(boardId);
                    
                    //TODO: 댓글 정보
                    
                    //TODO: 작성자 프로필사진 정보

                    request.setAttribute("boardDetail", detail);
                    request.getRequestDispatcher("/board/detailBoard/detailBoard.jsp").forward(request, response);
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
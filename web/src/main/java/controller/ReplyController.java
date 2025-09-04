package controller;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
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
import dto.board.ReplyListDTO;
import util.FileUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("*.reply")
public class ReplyController extends HttpServlet {
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
                case "/write.reply": {
                    Long boardId = Long.parseLong(request.getParameter("boardId"));
                    String contents = request.getParameter("contents");
                    String writer = (String)request.getSession().getAttribute("loginId");

                    replyDAO.writeReply(boardId,contents,writer);
                    break;
                }
                case "/get_reply_list.reply":{
                    Long boardId = Long.parseLong(request.getParameter("boardId"));
                    response.setContentType("text/plain; charset=UTF-8");
                    List<ReplyListDTO> result = replyDAO.getReplyByBoardId(boardId);
                    result.forEach(item -> {
                            try{
                                item.setNickname(memberDAO.getMemberById(item.getWriter()).getNickname());
                            }catch(Exception e){}
                    });

                    response.getWriter().write(gson.toJson(result));
                    break;
                }
                case "/update_reply.reply": {
                    Long id = Long.parseLong(request.getParameter("id"));
                    String contents = request.getParameter("contents");
                    String writer = request.getParameter("writer");
                    if(writer.equals(request.getSession().getAttribute("loginId"))){
                        replyDAO.updateById(id,contents);
                    }

                    break;
                }
                case "/delete_reply.reply": {
                    Long id = Long.parseLong(request.getParameter("id"));
                    String writer = request.getParameter("writer");
                    if(writer.equals(request.getSession().getAttribute("loginId"))){
                        replyDAO.deleteById(id);
                    }
                    break;
                }
                case "/add_report_count.reply": {
                    Long id = Long.parseLong(request.getParameter("id"));
                    replyDAO.plusReportCount(id);
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        doGet(request, response);
    }
}
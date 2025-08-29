package dao.board;

import dto.board.BoardDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class BoardDAO {
    private static BoardDAO instance;

    public static synchronized BoardDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BoardDAO();
        }
        return instance;
    }

    private BoardDAO() throws Exception {
    }

    //region create
    //TODO: 게시글 작성
    public int write(BoardDTO boardDTO)throws Exception{
        String sql = "insert into board values(board_seq.nextval,?,?,?,?,?,default,default,default,default)";

        try (Connection con = DataUtil.getConnection();
        PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, boardDTO.getBoardCategory());
            pstat.setString(2, boardDTO.getWriter());
            pstat.setLong(3, boardDTO.getGameId());
            pstat.setString(4,boardDTO.getTitle());
            pstat.setString(5, boardDTO.getContents());

            return pstat.executeUpdate();
        }
    }
    //endregion

    //region read
    //TODO: 게시글 목록 조회(title, writer 등 대표항목)
    //TODO: 게시글 단일 조회(contents포함 세부항목)
    //endregion

    //region update
    //TODO: 게시글 수정
    //endregion

    //region delete
    //TODO: 게시글 삭제
    //endregion
}

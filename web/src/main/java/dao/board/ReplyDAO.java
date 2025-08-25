package dao.board;

import util.DataUtil;

import java.sql.Connection;

public class ReplyDAO {
    private static ReplyDAO instance;
    private static Connection con;

    public static synchronized ReplyDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new ReplyDAO();
        }
        return instance;
    }

    private ReplyDAO() throws Exception {
        con = DataUtil.getConnection();
    }

    //region create
    //TODO: 댓글 작성
    //endregion

    //region read
    //TODO: 댓글 목록 조회
    //endregion

    //region update
    //TODO: 댓글 내용 수정
    //endregion

    //region delete
    //TODO: 댓글 삭제
    //endregion
}

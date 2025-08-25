package dao.game;

import util.DataUtil;

import java.sql.Connection;

public class GameReplyDAO {
    private static GameReplyDAO instance;
    private static Connection con;

    public static synchronized GameReplyDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new GameReplyDAO();
        }
        return instance;
    }

    private GameReplyDAO() throws Exception {
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

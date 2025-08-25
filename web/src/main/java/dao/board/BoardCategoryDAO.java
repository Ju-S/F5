package dao.board;

import util.DataUtil;

import java.sql.Connection;

public class BoardCategoryDAO {
    private static BoardCategoryDAO instance;
    private static Connection con;

    public static synchronized BoardCategoryDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BoardCategoryDAO();
        }
        return instance;
    }

    private BoardCategoryDAO() throws Exception {
        con = DataUtil.getConnection();
    }

    //region read
    //TODO: 게시글 카테고리 조회용(front출력용), 질문/공략 등
    //endregion
}

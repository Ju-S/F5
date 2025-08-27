package dao.board;

import util.DataUtil;

import java.sql.Connection;

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

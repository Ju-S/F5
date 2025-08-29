package dao.board;

import util.DataUtil;

import java.sql.Connection;

public class BoardFileDAO {
    private static BoardFileDAO instance;

    public static synchronized BoardFileDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BoardFileDAO();
        }
        return instance;
    }

    private BoardFileDAO() throws Exception {
    }

    //region create
    //TODO: 파일 업로드 정보 삽입
    //endregion

    //region read
    //TODO: 파일 업로드 정보 조회
    //endregion

    //region delete
    //TODO: 업로드 된 파일 삭제(controller에서 파일 삭제 필요)
    //endregion
}

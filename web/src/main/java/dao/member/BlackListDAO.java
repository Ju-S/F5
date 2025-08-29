package dao.member;

import util.DataUtil;

import java.sql.Connection;

public class BlackListDAO {
    private static BlackListDAO instance;

    public static synchronized BlackListDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BlackListDAO();
        }
        return instance;
    }

    private BlackListDAO() throws Exception {
    }

    //region create
    //TODO: 블랙리스트 생성
    //endregion

    //region read
    //TODO: 블랙리스트 조회
    //endregion

    //region update
    //TODO: 블랙리스트 수정
    //endregion

    //region delete
    //TODO: 블랙리스트 삭제
    //endregion
}

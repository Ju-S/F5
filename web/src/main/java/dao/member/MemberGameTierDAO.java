package dao.member;

import util.DataUtil;

import java.sql.Connection;

public class MemberGameTierDAO {
    private static MemberGameTierDAO instance;
    private static Connection con;

    public static synchronized MemberGameTierDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new MemberGameTierDAO();
        }
        return instance;
    }

    private MemberGameTierDAO() throws Exception {
        con = DataUtil.getConnection();
    }

    //region create
    //TODO: 회원의 게임 별 티어 등록
    //endregion

    //region read
    //TODO: 회원의 게임 별 티어 조회
    //endregion

    //region update
    //TODO: 게임 점수의 최고점or랭킹 갱신에 따른 티어 수정
    //endregion

    //region delete

    //endregion
}

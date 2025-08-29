package dao.member;

import util.DataUtil;

import java.sql.Connection;

public class MemberDAO {
    private static MemberDAO instance;
    public static synchronized MemberDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }

    private MemberDAO() throws Exception {
    }
    //region create
    //TODO: 아이디 중복검사(true,false 반환)
    //endregion


    //region create
    //TODO: 회원가입
    //endregion

    //region read
    //TODO: 회원 정보 조회
    //TODO: 인자를 가진 회원이 있는지 여부(아이디 중복)
    //endregion

    //region update
    //TODO: 회원 정보 수정
    //endregion

    //region delete
    //TODO: 회원 탈퇴
    //endregion
}

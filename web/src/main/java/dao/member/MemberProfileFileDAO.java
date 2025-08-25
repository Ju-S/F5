package dao.member;

import util.DataUtil;

import java.sql.Connection;

public class MemberProfileFileDAO {
    private static MemberProfileFileDAO instance;
    private static Connection con;

    public static synchronized MemberProfileFileDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new MemberProfileFileDAO();
        }
        return instance;
    }

    private MemberProfileFileDAO() throws Exception {
        con = DataUtil.getConnection();
    }

    //region create
    //TODO: 프로필 사진 등록
    //endregion

    //region read
    //TODO: 프로필 사진 경로 조회
    //endregion

    //region update
    //TODO: 프로필 사진 수정
    //endregion

    //region delete
    //TODO: 프로필 사진 삭제(이 경우에는 null을 삽입하여 기본 이미지로 노출하면 될듯함.)
    //endregion
}

package dao.member;

import dto.member.MemberDTO;
import util.DataUtil;
import util.SecurityUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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


    //아이디 중복 검사
    public boolean isIdExist(String id) throws Exception {
        String sql = "SELECT COUNT(*) FROM member WHERE id = ?";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("dao count값: " + count);
                    return count > 0;
                }
                return false;
            }
        }

    }

    //닉네임 중복 검사
    public boolean isNicknameExist(String nickname) throws Exception {
        String sql = "SELECT COUNT(*) FROM member WHERE nickname = ?";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);){
            ps.setString(1, nickname);
            try (ResultSet rs = ps.executeQuery();) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("dao count값: " + count);
                    return count > 0;
                }
                return false;
            }
        }
    }

    //회원가입
    public int insertMember(MemberDTO dto) throws Exception {
        String sql= "insert into member values(?,?,?,?,?,?,?,?,sysdate)";
        try(Connection conn = DataUtil.getConnection();
            PreparedStatement pstat = conn.prepareStatement(sql);){
            pstat.setString(1, dto.getId());
            pstat.setString(2, dto.getEmail());
            pstat.setString(3, SecurityUtil.encrypt(dto.getPw()));
            pstat.setString(4, dto.getName());
            pstat.setString(5, dto.getNickname());
            pstat.setString(6, dto.getAuthority().name());
            pstat.setInt(7,dto.getBirthyear());
            pstat.setInt(8,dto.getSex());
            return pstat.executeUpdate();
        }
    }

    //로그인 기능
    public boolean isLoginOk(String id,String pw) throws Exception {
        String sql = "select * from member where id = ? and pw = ?";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);){

            ps.setString(1, id);
            ps.setString(2, SecurityUtil.encrypt(pw));
            System.out.println("inDAO"+SecurityUtil.encrypt(pw));

            try (ResultSet rs = ps.executeQuery();) {
                if (rs.next()) {
                    return true;
                }
                return false;
            }
        }
    }



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

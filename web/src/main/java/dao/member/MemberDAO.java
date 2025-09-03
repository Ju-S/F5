package dao.member;

import dto.member.MemberDTO;
import enums.Authority;
import util.DataUtil;
import util.SecurityUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

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

    //region create
    //TODO: 회원가입
    //endregion

    //region read
    //TODO: 회원 정보 조회
    public MemberDTO getMemberById(String id) throws Exception {
        String sql = "select * from member where id=?";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, id);

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return MemberDTO.builder()
                            .id(rs.getString("id"))
                            .pw(rs.getString("pw"))
                            .name(rs.getString("name"))
                            .nickname(rs.getString("nickname"))
                            .email(rs.getString("email"))
                            .authority(Authority.valueOf(rs.getString("authority")))
                            .birthyear(rs.getInt("birthyear"))
                            .sex(rs.getInt("sex"))
                            .joinDate(rs.getTimestamp("join_date"))
                            .build();
                }
            }
        }
        return null;
    }
    //endregion

    //region update
    //TODO: 회원 정보 수정
    public int UpdateMember(MemberDTO dto) throws Exception{
        String sql ="update member set pw=?, name=?, nickname=?, email=?, authority=?, birthyear=?, sex=? where id=?";

        try(Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);)
        {
            pstat.setString(1, dto.getPw());
            pstat.setString(2, dto.getName());
            pstat.setString(3, dto.getNickname());
            pstat.setString(4, dto.getEmail());
            pstat.setString(5, dto.getAuthority().name());
            pstat.setInt(6, dto.getBirthyear());
            pstat.setInt(7, dto.getSex());
            pstat.setTimestamp(8, dto.getJoinDate());
            pstat.setString(9, dto.getId());

            return pstat.executeUpdate();
        }
    }
    //endregion

    //region delete
    //TODO: 회원 탈퇴
    public int deleteDateMember(String id) throws Exception{
        String sql = "delete from member where id=?";

        try(Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);)
        {
            pstat.setString(1, id);
            return pstat.executeUpdate();
        }
    }
    //endregion
}

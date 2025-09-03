package dao.member;

import dto.member.MemberDTO;
import enums.Authority;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class MemberDAO {
    private static MemberDAO instance;

    private MemberDAO() throws Exception {
    }

    public static synchronized MemberDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }
    //region create
    //TODO: 아이디 중복검사(true,false 반환)
    //endregion


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
    //TODO: 인자를 가진 회원이 있는지 여부(아이디 중복)
    public boolean isIdExist(String id) throws Exception{
        String sql ="select id from member where id=?";

        try(Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);){
            pstat.setString(1,id);

            try(ResultSet rs = pstat.executeQuery();){
                return rs.next();
            }
        }
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

package dao.member;

import dto.member.MemberProfileFileDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class MemberProfileFileDAO {
    private static MemberProfileFileDAO instance;

    private MemberProfileFileDAO() throws Exception {
    }

    public static synchronized MemberProfileFileDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new MemberProfileFileDAO();
        }
        return instance;
    }

    //region create
    //프로필 사진 등록
    public int insertProfileImage(MemberProfileFileDTO dto) throws Exception {
        String sql = "INSERT INTO member_profile_file(id, member_id, ori_name, sys_name, upload_date) VALUES(member_profile_file_seq.nextval, ?, ?, ?, sysdate)";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, dto.getMemberId());
            pstat.setString(2, dto.getOriName());
            pstat.setString(3, dto.getSysName());

            return pstat.executeUpdate();
        }
    }

    //endregion

    //region read
    //프로필 사진 경로 저장
    public List<MemberProfileFileDTO> listDateProfileImg() throws Exception {
        String sql = "SELECT * FROM member_profile_file ORDER BY upload_date DESC";
        List<MemberProfileFileDTO> list = new ArrayList<>();

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql); ResultSet rs = pstat.executeQuery()) {

            while (rs.next()) {
                MemberProfileFileDTO dto = MemberProfileFileDTO.builder().id(rs.getLong("id")).memberId(rs.getString("member_id")).oriName(rs.getString("ori_name")).sysName(rs.getString("sys_name")).uploadDate(rs.getTimestamp("upload_date")).build();

                list.add(dto);
            }
        }

        return list;
    }
    //endregion

    //region read
    //프로필 사진 경로 조회
    public MemberProfileFileDTO getProfileImagePath(String memberId) throws Exception {
        String sql = "SELECT id, ori_name, sys_name, upload_date FROM member_profile_file WHERE member_id = ?";
        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, memberId);
            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    long id = rs.getLong("id");
                    String oriName = rs.getString("ori_name");
                    String sysName = rs.getString("sys_name");
                    Timestamp uploadDate = rs.getTimestamp("upload_date");

                    // Builder 방식
                    return MemberProfileFileDTO.builder().id(id) // 또는 DB에서 id 컬럼도 조회하도록 쿼리 수정
                            .memberId(memberId).oriName(oriName).sysName(sysName).uploadDate(uploadDate).build();
                } else {
                    return null;
                }
            }
        }
    }

    //endregion

    //region update
    //프로필 사진 수정
    public int updateProfileImage(MemberProfileFileDTO dto) throws Exception {
        String sql = "UPDATE member_profile_file SET ori_name = ?, sys_name = ?, upload_date = sysdate WHERE member_id = ?";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setString(1, dto.getOriName());
            pstat.setString(2, dto.getSysName());
            pstat.setString(3, dto.getMemberId());

            return pstat.executeUpdate();
        }
    }
    //endregion

    //region delete
    //프로필 사진 삭제(이 경우에는 null을 삽입하여 기본 이미지로 노출하면 될듯함.)
    public int deleteProfileImage(String memberId) throws Exception {
        String sql = "DELETE FROM member_profile_file WHERE member_id = ?";
        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setString(1, memberId);
            return pstat.executeUpdate();
        }
    }
    //endregion
}

package dao.member;

import dto.member.BlackListDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BlackListDAO {
    private static BlackListDAO instance;

    private BlackListDAO() throws Exception {
    }

    public static synchronized BlackListDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BlackListDAO();
        }
        return instance;
    }

    // 블랙리스트 여부 확인
    public boolean isBlacklisted(String memberId) throws Exception {
        String sql = """
        SELECT COUNT(*) 
        FROM black_list 
        WHERE member_id = ? 
          AND start_date <= CURRENT_TIMESTAMP 
          AND end_date >= CURRENT_TIMESTAMP
    """;

        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
                return false;
            }
        }
    }

    // 블랙리스트에 추가
    public int insertBlacklist(BlackListDTO dto) throws Exception {
        String sql = "INSERT INTO black_list (member_id, start_date, end_date) VALUES (?, ?, ?)";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dto.getMemberId());
            ps.setTimestamp(2, dto.getStartDate());
            ps.setTimestamp(3, dto.getEndDate());

            return ps.executeUpdate();
        }
    }

    // 블랙리스트 전체 조회 (관리자 페이지용)
    public List<BlackListDTO> getAllBlacklist() throws Exception {
        String sql = "SELECT * FROM black_list ORDER BY start_date DESC";
        List<BlackListDTO> list = new ArrayList<>();

        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BlackListDTO dto = BlackListDTO.builder()
                        .id(rs.getLong("id"))
                        .memberId(rs.getString("member_id"))
                        .startDate(rs.getTimestamp("start_date"))
                        .endDate(rs.getTimestamp("end_date"))
                        .build();

                list.add(dto);
            }
        }

        return list;
    }


    //region update
    //TODO: 블랙리스트 수정
    //endregion

    // 블랙리스트 삭제
    public int deleteByMemberId(String memberId) throws Exception {
        String sql = "DELETE FROM black_list WHERE member_id = ?";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, memberId);
            return ps.executeUpdate();
        }
    }
}

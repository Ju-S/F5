package dao.admin;

import dto.admin.ReportedPostDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminBoardDAO {
    private static AdminBoardDAO instance;

    private AdminBoardDAO() throws Exception {
    }

    public static synchronized AdminBoardDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new AdminBoardDAO();
        }
        return instance;
    }

    // 신고된 게시글 목록
    public List<ReportedPostDTO> getReportedPosts(int offset, int limit) throws Exception {
        List<ReportedPostDTO> list = new ArrayList<>();

        String sql = "SELECT id, title, writer, write_date, report_count " +
                "FROM (" +
                "    SELECT ROW_NUMBER() OVER (ORDER BY report_count DESC, write_date DESC) AS rn, " +
                "           id, title, writer, write_date, report_count " +
                "    FROM board " +
                "    WHERE report_count > 0" +
                ") " +
                "WHERE rn BETWEEN ? AND ?";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
            pstat.setInt(1, offset);
            pstat.setInt(2, limit);

            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    ReportedPostDTO dto = new ReportedPostDTO();
                    dto.setId(rs.getLong("id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setNickname(rs.getString("writer"));
                    dto.setReportDate(rs.getTimestamp("write_date").toString());
                    dto.setReportCount(rs.getInt("report_count"));

                    list.add(dto);
                }
            }
        }

        return list;
    }

    // 신고된 게시글 총 개수 조회 (페이지네이션용)
    public int getReportedPostsCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM board WHERE report_count > 0";
        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);
             ResultSet rs = pstat.executeQuery();) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // 신고된 게시글 단건 조회 (상세 보기용)
    public ReportedPostDTO getReportedPostById(long id) throws Exception {
        String sql = "SELECT id, title, writer, write_date, report_count, contents " +
                "FROM board WHERE id = ? AND report_count > 0";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setLong(1, id);

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    ReportedPostDTO dto = new ReportedPostDTO();
                    dto.setId(rs.getLong("id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setNickname(rs.getString("writer"));
                    dto.setReportDate(rs.getTimestamp("write_date").toString());
                    dto.setReportCount(rs.getInt("report_count"));
                    dto.setContents(rs.getString("contents"));
                    return dto;
                }
            }
        }

        return null; // 게시글 없거나 신고된 상태 아니면 null
    }


}

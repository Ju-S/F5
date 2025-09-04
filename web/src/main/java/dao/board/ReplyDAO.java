package dao.board;

import dto.board.ReplyDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReplyDAO {
    private static ReplyDAO instance;

    private ReplyDAO() throws Exception {
    }

    public static synchronized ReplyDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new ReplyDAO();
        }
        return instance;
    }

    //region create
    //TODO: 댓글 작성
    public int writeReply(Long boardId, String contents, String writer) throws Exception {
        String sql = "INSERT INTO reply values(reply_seq.nextval,?,?,default,default,default, ?)";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setLong(1, boardId);
            pstat.setString(2, contents);
            pstat.setString(3, writer);
            return pstat.executeUpdate();
        }
    }
    //endregion

    //region read
    //TODO: 댓글 목록 조회
    public List<ReplyDTO> getReplyByBoardId(Long boardId) throws Exception {
        String sql = "SELECT * FROM reply WHERE board_id = ?";
        List<ReplyDTO> list = new ArrayList<>();
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, boardId);
            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    list.add(ReplyDTO.builder()
                            .id(rs.getLong("id"))
                            .writer(rs.getString("writer"))
                            .contents(rs.getString("contents"))
                            .likeCount(rs.getLong("like_count"))
                            .writeDate(rs.getTimestamp("write_date"))
                            .reportCount(rs.getLong("report_count"))
                            .build());
                }
            }
        }
        return list;
    }

    public int getReplyCountByBoardId(Long boardId) throws Exception {
        String sql = "SELECT count(*) FROM reply WHERE board_id = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, boardId);
            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public int getReportCountByReplyId(Long replyId) throws Exception {
        String sql = "SELECT report_count FROM reply WHERE id=?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, replyId);
            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    //endregion

    //region update
    //TODO: 댓글 내용 수정
    public int updateById(Long id, String contents) throws Exception {
        String sql = "UPDATE reply SET contents = ? WHERE id = ?";
        try (Connection con = DataUtil.getConnection();
        PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, contents);
            pstat.setLong(2, id);
            return pstat.executeUpdate();
        }
    }

    public void plusReportCount(Long id) throws Exception{
        String sql = "UPDATE reply SET report_count=? WHERE id=?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, getReportCountByReplyId(id) + 1);
            pstat.setLong(2, id);
            pstat.executeUpdate();
        }
    }
    //endregion

    //region delete
    //TODO: 댓글 삭제
    public int deleteById(Long id) throws Exception {
        String sql = "DELETE FROM reply WHERE id = ?";
        try (Connection con = DataUtil.getConnection();
        PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, id);
            return pstat.executeUpdate();
        }
    }
    //endregion

    // ReplyDAO.java
    // 페이징 쿼리 예시: Oracle의 경우 ROWNUM 이용, MySQL은 LIMIT, OFFSET 활용
    public List<ReplyDTO> getRepliesByBoardId(long boardId, int offset, int limit) {
        String sql = "SELECT * FROM (" +
                "   SELECT R.*, ROW_NUMBER() OVER (ORDER BY write_date DESC) rn" +
                "   FROM reply R WHERE board_id = ?" +
                ") WHERE rn BETWEEN ? AND ?";
        List<ReplyDTO> list = new ArrayList<>();
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setLong(1, boardId);
            pstat.setInt(2, offset);
            pstat.setInt(3, limit);

            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    ReplyDTO dto = ReplyDTO.builder()
                            .id(rs.getLong("id"))
                            .boardId(rs.getLong("board_id"))
                            .writer(rs.getString("writer"))
                            .contents(rs.getString("contents"))
                            .likeCount(rs.getInt("like_count"))
                            .writeDate(rs.getTimestamp("write_date"))
                            .reportCount(rs.getInt("reprt_count"))
                            .build();
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 관리자 댓글 총 개수
    public int getReplyCountByBoardId(long boardId) {
        String sql = "SELECT COUNT(*) FROM reply WHERE board_id = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setLong(1, boardId);

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


    // 관리자 댓글 삭제
    public boolean deleteReply(long id) {
        String sql = "DELETE FROM reply WHERE id = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setLong(1, id);
            int result = pstat.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


}

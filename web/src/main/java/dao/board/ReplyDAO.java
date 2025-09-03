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

    public static synchronized ReplyDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new ReplyDAO();
        }
        return instance;
    }

    private ReplyDAO() throws Exception {
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
}

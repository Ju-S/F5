package dao.board;

import dto.admin.ReportedPostDTO;
import dto.board.BoardDTO;
import dto.board.BoardListDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private static BoardDAO instance;

    private BoardDAO() throws Exception {
    }

    public static synchronized BoardDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BoardDAO();
        }
        return instance;
    }

    //region create
    //TODO: 게시글 작성
    public int write(BoardDTO boardDTO) throws Exception {
        String sql = "insert into board values(board_seq.nextval,?,?,?,?,?,default,default,default,default)";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, boardDTO.getBoardCategory());
            pstat.setString(2, boardDTO.getWriter());
            pstat.setLong(3, boardDTO.getGameId());
            pstat.setString(4, boardDTO.getTitle());
            pstat.setString(5, boardDTO.getContents());

            return pstat.executeUpdate();
        }
    }
    //endregion

    //region read
    //TODO: 게시글 목록 조회(title, writer 등 대표항목)
    public List<BoardListDTO> getBoardPage(int curPage, int itemPerPage, int filter, String searchQuery, int gameId) throws Exception {
        String sql = "SELECT * FROM (SELECT board.*, ROW_NUMBER() OVER(ORDER BY id DESC) rn FROM board";
        if (filter != -1) {
            sql += " WHERE board_category = ?";
            if (searchQuery != null) {
                sql += " AND ";
            }
        } else if (searchQuery != null) {
            sql += " WHERE ";
        }
        if (searchQuery != null) {
            sql += "title LIKE ?";
            if (gameId != -1) {
                sql += " AND ";
            }
        } else if (gameId != -1) {
            sql += " WHERE ";
        }
        if (gameId != -1) {
            sql += "game_id=?";
        }
        sql += ") WHERE rn BETWEEN ? AND ?";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            int parameterIndex = 1;
            if (filter != -1) {
                pstat.setInt(parameterIndex++, filter);
            }
            if (searchQuery != null) {
                pstat.setString(parameterIndex++, "%" + searchQuery + "%");
            }
            if (gameId != -1) {
                pstat.setInt(parameterIndex++, gameId);
            }
            pstat.setInt(parameterIndex++, curPage * itemPerPage - (itemPerPage - 1));
            pstat.setInt(parameterIndex, curPage * itemPerPage);

            try (ResultSet rs = pstat.executeQuery()) {
                return getBoardListByResultSet(rs);
            }
        }
    }

    // board의 resultSet을 boardDTO타입의 List로 변환.
    private List<BoardListDTO> getBoardListByResultSet(ResultSet rs) throws Exception {
        List<BoardListDTO> posts = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            long boardCategory = rs.getLong("board_category");
            long gameId = rs.getLong("game_id");
            String writer = rs.getString("writer");
            String title = rs.getString("title");
            String contents = rs.getString("contents");
            Timestamp writeDate = rs.getTimestamp("write_date");
            int viewCount = rs.getInt("view_count");
            posts.add(BoardListDTO.builder()
                    .id(id)
                    .boardCategory(boardCategory)
                    .gameId(gameId)
                    .writer(writer)
                    .title(title)
                    .contents(contents)
                    .writeDate(writeDate)
                    .viewCount(viewCount)
                    .build());
        }
        return posts;
    }

    public int getMaxPage(int itemPerPage, int filter, String searchQuery, int gameId) throws Exception {
        String sql = "SELECT count(*) FROM board";
        if (filter != -1) {
            sql += " WHERE board_category = ?";
            if (searchQuery != null) {
                sql += " AND ";
            }
        } else if (searchQuery != null) {
            sql += " WHERE ";
        }
        if (searchQuery != null) {
            sql += "title LIKE ?";
            if (gameId != -1) {
                sql += " AND ";
            }
        } else if (gameId != -1) {
            sql += " WHERE ";
        }
        if (gameId != -1) {
            sql += "game_id=?";
        }

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            int parameterIndex = 1;

            if (filter != -1) {
                pstat.setInt(parameterIndex++, filter);
            }
            if (searchQuery != null) {
                pstat.setString(parameterIndex++, "%" + searchQuery + "%");
            }
            if (gameId != -1) {
                pstat.setInt(parameterIndex, gameId);
            }

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return (rs.getInt(1) - 1) / itemPerPage + 1;
                }
                return 0;
            }
        }
    }

    //게시글 단일 조회(contents포함 세부항목)
    public BoardListDTO getBoardDetail(long boardId) throws Exception {
        String sql = "SELECT * FROM BOARD WHERE id = ?";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, boardId);
            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return BoardListDTO.builder()
                            .id(rs.getLong("id"))
                            .title(rs.getString("title"))
                            .writer(rs.getString("writer"))
                            .contents(rs.getString("contents"))
                            .writeDate(rs.getTimestamp("write_date"))
                            .gameId(rs.getLong("game_id"))
                            .boardCategory(rs.getLong("board_category"))
                            .build();
                }
                return null;
            }
        }
    }

    public int getReportCountByBoardId(Long boardId) throws Exception {
        String sql = "SELECT report_count FROM board WHERE id=?";
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

    public int getViewCountByBoardId(Long boardId) throws Exception {
        String sql = "SELECT view_count FROM board WHERE id=?";
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
    //endregion

    //region update
    //게시글 수정
    public int updateBoard(BoardDTO boardDTO) throws Exception {
        String sql = "update board set title=?,game_id=?,board_category=?,contents=? where id=?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, boardDTO.getTitle());
            pstat.setLong(2, boardDTO.getGameId());
            pstat.setLong(3, boardDTO.getBoardCategory());
            pstat.setString(4, boardDTO.getContents());
            pstat.setLong(5, boardDTO.getId());
            return pstat.executeUpdate();
        }
    }

    public void plusReportCount(Long id) throws Exception {
        String sql = "UPDATE board SET report_count=? WHERE id=?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, getReportCountByBoardId(id) + 1);
            pstat.setLong(2, id);
            pstat.executeUpdate();
        }
    }

    public void plusViewCount(Long id) throws Exception {
        String sql = "UPDATE board SET view_count=? WHERE id=?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, getViewCountByBoardId(id) + 1);
            pstat.setLong(2, id);
            pstat.executeUpdate();
        }
    }
    //endregion

    //region delete
    //TODO: 게시글 삭제
    public int deleteBoard(Long boardId) throws Exception {
        String sql = "delete from board where id = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, boardId);
            return pstat.executeUpdate();
        }
    }
    //endregion

    // 관리자 - 신고 게시글 목록 조회
    public List<ReportedPostDTO> getReportedPosts(int offset, int limit) throws Exception {
        String sql = "SELECT * FROM (" +
                "  SELECT ROWNUM rn, sub.* FROM (" +
                "    SELECT id, title, writer, write_date, report_count " +
                "    FROM board " +
                "    WHERE report_count > 0 " +
                "    ORDER BY report_count DESC, write_date DESC" +
                "  ) sub" +
                ") WHERE rn BETWEEN ? AND ?";

        List<ReportedPostDTO> list = new ArrayList<>();

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setInt(1, offset); // 예: 1, 11, 21 ...
            pstat.setInt(2, limit);  // 예: 10, 20, 30 ...

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

    // 관리자 - 신고 게시글 조회
    public int getReportedPostsCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM board WHERE report_count > 0";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql);
             ResultSet rs = pstat.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }

    // 관리자 - 삭제할 아이디
    public void deletePost(long id) throws Exception {
        String sql = "DELETE FROM board WHERE id = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, id);
            pstat.executeUpdate();
        }
    }

}

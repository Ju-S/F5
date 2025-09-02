package dao.board;

import dto.board.BoardDTO;
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
    public List<BoardDTO> getBoardPage(int curPage, int itemPerPage, int filter, String searchQuery) throws Exception {
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
            pstat.setInt(parameterIndex++, curPage * itemPerPage - (itemPerPage - 1));
            pstat.setInt(parameterIndex, curPage * itemPerPage);

            try (ResultSet rs = pstat.executeQuery()) {
                return getBoardListByResultSet(rs);
            }
        }
    }

    // board의 resultSet을 boardDTO타입의 List로 변환.
    private List<BoardDTO> getBoardListByResultSet(ResultSet rs) throws Exception {
        List<BoardDTO> posts = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String writer = rs.getString("writer");
            String title = rs.getString("title");
            String contents = rs.getString("contents");
            Timestamp writeDate = rs.getTimestamp("write_date");
            int viewCount = rs.getInt("view_count");
            posts.add(BoardDTO.builder()
                    .id(id)
                    .writer(writer)
                    .title(title)
                    .contents(contents)
                    .writeDate(writeDate)
                    .viewCount(viewCount)
                    .build());
        }
        return posts;
    }

    public int getMaxPage(int itemPerPage, int filter, String searchQuery) throws Exception {
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
        }

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            int parameterIndex = 1;

            if (filter != -1) {
                pstat.setInt(parameterIndex++, filter);
            }
            if (searchQuery != null) {
                pstat.setString(parameterIndex, "%" + searchQuery + "%");
            }

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return (rs.getInt(1) - 1) / itemPerPage + 1;
                }
                return 0;
            }
        }
    }

    //TODO: 게시글 단일 조회(contents포함 세부항목)
    public BoardDTO getBoardDetail(long boardId) throws Exception {
        String sql = "SELECT * FROM BOARD WHERE id = ?";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, boardId);
            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return BoardDTO.builder()
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
    //endregion

    //region update
    //TODO: 게시글 수정
    //endregion

    //region delete
    //TODO: 게시글 삭제
    //endregion
}

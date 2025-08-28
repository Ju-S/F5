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
    private static Connection con;

    public static synchronized BoardDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BoardDAO();
        }
        return instance;
    }

    private BoardDAO() throws Exception {
        con = DataUtil.getConnection();
    }

    //region create
    //TODO: 게시글 작성
    //endregion

    //region read
    //TODO: 게시글 목록 조회(title, writer 등 대표항목)
    public List<BoardDTO> getBoardPage(int curPage, int itemPerPage) throws Exception {
        String sql = "SELECT * FROM (SELECT board.*, ROW_NUMBER() OVER(ORDER BY id DESC) rn FROM board) WHERE rn BETWEEN ? AND ?";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setInt(1, curPage * itemPerPage - (itemPerPage - 1));
            pstat.setInt(2, curPage * itemPerPage);
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
                            .writeDate(writeDate.toLocalDateTime())
                            .viewCount(viewCount)
                            .build());
        }
        return posts;
    }

    public int getMaxPage(int itemPerPage) throws Exception {
        String sql = "SELECT count(*) FROM board";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql);
             ResultSet rs = pstat.executeQuery()) {
            if (rs.next()) {
                return (rs.getInt(1) - 1) / itemPerPage + 1;
            }
            return 0;
        }
    }

    //TODO: 게시글 단일 조회(contents포함 세부항목)
    //endregion

    //region update
    //TODO: 게시글 수정
    //endregion

    //region delete
    //TODO: 게시글 삭제
    //endregion
}

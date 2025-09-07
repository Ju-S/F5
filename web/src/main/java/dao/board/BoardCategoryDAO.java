package dao.board;

import dto.admin.ReportedPostDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardCategoryDAO {
    private static BoardCategoryDAO instance;

    private BoardCategoryDAO() throws Exception {
    }

    public static synchronized BoardCategoryDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BoardCategoryDAO();
        }
        return instance;
    }

    //region read
    //TODO: 게시글 카테고리 조회용(front출력용), 질문/공략 등
    public String getBoardCategoryNameById(long id) throws Exception {
        String sql = "SELECT name FROM board_category WHERE id=?";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setLong(1, id);
            try(ResultSet rs = pstat.executeQuery()){
                if(rs.next()) {
                    return rs.getString(1);
                }
                return "";
            }
        }
    }
    //endregion
}

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

    public static synchronized BoardCategoryDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new BoardCategoryDAO();
        }
        return instance;
    }

    private BoardCategoryDAO() throws Exception {
    }

    //region read
    //TODO: 게시글 카테고리 조회용(front출력용), 질문/공략 등
    //endregion


}

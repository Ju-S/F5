package dao.game;

import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class GameDAO {
    private static GameDAO instance;
    private static Connection con;

    public static synchronized GameDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new GameDAO();
        }
        return instance;
    }

    private GameDAO() throws Exception {
        con = DataUtil.getConnection();
    }




    //region read
    //TODO: 등록된 게임 정보 조회
    //endregion
}

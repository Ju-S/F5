package dao.game;

import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class GameDAO {
    private static GameDAO instance;

    public static synchronized GameDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new GameDAO();
        }
        return instance;
    }

    private GameDAO() throws Exception {
    }




    //region read
    //TODO: 등록된 게임 정보 조회
    //endregion
}

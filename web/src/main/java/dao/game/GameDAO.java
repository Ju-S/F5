package dao.game;

import dto.game.GameDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
    public String getGameName(long id) throws Exception {
       String sql = "SELECT name FROM game WHERE id=?";

        try( Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql);){
            pstat.setLong(1, id);
            try(ResultSet rs = pstat.executeQuery();) {
                if(rs.next()) {
                    return rs.getString("name");
                }
                return "";
            }
        }
    }
    //endregion
}

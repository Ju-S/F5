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
    public List<GameDTO> sellectGame() throws Exception {


       String sql = "select * from GAME";


        //TODO: 등록된 게임 정보 조회
        try( Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql);

             ResultSet rs = pstat.executeQuery();){
            List<GameDTO> gameList = new ArrayList<>();

            while(rs.next()){

               int id  = rs.getInt(rs.getInt("id"));
               String name = rs.getString("name");
               String description = rs.getString("description");
                GameDTO dto = new GameDTO(id,name,description);
                gameList.add(dto);
            }
           return (gameList);
        }
    }
    //endregion
}

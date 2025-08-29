package dao.game;

import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class GameScoreDAO {
    private static GameScoreDAO instance;

    public static synchronized GameScoreDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new GameScoreDAO();
        }
        return instance;
    }

    private GameScoreDAO() throws Exception {
    }

    public int insert_score(int score) throws Exception{
        String sql = "INSERT INTO game_score (id,game_id, member_id, score) VALUES (GAME_SCORE_SEQ.nextval,2, 'one', ?)";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql))
        {   pstat.setInt(1, score);
            return pstat.executeUpdate();
        }

    }



    public int insert_tier(String tier) throws Exception{ // 랭킹출력
        //region create
        //TODO: 점수를 티어로 변환하여 정보를 tier에 넣기
        //endregion


        String sql = "insert into member_game_tier values (member_GAME_TIER_SEQ.nextval,2,3,?)";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql))
        {   pstat.setString(1, tier);
            return pstat.executeUpdate();
        }

    }


        public int select_ranking() throws Exception{ // 랭킹출력
        //region create
        //TODO: 랭킹출력
        //endregion


            String sql = "SELECT game_score.*, member_game_tier.tier " +
                    "FROM game_score game_score " +
                    "JOIN member_game_tier mgt ON gs.member_id = mgt.member_id";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql))
        {
            return pstat.executeUpdate();
        }

    }
    //region create
    //TODO: 게임 점수 등록
    //endregion

    //region read
    //TODO: 게임 점수 조회
    //TODO: 유저(중복 금지)의 최고점을 기준으로 랭킹조회
    //endregion

    //region update

    //endregion

    //region delete

    //endregion
}

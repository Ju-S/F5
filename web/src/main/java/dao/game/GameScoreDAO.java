package dao.game;

import dto.game.GameScoreDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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


    //region create
    public int insert_score(int score) throws Exception{// 점수 등록
        //TODO: 게임 점수 등록

        String sql = "INSERT INTO game_score (id,game_id, member_id, score) VALUES (GAME_SCORE_SEQ.nextval,3, 'MIN', ?)";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql))
        {   pstat.setInt(1, score);
            return pstat.executeUpdate();
        }

    }
    //endregion




    //region create

    public int insert_tier(String tier) throws Exception{ // 티어 구분

        //TODO: 점수를 티어로 변환하여 정보를 tier에 넣기
        String sql = "insert into member_game_tier values (member_GAME_TIER_SEQ.nextval,'MIN',3,?)";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql))
        {   pstat.setString(1, tier);
            return pstat.executeUpdate();
        }

    }
    //endregion



    //region create

    public List<GameScoreDTO> selectRanking(int game_id) throws Exception {

        //TODO: 유저(중복 금지)의 최고점 및 최고 티어 순으로 랭킹조회

        String sql =
                "SELECT *\n" +
                        "FROM (\n" +
                        "    SELECT MEMBER_ID, SCORE, TIER,\n" +
                        "           DENSE_RANK() OVER (ORDER BY SCORE DESC) AS RANKING\n" +
                        "    FROM (\n" +
                        "        SELECT GS.MEMBER_ID, GS.SCORE, MGT.TIER\n" +
                        "        FROM (\n" +
                        "            SELECT MEMBER_ID, GAME_ID, SCORE,\n" +
                        "                   ROW_NUMBER() OVER (PARTITION BY MEMBER_ID ORDER BY SCORE DESC) AS RN_MEMBER\n" +
                        "            FROM GAME_SCORE\n" +
                        "            WHERE GAME_ID = ?\n" +
                        "        ) GS\n" + // GAME_SCORE 테이블 컬럼 GS
                        "        JOIN (\n" +
                        "            SELECT MEMBER_ID, GAME_ID, TIER,\n" +
                        "                   ROW_NUMBER() OVER (\n" +
                        "                       PARTITION BY MEMBER_ID, GAME_ID \n" + // MEMBER_ID와 GAME_ID의 조합별로 그룹을 나누고, 그 그룹 안에서 ORDER BY에 따라 번호를 매김.
                        "                       ORDER BY CASE TIER\n" +  // 각 티어별로 번호를 매김
                        "                                WHEN 'GOLD' THEN 3\n" +
                        "                                WHEN 'SILVER' THEN 2\n" +
                        "                                WHEN 'BRONZE' THEN 1\n" +
                        "                                ELSE 0\n" +
                        "                       END DESC\n" +
                        "                   ) AS RN_TIER\n" +
                        "            FROM MEMBER_GAME_TIER\n" +
                        "            WHERE GAME_ID = ?\n" +
                        "        ) MGT\n" + // MEMBER_GAME_TIER 컬럼 MGT
                        "        ON GS.MEMBER_ID = MGT.MEMBER_ID AND GS.GAME_ID = MGT.GAME_ID\n" +
                        "        WHERE GS.RN_MEMBER = 1 AND MGT.RN_TIER = 1\n" +  // 각 유저의 최고점수,최고티어 만 추출
                        "    )\n" +
                        ") FINAL\n" +
                        "WHERE RANKING <= 20\n" + // 랭킹 20번까지
                        "ORDER BY RANKING\n"; //랭킹번호 낮은순

        List<GameScoreDTO> rankings = new ArrayList<>();

        try(Connection con = DataUtil.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setInt(1, game_id); // for GAME_SCORE
            pstat.setInt(2, game_id); // for MEMBER_GAME_TIER

            try (ResultSet rs = pstat.executeQuery()) {

                while (rs.next()) {
                    GameScoreDTO dto = new GameScoreDTO();
                    dto.setMemberId(rs.getString("MEMBER_ID"));
                    dto.setScore(rs.getLong("SCORE"));
                    dto.setTier(rs.getString("TIER"));
                    dto.setRank(rs.getInt("RANKING")); // 컬럼명 대문자
                    rankings.add(dto);
                }
            }
        }
        return rankings;
    }

    //endregion




    //region read
    //TODO: 게임 점수 조회

    //endregion

    //region update

    //endregion

    //region delete

    //endregion
}

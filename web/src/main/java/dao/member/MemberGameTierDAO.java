package dao.member;

import dto.game.GameScoreDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MemberGameTierDAO {
    private static MemberGameTierDAO instance;

    private MemberGameTierDAO() throws Exception {
    }

    public static synchronized MemberGameTierDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new MemberGameTierDAO();
        }
        return instance;
    }

    //region create
    //TODO: 회원의 게임 별 티어 등록
    //endregion

    //region read
    //TODO: 회원의 게임 별 티어 조회
    //endregion

    //region update
    //TODO: 게임 점수의 최고점or랭킹 갱신에 따른 티어 수정
    //endregion

    //region delete
    // 모든 게임의 랭킹
    // (string id, int game id)id => 게임별로 오더바이 => id 랭킹 가져요는 식
    public Map<Integer, List<GameScoreDTO>> selectAllGameRankings(String loginId) throws Exception {
        String sql = """
                    SELECT *
                    FROM (
                        SELECT 
                            gs.game_id,
                            gs.member_id,
                            gs.score,
                            mgt.tier,
                            DENSE_RANK() OVER (
                                PARTITION BY gs.game_id 
                                ORDER BY gs.score DESC
                            ) AS ranking
                        FROM (
                            SELECT 
                                member_id, 
                                game_id, 
                                score,
                                ROW_NUMBER() OVER (
                                    PARTITION BY member_id, game_id 
                                    ORDER BY score DESC
                                ) AS rn
                            FROM game_score
                            WHERE member_id = ?
                        ) gs
                        JOIN (
                            SELECT 
                                member_id, 
                                game_id, 
                                tier,
                                ROW_NUMBER() OVER (
                                    PARTITION BY member_id, game_id
                                    ORDER BY CASE 
                                        WHEN tier = 'GOLD' THEN 3
                                        WHEN tier = 'SILVER' THEN 2
                                        WHEN tier = 'BRONZE' THEN 1
                                        ELSE 0
                                    END DESC
                                ) AS rn
                            FROM member_game_tier
                            WHERE member_id = ?
                        ) mgt
                        ON gs.member_id = mgt.member_id 
                        AND gs.game_id = mgt.game_id
                        WHERE gs.rn = 1 AND mgt.rn = 1
                    ) ranked
                    WHERE ranking <= 20
                    ORDER BY game_id, ranking
                """;

        Map<Integer, List<GameScoreDTO>> gameRankings = new LinkedHashMap<>();

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, loginId);
            pstat.setString(2, loginId);
            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    GameScoreDTO dto = GameScoreDTO.builder()
                            .gameId(rs.getInt("game_id"))
                            .memberId(rs.getString("member_id"))
                            .score(rs.getLong("score"))
                            .tier(rs.getString("tier"))
                            .rank(rs.getInt("ranking"))
                            .build();

                    gameRankings.computeIfAbsent((int) dto.getGameId(), k -> new ArrayList<>()).add(dto);
                }
            }
        }

        return gameRankings;
    }
    //endregion
}

package dao.game;

import util.DataUtil;

import java.sql.Connection;

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

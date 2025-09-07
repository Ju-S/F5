package dao.game;

import dto.game.GameReplyDTO;
import util.DataUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class GameReplyDAO {
    private static GameReplyDAO instance;

    private GameReplyDAO() throws Exception {
    }

    public static synchronized GameReplyDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new GameReplyDAO();
        }
        return instance;
    }

    //region create
    public int insertReply(int game_id, String writer, String contents) throws Exception { // 댓글 입력
        //TODO: 댓글 작성 : sql에 데이터값 옮기기 완료
        String sql = "insert into game_reply (id, game_id,writer, contents, write_date) values (GAME_REPLY_SEQ.nextval, ?, ?, ?, sysdate)";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)
        ) {
            pstat.setInt(1, game_id);
            pstat.setString(2, writer);
            pstat.setString(3, contents);

            return pstat.executeUpdate();
        }
    }
//endregion

    //region read
    public List<GameReplyDTO> selectAll(int GAME_ID) throws Exception { // 댓글 목록 출력
        //TODO: 댓글 목록 조회
        String sql = "SELECT gr.*, t.tier\n" +
                "FROM game_reply gr\n" +
                "LEFT JOIN (\n" +
                "    SELECT *\n" +
                "    FROM (\n" +
                "        SELECT member_id, game_id, tier,\n" +
                "               ROW_NUMBER() OVER (\n" +
                "                   PARTITION BY member_id, game_id\n" +
                "                   ORDER BY CASE tier\n" +
                "                       WHEN '/game/img/gold.png' THEN 3\n" +
                "                       WHEN '/game/img/silver.png' THEN 2\n" +
                "                       WHEN '/game/img/bronze.png' THEN 1\n" +
                "                       ELSE 0\n" +
                "                   END DESC\n" +
                "               ) AS rn\n" +
                "        FROM member_game_tier\n" +
                "    ) \n" +
                "    WHERE rn = 1\n" +
                ") t\n" +
                "ON gr.writer = t.member_id AND gr.game_id = t.game_id\n" +
                "WHERE gr.game_id = ?\n" +
                "ORDER BY gr.id DESC\n";

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setInt(1, GAME_ID); // for GAME_REPLY


            try (ResultSet rs = pstat.executeQuery()) {
                List<GameReplyDTO> list = new ArrayList<>();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    int game_id = rs.getInt("game_id");
                    String writer = rs.getString("writer");
                    String contents = rs.getString("contents");
                    Timestamp write_date = rs.getTimestamp("write_date");
                    int report_count = rs.getInt("report_count");
                    String tier = rs.getString("tier");

                    if (tier == null) { // tier 값이 null 일경우 unraked.png로 대체
                        tier = "/game/img/unranked.png";
                    }

                    GameReplyDTO dto = GameReplyDTO.builder()
                            .id(id)
                            .gameId(game_id)
                            .writer(writer)
                            .contents(contents)
                            .writeDate(write_date)
                            .report_count(report_count)
                            .tier(tier)
                            .build();
                    list.add(dto);
                }
                return (list);
            }
        }
    }
//endregion

    //region update
    public int updateReply(String contents, String writer, int id) throws Exception {
        //loginId를 받아서 writer 버튼 보이게 코드 수정할 이후에는 writer 빼도 무방
        //TODO: 댓글 내용 수정
        String sql = "update game_reply set contents = ?  where writer = ? and id = ? ";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, contents);
            pstat.setString(2, writer);
            pstat.setInt(3, id);
            return pstat.executeUpdate();
        }
    }
    //endregion


    //region delete
    public int deleteReply(String writer, int id) throws Exception {
        //loginId를 받아서 writer 버튼 보이게 코드 수정할 이후에는 writer 빼도 무방
        //TODO: 댓글 삭제

        String sql = "delete from game_reply  where writer = ? and id = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, writer);
            pstat.setInt(2, id);
            return pstat.executeUpdate();
        }
    }

    //region delete
    public int insertReportCount(String writer, int report_count) throws Exception {
        //TODO: 신고카운트 증가 (작성자기준)
        String sql = "update game_reply set report_count = report_count + 1 where writer = ? and report_count = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, writer);
            pstat.setInt(2, report_count);
            return pstat.executeUpdate();
        }
    }

    //endregion


}

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

    public static synchronized GameReplyDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new GameReplyDAO();
        }
        return instance;
    }

    private GameReplyDAO() throws Exception {
    }

    //region create
    public int insert_reply(int game_id, String writer , String contents) throws Exception{ // 댓글 입력

        //TODO: 댓글 작성 : sql에 데이터값 옮기기 완료

        //game_id는 게임종류별 id받아야함 실행을위해 임시 GAME_REPLY_SEQ 사용


      String sql = "insert into game_reply (id, game_id,writer, contents, write_date) values (GAME_REPLY_SEQ.nextval, ?, ?, ?, sysdate)";


        try( Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql);
        ){

            pstat.setInt(1, game_id);
            pstat.setString(2, writer);
            pstat.setString(3, contents);

            return pstat.executeUpdate();
        }

    }
//endregion

    //region read
    public List<GameReplyDTO> selectAll(int GAME_ID) throws Exception{ // 댓글 목록 출력

        //TODO: 댓글 목록 조회

        String sql = "select gr.*, mgt.tier\n" +
                "from game_reply gr\n" +
                "left join member_game_tier mgt\n" +
                "on gr.writer = mgt.member_id and gr.game_id = mgt.game_id\n" +
                "where gr.game_id = ?\n" +
                "order by gr.id desc\n";

        try(Connection con = DataUtil.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql)){

            pstat.setInt(1, GAME_ID); // for GAME_REPLY


            try(ResultSet rs = pstat.executeQuery()){
                List<GameReplyDTO> list = new ArrayList<>();
                while(rs.next()){
                    int id = rs.getInt("id");
                    int game_id = rs.getInt("game_id");
                    String writer = rs.getString("writer");
                    String contents = rs.getString("contents");
                    Timestamp write_date = rs.getTimestamp("write_date");
                    String tier = rs.getString("tier");
                    GameReplyDTO dto = new GameReplyDTO(id,game_id,writer,contents,write_date,tier);
                    list.add(dto);
                }
                return(list);
            }
        }
    }
//endregion

    //region update
    public int updateReply(String contents,Timestamp write_date) throws Exception {
        //TODO: 댓글 내용 수정
        String sql = "update game_reply set contents = ?  where write_date = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, contents);
            pstat.setTimestamp(2, write_date);
            return pstat.executeUpdate();
        }
    }
    //endregion


    //region delete
    public int deleteReply(Timestamp write_date) throws Exception {
        //TODO: 댓글 삭제
        String sql = "delete from game_reply where write_date = ?";
        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setTimestamp(1, write_date);
            return pstat.executeUpdate();
        }
    }
    //endregion








}

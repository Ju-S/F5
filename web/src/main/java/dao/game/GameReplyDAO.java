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
    public int insertReply(int game_id, String writer , String contents) throws Exception{ // 댓글 입력

        //TODO: 댓글 작성 : sql에 데이터값 옮기기 완료



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
                    int report_count = rs.getInt("report_count");
                    String tier = rs.getString("tier");
                    GameReplyDTO dto = new GameReplyDTO(id,game_id,writer,contents,write_date, report_count, tier);
                    list.add(dto);
                }
                return(list);
            }
        }
    }
//endregion

    //region update
    public int updateReply(String contents,String writer , int id) throws Exception {
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
    public int deleteReply(String writer , int id) throws Exception {
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
    public int insertReportCount(String writer , int report_count) throws Exception {
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

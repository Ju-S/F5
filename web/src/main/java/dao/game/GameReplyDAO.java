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
    public List<GameReplyDTO> selectAll() throws Exception{ // 댓글 목록 출력

        //TODO: 댓글 목록 조회

        String sql = "select * from game_reply order by id desc";

        try(Connection con = DataUtil.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
        ){

            try(ResultSet rs = pstat.executeQuery()){
                List<GameReplyDTO> list = new ArrayList<>();
                while(rs.next()){
                    int id = rs.getInt("id");
                    int game_id = rs.getInt("game_id");
                    String writer = rs.getString("writer");
                    String contents = rs.getString("contents");
                    Timestamp write_date = rs.getTimestamp("write_date");

                    GameReplyDTO dto = new GameReplyDTO(id,game_id,writer,contents,write_date);
                    list.add(dto);
                }
                return(list);
            }
        }
    }
//endregion




    //region update
    //TODO: 댓글 내용 수정
    //endregion

    //region delete
    //TODO: 댓글 삭제
    //endregion
}

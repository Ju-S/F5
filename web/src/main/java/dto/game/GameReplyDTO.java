package dto.game;

import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GameReplyDTO {
    private long id;
    private long gameId;
    private String writer;
    private String contents;
    private Timestamp writeDate;
    private int report_count;
    private String tier; // 추가
    private String nickname; // 추가
}



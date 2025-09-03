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
    private String tier; // 추가
}



package dto.game;

import lombok.*;

import java.time.LocalDateTime;

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
    private LocalDateTime writeDate;
}

package dto.game;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GameScoreDTO {
    private long id;
    private long gameId;
    private String memberId;
    private long score;
    private LocalDateTime recdDate;
}

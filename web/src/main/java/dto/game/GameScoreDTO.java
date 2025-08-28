package dto.game;

import lombok.*;

import java.sql.Timestamp;

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
    private Timestamp recdDate;
}

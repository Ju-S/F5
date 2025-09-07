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

    private String tier; // 추가
    private int rank; // 추가
    private String nickname; // 추가
}

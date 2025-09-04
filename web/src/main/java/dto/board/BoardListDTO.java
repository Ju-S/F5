package dto.board;

import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BoardListDTO {
    private long id;
    private long boardCategory;
    private String writer;
    private long gameId;
    private String title;
    private String contents;
    private long viewCount;
    private long like_count;
    private Timestamp writeDate;
    private long reportCount;
    private int replyCount;
}

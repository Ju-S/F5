package dto.board;

import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReplyDTO {
    private long id;
    private String writer;
    private long boardId;
    private String contents;
    private long likeCount;
    private Timestamp writeDate;
    private long reportCount;
}

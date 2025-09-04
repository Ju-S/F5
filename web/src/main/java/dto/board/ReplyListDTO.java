package dto.board;

import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReplyListDTO {
    private long id;
    private String writer;
    private long boardId;
    private String contents;
    private long likeCount;
    private Timestamp writeDate;
    private long reportCount;
    private String nickname;
}

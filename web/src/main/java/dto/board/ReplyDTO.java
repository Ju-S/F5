package dto.board;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReplyDTO {
    private long id;
    private long boardId;
    private String contents;
    private long likeCount;
    private LocalDateTime writeDate;
    private long reportCount;
}

package dto.board;

import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BoardFileDTO {
    private long id;
    private long boardId;
    private String oriName;
    private String sysName;
    private Timestamp uploadDate;
}

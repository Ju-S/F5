package dto.admin;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReportedPostDTO {
    private long id;              // 게시글 ID
    private String title;         // 제목
    private String nickname;      // 작성자 (writer)
    private String reportDate;    // 작성일 (신고일로 활용)
    private String contents;
    private int reportCount;      // 신고 횟수
}

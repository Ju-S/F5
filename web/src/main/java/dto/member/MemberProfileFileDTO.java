package dto.member;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberProfileFileDTO {
    private long id;
    private String memberId;
    private String oriName;
    private String sysName;
    private LocalDateTime uploadDate;
}

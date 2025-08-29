package dto.member;

import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BlackListDTO {
    private long id;
    private String memberId;
    private Timestamp startDate;
    private Timestamp endDate;
}

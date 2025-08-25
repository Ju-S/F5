package dto.member;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BlackListDTO {
    private long id;
    private String memberId;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
}

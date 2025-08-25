package dto.member;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberGameTierDTO {
    private long id;
    private String memberId;
    private long gameId;
    private String tier;
}

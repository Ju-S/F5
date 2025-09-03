package dto.member;

import enums.Authority;
import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {
    private String id;
    private String pw;
    private String name;
    private String nickname;
    private String email;
    // enums/Authority에서 권한 정의(ADMIN, MEMBER 등)
    private Authority authority;
    private int birthyear;
    // 0남자 or 1여자로 성별 구분.
    private int sex;
    private Timestamp joinDate;
}

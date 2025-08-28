package dto.member;

import enums.Authority;
import lombok.*;

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
    private String phone;
    private long zipcode;
    private String address1;
    private String address2;
    // enums/Authority에서 권한 정의(ADMIN, MEMBER 등)
    private Authority authority;
    private int birthyear;
    // 성별은 0 or 1로 받는다.
    // regex해줘야 할것 같다.
    private int sex;
    private String ip;
}

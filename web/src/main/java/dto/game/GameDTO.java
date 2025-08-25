package dto.game;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GameDTO {
    private long id;
    private String name;
    private String description;
}

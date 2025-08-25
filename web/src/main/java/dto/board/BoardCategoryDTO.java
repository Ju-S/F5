package dto.board;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BoardCategoryDTO {
    private long id;
    private String name;
    private String description;
}

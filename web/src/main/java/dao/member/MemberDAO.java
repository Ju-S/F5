package dao.member;

import dto.member.MemberDTO;
import enums.Authority;
import util.DataUtil;
import util.SecurityUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.*;

public class MemberDAO {
    private static MemberDAO instance;
    public static synchronized MemberDAO getInstance() throws Exception {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }

    // 로그인 후 사용자 정보 반환 - 관리자용 때 필요
    public MemberDTO login(String id, String pw) throws Exception {
        String sql = "SELECT * FROM member WHERE id = ? AND pw = ?";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            ps.setString(2, SecurityUtil.encrypt(pw));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return MemberDTO.builder()
                            .id(rs.getString("id"))
                            .pw(rs.getString("pw"))
                            .name(rs.getString("name"))
                            .nickname(rs.getString("nickname"))
                            .email(rs.getString("email"))
                            .authority(Authority.valueOf(rs.getString("authority")))
                            .birthyear(rs.getInt("birthyear"))
                            .sex(rs.getInt("sex"))
                            .joinDate(rs.getTimestamp("join_date"))
                            .build();
                }
            }
        }
        return null;
    }
    //===================아이디 찾기용
    public boolean isNameEmailExist(String name,String email)throws Exception{
        String sql = "SELECT COUNT(*) FROM member WHERE name = ? and email = ?";

        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("EMAIL: " + count);
                    return count > 0;
                }
                return false;
            }
        }
    }
    public String findIdByNameEmail(String name, String email)throws Exception{
        String sql = "select * from member where name=? and email=?";
        try( Connection conn = DataUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);

            try (ResultSet rs = ps.executeQuery()) {
                String foundId=null;
                if (rs.next()) {
                    foundId = rs.getString("id");
                }
                return foundId;
            }
        }
    }


    //===================비밀번호 변경용
    //비밀번호 변경
    public int changePw(String pw, String id) throws Exception {
        String sql = "UPDATE member SET pw=? WHERE id=?";
        try(Connection con = DataUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
        ){

            ps.setString(1, SecurityUtil.encrypt(pw));
            ps.setString(2, id);
            return ps.executeUpdate();
        }
    }
    //아이디+이메일 여부 검사 : 비밀번호 찾기용
    public boolean isIdEmailExist(String id, String email) throws Exception {
        String sql = "SELECT COUNT(*) FROM member WHERE id = ? and email = ?";

        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("EMAIL: " + count);
                    return count > 0;
                }
                return false;
            }
        }
    }



    //===================회원가입용
    //아이디 중복 검사
    public boolean isIdExist(String id) throws Exception {
        String sql = "SELECT COUNT(*) FROM member WHERE id = ?";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("dao count값: " + count);
                    return count > 0;
                }
                return false;
            }
        }

    }

    //닉네임 중복 검사
    public boolean isNicknameExist(String nickname) throws Exception {
        String sql = "SELECT COUNT(*) FROM member WHERE nickname = ?";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);){
            ps.setString(1, nickname);
            try (ResultSet rs = ps.executeQuery();) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("dao count값: " + count);
                    return count > 0;
                }
                return false;
            }
        }
    }
    //회원가입
    public int insertMember(MemberDTO dto) throws Exception {
        String sql= "insert into member values(?,?,?,?,?,?,?,?,sysdate)";
        try(Connection conn = DataUtil.getConnection();
            PreparedStatement pstat = conn.prepareStatement(sql);){
            pstat.setString(1, dto.getId());
            pstat.setString(2, dto.getEmail());
            pstat.setString(3, SecurityUtil.encrypt(dto.getPw()));
            pstat.setString(4, dto.getName());
            pstat.setString(5, dto.getNickname());
            pstat.setString(6, dto.getAuthority().name());
            pstat.setInt(7,dto.getBirthyear());
            pstat.setInt(8,dto.getSex());
            return pstat.executeUpdate();
        }
    }

    //===================로그인용
    //로그인 기능
    public boolean isLoginOk(String id, String pw) throws Exception {
        String sql = "select * from member where id = ? and pw = ?";
        try (Connection conn = DataUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setString(1, id);
            ps.setString(2, SecurityUtil.encrypt(pw));
            System.out.println("inDAO" + SecurityUtil.encrypt(pw));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // 블랙리스트 체크
                    boolean isBlacklisted = BlackListDAO.getInstance().isBlacklisted(id);
                    if (isBlacklisted) {
                        System.out.println("Login denied: User is blacklisted.");
                        return false; // 로그인 차단
                    }
                    return true;
                }
                return false;
            }
        }
    }



    //region create
    //TODO: 회원가입
    //endregion

    //회원가입 - list 저장
    public List<MemberDTO> listMemberDate() throws Exception {
        String sql = "select * from member";
        List<MemberDTO> list = new ArrayList<>();

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql); ResultSet rs = pstat.executeQuery();) {
            while (rs.next()) {
                MemberDTO memberDTO = MemberDTO.builder()
                        .id(rs.getString("id"))
                        .pw(rs.getString("pw"))
                        .name(rs.getString("name"))
                        .nickname(rs.getString("nickname"))
                        .email(rs.getString("email"))
                        .authority(Authority.valueOf(rs.getString("authority")))
                        .birthyear(rs.getInt("birthyear"))
                        .sex(rs.getInt("sex"))
                        .joinDate(rs.getTimestamp("join_date"))
                        .build();

                list.add(memberDTO);
            }
            return list;
        }
    }

    //회원 정보 조회
    public MemberDTO getMemberById(String id) throws Exception {
        String sql = "select id, name, nickname, email, authority, birthyear, sex, join_date from member where id=?";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, id);

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return MemberDTO.builder()
                            .id(rs.getString("id"))
                            .name(rs.getString("name"))
                            .nickname(rs.getString("nickname"))
                            .email(rs.getString("email"))
                            .authority(Authority.valueOf(rs.getString("authority")))
                            .birthyear(rs.getInt("birthyear"))
                            .sex(rs.getInt("sex"))
                            .joinDate(rs.getTimestamp("join_date"))
                            .build();
                }
            }
        }
        return null;
    }

    // 회원 정보 수정
    public int updateMember(MemberDTO dto) throws Exception {
        String sql = "UPDATE member SET name=?, nickname=?, email=?, birthyear=?, sex=? WHERE id=?";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

            pstat.setString(1, dto.getName());
            pstat.setString(2, dto.getNickname());
            pstat.setString(3, dto.getEmail());
            pstat.setInt(4, dto.getBirthyear());
            pstat.setInt(5, dto.getSex()); // sex를 int로 쓰는 경우
            pstat.setString(6, dto.getId());

            return pstat.executeUpdate(); // 0 = 실패, 1 = 성공
        }
    }
    //endregion

    //회원 탈퇴
    public int deleteDateMember(String id) throws Exception {
        String sql = "delete from member where id=?";

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
            pstat.setString(1, id);
            return pstat.executeUpdate();
        }
    }

    //치트 정보 - 성별 비율 조회
    public Map<String, Integer> getGenderStats() throws Exception {
        String sql = "SELECT sex, count(*) AS cnt FROM member GROUP BY sex";
        Map<String, Integer> result = new HashMap<>();

        try (Connection con = DataUtil.getConnection(); PreparedStatement pstat = con.prepareStatement(sql); ResultSet rs = pstat.executeQuery();) {
            while (rs.next()) {
                int sex = rs.getInt("sex");
                int cnt = rs.getInt("cnt");

                if (sex == 1) {
                    result.put("male", cnt);
                } else {
                    result.put("female", cnt);
                }
            }
        }
        return result;
    }

    // 출생년도별 통계
    public Map<String, Integer> getYearStats() throws Exception {
        String sql = """
                    SELECT
                        CASE
                            WHEN birthyear BETWEEN 1990 AND 1999 THEN '1990년대'
                            WHEN birthyear BETWEEN 2000 AND 2009 THEN '2000년대'
                            WHEN birthyear BETWEEN 2010 AND 2019 THEN '2010년대'
                            ELSE '기타'
                        END AS year_group,
                        COUNT(*) AS cnt
                    FROM member
                    GROUP BY year_group
                    ORDER BY year_group
                """;
        Map<String, Integer> result = new LinkedHashMap<>();

        try (Connection con = DataUtil.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql);
             ResultSet rs = pstat.executeQuery()) {

            while (rs.next()) {
                String group = rs.getString("year_group");
                int cnt = rs.getInt("cnt");
                result.put(group, cnt);
            }
        }
        return result;
    }

}

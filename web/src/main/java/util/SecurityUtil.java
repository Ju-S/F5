package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SecurityUtil {
    private SecurityUtil(){}

    // 암호화 Util(SHA-256방식)
    public static String encrypt(String text) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256"); // SHA-512은 암호화 글자수 더 작음
            byte[] bytes = text.getBytes(StandardCharsets.UTF_8);
            byte[] digest = md.digest(bytes);

            StringBuilder builder = new StringBuilder();
            for (byte b : digest) {
                builder.append(String.format("%02x", b));
            }
            return builder.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 암호화 실패", e);
        }
    }
}
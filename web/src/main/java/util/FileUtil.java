package util;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

// 파일 업로드 Util
public class FileUtil {
    private FileUtil() {
    }

    public static MultipartRequest fileUpload(HttpServletRequest request, String subDir) throws Exception {
        int MAX_SIZE = 1024 * 1024 * 10;
        // '/webapp/upload' 폴더를 파일 저장 위치로 선정.
        String savePath = request.getServletContext().getRealPath("upload/" + subDir);
        File filePath = new File(savePath);

        if (!filePath.exists()) {
            filePath.mkdirs();
        }

        // MultipartRequest를 반환.
        // 콜러에서 getFilesystemName() 및 getOriginalFileName()을 사용하기 위함.
        return new MultipartRequest(request, savePath, MAX_SIZE, "utf8", new DefaultFileRenamePolicy());
    }

    // 파일 다운로드
    public static void fileDownload(HttpServletRequest request, HttpServletResponse response, String subDir, String sysName, String oriName) throws Exception {
        String realPath = request.getServletContext().getRealPath("upload/" + subDir);
        File target = new File(realPath + "/" + sysName);

        response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(oriName, StandardCharsets.UTF_8) + "\"");

        try (FileInputStream fis = new FileInputStream(target);
             DataInputStream dis = new DataInputStream(fis);
             ServletOutputStream sos = response.getOutputStream()) {
            byte[] fileContents = new byte[(int) target.length()];

            dis.readFully(fileContents);

            sos.write(fileContents);
            sos.flush();
        }
    }

    // 파일 삭제
    public static boolean deleteFile(HttpServletRequest request, String subDir, String sysName) {
        String realPath = request.getServletContext().getRealPath("upload/" + subDir);

        if (realPath == null || realPath.isEmpty()) return false;

        File file = new File(realPath);
        if (!file.exists()) return false;

        return file.delete(); // true: 삭제 성공, false: 실패
    }
}

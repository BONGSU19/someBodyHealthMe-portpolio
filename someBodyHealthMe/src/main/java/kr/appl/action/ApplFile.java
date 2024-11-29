package kr.appl.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import kr.util.FileUtil;

public class ApplFile extends FileUtil{
	//업로드 상대경로
		public static final String UPLOAD_PATH = "/upload";
		//파일 업로드
		public static String uploadFile(HttpServletRequest request, String param) throws IOException, ServletException{
			//컨텍스트 경로상의 업로드 절대경로
			String upload = request.getServletContext().getRealPath(UPLOAD_PATH);
			Part part = request.getPart(param);
			String filename = part.getSubmittedFileName();
			if(!filename.isEmpty()) {//파일을 업로드한 경우
				//파일이 중복되지 않도록 파일명 변경
				UUID uuid = UUID.randomUUID();
				
				//_ 이후에 원래 파일명을 보존할 경우
				filename = uuid.toString() + "_" + filename;
				part.write(upload+"/"+filename);//지정된 경로에 파일 저장
			}
			return filename;
		}
		
		//파일 다운로드		
		public static int downloadFile(HttpServletRequest request, HttpServletResponse response, String filename) throws IOException {
		    // 업로드된 파일이 저장된 경로
		    String uploadDir = request.getServletContext().getRealPath(UPLOAD_PATH);
		    
		    
		    // 다운로드할 파일의 경로
		    File file = new File(uploadDir, filename);
		    
		    // 파일이 존재하는지 확인
		    if (file.exists()) {
		        // 파일의 MIME 타입을 설정 (파일 확장자에 맞는 MIME 타입을 설정)
		        String mimeType = request.getServletContext().getMimeType(file.getName());
		        
		        // MIME 타입을 application/octet-stream으로 강제 설정하여 브라우저에서 파일을 열지 않도록 함
		        if (mimeType == null || mimeType.equals("application/pdf") || mimeType.equals("image/jpeg") || mimeType.equals("image/png")) {
		            mimeType = "application/octet-stream";  // 기본 MIME 타입
		        }
		        
		        // 응답 헤더 설정 (다운로드할 때 파일 이름 지정)
		        response.setContentType(mimeType);
		        response.setContentLength((int) file.length());
		        
		        // 파일 다운로드 시, 다운로드 창에 파일 이름이 보이도록 설정
		        String headerKey = "Content-Disposition";
		        String headerValue = "attachment; filename=\"" + filename + "\"";
		        response.setHeader(headerKey, headerValue);
		        
		        // 파일을 클라이언트로 전송 (파일 스트림을 사용)
		        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
		             OutputStream out = response.getOutputStream()) {
		            
		            byte[] buffer = new byte[1024];
		            int bytesRead;
		            
		            while ((bytesRead = in.read(buffer)) != -1) {
		                out.write(buffer, 0, bytesRead);
		            }
		            return 0 ;//성공
		        }
		    } else {
		        // 파일이 존재하지 않으면 404 오류 반환
		        response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
		        return 1 ;//실패
		    }
		}


}























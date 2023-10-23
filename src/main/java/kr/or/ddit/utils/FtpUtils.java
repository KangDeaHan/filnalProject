package kr.or.ddit.utils;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.SocketException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component //Bean 생성
@PropertySource("classpath:config/props/ftpConf.properties")
public class FtpUtils {
	 //Ftp 서버에 들어가기 위해 필요한것
	 @Value("${myftp.server}")
	    private String server;
	    
	    @Value("${myftp.port}")
	    private int port;
	    
	    @Value("${myftp.username}")
	    private String username;
	    
	    @Value("${myftp.password}")
	    private String password;
	    
	    private FTPClient ftp;
	    
	    //FTPClient 객체를 통한 ftp 서버 연결
	    public void open() throws SocketException, IOException { 
	    	log.debug("server:" + server);
	    	log.debug("port:" + port);
	    	log.debug("username:" + username);
	    	log.debug("password:" + password);
	    	
	    	ftp = new FTPClient();
	    	ftp.setControlEncoding("UTF-8");
	    	//로그로 서버와 주고받은 명령어 결과들을 출력 받을 수 있음
	    	ftp.addProtocolCommandListener(new PrintCommandListener(new PrintWriter(System.out), true));

	            ftp.connect(server, port);
	            int reply = ftp.getReplyCode();
	            if (!FTPReply.isPositiveCompletion(reply)) {
	                ftp.disconnect();
	                log.error("FTPClient:: server connection failed.");
	            }

	            ftp.setSoTimeout(1000);
	            ftp.login(username, password);
	            ftp.setFileType(FTP.BINARY_FILE_TYPE);
	    }
	    
	    public void close() throws IOException { 
	            ftp.logout();
	            ftp.disconnect();
	    }
	    
	    //ftp 서버에 전송받은 파일 UPLOAD
	    public void upload(MultipartFile file) throws IOException {
	    	open();
	    	
	        InputStream inputStream = null;
	        inputStream = file.getInputStream();
	        //아래 라인이 핵심, put과 같음
	        ftp.storeFile(file.getOriginalFilename(), inputStream);
	         inputStream.close();
	         
	         close();
	    }
	    
	    // ftp download
	    public void downlod(String fName, HttpServletResponse resp) throws IOException {
	        
	    	String fileName = URLEncoder.encode(fName, "UTF-8");
	    	//String fileName2 = "미우.jpg";
	    	
	    	// 브라우져 별 기본 세팅이 쪼메 다름(구글 참공, 여기선 크롬기준으로)
	    	resp.setContentType("application/octet-stream");
	        resp.setHeader("Content-Disposition", "attachment; filename=\""+ fileName + "\"");
	        
	    	open(); //ftp 연결
	    	
	        OutputStream outputStream = new BufferedOutputStream(resp.getOutputStream());
	    	InputStream inputStream = null;
	    	
	    	//get에 해당(뽀인또)
	    	inputStream =ftp.retrieveFileStream("/"+fName);
	        
	    	byte[] bytesArray = new byte[4096];
	        int bytesRead = -1;
	        while ((bytesRead = inputStream.read(bytesArray)) != -1) {
	            outputStream.write(bytesArray, 0, bytesRead);
	        }

	        boolean success  = ftp.completePendingCommand();
	        log.debug("check: " + success);
	        outputStream.close();
	        inputStream.close();        
	        
	        //ftp 닫는거
	         close();         
	    }
	    
}

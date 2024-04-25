
package org.project.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.project.domain.FileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	/* 폴더 생성 규칙 */
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-",File.separator);
	}	
	
	/* 이미지 파일 체크 */
	private boolean checkImg(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath()); // 파일 경로에서 확장자를 확인 후 MIME타입으로 반환
			return contentType.startsWith("image"); // image로 시작하는지 확인
		} catch (IOException e) {
			e.printStackTrace();
		}		
		return false; // 기본적으로는 이미지 파일이 아닌 것으로 판단
	}
	
	/* ajax방식 파일 업로드페이지 
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
	}*/
	
	/* 단일파일 저장 */
	@PostMapping("/uploadSingle")
	public String singleFileUpload(@RequestParam("profileImg")MultipartFile profileImg) {
		
		// 1. 전송받은 파일 및 파일설명 값 가져오기
		log.info("singleFile : " + profileImg);
		
		
		// 2. 저장할 경로 가져오기
		String uploadFolder = "C:\\upload"; // 업로드 할 폴더 경로
		File uploadPath = new File(uploadFolder, getFolder()); // 새 폴더는 오늘 날짜 이름으로 한다.			
		
		// 같은 이름의 폴더가 없다면 새 폴더를 생성한다.
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}			
		
		// 업로드할 폴더 설정
		String uploadFileName = profileImg.getOriginalFilename();
		UUID uuid = UUID.randomUUID(); // UUID(고유ID_난수)

		//IE브라우저 파일 경로
		FileDTO file = new FileDTO();
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
		file.setFileName(uploadFileName);
		
		//중복방지를 위한 UUID적용
		uploadFileName = uuid.toString()+"_"+uploadFileName;
				
		// 파일업로드
		try {
			File saveFile = new File(uploadPath, uploadFileName);
			profileImg.transferTo(saveFile);
			
			if(checkImg(saveFile)) {
				file.setImg(true);					
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName)); //썸네일은 "s_uuid_파일명"으로 저장(outputstream-출력)					
				Thumbnailator.createThumbnail(profileImg.getInputStream(), thumbnail, 100, 100);//썸네일파일명, 100*100사이즈로 썸네일 생성(inputstream-입력)					
				thumbnail.close();
			}
			log.info("파일 업로드 성공");
		} catch (IllegalStateException | IOException e) {
			log.info("파일 업로드 실패");
			e.printStackTrace();
		}
		
		return "result";
	}
	
	/* ajax방식 다중파일 저장 + 인증된 사용자(로그인) */	
	@ResponseBody
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<FileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<FileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload"; // 업로드 할 폴더 경로
		File uploadPath = new File(uploadFolder, getFolder()); // 새 폴더는 오늘 날짜 이름으로 한다.
		String uploadFolderPath = getFolder(); // 업로드폴더 이름				

		// 같은 이름의 폴더가 없다면 새 폴더를 생성한다.
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}		
		
		for(MultipartFile file : uploadFile) {
			FileDTO attach = new FileDTO();
			log.info("File Name:"+file.getOriginalFilename());
			log.info("File Size:"+file.getSize());
			
			String uploadFileName = file.getOriginalFilename();
			
			//IE브라우저 파일 경로
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			attach.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID(); // UUID(고유ID_난수)
			
			//중복방지를 위한 UUID적용
			uploadFileName = uuid.toString()+"_"+uploadFileName;			
						
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				file.transferTo(saveFile);
				
				attach.setUuid(uuid.toString());
				attach.setUploadPath(uploadFolderPath);
				
				//img check
				if(checkImg(saveFile)) {
					attach.setImg(true);					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName)); //썸네일은 "s_uuid_파일명"으로 저장(outputstream-출력)					
					Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 100, 100);//썸네일파일명, 100*100사이즈로 썸네일 생성(inputstream-입력)					
					thumbnail.close();
				}				
				list.add(attach);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
		
	/* 썸네일 전송하기 */
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		File file = new File("C:\\upload\\"+fileName);
		ResponseEntity<byte[]> result = null; // byte[]는 실제 파일을 넘기기 위함.
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	/* 다운로드 */
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){		
		Resource resource = new FileSystemResource("C:\\upload\\"+fileName); //다운로드할 파일
		
		if (resource.exists() == false) {// 다운로드할 파일이 없다면 
			return new ResponseEntity<>(HttpStatus.NOT_FOUND); // 404오류
		}
		
		String resourceName = resource.getFilename(); // 다운로드할 파일의 이름
		
		//UUID제거 : 전체이름 중 "_" 다음글자부터 추출 >> (s_)uuid_filename > filename(진짜이름)
		String resourceOriginName = resourceName.substring(resourceName.indexOf("_")+1);  
		
		HttpHeaders headers = new HttpHeaders(); // 헤더
		
		try {
			String downloadName = null; //다운로드이름 지정(브라우저별로 상이)
			if(userAgent.contains("Trident")){ //IE
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginName,"UTF-8").
				replaceAll("\\+", " ");
			} else if(userAgent.contains("Edge")) { //Edge
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginName,"UTF-8");
				log.info("Edge name: " + downloadName);
			}else {
				log.info("Chrome browser"); //Chrome
				downloadName = new String(resourceOriginName.getBytes("UTF-8"), "ISO-8859-1");
			}
			headers.add("Content-Disposition", "attachment; filename="+downloadName); //헤더에 정보저장
		} catch (Exception e) {
			e.printStackTrace();
		}			
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	/* 파일삭제 */	
	@ResponseBody
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName, String type){
		File file;
		
		try {
			file = new File("C:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete();// 일반파일의 경우 경로에 해당하는 파일 바로 삭제
			if(type.equals("image")) { // 이미지 타입의 파일이라면,
				String largeFileName = file.getAbsolutePath().replace("s_", ""); // 절대경로에서 s_를 지워버림.
				file = new File(largeFileName); // largeFileName을 새 File객체로 생성
				file.delete(); // 파일삭제 : 원본파일 + largeFile(s_를 지운 썸네일) 모두 삭제
				log.info("[UploadController]---------------------------경로"+file);
				log.info("[UploadController]---------------------------삭제성공");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}		
		return new ResponseEntity<>("deleted", HttpStatus.OK);
	}
	
}

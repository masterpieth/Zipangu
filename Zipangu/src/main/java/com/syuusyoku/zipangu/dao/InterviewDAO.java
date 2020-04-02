package com.syuusyoku.zipangu.dao;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import com.syuusyoku.zipangu.vo.QuestionVO;

@Controller
public class InterviewDAO {

	@Autowired
	private SqlSession sqlSession;

	public ArrayList<QuestionVO> selectList(){
		ArrayList<QuestionVO> list = null;
		
		try {
			InterviewMapper mapper = sqlSession.getMapper(InterviewMapper.class);
			list = mapper.selectList();
			
			Collections.shuffle(list);

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	public int test(MultipartFile blob) {
		int result = 0;
		
		if(!blob.isEmpty()) {
			try {
				blob.transferTo(new File("C:/PJT/"+blob));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		try {
			InterviewMapper mapper = sqlSession.getMapper(InterviewMapper.class);
			result = mapper.test(blob);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
		
	//multipart File converter
	public void convert(MultipartFile blob) {
		Path filepath = Paths.get("C:/PJT/",blob.getOriginalFilename());
		try(OutputStream os = Files.newOutputStream(filepath)){
			os.write(blob.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
//	public class UtilFile {
//	    String fileName = "";
//
//	    //  fileUpload() 메소드에서 전체 경로를 DB에 경로 그대로 저장 한다.  
//	    public String fileUpload(MultipartHttpServletRequest request,
//	    MultipartFile uploadFile, Object obj) {
//	        String path = "";
//	        String fileName = "";
//
//	        OutputStream out = null;
//	        PrintWriter printWriter = null;
//
//	        try {
//	            fileName = uploadFile.getOriginalFilename();
//	            byte[] bytes = uploadFile.getBytes();
//	            path  = getServletContext().getRealPath("/") + "C:\\PJT";
//
//	            File file = new File(path);
//
//	            // 파일명이 중복체크
//	            if (fileName != null && !fileName.equals("")) {
//	                if (file.exists()) {
//	            // 파일명 앞에 구분(예)업로드 시간 초 단위)을 주어 파일명 중복을 방지한다.
//	                fileName = System.currentTimeMillis() + "_" + fileName;
//	                file = new File(path + fileName);
//	                }
//	            }
//	            out = new FileOutputStream(file);
//
//	            out.write(bytes);
//	        } catch (Exception e) {
//	            e.printStackTrace();
//	        } finally {
//	            try {
//	                if (out != null) {
//	                    out.close();
//	                }
//	                if (printWriter != null) {
//	                    printWriter.close();
//	                }
//	            } catch (IOException e) {
//	                e.printStackTrace();
//	            }
//	        }
//	        return path + fileName;
//	    }
}

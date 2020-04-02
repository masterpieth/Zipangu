package com.syuusyoku.zipangu.dao;

import java.io.File;
import java.io.IOException;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.Collections;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

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
	
	public int test(Blob blobt) {
		int result = 0;
		
		if(blobt.length()!=0) {
//			String blob = UUID.randomUUID().toString();
			try {
				blobt.transferTo(new File("C:/PJT/"+blobt));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		try {
			InterviewMapper mapper = sqlSession.getMapper(InterviewMapper.class);
			result = mapper.test(blobt);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(result);
		return result;
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

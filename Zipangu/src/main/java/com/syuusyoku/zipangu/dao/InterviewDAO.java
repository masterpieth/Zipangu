package com.syuusyoku.zipangu.dao;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Locale;

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
	

		
	//multipart File converter
	public MultipartFile convert(MultipartFile blob) {
		//파일명 시간 구하기
		long systemTime = System.currentTimeMillis();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.KOREA);
		String dTime = formatter.format(systemTime);
		
		File original = new File("C:/PJT/blob");
		File change = new File("C:/PJT/"+dTime+".wav");
		Path filepath = Paths.get("C:/PJT/",blob.getOriginalFilename());
		
		try(
			OutputStream os = Files.newOutputStream(filepath)){
				os.write(blob.getBytes());
			    System.out.println(dTime+".wav DAO.파일명");//파일명
		} catch (IOException e) {
			e.printStackTrace();
		}
	    if (!original.renameTo(change)) {
	        System.err.println("이름 변경 에러 : " + original);
	      }
	    System.out.println(blob + "DAO");
	    return blob;
	}

//	public void speechToText(MultipartFile blob) {
//		long systemTime = System.currentTimeMillis();
//		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.KOREA);
//		String dTime = formatter.format(systemTime);
//		
//		File voiceFilename = new File("C:/PJT/"+dTime+".wav");
//	}
}

package com.syuusyoku.zipangu.util;

import java.io.IOException;
import java.util.ArrayList;

import org.atilika.kuromoji.Token;
import org.atilika.kuromoji.Tokenizer;

public class Kuromoji {
	
//	public static void main(String[] args) {
//		GatewayServer gatewayServer = new GatewayServer(new Kuromoji());
//		gatewayServer.start();
//		System.out.println("Gateway Server Started");
//	}
//	public static String kuromoji(String str) throws IOException{
//		ArrayList<String> surfaceForms = new ArrayList<>();
//		Tokenizer tokenizer = Tokenizer.builder().build();
//		String surfaceStr = "";
//		for(Token token: tokenizer.tokenize(str)) {
//			if(token.getAllFeaturesArray()[0].equals("名詞")) {
//				surfaceForms.add(token.getSurfaceForm());
//			}
//		}
//		for(String surface: surfaceForms) surfaceStr += " " + surface;
//		
//		return surfaceStr;
//	}
//	public static String papago(String str) {
//		String clientId = "9VLCjOECDMTITU4FwWNG";// 애플리케이션 클라이언트 아이디값";
//		String clientSecret = "nNz9z7RPL_";// 애플리케이션 클라이언트 시크릿값";
//		String translatedText = "";
//		try {
//			String text = URLEncoder.encode(str, "UTF-8");
//			String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
//			URL url = new URL(apiURL);
//			HttpURLConnection con = (HttpURLConnection) url.openConnection();
//			con.setRequestMethod("POST");
//			con.setRequestProperty("X-Naver-Client-Id", clientId);
//			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
//			// post request
//			String postParams = "source=ja&target=ko&text=" + text;
//			con.setDoOutput(true);
//			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
//			wr.writeBytes(postParams);
//			wr.flush();
//			wr.close();
//			int responseCode = con.getResponseCode();
//			BufferedReader br;
//			if (responseCode == 200) { // 정상 호출
//				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//			} else { // 에러 발생
//				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
//			}
//			String inputLine;
//			StringBuffer response = new StringBuffer();
//			while ((inputLine = br.readLine()) != null) {
//				response.append(inputLine);
//			}
//			br.close();
//
//			String resultText = response.toString();
//			Charset.forName("UTF-8").encode(resultText);
//			JSONParser parser = new JSONParser();
//			JSONObject obj = (JSONObject) parser.parse(resultText);
//			JSONObject message = (JSONObject) obj.get("message");
//
//			JSONObject res = (JSONObject) message.get("result");
//
//			translatedText = (String) res.get("translatedText");
//			
//		} catch (Exception e) {
//			System.out.println(e);
//		}
//		return translatedText;
//	}
		
}

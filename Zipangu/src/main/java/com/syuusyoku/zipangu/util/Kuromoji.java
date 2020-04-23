package com.syuusyoku.zipangu.util;

import java.util.ArrayList;

import org.atilika.kuromoji.Token;
import org.atilika.kuromoji.Tokenizer;
import org.springframework.stereotype.Repository;

@Repository
public class Kuromoji {
//	public static void main(String[] args) {
//		GatewayServer gatewayServer = new GatewayServer(new Kuromoji());
//		gatewayServer.start();
//		System.out.println("Gateway Server Started");
//	}
	public String kuromoji(String str){
		ArrayList<String> surfaceForms = new ArrayList<>();
		Tokenizer tokenizer = Tokenizer.builder().build();
		String surfaceStr = "";
		for(Token token: tokenizer.tokenize(str)) {
			if(token.getAllFeaturesArray()[0].equals("名詞")) {
				surfaceForms.add(token.getSurfaceForm());
			}
		}
		for(String surface: surfaceForms) surfaceStr += " " + surface;
		
		return surfaceStr;
	}
}

package com.syuusyoku.zipangu.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.ArrayList;

import org.atilika.kuromoji.Token;
import org.atilika.kuromoji.Tokenizer;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import py4j.GatewayServer;

public class Kuromoji {
//	private static final Logger log = LoggerFactory.getLogger(Kuromoji.class);
	
//	public static void main(String[] args) {
//		String str = "パナソニック、三菱電機、本田技研工業など、\r\n" + 
//				"日本を代表する大手メーカー、優良企業がエスユーエスの取引先企業。\r\n" + 
//				" 機械・電気電子・IT・化学分野における、\r\n" + 
//				"最先端開発プロジェクトを通じて、\r\n" + 
//				"幅広い経験と、高い技術力を身につけながら、\r\n" + 
//				"一人ひとりの\"本当にやりたいこと\"を一緒に見つける。\r\n" + 
//				" エンジニアとして成長していただくために、\r\n" + 
//				"≪社会人学校(R)≫というコンセプトでサポートします。 エスユーエスのエンジニアは、自動車、ロケット、家電、産業機械、AIなど、多種多様な分野の最先端プロジェクトで、機械設計・電気電子設計、制御・ソフトウェア設計など幅広い設計開発に携わっています。さらに、エスユーエスをエンジニアリングパートナーとする企業は、日本を代表する大手メーカーから最先端開発に取り組む優良企業ばかり。「やりたいことがありすぎて、ひとつに絞れない」「向いている分野がわからない」今未来を決めてしまう必要はありません。エンジニア一人ひとりと向きあい、サポートをしながら、それぞれのキャリパスを一緒に目指していきます。エンジニア同士も切磋琢磨しながら本音で関われる環境を構築しています。 視野があまり広くない学生のうちには敢えて道を絞り込まず、エスユーエスの正社員として安定した雇用を確保した上で様々な職場で実力を磨きながら、自分の本当に進みたい道を見つけ、キャリアパスを実現していく。それが、『社会人学校（R)』というコンセプト。内定者の段階から充実した研修を設け、プロジェクト着任後も担当者やサポートスタッフのフォロー体制が整っています。その他、勉強会やe-learning、専門分野別教育など、エンジニアの成長を支援する制度がたくさん。「これこそが私の進みたかった道！」そう確信できた時、どんな企業からも必要とされるような実力を身につけていられるよう、エスユーエスが全力でバックアップします。 売上成長率は5年で236％。東証マザーズ上場を経て、社員一人ひとりが思い描く生き方を歩めるよう教育・成長への投資をいっそう充実させています。例えば自社製品を開発するSUS Labでは、最先端AI研究の第一人者のもと、6つのテーマでAIの研究を実施。「VRを作り出すAI研究」を中心に、各研究テーマにAIと自社エンジニアの技術を組み合わせ、自社製品・技術・サービスの開発、新規事業の創出を行っていきます。また社内受託開発や産学協業PJ、自社での事業創出、起業支援、ベンチャーへの投資にも注力。エンジニアが新たな夢を描いたとき、それを応援できる会社＝「エンジニアが世界で一番『自分』を歩める場所」を目指し続けます。 【エンジニア職：機械・電気電子・情報などの設計/開発工程全般】\r\n" + 
//				" ・自動車/二輪車エンジン、シャシー\r\n" + 
//				"・OA/家電\r\n" + 
//				"・航空宇宙関連\r\n" + 
//				"・産業用ロボット\r\n" + 
//				"・電気自動車モーター制御回路\r\n" + 
//				"・鉄道ブレーキ回路\r\n" + 
//				"・自動運転AI\r\n" + 
//				"・AR/VR関連システム　など\r\n" + 
//				" プロジェクトでは、エスユーエスの先輩社員がサポートしてくれますので、 \r\n" + 
//				"社会人としてのスタートを安心して踏み出すことができる環境があります。 ≪エンジニア職≫\r\n" + 
//				"■モノづくりへの興味や情熱をお持ちの方\r\n" + 
//				"■真面目で素直な方\r\n" + 
//				" エンジニアとしてキャリアを積むうえで、\r\n" + 
//				"「最先端業務にチャレンジしたい」\r\n" + 
//				"「幅広い経験を積んでみたい」\r\n" + 
//				"「新しい技術に触れていきたい」\r\n" + 
//				"「自分が本当にやりたいことを見つけたい」\r\n" + 
//				"そんな方を大歓迎します！\r\n" + 
//				" エスユーエスでは様々な最先端プロジェクトを通して経験を積み、\r\n" + 
//				"エンジニアとして成長をしながら、\r\n" + 
//				"≪本当にやりたい事≫を見つけていけばいいと考えています。\r\n" + 
//				" 実際に経験をしてみることで、\r\n" + 
//				"自分にとって何が楽しいのか？得意なのか？やってみないのか？\r\n" + 
//				"必ず見えてきます。\r\n" + 
//				" あなたのモノづくりに対する想い、そして成長したいという気持ち、\r\n" + 
//				"まずはそれを私たちに教えてください！";
//		String surfaceStr = "";
//		try {
//			surfaceStr = kuromoji(str);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		System.out.println(surfaceStr);
//	}
	public static void main(String[] args) {
		GatewayServer gatewayServer = new GatewayServer(new Kuromoji());
		gatewayServer.start();
		System.out.println("Gateway Server Started");
	}
	public static String kuromoji(String str) throws IOException{
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

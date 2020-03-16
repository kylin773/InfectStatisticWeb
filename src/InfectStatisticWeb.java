import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class InfectStatisticWeb {
	
	public static JSONObject spider(String urlStr) {
		
		try {
			String line;
			 
			URL url = new URL(urlStr);
			if("https".equalsIgnoreCase(url.getProtocol())){
	            SslUtils.ignoreSsl();
	        }
			
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	        connection.setDoInput(true);
	        connection.setRequestMethod("GET");
	        connection.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
			BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));
			StringBuilder sbBuilder = new StringBuilder();
			
			while ((line = br.readLine()) != null) {
				sbBuilder.append(line);
			}
			br.close();
			connection.disconnect();
			
			//开始进行信息筛选，获得result转化为array
			JSONObject jsonObject = JSONObject.parseObject(sbBuilder.toString());

			return jsonObject;
		}
		catch (Exception e) {
		    e.printStackTrace();
		    return null;
		}
	}
	
	public static JSONArray dealData() {
		//String url = "https://lab.isaaclin.cn/nCoV/api/area?latest=1";
		JSONArray needArray = new JSONArray();	
		JSONArray array;
//		try {
//		    array = JSONArray.parseArray(spider(url).get("results").toString());
//		    int size = array.size();
//			for (int i = 0; size > i; i++) {
//				JSONObject jo1 = (JSONObject)array.get(i);
//				if (jo1.get("countryName").toString().equals("中国")) {
//					JSONObject jp3 = new JSONObject();
//					jp3.put("name", jo1.get("provinceShortName").toString());
//					jp3.put("value", jo1.get("currentConfirmedCount").toString());
//					jp3.put("confirmedCount", jo1.get("confirmedCount").toString());
//					jp3.put("curedCount", jo1.get("curedCount").toString());
//					jp3.put("suspectedCount", jo1.get("suspectedCount").toString());
//					jp3.put("deadCount", jo1.get("deadCount").toString());
//					needArray.add(jp3);
//				}
//			}
//			
//			return needArray;
//		}
//		catch(Exception e) {
			try {			
				File jsonFile = new File("F:\\Eclipse\\eclipse-ee-workspace\\InfectStatisticWeb\\src\\DXYArea.json");
				FileReader fileReader = new FileReader(jsonFile);
				
				BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(jsonFile),"utf-8"));
				StringBuilder sbBuilder = new StringBuilder();
				String line;
				while ((line = br.readLine()) != null) {
					sbBuilder.append(line);
				}
				br.close();
				fileReader.close();
				
				//开始进行信息筛选，获得result转化为array
				JSONObject jsonObject = JSONObject.parseObject(sbBuilder.toString());
			    array = JSONArray.parseArray(jsonObject.get("results").toString());
			    int size = array.size();
				for (int i = 0; size > i; i++) {
					JSONObject jo1 = (JSONObject)array.get(i);
					if (jo1.get("countryName").toString().equals("中国")) {
						JSONObject jp3 = new JSONObject();
						jp3.put("name", jo1.get("provinceShortName").toString());
						jp3.put("value", jo1.get("currentConfirmedCount").toString());
						jp3.put("confirmedCount", jo1.get("confirmedCount").toString());
						jp3.put("curedCount", jo1.get("curedCount").toString());
						jp3.put("suspectedCount", jo1.get("suspectedCount").toString());
						jp3.put("deadCount", jo1.get("deadCount").toString());
						needArray.add(jp3);
					}
				}
				
				return needArray;
			} 
			catch (Exception a) {
				a.printStackTrace();
				return null;
			}
//		}	
	
	}
	
	public static JSONObject dealOverall() {
		String url = "https://lab.isaaclin.cn/nCoV/api/overall";
		JSONArray array;
//		
//		try {
//			array = JSONArray.parseArray(spider(url).get("results").toString());
//			JSONObject jo1 = (JSONObject)array.get(0);
//			return jo1;
//		} 
//		catch (Exception e) {
			try {			
				File jsonFile = new File("F:\\Eclipse\\eclipse-ee-workspace\\InfectStatisticWeb\\src\\DXYOverall.json");
				FileReader fileReader = new FileReader(jsonFile);
				
				BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(jsonFile),"utf-8"));
				StringBuilder sbBuilder = new StringBuilder();
				String line;
				while ((line = br.readLine()) != null) {
					sbBuilder.append(line);
				}
				br.close();
				fileReader.close();
				
				//开始进行信息筛选，获得result转化为array
				JSONObject jsonObject = JSONObject.parseObject(sbBuilder.toString());
				array = JSONArray.parseArray(jsonObject.get("results").toString());
			    JSONObject jo1 = (JSONObject)array.get(0);
			    return jo1;
			} catch (IOException a) {
					a.printStackTrace();
					return null;
			}
	//	}
		
	}
	
	public static JSONArray dealDetail(String province) {
		try {
			
			String url = "https://api.inews.qq.com/newsqa/v1/query/pubished/daily/list?province=" + 
			    URLEncoder.encode(province, "UTF-8");
			JSONObject obj = spider(url);
			JSONArray array = JSONArray.parseArray(obj.get("data").toString());
			if(array == null) {
				return null;
			}		
			
			return array;
		}
		catch(Exception e) {
			return null;
		}
		
	}

	public static JSONArray dealGlobal() {
		try {
			String url = "https://wuliang.art/ncov/statistics/dataChangeList";

			JSONArray needArray = new JSONArray();
			JSONObject obj = spider(url);
			JSONObject obj2 = (JSONObject)JSONArray.parse(obj.get("data").toString());
			JSONArray array = (JSONArray)JSONArray.parseArray(obj2.get("foreignList").toString());
			
			int size = array.size();
			String test;
			for (int i = 0; size > i; i++) {
				JSONObject jo1 = (JSONObject)array.get(i);
				String isNeed = jo1.get("isUpdated").toString();
				if (isNeed != null && isNeed.equals("true")) {
					JSONObject jo3 = new JSONObject();
					jo3.put("name", jo1.get("name").toString());
					jo3.put("nowConfirm", jo1.get("nowConfirm").toString());
					jo3.put("confirmed", jo1.get("confirm").toString());
					jo3.put("confirmAdd", jo1.get("confirmAdd").toString());
					needArray.add(jo3);
				}
			}
			return needArray;
		}
		catch (Exception e) {
			return null;
		}
	}
}

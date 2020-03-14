import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class InfectStatisticWeb {
	
	public static JSONArray spider(String urlStr, String key) {
		
		try {
			String line;
			 
			URL url = new URL(urlStr);
			//URL url = new URL("https://ncov.dxy.cn/ncovh5/view/pneumonia");
			//skip security check on website
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
			JSONArray array = JSONArray.parseArray(jsonObject.get(key).toString());

			return array;
		}
		catch (Exception e) {
		    e.printStackTrace();
		    return null;
		}
	}
	
	public static JSONArray dealData() {
		String url = "https://lab.isaaclin.cn/nCoV/api/area?latest=1";
		JSONArray needArray = new JSONArray();
		JSONArray array = spider(url, "results");
		
		if(array == null) {
			return null;
		}
		
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
	
	public static JSONObject dealOverall() {
		String url = "https://lab.isaaclin.cn/nCoV/api/overall";
		//JSONArray needArray = new JSONArray();
		//JSONObject needObj = new JSONObject();
		JSONArray array = spider(url, "results");
		
		if(array == null) {
			return null;
		}
		JSONObject jo1 = (JSONObject)array.get(0);
		return jo1;
	}
	
	public static JSONArray dealOld(String province) {
		String url = "https://api.inews.qq.com/newsqa/v1/query/pubished/daily/list?province=";
		JSONArray needArray = new JSONArray();
		JSONArray array = spider(url, "data");
		
		if(array == null) {
			return null;
		}
		
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
	
	public static JSONArray dealDetail(String province) {
		try {
			
			String url = "https://api.inews.qq.com/newsqa/v1/query/pubished/daily/list?province=" + URLEncoder.encode(province, "UTF-8");;
			JSONArray needArray = new JSONArray();
			JSONArray array = spider(url, "data");
			
			if(array == null) {
				return null;
			}		
			
			return array;
		}
		catch(Exception e) {
			return null;
		}
		
	}

}

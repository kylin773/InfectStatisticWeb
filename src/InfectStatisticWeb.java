import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class InfectStatisticWeb {
	
	public static JSONObject spider() {
		
		try {
			String line;
			 
			URL url = new URL("https://lab.isaaclin.cn//nCoV/api/area?latest=1");
			//URL url = new URL("https://ncov.dxy.cn/ncovh5/view/pneumonia");
			//skip security check on website,ignored
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
			String s = sbBuilder.toString();
			
			//开始进行信息筛选，获得result转化为aray
			JSONObject jsonObject = JSONObject.parseObject(sbBuilder.toString());
			JSONArray array = JSONArray.parseArray(jsonObject.get("results").toString());
			JSONArray needArray = new JSONArray();
			JSONObject needObj = new JSONObject();
			//JSONObject jo2 = (JSONObject)jsonObject.get("results");
			//System.out.printf(jsonObject.get("results").toString());
			//System.out.printf(array.getString(0));

			int size = array.size();
			for (int i = 0; size > i; i++) {

				JSONObject jo1 = (JSONObject)array.get(i);
				//System.out.printf(jo1.get("countryName").toString());
				if (jo1.get("countryName").toString().equals("中国")) {
					//JSONObject joNeed = new JSONObject();
					//joNeed.entrySet()
					needObj.put(jo1.getString("provinceName"), jo1);
					//System.out.printf(jo1.get("provinceName").toString());
				}
			}
			//JSONObject jo2 = (JSONObject)array.get(0);
			
			return needObj;
			//System.out.printf(needObj.toJSONString());
		}
		catch (Exception e) {
		    e.printStackTrace();
		    return null;
		}
	}

}

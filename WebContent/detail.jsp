<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>详情</title>
<script src="dist/echarts.min.js"></script>
<script src="dist/china.js"></script>
<link href="css/firstPage.css" rel="stylesheet">
</head>
<body>
    <div id="lineChart" style="width: 800px;height:600px;"></div>
	<script type="text/javascript">
    
	var lineChart = echarts.init(document.getElementById('lineChart'),'infographic');
    <% JSONArray obj = (JSONArray)request.getAttribute("provinceData");%>
	  console.log(<%=obj%>);
	  let  date,confirm,sus,cure,dead;
	<% 
	int size = obj.size();
	%>
  	lineChart.setOption({
                  //设置标题
                  title: {
                      text: "<% out.print(request.getAttribute("province")); %>" + '疫情趋势'
                  },
                  //数据提示框
                  tooltip: {
                      trigger: 'axis',
                  },
                  legend: {
                      data: ['累计确诊','治愈','死亡']
                  },
                  xAxis: {
                      data:[
                    		<% 
                    		for (int i = size - 10; size > i; i++) {
                    			JSONObject jo1 = (JSONObject)obj.get(i);
                    			out.print("\""+jo1.get("date").toString()+"\",");
                    		}
                    		%>
                      ]
                  },
                  yAxis: {},
                  series: [
                      {
                          name: '累计确诊',
                          type: 'line',
                          data:[<% 
                  		for (int i = size - 10; size > i; i++) {
                			JSONObject jo1 = (JSONObject)obj.get(i);
                			out.print(jo1.get("confirm").toString()+",");
                		}
                		%>]
                      },
                      {
                          name: '治愈',
                          type: 'line',
                          data:[
                    		<% 
                    		for (int i = size - 10; size > i; i++) {
                    			JSONObject jo1 = (JSONObject)obj.get(i);
                    			out.print(jo1.get("heal").toString()+",");
                    		}
                    		%>
                      ]
                      },
                      {
                          name: '死亡',
                          type: 'line',
                          data:[
                    		<% 
                    		for (int i = size - 10; size > i; i++) {
                    			JSONObject jo1 = (JSONObject)obj.get(i);
                    			out.print(jo1.get("dead").toString()+",");
                    		}
                    		%>
                      ]
                      }
                  ]
              },true)
    </script>
</body>
</html>
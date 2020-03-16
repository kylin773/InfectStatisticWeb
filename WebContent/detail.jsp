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
    <label><a href="index.jsp">返回</a></label>
    <div id="global" style="width: 800px;height:800px;"></div>
	
	<script type="text/javascript">
    
	var lineChart = echarts.init(document.getElementById('lineChart'),'infographic');
    <% JSONArray obj = (JSONArray)request.getAttribute("provinceData");%>
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
              },true);
    </script>
    
    <script type="text/javascript">
    var globalChart = echarts.init(document.getElementById('global'));
        
    var data = [
    	<% 
		   	JSONArray array = (JSONArray)request.getAttribute("globalData");
		   	int aSize = array.size();
		   	for (int i = 0; i < 14; i++) {
		   		JSONObject jo1 = (JSONObject)array.get(i);
				out.print("[" + jo1.get("confirmed").toString()+",");
				out.print(jo1.get("nowConfirm").toString()+",");
				out.print(jo1.get("confirmAdd").toString()+"], \n");
			}
    	%>
    ];
    var name1 = [<%
	for (int i = 0; i < 14; i++) {
		JSONObject jo1 = (JSONObject)array.get(i);
		out.print("\'" + jo1.get("name").toString() + "\',");
	}
    %>];
    
    var cities = ['北京', '上海', '深圳', '广州', '苏州', '杭州', '南京', '福州', '青岛', '济南', '长春', '大连', '温州', '郑州', '武汉', '成都', '东莞', '沈阳', '烟台'];
    var barHeight = 100;

    globalChart.setOption({
        title: {
            text: '国外数据概览',
            subtext: '部分数据展示'
        },
        legend: {
            show: true,
            data: ['累计确诊', '现有确诊']
        },
        grid: {
            top: 100
        },
        angleAxis: {
            type: 'category',
            data: name1
        },
        tooltip: {
            show: true,
            formatter: function (params) {
                var id = params.dataIndex;
                return name1[id] + '<br/>累计确诊：' + data[id][0] + '<br/>现有确诊：' + data[id][1] +
                    '<br/>确诊增加：' + data[id][2];
            }
        },
        radiusAxis: {
        },
        polar: {
        },
        series: [{
            type: 'bar',
            itemStyle: {
                color: 'transparent'
            },
            data: data.map(function (d) {
                return 0;
            }),
            coordinateSystem: 'polar',
            stack: '最大最小值',
            silent: true
        }, {
            type: 'bar',
            data: data.map(function (d) {
                return d[0];
            }),
            coordinateSystem: 'polar',
            name: '累计确诊',
            stack: '最大最小值'
        }, {
            type: 'bar',
            itemStyle: {
                color: 'transparent'
            },
            data: data.map(function (d) {
                return d[1];
            }),
            coordinateSystem: 'polar',
            stack: '均值',
            silent: true,
            z: 10
        }, {
            type: 'bar',
            data: data.map(function (d) {
                return barHeight * 2;
            }),
            coordinateSystem: 'polar',
            name: '现有确诊',
            stack: '均值',
            barGap: '-100%',
            z: 10
        }]
    },true);
    </script>
</body>
</html>
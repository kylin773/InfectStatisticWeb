<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>InfectStatisticWeb</title>
<script src="dist/echarts.min.js"></script>
<script src="dist/china.js"></script>
<link href="css/firstPage.css" rel="stylesheet">
</head>
<body>

	<% if (request.getAttribute("overall") == null) { %>
		<jsp:forward page="Servlet" />
		%>
	<%
	}
	%>

	
	 <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	
    <div id="overall" style="margin: auto; width: 800px;height:330px;">
    <br/>
    <br/>
    
    <!-- 日期  -->
    <div class="content">
    	<form method="get">
    		<div>
    			<label>日期：</label>
    			<input type="date" id="txtDate" />
    		</div>
    		<div>
    			<input type="button" id="btn" value="提交">
    		</div>
    	</form>
    </div>
    <script type="text/javascript"> //获取数据
    	$(document).ready(function(){
    		$("#btn").click(function(){
    			//alert(document.getElementById("txtDate").value); 同下
    			alert($("#txtDate").val());
    		});
    	});
    </script>
    
    <div style="text-align: center;">
      <h1>nCoV疫情统计</h1>
    </div>
      <table width="800" style="text-align: center;">
        <tbody><tr>
          <td style="font-weight: bolder;">现存确诊</td>
          
          <td style="font-weight: bolder;">境外输入</td>
          
          <td style="font-weight: bolder;">现存重症</td>
        </tr>
        <tr>
          <% JSONObject obj = (JSONObject)request.getAttribute("overall"); 
          %>
          <td style="font-weight: bolder; font-size:xx-large; color:crimson;">
          <%=obj.get("currentConfirmedCount").toString() %></td>
          <td style="font-weight: bolder; font-size:xx-large; color:cornflowerblue;">
          <%=obj.get("suspectedCount").toString() %></td>
          <td style="font-weight: bolder; font-size:xx-large; color:saddlebrown;">
          <%=obj.get("seriousCount").toString() %></td>
        </tr>
        <tr>
          <td class="tableSmall">较昨日<span style="font-weight: bolder; color:crimson;">
         	 <%=obj.get("confirmedIncr").toString() %></span></td>
          <td class="tableSmall">较昨日<span style="font-weight: bolder; color:cornflowerblue;">
            <%=obj.get("suspectedIncr").toString() %></span></td>
          <td class="tableSmall">较昨日<span style="font-weight: bolder; color:saddlebrown;">
            <%=obj.get("seriousIncr").toString() %></span></td>
        </tr>
        <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
        <tr>
          <td style="font-weight: bolder;">累计确诊</td>
          
          <td style="font-weight: bolder;">累计死亡</td>
          <!-- <td class="tableSplit" rowspan="3">|</td> -->
          <td style="font-weight: bolder;">累计治愈</td>
        </tr>
        <tr>
          <td style="font-weight: bolder; font-size:xx-large; color:coral;">
          <%=obj.get("confirmedCount").toString() %></td>
          <td style="font-weight: bolder; font-size:xx-large; color:dimgray;">
          <%=obj.get("deadCount").toString() %></td>
          <td style="font-weight: bolder; font-size:xx-large; color:forestgreen;">
          <%=obj.get("curedCount").toString() %></td>
        </tr>
        <tr>
          <td class="tableSmall">较昨日<span style="font-weight: bolder; color:coral;">
          <%=obj.get("confirmedIncr").toString() %></span></td>
          <td class="tableSmall">较昨日<span style="font-weight: bolder; color:dimgray;">
          <%=obj.get("deadIncr").toString() %></span></td>
          <td class="tableSmall">较昨日<span style="font-weight: bolder; color:forestgreen;">
          <%=obj.get("curedIncr").toString() %></span></td>
        </tr>
        
      </tbody></table>
      </div>
      <br/>
    <div id="map" style="width: 800px;height:600px;"></div>
    <br/>
    <div id="lineChart" style="width: 800px;height:600px;"></div>
    
    <script type="text/javascript">
    var myChart = echarts.init(document.getElementById('map'));
    var option = {
        title: {
            text: '全国疫情地图',
            left: 'center'
        },
        backgroundColor: '#f7f7f7',
        tooltip: {
        	formatter: function(params) {
        		return `地区：`+ params.name +` <br/>确诊：` + (params.value || 0) + `人<br/>死亡：`
        		+ (params.data && params.data.deadCount || 0) + `人`;
        	},
        },
        visualMap: [
            { 
                type: 'piecewise', 
                pieces: [
                    {gt: 10000},            // (1500, Infinity]
                    {gt: 1000, lte: 9999},  // (900, 1500]
                    {gt: 100, lte: 999},  // (310, 1000]
                    {gt: 10, lte: 99},   // (200, 300]
                    {gt: 0, lte: 9},       // (10, 200]
                ]
            }
        ],
        series: [{
            type: 'map',
            map: 'china',
            label: {
            	show: true
            },
            data: <%= request.getAttribute("data") %>
        }]
    };
    myChart.setOption(option);
    myChart.on('click', function (params) {
    	   console.log(params);
    	   alert("./Servlet?flag=1&province=" + params.name);
    	   location.href = "./Servlet?province=" + params.name;
    });

    var lineChart = echarts.init(document.getElementById('lineChart'),'infographic');
    lineChart.setOption({
                  //设置标题
                  title: {
                      text: (name || "全国") + '疫情趋势'
                  },
                  //数据提示框
                  tooltip: {
                      trigger: 'axis',
                  },
                  legend: {
                      data: ['确诊','疑似','治愈','死亡']
                  },
                  xAxis: {
                      data:['18日', '19日', '20日', '11日', '12日', '13日', '14日']
                  },
                  yAxis: {},
                  series: [
                      {
                          name: '确诊',
                          type: 'line',
                          data:[820, 932, 901, 934, 1290, 1330, 1320]
                      },
                      {
                          name: '疑似',
                          type: 'line',
                          data:[220, 182, 191, 234, 290, 330, 310]
                      },
                      {
                          name: '治愈',
                          type: 'line',
                          data:[150, 232, 201, 154, 190, 330, 410]
                      },
                      {
                          name: '死亡',
                          type: 'line',
                          data:[120, 132, 101, 134, 90, 230, 210]
                      }
                  ]
              },true);
    </script>
    
</body>
</html>
<%@page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>详情</title>
<script src="dist/echarts.min.js"></script>
<script src="dist/china.js"></script>
<link href="css/firstPage.css" rel="stylesheet">
</head>
<body>
    <div id="lineChart" style="width: 800px;height:600px;"></div>
	<script type="text/javascript">
    var lineChart = echarts.init(document.getElementById('lineChart'),'infographic');

  	lineChart.setOption({
                  //设置标题
                  title: {
                      text: name + '疫情趋势'
                  },
                  //数据提示框
                  tooltip: {
                      trigger: 'axis',
                  },
                  legend: {
                      data: ['确诊','疑似','治愈','死亡']
                  },
                  xAxis: {
                      data:[]
                  },
                  yAxis: {},
                  series: [
                      {
                          name: '确诊',
                          type: 'line',
                          data:[]
                      },
                      {
                          name: '疑似',
                          type: 'line',
                          data:[]
                      },
                      {
                          name: '治愈',
                          type: 'line',
                          data:[]
                      },
                      {
                          name: '死亡',
                          type: 'line',
                          data:[]
                      }
                  ]
              },true)
    </script>
</body>
</html>
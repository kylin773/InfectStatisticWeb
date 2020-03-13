<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>InfectStatisticWeb</title>
<script src="dist/echarts.min.js"></script>
<script src="dist/china.js"></script>
</head>
<body>
	 <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 800px;height:600px;"></div>
    <script type="text/javascript">
    $.ajax({
        "url": "",
        "type": "get",
        "dataType": "json",
        "success": function(data){

        },
        "error": function(data){

        }
    })
    
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '全国疫情地图',
                left: 'center'
            },
            backgroundColor: '#f7f7f7',
            series: [{
                type: 'map',
                map: 'china',
                label: {
                	show: true
                },
                data: []
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</body>
</html>
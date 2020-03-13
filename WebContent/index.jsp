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
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
</head>
<body>
	 <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 800px;height:600px;"></div>
    <script type="text/javascript">
    $.ajax({
        url: "Servlet",
        type: "post",
        async : true,
        dataType: "json",
        contentType: 'text/json,charset=utf-8',
        success : function(json){
			console.log(json)
        	// 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'));

            // 指定图表的配置项和数据
            var option = {
                title: {
                    text: '全国疫情地图',
                    left: 'center'
                },
                backgroundColor: '#f7f7f7',
                tooltip: {
                	formatter: function(params) {
                		console.log(params, 'formatter');
                		return `地区：`+ params.name +` <br/>确诊：` + params.value + `人<br/>死亡：`
                		+ params.data.deadCount + `人`;
                	},
                },
                series: [{
                    type: 'map',
                    map: 'china',
                    label: {
                    	show: true
                    },
                    data: json
                }]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        },
        error : function(err){
        	console.log(err)
        }
    });
    </script>
</body>
</html>
// 1. 引入express
const express = require('express')
const fs = require('fs')
const path = require('path')
// 2. 创建服务器应用
const app = express()
// 3. 监听请求
app.all('*', function(req, response, next) {
 
  //设置允许跨域的域名，*代表允许任意域名跨域
  response.header("Access-Control-Allow-Origin", "*");
  //允许的header类型
  response.header("Access-Control-Allow-Headers", "X-Requested-With");
  //跨域允许的请求方式
  response.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
  //设置响应头信息
  response.header("X-Powered-By",' 3.2.1')
  response.header("Content-Type", "application/json;charset=utf-8");
   
   
   
   
  next();
  });
app.get('/api/data', (req, res) => {
  // 要将爬取到的json数据返回
  fs.readFile(path.join(__dirname, './data.json'), 'utf8', (err, data) => {
    if (err) throw err
    console.log(data)
    res.send(data)
  })
})

// 4. 分配端口号启动服务
app.listen(8066, () => {
  console.log(`当前服务器启动成功 http://127.0.0.1:8066/api/data`)
})

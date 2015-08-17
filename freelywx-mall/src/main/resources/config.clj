(ns config)

(def flag "true");;运行环境(true:公测、false:内测)
(def visit "true");;记录日志(true:启用、false:禁用)

(def member "61");;测试用户(需是数据库中存在，不存在者取第一个用户测试)

(def resPath ".css .js .png .jpg .gif .jpeg");;资源路径(空格分隔)
(def appPath "member order/confirm order/create order/updOrder order/pay tribe/add tribe/adding ");;应用路径(空格分隔)
(def httpUrl "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf06e6587146f9056&redirect_uri=URL&response_type=code&scope=snsapi_base&state=123#wechat_redirect")

;;锋付智能
(def appid "wxf06e6587146f9056")
(def appsecret "aedceb6784f41e9d9db128a9a9511246")

(def admin "0");;管理员编号(逗号分隔)
(def pageSize "10");;分页大小
(def subscribe "http://120.24.73.10/wxmall");  关注链接

(def serverPath "http://120.24.73.10:8999");;nginx服务器地址
(def uploadPath "/opt/weixin/wApp");;nginx文件上传路径


(def crowd_time_out 12)
(def order_time_out 24)
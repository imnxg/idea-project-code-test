﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="assets/css/layui.css">
    <link rel="stylesheet" href="assets/css/login.css">
    <link rel="icon" href="/favicon.ico">
    <title>快递e栈管理后台</title>
</head>
<body class="login-wrap">
    <div class="login-container">
    	<h3>快递e栈后台管理</h3>
        <form class="login-form" action="index.html">
            <div class="input-group">
                <input type="text" id="username" name="username" class="input-field">
                <label for="username" class="input-label">
                    <span class="label-title">用户名</span>
                    <span id="userMsg"></span>
                </label>
            </div>
            <div class="input-group">
                <input type="password" id="password" name="password"  class="input-field">
                <label for="password" class="input-label">
                    <span class="label-title">密码</span>
                    <span id="pwdMsg"></span>
                </label>
            </div>
            <button type="button" class="login-button">登录<i class="ai ai-enter"></i></button>
        </form>
    </div>
</body>
<script src="assets/layui.js"></script>
<script src="js/index.js" data-main="login"></script>
<script src="js/login.js" data-main="login"></script>
<script src="../qrcode/jquery2.1.4.js"></script>
<script src="../layer/layer.js"></script>
<script>
    //页面加载完成后执行
    $(function(){
        $(".login-button").click(function(){
            var username = $("#username").val();
            var password = $("#password").val();
            //进行判断 用户名 密码 是否规范
            $("input[name='username']").blur(function(){
                validateUser();
            });
            //判断密码是否合理
            $("input[name='password']").blur(function(){
                validatePwd();
            });

            //1.先使用layer,弹出load(提示加载中....)
            var windowId = layer.load();
            //2. ajax与服务器交互
            $.post("login.do",{username:username,password:password},function(data){
                //3. 关闭load窗口
                layer.close(windowId);
                //使用closeAll()也可以

                //4. 将服务器回复结果进行显示
                layer.msg(data.result);
                if (data.status == 0){
                    //跳转页面
                    location.assign("index.html");
                }
            },"JSON");
        });
    });

    //用户名
    function validateUser(){
        var userName = $("input[name='username']").val();
        if(userName == ""){
            $("#userMsg").html("用户信息不能为空!").css("color","red");
            return false;
        }else if(/^[a-zA-Z]\w{5,}/.test(userName) == false){
            $("#userMsg").html("用户名不合法").css("color","red");
            return false;
        }else{
            $("#userMsg").html("用户名可用").css("color","green");
            return true;
        }

    }
    //密码验证
    function validatePwd(){
        var pass = $("input[name='password']").val();
        if(pass == ""){
            $("#pwdMsg").html("密码不能为空").css("color","red");
            return false;
        }else if(pass.length<6){
            $("#pwdMsg").html("密码长度不合法！").css("color","red");
            return false;
        }else{
            $("#pwdMsg").html("密码格式正确！").css("color","green");
            return true;
        }
    }

</script>
</html>
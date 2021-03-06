<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2019/6/28
  Time: 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>GavinHRM后台登录</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <!-- load css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/login_style/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/login_style/login.css" media="all">
</head>
<body>
<div class="layui-canvs"></div>
<div class="layui-layout layui-layout-login">
    <h1>
        <strong>GavinHRM管理系统后台</strong>
        <em>Management System</em>
    </h1>
    <form action="${pageContext.request.contextPath}/login.action" method="post" onsubmit="return checkInf();">
    <div class="layui-user-icon larry-login">
        <input type="text" placeholder="账号" class="login_txtbx" name="username" id="loginname"/>
    </div>
    <div class="layui-pwd-icon larry-login">
        <input type="password" placeholder="密码" class="login_txtbx" name="password" id="password"/>
    </div>

    <div class="layui-val-icon larry-login">
        <div class="layui-code-box">
            <input type="text" id="code" name="loginname" placeholder="验证码" maxlength="4" class="login_txtbx">
            <img  alt="点击更换验证码" class="verifyImg" id="verifyImg" onClick="javascript:this.src='${pageContext.request.contextPath}/getVerify.action?'+Math.random();">
        </div>
    </div>
    <div id="upError" style="color: red;height: 10px">${error.error}</div>
    <div class="layui-submit larry-login">
        <input type="submit" value="立即登陆" class="submit_btn" id="sub"/>
    </div>
    </form>
    <div class="layui-login-text">
        <p>© 2019-2059 Gavin 版权所有</p>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/login_style/layui.all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/login_style/login.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/login_style/jparticle.jquery.js"></script>
<script type="text/javascript">
    $(document.body).ready(function (){
        $("#verifyImg").attr("src","${pageContext.request.contextPath}/getVerify.action?"+Math.random());
        ajaxLoadEnd();
    });
    $(function(){
        $(".layui-canvs").jParticle({
            background: "#141414",
            color: "#E6E6E6"
        });
        /*$("#sub").click(function () {
            $.easyui.loading({ msg: "正在加载...", topMost: true });
            window.setTimeout(function () { $.easyui.loaded(true); }, 1000);
        });*/
    });


    //采用jquery easyui loading css效果
    function ajaxLoading(){
        $("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");
        $("<div class=\"datagrid-mask-msg\"></div>").html("正在登录，请稍候。。。").appendTo("body").css({color:"white",display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});
    }
    function ajaxLoadEnd(){
        $(".datagrid-mask").remove();
        $(".datagrid-mask-msg").remove();
    }



    function checkInf(){
        //location.href="index.html";

        var name = $('#loginname').val();
        var pass = $('#password').val();
        var username = $('#code').val();
        username = username.toUpperCase();
        if (name == null || name == ""){
            $('#upError').html("请输入账号");
            return false;
        }
        if (pass == null || pass == "") {
            $('#upError').html("请输入密码");
            return false;
        }
        if (username == null || username == ""){
            $('#upError').html("请输入验证码");
            return false;
        }
        ajaxLoading();
        return true;
    }
</script>
</body>
</html>

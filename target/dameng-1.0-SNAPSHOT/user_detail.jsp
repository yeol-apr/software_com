<%--
  Created by IntelliJ IDEA.
  User: Zhangbaili
  Date: 2023-7-12
  Time: 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户详情</title>
    <script type="text/javascript" charset="UTF-8" src="public/js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" charset="UTF-8" src="public/layer/layer.js"></script>
    <link href="public/js/bootstrap-5.3.0-alpha1-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .user-info-2 {
            display: flex;
            align-items: center;
            margin: 20px;
            padding: 20px;
            background-color: #f5f5f5;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        .user-avatar-2 {
            width: 100px;
            height: 100px;
            margin-right: 20px;
            border-radius: 50%;
            overflow: hidden;
        }
        .user-avatar-2 img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .user-details-2 div {
            margin-bottom: 10px;
        }

        body {
            background-color: #ffffff;
            color: #7d7d7d;
            font-family: Arial, Helvetica, sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;

        }
        .user-info {
            background-color: #000000;
            padding: 20px;
            margin-bottom: 20px;
        }
        .user-info h2 {
            margin-top: 0;
            color: #ffffff; /* Added to change the heading color to white */
        }
        .user-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-gap: 20px;
        }
        .user-details div {
            margin-bottom: 10px;
            color: #000000; /* Added to change the text color to white */
        }
        .user-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-actions button {
            background-color: #ffffff;
            color: #000000;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
        .user-history {
            margin-top: 20px;
            border-top: 1px solid #ccc;
            padding-top: 20px;
        }
        .user-history ul {
            list-style-type: none;
            padding: 0;
        }
        .user-history li {
            margin-bottom: 10px;
        }
        .return-button a {
            background-color: #ffffff;
            color: #000000;
            padding: 10px 20px;
            text-decoration: none;
        }
    </style>
</head>
<body>
<%--导航栏start--%>
<%@include file="main.jsp"%>
<%--导航栏end--%>
<div class="container" style="width: 1000px;margin-left: 400px">
    <div class="user-info" style="border-radius: 25px;">
        <h2>用户信息</h2>
        <div class="user-info-2" style="border-radius: 25px;">
            <div class="user-avatar-2">
                <img src="public/images/usercute.jpg" alt="用户头像">
            </div>
            <div class="user-details">
                <div>
                    <strong>用户名:</strong> ${user.USERNAME}
                </div>
                <div>
                    <strong>角色:</strong> ${user.GROUP}
                </div>
                <div>
                    <strong>联系方式:</strong> ${user.USERNAME}.doe@163.com
                </div>
                <div>
                    <strong>姓名:</strong> ${user.NAME}
                </div>
                <div>
                    <strong>邮箱:</strong> ${user.USERNAME}.doe@163.com
                </div>
                <div>                                       
                    <strong>所属部门:</strong> 研发部门
                </div>
                <div> <!-- Added a new user detail -->
                    <strong>地址:</strong> 123 Main St
                </div>
                <button class="btn btn-danger" onclick="quit_to_login()">退出登录</button>
            </div>
        </div>
        <div class="user-actions">
            <button class="btn btn-primary">编辑</button>
            <button class="btn btn-primary">重置密码</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="user-history">
        <h2>历史记录</h2>
        <ul>
            <li>操作类型: 编辑用户信息, 时间: 2021-01-01, 执行者: Admin</li>
            <li>操作类型: 重置密码, 时间: 2021-01-02, 执行者: Admin</li>
            <li>操作类型: 删除用户, 时间: 2021-01-03, 执行者: Admin</li>
        </ul>
    </div>
</div>
<script>
        function quit_to_login()
        {
            window.location.href="login.jsp";
            return;
        }

    const avatar = document.querySelector('.user-avatar-2');
    const details = document.querySelector('.user-details');

    avatar.addEventListener('mouseover', () => {
        avatar.style.transform = 'scale(1.2)';
        avatar.style.transition = 'transform 0.5s';
        details.style.opacity = '0.5';
        details.style.transition = 'opacity 0.5s';
    });

    avatar.addEventListener('mouseout', () => {
        avatar.style.transform = 'scale(1)';
        avatar.style.transition = 'transform 0.5s';
        details.style.opacity = '1';
        details.style.transition = 'opacity 0.5s';
    });
</script>
</body>
</html>


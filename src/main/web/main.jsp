<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/6/28
  Time: 9:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link href="public/js/bootstrap-5.3.0-alpha1-dist/css/bootstrap.min.css" rel="stylesheet"/>

    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .b-example-divider {
            height: 3rem;
            background-color: rgba(0, 0, 0, 0.1);
            border: solid rgba(0, 0, 0, 0.15);
            border-width: 1px 0;
            box-shadow: inset 0 0.5em 1.5em rgba(0, 0, 0, 0.1),
            inset 0 0.125em 0.5em rgba(0, 0, 0, 0.15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -0.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        .li {
            letter-spacing: 2px;
            font: 600 17px "";
            padding: 16px 52px;
            transition: 0.3s;
            position: relative;
        }

        .li::after {
            content: "";
            position: absolute;
            left: 20px;
            margin-top: -22px;
            display: block;
            width: 20px;
            height: 20px;
            background-color: #fff;
            border-radius: 50%;
        }

        .buttons > li:hover {
            background-color: #ffffff;
        }

        .li ul {
            width: 0;
            padding: 60px 0;
            position: absolute;
            top: 0;
            right: 0;
            overflow: hidden;
            background-color: #ecebd4;
            transition: 0.3s;
            border-radius: 25px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .li ul li {
            padding: 16px 24px;
            transition: 0.3s;
        }

        .li:hover ul {
            width: 228px;
            transform: translateX(100%);
        }

        .li ul li:hover {
            background-color: #828eb9;
        }

        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .b-example-divider {
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }
    </style>

    <!-- Custom styles for this template -->
    <link href="public/css/dashboard.css" rel="stylesheet" />
    <link href="public/css/cheatsheet.css" rel="stylesheet" />
</head>
<body>
<header
        class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow py-3"
>
    <div class="container-fluid d-flex align-items-center">
        <h1 class="d-flex align-items-center fs-4 text-white mb-0">
            <img src="public/images/xingqiu.jpg" width="38" height="30" class="me-3" alt="Bootstrap">
            达梦数据中台系统
        </h1>
    </div>
</header>

<div class="container-fluid">
    <div class="row">
        <nav
                id="sidebarMenu"
                class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse"
        >
            <hr class="line">
            <aside class="bd-aside sticky-xl-top text-muted align-self-start mb-3 mb-xl-5 px-2">
                <nav class="small" id="toc">
                    <ul class="list-unstyled">
                        <li class="my-2">
                            <button class="btn d-inline-flex align-items-center collapsed border-0" data-bs-toggle="collapse" aria-expanded="false" data-bs-target="#contents-collapse" aria-controls="contents-collapse" style="font-size: x-large">介绍</button>
                            <ul class="list-unstyled ps-3 collapse" id="contents-collapse">
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="data_introduction.jsp" style="font-size:17px">系统介绍</a></li>
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="user_detail.jsp" style="font-size:17px">账号详情</a></li>
                            </ul>
                        </li>
                        <li class="my-2">
                            <button class="btn d-inline-flex align-items-center collapsed border-0" data-bs-toggle="collapse" aria-expanded="false" data-bs-target="#forms-collapse" aria-controls="forms-collapse" style="font-size: x-large">数据提取</button>
                            <ul class="list-unstyled ps-3 collapse" id="forms-collapse">
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="data_extraction.jsp" style="font-size:17px">提取数据源</a></li>
                            </ul>
                        </li>
                        <li class="my-2">
                            <button class="btn d-inline-flex align-items-center collapsed border-0" data-bs-toggle="collapse" aria-expanded="false" data-bs-target="#components-collapse-2" aria-controls="components-collapse" style="font-size: x-large">数据治理</button>
                            <ul class="list-unstyled ps-3 collapse" id="components-collapse-2">
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="data_govern.jsp" style="font-size:17px">身份证治理</a></li>
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="data_govern_two.jsp" style="font-size:17px">物流单治理</a></li>
                            </ul>
                        </li>
                        <li class="my-2">
                            <button class="btn d-inline-flex align-items-center collapsed border-0" data-bs-toggle="collapse" aria-expanded="false" data-bs-target="#components-collapse-3" aria-controls="components-collapse" style="font-size: x-large">数据共享</button>
                            <ul class="list-unstyled ps-3 collapse" id="components-collapse-3">
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="data_share.jsp" style="font-size:17px">接口服务</a></li>
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="data_show_databases.jsp" style="font-size:17px">共享数据库</a></li>
                            </ul>
                        </li>
                        <li class="my-2">
                            <button class="btn d-inline-flex align-items-center collapsed border-0" data-bs-toggle="collapse" aria-expanded="false" data-bs-target="#components-collapse" aria-controls="components-collapse" style="font-size: x-large">数据展示</button>
                            <ul class="list-unstyled ps-3 collapse" id="components-collapse">
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="datashow.jsp" style="font-size:17px">详细信息</a></li>
                                <li><a class="d-inline-flex align-items-center rounded text-decoration-none" href="data_show_social.jsp" style="font-size:17px">探讨社会现象</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </aside>
            <hr class="line">
            <rect>
                <img src="public/images/usercute.jpg" alt="logo" style="width:40px;margin-left: 20px;border-radius: 25px">
            </rect>
            <button class="btn btn-outline-danger" onclick="quit_to_login()">退出登录</button>
        </nav>
    </div>
</div>
<script src="public/js/bootstrap-5.3.0-alpha1-dist/js/bootstrap.bundle.min.js"></script>

<script src="public/js/cheatsheet.js"></script>

<script>
    function quit_to_login()
    {
        window.location.href="login.jsp";
        return;
    }
</script>
</body>
</html>
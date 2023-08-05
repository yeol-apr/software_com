<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/6/28
  Time: 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        /* 导航栏样式 */
        .navbar-intro {
            margin-left: 45px;
            background-color: rgba(242,242,242,0.8);
            position: fixed;
            top: 60px;
            left: 200px;
            width: 100%;
            z-index: 1;
        }

        .ul-intro {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .li-intro {
            float: left;
        }

        .li-intro a {
            display: block;
            color: black;
            text-align: center;
            padding: 7px 16px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .li-intro a:hover {
            background-color: #9F9F9F;
        }

        /* 页面内容样式 */
        body {
            margin: 0;
        }

        /*section {*/
        /*    height: 100vh; !* 设置内容区域的高度为视口高度 *!*/
        /*    display: flex;*/
        /*    align-items: center;*/
        /*    justify-content: center;*/
        /*    font-size: 48px;*/
        /*}*/

        /* 活动导航栏字段样式 */
        .active-nav {
            background-color: #9F9F9F!important;
        }
        .feature-container {
            display: flex;
            flex-flow: row wrap;
            justify-content: space-between;
        }
        .feature-box {
            width: 500px;
            height: 250px;
            padding: 20px;
            margin-bottom: 20px;
            background-color: #f2f2f2;
        }
        .feature-title {
            font-weight: bold;
            font-size: xx-large;
        }
        .feature-description {
            margin-top: 10px;
            font-size: large;
        }
        .feature-action {
            background-color: #f2f2f2;
            display: flex;
            justify-content: space-between;
            margin-top: 60px;
        }
        .feature-actions {
            background-color: #f2f2f2;
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .learn-more {
            color: #333;
            text-decoration: none;
            font-size: x-large;
        }
        .try-now {
            background-color:#6FA5DB;
            width: 100px;
            height: 50px;
            border-radius: 25px;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            font-size: x-large;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .abcd {
            padding: 10px;
            margin: 10px;
            display: flex;
            border: none;
            flex-direction: column;
        }
        .abcd:hover .details {
            display: block;
        }
        .details {
            display: none;
            position: relative;
            top:-387px;
            left: 0;
            width: 250px;
            height: 350px;
            padding: 10px;
            background-color: rgba(242,242,242,0.8);
            font-size: large;
        }
        .all_container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-template-rows: repeat(2, 1fr);
            grid-gap: 10px;
            text-align: center;
            font-size: large;
            position: relative;
            left: 0px;
            top: 0px;
        }

        .all_box {
            border: none;
            width:  340px;
            height: 240px;
        }


        .all_overlay {
            position: relative;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: black;
            opacity: 0;
            color: white;
            padding: 5px;
            transition: opacity 0.3s;
        }

    </style>
    <title>介绍</title>
    <link href="public/css/function.css" type="text/css" rel="stylesheet">
</head>
<body>
<%--侧边栏start--%>
<%@include file="main.jsp"%>
<%--侧边栏end--%>
<!--
 创建导航栏，与首页内容通过id关联，实现跳转
-->
<nav class="navbar-intro" id="navbar">
    <ul class="ul-intro">
        <li class="li-intro"><a class="nav-item-intro" href="#solution">方案构建</a></li>
        <li class="li-intro"><a class="nav-item-intro" href="#advantages">方案优势</a></li>
        <li class="li-intro"><a class="nav-item-intro" href="#our-products">我们的产品</a></li>
        <li class="li-intro"><a class="nav-item-intro" href="#recommended-scenarios">推荐场景</a></li>
        <li class="li-intro"><a class="nav-item-intro" href="#data-coverage">全链物流数据覆盖</a></li>
    </ul>
</nav>

<div id="myCarousel" class="carousel slide" data-bs-ride="carousel" style=";margin-left: 225px;height: 60%;">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="${pageContext.request.contextPath}/public/images/dameng1.png" class="img-fluid" alt="...">
            <div class="container">
                <div class="carousel-caption text-start">
                    <h1>达梦数据中台系统</h1>
                    <p>基于达梦云原生大数据平台的物流信息分析系统，采集、治理和展示物流大数据，帮助港口优化运营决策，掌握未来趋势。</p>
                    <p><a class="btn btn-lg btn-primary" href="#">Sign up today</a></p>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/public/images/342.png" class="img-fluid" alt="...">
            <div class="container">
                <div class="carousel-caption">
                    <h1>达梦数据中台系统</h1>
                    <p>基于达梦云原生大数据平台的物流信息分析系统，采集、治理和展示物流大数据，帮助港口优化运营决策，掌握未来趋势。</p>
                    <p><a class="btn btn-lg btn-primary" href="#">Learn more</a></p>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/public/images/522.png" class="img-fluid" alt="...">
            <div class="container">
                <div class="carousel-caption text-end">
                    <h1>达梦数据中台系统</h1>
                    <p>基于达梦云原生大数据平台的物流信息分析系统，采集、治理和展示物流大数据，帮助港口优化运营决策，掌握未来趋势。</p>
                    <p><a class="btn btn-lg btn-primary" href="#">Browse gallery</a></p>
                </div>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<section id="solution" class="p-5 mb-4 bg-light rounded-3" style="margin-left: 200px;">
    <div class="container-fluid py-5">
        <h2 style="margin-left: 500px">方案构建</h2>
        <hr class="border border-3 opacity-75">
    </div>
    <img class="img-fluid" src="public/images/fangan.jpg" alt="描述图片的文字">
</section>

<section id="advantages">
        <div class="container-fluid py-5">
            <h2 style="margin-left: 775px">方案优势</h2>
            <hr class="border border-3 opacity-75">
        </div>

            <div class="row" style="margin-left: 300px;">
                <div class="col-lg-4">
                    <img src="public/images/付费图片.png" alt="描述图片的文字" style="width: 200px;height: 140px;">
                    <hr class="border border-3 opacity-75">
                    <h2 class="fw-normal">达梦云原生大数据平台</h2>
                    <p>基于达梦云原生大数据平台，系统平台可以集中管理和协调多个组件和功能。它提供了一个统一的管理界面，可以简化系统配置、监视和维护的操作。</p>
                    <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
                </div><!-- /.col-lg-4 -->
                <div class="col-lg-4">
                    <img src="public/images/图表展示3.png" alt="描述图片的文字" style="width: 200px;height: 140px;">
                    <hr class="border border-3 opacity-75">
                    <h2 class="fw-normal">DMETL</h2>
                    <p>通过DMETL平台具有灵活的架构和模块化设计，可以根据用户需求进行定制和扩展。根据具体业务需求添加、移除或替换组件，从而实现灵活性和可扩展性。</p>
                    <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
                </div><!-- /.col-lg-4 -->
                <div class="col-lg-4">
                    <img src="public/images/等待中.png" alt="描述图片的文字" style="width: 200px;height: 140px;">
                    <hr class="border border-3 opacity-75">
                    <h2 class="fw-normal">达梦大数据分析平台</h2>
                    <p>可以帮助用户更好地理解和分析数据。通过多维度图，帮助用户可以快速了解港口状态、趋势和关键指标，并与数据进行交互以进行进一步的分析和决策。</p>
                    <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
                </div><!-- /.col-lg-4 -->

        </div>
</section>

<section id="our-products" style="margin-left: 350px;">
    <div style="margin-top: 200px">
        <h2 style="margin-left: 425px">我们的产品</h2>
        <hr style="margin-bottom: 100px;" class="border border-3 opacity-75">
<%--        <div>--%>
            <div style="border-radius:25px;" class="feature-container">
                <div class="feature-box" style="border-radius: 25px">
                    <div class="feature-title">
                        <img src="public/images/one.png" style="width: 40px;height: 40px">数据提取</div>
                    <div class="feature-description">
                        多种数据源，实现可动态管理（创建，修改，删除）数据源，灵活的数据源管理功能。
                    </div>
                    <div class="feature-action">
                        <a class="learn-more" href="data_extraction.jsp ">了解详情</a >
                        <button class="try-now" ><a href="data_extraction.jsp " style="color: white;text-decoration: none">体验</a></button>
                    </div>
                </div>
            </div>
            <div style="border-radius:25px;position: relative;left: 540px;top: -270px">
                <div class="feature-box" style="border-radius: 25px">
                    <div class="feature-title">
                        <img src="public/images/two.png" style="width: 40px;height: 40px">数据治理</div>
                    <div class="feature-description">
                        根据制定的数据治理规则，将正常数据和异常数据分开存放。异常数据提供处理界面，并能重新治理，可根据数据溯源查看修改前后数据。
                    </div>
                    <div class="feature-actions">
                        <a class="learn-more" href="data_govern.jsp">了解详情</a >
                        <button class="try-now" ><a href="data_govern.jsp" style="color: white;text-decoration: none">体验</a></button>
                    </div>
                </div>
            </div>
            <div style="border-radius:25px;position: relative;left: 0px;top: -255px">
                <div class="feature-box" style="border-radius: 25px">
                    <div class="feature-title">
                        <img src="public/images/three.png" style="width: 40px;height: 40px">数据共享</div>
                    <div class="feature-description">
                        存储治理后的数据，对外提供数据服务（接口服务、共享数据库）。
                    </div>
                    <div class="feature-action">
                        <a class="learn-more" href="data_share.jsp">了解详情</a >
                        <button class="try-now"><a href="data_share.jsp" style="color: white;text-decoration: none">体验</a></button>
                    </div>
                </div>
            </div>
            <div style="border-radius:25px;position: relative;left: 540px;top: -525px">
                <div class="feature-box" style="border-radius: 25px">
                    <div class="feature-title">
                        <img src="public/images/four.png" style="width: 40px;height: 40px">数据展示</div>
                    <div class="feature-description">
                        基于给出的数据集，结合其他数据集以充实数据分析，运用数据思维，发现与解释数据趋势现象，探讨与解决社会问题。
                    </div>
                    <div class="feature-actions">
                        <a class="learn-more" href="datashow.jsp">了解详情</a >
                        <button class="try-now" ><a href="datashow.jsp" style="color: white;text-decoration: none">体验</a></button>
                    </div>
                </div>
            </div>
<%--        </div>--%>
    </div>

</section>
<!--
<%-- 鼠标滑到图片时，详解文字滑出覆盖到图片上面进行解释--%>
-->


<div class="p-5 mb-4 bg-light rounded-3">
    <section id="recommended-scenarios">
        <h2 style="margin-left: 700px">推荐场景</h2>
        <hr class="border border-3 opacity-75">
        <div class="container">
            <div style="position: absolute;left: 420px;top: 2200px">
                <div class="abcd" style="margin-top: 1150px;border-radius: 25px">
                    <img src="public/images/image1.jpg" alt="图片1" style="width:250px;height: 350px;margin-top: 350px;border-radius: 25px">
                    <div style="font-size: large;width: 100%;margin-top: 10px;position: relative;left: 28px;top: 0px">提供精准的港口数据分析</div>
                    <div class="details">
                        基于港口运营数据和相关指标进行深入分析和解读的专业技术。通过对港口的吞吐量、不同类型货物吞吐趋势、货物吞吐同比环比、不同货物吞吐占比、货物流向等等进行分析，以充实数据分析，运用数据物理等思维，发现与解释经济社会现象，揭示出港口运营的关键信息和趋势，实现可持续发展和增强市场地位。
                    </div>
                </div>
            </div>
            <div style="position: absolute;left:920px;top: 2200px">
                <div class="abcd" style="margin-top: 1150px;">
                    <img src="public/images/image2.jpg" alt="图片2" style="width: 250px;height: 350px;margin-top: 350px;border-radius: 25px">
                    <div style="font-size: large;width: 100%;margin-top: 10px;position: relative;left: 33px;top: 0px">一站式物流数据服务平台</div>
                    <div class="details">
                        帮助物流行业的参与者更好地利用数据来改善运营和管理，通过物流信息数据中台系统的溯源、分析等功能，实现物流过程的数字化转型和智能化发展。通过统一的数据平台，用户可以更高效地掌握信息、做出决策，并与其他参与者进行合作，共同推进物流行业的创新和持续改进。
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<div class="p-5 mb-4 bg-light rounded-3">
    <div class="container-fluid py-5" style="margin-top: 625px;margin-left: 675px">
        <h2>全链物流数据覆盖</h2>
        <hr class="border border-3 opacity-75">
    </div>
    <section id="data-coverage" class="d-md-flex flex-md-equal w-100 my-md-3 ps-md-3" style="margin-left: 300px">
        <div class="all_container">
            <div class="all_box">
                <img src="public/images/all_one.jpg" alt="Image 1" style="width: 320px;height: 220px;position: relative;left: 0px;top: 0px;border-radius: 25px">
                订单管理
            </div>

            <div class="all_box">
                <img src="public/images/all_two.jpg" alt="Image 2"  style="width: 320px;height: 220px;position: relative;left: 0px;top: 0px;border-radius: 25px">
                运输管理
            </div>
            <div class="all_box">
                <img src="public/images/all_five.jpg" alt="Image 5" style="width: 340px;height: 440px;position: relative;left: 0px;top: 0px;border-radius: 25px" >
                数据分析与业务智能
            </div>
            <div class="all_box">
                <img src="public/images/all_three.jpg" alt="Image 4" style="width: 340px;height: 190px;position: relative;left: 0px;top: 0px;border-radius: 25px" >
                数据分析与业务智能
            </div>
            <div class="all_box">
                <img src="public/images/all_four.jpg" alt="Image 3" style="width: 340px;height: 190px;position: relative;left: 0px;top: 0px;border-radius: 25px" >
                数据分析与业务智能
            </div>
        </div>
    </section>
</div>


<!--
 滑动到特定内容时，导航栏相应的字段高亮
-->
<script>
    const navbar = document.getElementById("navbar");
    const navLinks = navbar.getElementsByClassName("nav-item-intro");
    window.addEventListener("scroll", function() {
        const currentPos = window.scrollY + 200;

        for (let i = 0; i < navLinks.length; i++) {
            const section = document.getElementById(navLinks[i].getAttribute("href").substring(1));

            if (section.offsetTop <= currentPos &&
                section.offsetTop + section.offsetHeight > currentPos) {
                navLinks[i].classList.add("active-nav");
            } else {
                navLinks[i].classList.remove("active-nav");
            }
        }
    });
</script>
</body>
</html>

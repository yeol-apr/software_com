<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>数据展示</title>
    <link href="public/js/bootstrap-5.3.0-alpha1-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script type="text/javascript" charset="UTF-8" src="public/js/jquery-1.10.1.min.js"></script>
    <link href="public/css/dashboard.css" rel="stylesheet"/>
</head>
<body>
<%--导航栏start--%>
<%@include file="main.jsp" %>
<%--导航栏end--%>
<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">数据展示</h1>
            </div>

            <%--（1）港口的吞吐量分析tstart--%>
            <h4 class="mb-3">（1）港口的吞吐量分析</h4>
            <div class="col-sm-6" >
                <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                    <img style="width: 250px;height: 150px;" src="public/images/2022年吞吐量.png"><br>
                    <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=1676768287049916418&isTemplate=0" target="_blank">2022年港口吞吐量</a>
                </button>
            </div>
            <%--（1）港口的吞吐量分析tstart--%>

            <hr class="my-4">

            <%-- （2）港口不同类型货物吞吐趋势start--%>
            <div class="table-responsive">
                <h4 class="mb-3">（2）港口不同类型货物吞吐趋势</h4>
                <div class="col-sm-6" >
                    <div style="display: flex;flex-direction: row">
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐趋势/杭州港吞吐趋势.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=7a88e3c28d8e8507fe0182a495e7bc4e&isTemplate=0" target="_blank">
                                2022杭州港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐趋势/铜陵港吞吐趋势.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=8776d5795cd3ab21b730e78a06886290&isTemplate=0" target="_blank">
                                2022铜陵港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐趋势/马鞍山港趋势.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=fb9bcdcc7f64a9bd4f7a055270f99a3d&isTemplate=0" target="_blank">
                                2022马鞍山港
                            </a>
                        </button><br/>
                    </div>
                    <div style="display: flex;flex-direction: row">
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;"
                                 src="public/images/不同货物吞吐趋势/镇江港吞吐趋势.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=0e4fee88197f80d63d5d8eb1dab14836&isTemplate=0"
                               target="_blank">
                                2022镇江港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐趋势/苏州港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=1676781615679807490&isTemplate=0"
                               target="_blank">
                                2022苏州港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐趋势/南通港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=1496e5487878f8916854a131f9bd0ffb&isTemplate=0"
                               target="_blank">
                                2022南通港
                            </a>
                        </button>
                        <br/>
                    </div>
                    <div style="display: flex;flex-direction: row">
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐趋势/泰州港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=4c419ea886c64cca66ab007b13e3b328&isTemplate=0"
                               target="_blank">
                                2022泰州港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐趋势/太仓港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=26aef2860ae87379bd85b39d2ae31227&isTemplate=0"
                               target="_blank">
                                2022太仓港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐趋势/芜湖港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=81106169899cfd6750a6711f9aec8331&isTemplate=0"
                               target="_blank">
                                2022芜湖港
                            </a>
                        </button>
                    </div>
                </div>
            </div>
            <%-- （2）港口不同类型货物吞吐趋势end--%>

            <hr class="my-4">

            <%--（3）港口货物吞吐同比环比start--%>
            <div class="table-responsive">
                <h4 class="mb-3">（3）港口货物吞吐同比环比</h4>
                <div class="col-sm-6" >
                    <div style="display: flex;flex-direction: row">
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/杭州港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=1aaa5b3837d88a82d9d2f18a13136143&isTemplate=0"
                               target="_blank">
                                2022杭州港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/铜陵港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=9a2163b74e62c167af3eee9a04c8e5b4&isTemplate=0"
                               target="_blank">
                                2022铜陵港
                            </a>

                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/马鞍山港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=5e67db623f23dfae8a4a130da751500b&isTemplate=0"
                               target="_blank">
                                2022马鞍山港
                            </a>
                        </button>
                        <br/>
                    </div>
                    <div style="display: flex;flex-direction: row">
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/镇江港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=8fdecc7635c2ea5a816a2c735f02c06d&isTemplate=0"
                               target="_blank">
                                2022镇江港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/苏州港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=1676892333481676802&isTemplate=0"
                               target="_blank">
                                2022苏州港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/南通港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=de2040b160bf3397388edbbbcd06a37c&isTemplate=0"
                               target="_blank">
                                2022南通港
                            </a>
                        </button>
                        <br/>
                    </div>
                    <div style="display: flex;flex-direction: row">
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/泰州港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=2a106c08d5089edaf472746a8a5ef914&isTemplate=0"
                               target="_blank">
                                2022泰州港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/太仓港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=8011b3c4bc18bcc8ef955a3fafbc8d23&isTemplate=0"
                               target="_blank">
                                2022太仓港
                            </a>
                        </button>
                        <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;"
                                onclick="getInvalidList()">
                            <img style="width: 250px;height: 150px;" src="public/images/港口货物占比/芜湖港.png">
                            <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=428d221ec57b633819ac328c2763f070&isTemplate=0"
                               target="_blank">
                                2022芜湖港
                            </a>
                        </button>
                    </div>
                </div>
            </div>
            <%--（3）港口货物吞吐同比环比end--%>

            <hr class="my-4">

            <%-- （4）不同货物吞吐占比start--%>
            <div class="table-responsive">
                <h4 class="mb-3">（4）不同货物吞吐占比</h4>
                <div class="col-sm-6" >
                    <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                        <img style="width: 250px;height: 150px;" src="public/images/不同货物吞吐占比2022.png"><br>
                        <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=1676791800276197377&isTemplate=0" target="_blank">
                            2022年不同货物吞吐占比
                        </a>
                    </button>
                </div>
            </div>
            <%-- （4）不同货物吞吐占比end--%>

            <hr class="my-4">

            <%--（5）不同货物流向分析start--%>
            <div class="table-responsive">
                <h4 class="mb-3">（5）不同货物流向分析</h4>
                <div class="col-sm-6" >
                    <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                        <img style="width: 250px;height: 150px;" src="public/images/货物流向.png"><br>
                        <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=1674301832471519234&isTemplate=0" target="_blank">
                            2022年不同货物流向分析
                        </a>
                    </button>
                </div>
            </div>
            <%--（5）不同货物流向分析end--%>

            <hr class="my-4">

            <%--（6）不同类型货物堆场流转周期分析start--%>
            <div class="table-responsive">
                <h4 class="mb-3">（6）不同类型货物堆场流转周期分析</h4>
                <div class="col-sm-6" >
                    <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList()">
                        <img style="width: 250px;height: 150px;" src="public/images/货物堆场周期.png"><br>
                        <a href="https://datav.dameng.com/dataview/publish/page.html?pageId=1676782455652098050&isTemplate=0" target="_blank">
                            2022年不同类型货物堆场流转周期分析
                        </a>
                    </button>

                </div>
            </div>
            <%--（6）不同类型货物堆场流转周期分析end--%>
            <hr class="my-4">


        </main>
    </div>
</div>


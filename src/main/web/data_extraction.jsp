<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/6/28
  Time: 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="public/js/bootstrap-5.3.0-alpha1-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script type="text/javascript" charset="UTF-8" src="public/js/jquery-1.10.1.min.js"></script>
    <link href="public/css/function.css" type="text/css" rel="stylesheet">
    <title>数据提取</title>
    <style>
        .cz {
            display: flex;
            align-items: center;
        }
        .cm_cz{
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .cm_table tr{
            height: 40px;
            text-align: center;
            line-height: 40px;
        }
        .cm_table-striped > tbody > tr:nth-child(odd) > th{
            background-color:#716f6f; color:#fff;
            text-align: center;
        }
    </style>
</head>
<body>
<%--导航栏start--%>
<%@include file="main.jsp" %>
<%--导航栏end--%>
<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">数据提取</h1>
            </div>
            <div class="form-group" style="margin: 40px auto">
                <div style="display: flex;flex-direction:row;left: 350px;" class="cz">
                    <div style="font-size: large;">数据源：</div>
                    <br>
                    <div>
                        <select class="form-select form-select-sm" id="sel1" onblur="cc()">
                            <option value="mysql">MySQL数据库</option>
                            <option value="hdfs">hdfs存储(数据格式：txt)</option>
                            <option value="minio">minio存储(数据格式：csv、xls)</option>
                        </select>
                    </div>
                   <button class="btn btn-secondary" style="margin-left: 30px" onclick="extract()">开始提取</button>
                </div>
            </div>



            <%--            下拉框切换时显示不同的表--%>
            <div id="labelList" style="display: flex;flex-direction: row;margin: 15px auto"></div>

            <text >部分提取结果</text>
            <div class="table-responsive" style="margin-top: 15px">
                <%--user2021-2022  start--%>
                <table id="one"  style="display: none" class="cm_table-striped cm_table Table_tc cm_table-bordered Table table table-striped table-sm ">
                    <tbody>
                    <tr>
                        <th>序号</th>
                        <th>客户名称</th>
                        <th>客户编号</th>
                        <th>手机号</th>
                        <th>省市区</th>
                    </tr>
                    <tbody id="dataTable1"></tbody>
                </table>
                <%--user2021-2022  end--%>

                <%--物流信息start--%>
                <table id="two"  style="display: none" class="cm_table-striped cm_table Table_tc cm_table-bordered Table table table-striped table-sm ">
                    <tbody>
                    <tr>
                        <th style="text-align: left;margin-left: 12px">提单号/物流公司</th>
                        <th style="text-align: left;margin-left: 12px">货主名称</th>
                        <th style="text-align: left;margin-left: 12px">货主代码</th>
                        <th style="text-align: left;margin-left: 12px">集装箱箱号</th>
                        <th style="text-align: left;margin-left: 12px">货物名称/货重</th>
                    </tr>
                    <tbody  id="dataTable2"></tbody>
                </table>
                <%--物流信息end--%>

                <%--装货表start            --%>
                <table id="three"  style="display: none" class="cm_table-striped cm_table Table_tc cm_table-bordered Table table table-striped table-sm ">
                    <tbody>
                    <tr>
                        <th>船公司</th>
                        <th>船名称</th>
                        <th>到达时间</th>
                        <th>作业港口</th>
                        <th>提单号</th>
                        <th>集装箱箱号</th>
                        <th>启运地/目的地</th>
                    </tr>
                    <tbody id="dataTable3"></tbody>
                </table>
                <%--装货表start --%>

                <%--卸货表start --%>
                <table id="four"  style="display: none" class="cm_table-striped cm_table Table_tc cm_table-bordered Table table table-striped table-sm ">
                    <tbody>
                    <tr>
                        <th>船公司</th>
                        <th>船名称</th>
                        <th>到达时间</th>
                        <th>作业港口</th>
                        <th>提单号</th>
                        <th>集装箱箱号</th>
                        <th>启运地/目的地</th>
                    </tr>
                    <tbody  id="dataTable4"></tbody>
                </table>
                <%--卸货表start --%>

                <%--            集装箱动态start--%>
                <table id="five"  style="display: none" class="cm_table-striped cm_table Table_tc cm_table-bordered Table table table-striped table-sm ">
                    <tbody>
                    <tr>
                        <th>堆存港口</th>
                        <th>集装箱箱号</th>
                        <th>箱状态</th>
                        <th>提单号</th>
                        <th>堆场位置</th>
                        <th>操作</th>
                        <th>操作日期</th>
                    </tr>
                    <tbody id="dataTable5"></tbody>
                </table>
                <%--  集装箱动态end--%>


                <%--物流公司信息start--%>
                <table id="six"  style="display: none" class="cm_table-striped cm_table Table_tc cm_table-bordered Table table table-striped table-sm ">
                    <tbody>
                    <tr>
                        <th>公司名称</th>
                        <th>客户编号</th>
                        <th>联系人</th>
                        <th>电话</th>
                        <th>省市区</th>
                    </tr>
                    <tbody id="dataTable6"></tbody>
                </table>
                <%-- 物流公司信息end --%>
            </div>

        </main>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function (){
        cc("mysql");
    })

    $('#two').hide();
    $('#three').hide();
    $('#one').hide();
    $('#five').hide();
    $('#six').hide();
    $('#seven').hide();
    $('#four').hide();

    //单选框切换监听
    function cc(flag) {
        $('#two').hide();
        $('#three').hide();
        $('#neo').hide();
        $('#five').hide();
        $('#six').hide();
        $('#seven').hide();
        $('#four').hide();

        var ss = $("#sel1").val();
        if(flag == 'mysql'){
            ss = "mysql"
        }
        if (ss == "mysql") {
            $("#labelList").empty();
            $("#labelList").append("<button   id='user' class='btn btn-sm btn-outline-secondary cm_cz' onclick='one()'>客户表2021-2022</button>");
            one();
        }
        if (ss == "hdfs") {

            $("#labelList").empty();
            $("#labelList").append("<button id='hdfs1' class='btn btn-sm btn-outline-secondary cm_cz' onclick='two()'>物流信息2021-2022</button>" +
                "<button  id='hdfs2' class='btn btn-sm btn-outline-secondary cm_cz'  style='margin-left: 20px' onclick='three()'>卸货表2021-2022</button>" +
                "<button id='hdfs3' class='btn btn-sm btn-outline-secondary cm_cz' style='margin-left: 20px' onclick='four()'>装货表2021-2022</button>");
            two();
        }
        if (ss == "minio") {
            $("#labelList").empty();
            $("#labelList").append("<button id='minio1' class='btn btn-sm btn-outline-secondary cm_cz'  onclick='five()'>集装箱动态2021-2022</button>" +
                "<button id='minio2' class='btn btn-sm btn-outline-secondary cm_cz' style='margin-left: 20px' onclick='six()'>物流公司2021-2022</button>");
            five();
        }
    }

    /**
     * 查询客户表
     */
    function one() {
        $('#two').hide();
        $('#three').hide();
        $('#one').show();
        $('#four').hide();
        $('#five').hide();
        $('#six').hide();

        //切换时显示样式
        $('#user').css( 'background-color', '#6c757d');
        $('#user').css( 'color', '#ffffff');

        var extract = "客户表";
        var dataTable = $('#dataTable1');
        dataTable.html('');
        $.ajax({
            url: "extract",
            data: {"extract": extract},
            dataType: "JSON",
            type: "post",
            success: function (res) {
                if (res.code == 1) {
                    var data = res.data;
                    for (var i = 0; i < data.length; i++) {
                        var tr = ' <tr >' +
                            '<td>' + (i+1) + '</td>' +
                            '<td>' + data[i].客户名称 + '</td>' +
                            '<td>' + data[i].客户编号 + '</td>' +
                            '<td>' + data[i].手机号 + '</td>' +
                            '<td>' + data[i].省市区 + '</td>' +
                            '</tr>';
                        dataTable.append(tr)
                    }
                } else {
                    dataTable.append('<tr><td colspan="5">暂无数据</td></tr>')
                }
            },
            error: function (res) {
                console.log('请求失败');
            }
        })
    }

    /**
     * 物流信息
     */
    function two() {
        $('#two').show();
        $('#three').hide();
        $('#one').hide();
        $('#four').hide();
        $('#five').hide();
        $('#six').hide();

        //切换时显示样式
        $('#hdfs1').css( 'background-color', '#6c757d');
        $('#hdfs1').css( 'color', '#ffffff');
        $('#hdfs2').css( 'background-color', '#ffffff');
        $('#hdfs2').css( 'color', '#6c757d');
        $('#hdfs3').css( 'background-color', '#ffffff');
        $('#hdfs3').css( 'color', '#6c757d');

        var extract = "物流信息";
        var dataTable = $('#dataTable2');
        dataTable.html('');
        $.ajax({
            url: "extract",
            data: {"extract": extract},
            dataType: "JSON",
            type: "post",
            success: function (res) {
                //console.log('----',res);
                if (res.code == 1) {
                    var data = res.data;
                    for (var i = 0; i < data.length; i++) {
                        var tr = ' <tr >' +
                            '<td style="text-align: left;margin-left: 12px">' + data[i].提单号 + '<br>'+ data[i].物流公司 +'</td>' +
                            '<td style="text-align: left;margin-left: 12px">' + data[i].货主名称 + '</td>' +
                            '<td style="text-align: left;margin-left: 12px">' + data[i].货主代码 + '</td>' +
                            '<td style="text-align: left;margin-left: 12px">' + data[i].集装箱箱号 + '</td>' +
                            '<td style="text-align: left;margin-left: 12px">' + data[i].货物名称 + '/'+ data[i].货重 +'</td>' +
                            '</tr>';
                        dataTable.append(tr)
                    }
                } else {
                    dataTable.append('<tr><td colspan="5">暂无数据</td></tr>')
                }
            },
            error: function (res) {
                console.log("请求失败");
            }
        })

    }

    /**
     * 卸货表
     */
    function three() {
        $('#two').hide();
        $('#three').show();
        $('#one').hide();
        $('#four').hide();
        $('#five').hide();
        $('#six').hide();

        //切换时显示样式
        $('#hdfs2').css( 'background-color', '#6c757d');
        $('#hdfs2').css( 'color', '#ffffff');
        $('#hdfs1').css( 'background-color', '#ffffff');
        $('#hdfs1').css( 'color', '#6c757d');
        $('#hdfs3').css( 'background-color', '#ffffff');
        $('#hdfs3').css( 'color', '#6c757d');

        var extract = "卸货表";
        var dataTable = $('#dataTable3');
        dataTable.html('');
        $.ajax({
            url: "extract",
            data: {"extract": extract},
            dataType: "JSON",
            type: "post",
            success: function (res) {
                if (res.code == 1) {
                    var data = res.data;
                    for (var i = 0; i < data.length; i++) {
                        var tr = ' <tr >' +
                            '<td>' + data[i].船公司 + '</td>' +
                            '<td>' + data[i].船名称 + '</td>' +
                            '<td>' + data[i].到达时间 + '</td>' +
                            '<td>' + data[i].作业港口 + '</td>' +
                            '<td>' + data[i].提单号 + '</td>' +
                            '<td>' + data[i].集装箱箱号 + '</td>' +
                            '<td>' + data[i].启运地 + '/'+ data[i].目的地 + '</td>' +
                            '</tr>';
                        dataTable.append(tr)
                    }
                } else {
                    dataTable.append('<tr><td colspan="7">暂无数据</td></tr>')
                }
            },
            error: function (res) {
                console.log("请求失败");
            }
        })

    }

    /**
     * 装货表
     */
    function four() {
        $('#two').hide();
        $('#three').hide();
        $('#one').hide();
        $('#four').show();
        $('#five').hide();
        $('#six').hide();

        //切换时显示样式
        $('#hdfs3').css( 'background-color', '#6c757d');
        $('#hdfs3').css( 'color', '#ffffff');
        $('#hdfs1').css( 'background-color', '#ffffff');
        $('#hdfs1').css( 'color', '#6c757d');
        $('#hdfs2').css( 'background-color', '#ffffff');
        $('#hdfs2').css( 'color', '#6c757d');

        var extract = "装货表";
        var dataTable = $('#dataTable4');
        dataTable.html('');
        $.ajax({
            url: "extract",
            data: {"extract": extract},
            dataType: "JSON",
            type: "post",
            success: function (res) {
                if (res.code == 1) {
                    var data = res.data;
                    for (var i = 0; i < data.length; i++) {
                        var tr = ' <tr >' +
                            '<td>' + data[i].船公司 + '</td>' +
                            '<td>' + data[i].船名称 + '</td>' +
                            '<td>' + data[i].到达时间 + '</td>' +
                            '<td>' + data[i].作业港口 + '</td>' +
                            '<td>' + data[i].提单号 + '</td>' +
                            '<td>' + data[i].集装箱箱号 + '</td>' +
                            '<td>' + data[i].启运地 + '/'+ data[i].目的地 + '</td>' +
                            '</tr>';
                        dataTable.append(tr)
                    }
                } else {
                    dataTable.append('<tr><td colspan="7">暂无数据</td></tr>')
                }
            },
            error: function (res) {
                console.log("请求失败");
            }
        })

    }


    /**
     * 集装箱动态
     */
    function five() {
        $('#two').hide();
        $('#three').hide();
        $('#one').hide();
        $('#four').hide();
        $('#five').show();
        $('#six').hide();

        //切换时显示样式
        $('#minio1').css( 'background-color', '#6c757d');
        $('#minio1').css( 'color', '#ffffff');
        $('#minio2').css( 'background-color', '#ffffff');
        $('#minio2').css( 'color', '#6c757d');


        var extract = "集装箱动态";
        var dataTable = $('#dataTable5');
        dataTable.html('');
        $.ajax({
            url: "extract",
            data: {"extract": extract},
            dataType: "JSON",
            type: "post",
            success: function (res) {
                if (res.code == 1) {
                    var data = res.data;
                    for (var i = 0; i < data.length; i++) {
                        var tr = ' <tr >' +
                            '<td>' + data[i].堆存港口 + '</td>' +
                            '<td>' + data[i].集装箱箱号 + '</td>' +
                            '<td>' + data[i].箱状态 + '</td>' +
                            '<td>' + data[i].提单号 + '</td>' +
                            '<td>' + data[i].堆场位置 + '</td>' +
                            '<td>' + data[i].操作 + '</td>' +
                            '<td>' + data[i].操作日期 + '</td>' +
                            '</tr>';
                        dataTable.append(tr)
                    }
                } else {
                    dataTable.append('<tr><td colspan="7">暂无数据</td></tr>')
                }
            },
            error: function (res) {
                console.log("请求失败");
            }
        })

    }


    /**
     * 物流公司
     */
    function six() {
        $('#two').hide();
        $('#three').hide();
        $('#one').hide();
        $('#four').hide();
        $('#five').hide();
        $('#six').show();

        //切换时显示样式
        $('#minio2').css( 'background-color', '#6c757d');
        $('#minio2').css( 'color', '#ffffff');
        $('#minio1').css( 'background-color', '#ffffff');
        $('#minio1').css( 'color', '#6c757d');

        var extract = "物流公司";
        var dataTable = $('#dataTable6');
        dataTable.html('');
        $.ajax({
            url: "extract",
            data: {"extract": extract},
            dataType: "JSON",
            type: "post",
            success: function (res) {
                if (res.code == 1) {
                    var data = res.data;
                    for (var i = 0; i < data.length; i++) {
                        var tr = ' <tr >' +
                            '<td>' + data[i].公司名称 + '</td>' +
                            '<td>' + data[i].客户编号 + '</td>' +
                            '<td>' + data[i].联系人 + '</td>' +
                            '<td>' + data[i].电话 + '</td>' +
                            '<td>' + data[i].省市区 + '</td>' +
                            '</tr>';
                        dataTable.append(tr)
                    }
                } else {
                    dataTable.append('<tr><td colspan="5">暂无数据</td></tr>')
                }
            },
            error: function (res) {
                console.log("请求失败");
            }
        })
    }


</script>
</html>

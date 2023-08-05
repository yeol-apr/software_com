<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/6/28
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false"%>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>身份证治理</title>
    <link href="public/js/bootstrap-5.3.0-alpha1-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script type="text/javascript" charset="UTF-8" src="public/js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" charset="UTF-8" src="public/layer/layer.js"></script>
    <link href="public/css/dashboard.css" rel="stylesheet"/>
    <script src="public/js/bootstrap-5.3.0-alpha1-dist/js/bootstrap.bundle.js"></script>
    <script src="public/js/checkout.js"></script>
    <script type="text/javascript" charset="UTF-8" src="public/layui/layui.js"></script>
    <link  type="text/css" rel="stylesheet" href="public/layui/css/layui.css">
    <style>
        .cm_table tr{
            height: 40px;
            text-align: center;
            line-height: 40px;
        }
        .cm_table-striped > tbody > tr:nth-child(odd) > th{
            background-color:#716f6f; color:#fff;
            text-align: center;
        }
        .cm_btn{
            background-color: #9ec5fe;
            color: white;
            width: 50px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
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
                <h1 class="h2">身份证治理</h1>
            </div>

            <h4 class="mb-3">治理规则</h4>
            <div class="table-responsive">
                <div class="form-check form-check-inline">
                    <input type="checkbox" id="aggregate" name="rule" value="aggregate">
                    <label class="form-check-label" for="aggregate">数据聚合</label>
                </div>

                <div class="form-check form-check-inline">
                    <input type="checkbox" id="deduplication" name="rule" value="deduplication">
                    <label class="form-check-label" for="deduplication">数据去重</label>
                </div>

                <div class="form-check form-check-inline">
                    <input type="checkbox" id="detection" name="rule" value="detection">
                    <label class="form-check-label" for="detection">异常值检测</label>
                </div>

                <div class="form-check form-check-inline">
                    <input type="checkbox" id="conversion" name="rule" value="conversion">
                    <label class="form-check-label" for="conversion">数据转换</label>
                </div>

                <div class="col-sm-6">
                    <button class="btn btn-sm btn-outline-secondary" style="margin: 10px;">开始治理</button>
                </div>
            </div>

            <hr class="my-4">
            <div class="table-responsive">
                <h4 class="mb-3">治理结果</h4>
                <div class="col-sm-6" >
                    <button id="acc" class="btn btn-sm btn-outline-secondary " style="margin: 10px;" onclick="getValidList(1,10)">
                        正常数据
                    </button>
                    <button  id="err" class="btn btn-sm btn-outline-secondary " style="margin: 10px;" onclick="getInvalidList()">
                        异常数据
                    </button>
                    <button  id="suyuan" class="btn btn-sm btn-outline-secondary " style="margin: 10px;" onclick="getSuYuanList()">
                        数据溯源
                    </button>
                </div>
            </div>
            <div class="table-responsive" style="margin-top: 15px">
                <table class="cm_table-striped cm_table Table_tc cm_table-bordered Table table table-striped table-sm ">
                    <tbody id="customersList"></tbody>
                </table>
            </div>
            <div class="cz" id="pagination"  ></div>
        </main>
    </div>
</div>


<%--客户身份证治理弹窗start--%>
<div id="formContainer" style="display:none;">
    <div style="margin-left: 10px;margin-left: 100px">
        <input type="hidden" id="err_id">
        <br>
        <div >客户名：<input  id="name" disabled></div><br>
        <div >身份证：<input  id="certificate_no" ></div><br>
        <div >手机号：<input  disabled id="phone" ></div><br>
        <div >省市区：<input disabled  id="address" ></div><br>
    </div>
    <div  style="display: flex;align-content: center;justify-content: center">
        <button type="submit" style=" border: 0px;
                background-color: #9ec5fe;
                color: white;
                width: 100px;
                line-height: 35px;
                border-radius: 10px;" onclick="saveEdit()">提交</button>
    </div>
</div>
<%--客户身份证治理弹窗end--%>

<script>
    $(function (){
        getValidList(1,10);
    })

    /**
     * 查询正常客户表数据（身份证合法的客户）
     */
    function getValidList(page,limit) {
        $('#pagination').show(); //显示分页
        //正常和异常按钮切换样式显示
        $('#acc').css( 'background-color', '#6c757d');
        $('#acc').css( 'color', '#ffffff');
        $('#err').css( 'background-color', '#ffffff');
        $('#err').css( 'color', '#6c757d');
        $('#suyuan').css( 'background-color', '#ffffff');
        $('#suyuan').css( 'color', '#6c757d');
        //加载
        var loading = layer.load();
        //将表格下面的数据清空
        var customersList = $('#customersList');
        customersList.html('');
        //表头
        var head = ' <tr><th >客户名</th><th>身份证号</th>'+
            '<th >电话号码</th><th >省市区</th></tr>';
        $.ajax({
            data: {"method": "v_data","page":page,"limit":limit},
            url: 'customer',
            dataType: 'JSON',
            type: "get",
            success: function (res) {
                layer.close(loading);  //关闭加载
                if (res.code == 1) {
                    if (res.data.length > 0) {
                        customersList.append(head);
                        for (var i = 0; i < res.data.length; i++) {
                            var tr = '<tr>' +
                                '<td>' + res.data[i].客户名称 + '</td>' +
                                '<td>' + res.data[i].客户编号 + '</td>' +
                                '<td>' + res.data[i].手机号 + '</td>' +
                                '<td>' + res.data[i].省市区 + '</td>' +
                                '</tr>'
                            customersList.append(tr);
                        }
                    }else {
                        customersList.append('<tr><td colspan="4" style="text-align: center">暂无数据</td></tr>');
                    }
                } else {
                    var msg = '';
                    if (res.msg != null && res.msg != '') {
                        msg = res.msg;
                    }
                    alert(msg);
                    return false;
                }
                layui.use(['laypage'], function () {
                    var $ = layui.jquery
                        , laypage = layui.laypage;
                    //完整功能
                    laypage.render({
                        elem: 'pagination'
                        , count: res.total
                        , curr: res.page
                        , limit: res.limit
                        , layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh']
                        , jump: function (obj, first) {
                            if (!first) {
                                currPage = obj.curr;
                                limit = obj.limit;
                                getValidList(obj.curr, obj.limit);
                            }
                        }
                    });
                });
            },
            error: function (res) {
                layer.close(loading);
                console.log('请求失败', res);
            }
        })
    }

    /**
     * 查询异常客户表数据（身份证不合法的客户）
     */
    function getInvalidList() {
        $('#pagination').hide(); //隐藏分页
        //正常和异常按钮切换样式显示
        $('#err').css( 'background-color', '#6c757d');
        $('#err').css( 'color', '#ffffff');
        $('#acc').css( 'background-color', '#ffffff');
        $('#acc').css( 'color', '#6c757d');
        $('#suyuan').css( 'background-color', '#ffffff');
        $('#suyuan').css( 'color', '#6c757d');
        //加载
        var loading = layer.load();
        //将表格下面的数据清空
        var customersList = $('#customersList');
        customersList.html('');
        //表头
        var head = ' <tr><th >客户名</th><th>身份证号</th>'+
            '<th >电话号码</th><th >省市区</th><th >操作</th></tr>';
        customersList.append(head);
        $.ajax({
            data: {"method": "inv_data"},
            url: 'customer',
            dataType: 'JSON',
            type: "get",
            success: function (res) {
                layer.close(loading);
                if (res.code == 1) {
                    if (res.data.length > 0) {
                        for (var i = 0; i < res.data.length; i++) {
                            var tr = $('<tr>' +
                                '<td>' + res.data[i].客户名称 + '</td>' +
                                '<td>' + res.data[i].客户编号 + '</td>' +
                                '<td>' + res.data[i].手机号 + '</td>' +
                                '<td>' + res.data[i].省市区 + '</td>' +
                                '<td><button style=" border: 0px;background-color:#adb5bd;color: white;width: 50px;line-height: 30px;border-radius: 10px;"  onclick="editCustomer(this)">修改</button></td>'+
                                '</tr>');
                            tr.data('item',res.data[i]);
                            customersList.append(tr);
                        }
                    } else {
                        customersList.append('<tr><td colspan="5" style="text-align: center">暂无数据</td></tr>');
                    }
                } else {
                    var msg = '';
                    if (res.msg != null && res.msg != '') {
                        msg = res.msg;
                    }
                    alert(msg);
                    return false;
                }
            },
            error: function (res) {
                layer.close(loading);
                console.log('请求失败', res);
            }
        })
    }


    /**
     * 清空修改弹出的内容
     */
    function clearDailog(){
        $('#err_id').val('');
        $('#name').val('');
        $('#phone').val('');
        $('#certificate_no').val('');
        $('#address').val('');
    }

    /**
     * 打开修改异常数据客户弹窗（修改身份证）
     * @param obj
     */
    var codeDialog = null;
    function editCustomer(obj) {
        //清空弹窗内容
        clearDailog();
        var item = $(obj).parent().parent().data('item');
        if(item){
            $('#err_id').val(item.ID);
            $('#name').val(item.客户名称);
            $('#phone').val(item.手机号);
            $('#certificate_no').val(item.客户编号);
            $('#address').val(item.省市区);
            codeDialog = layer.open({
                type: 1,
                title: '修改',
                area: ['500px', '300px'],
                content: $('#formContainer')
            })
        }
    }


    /**
     * 修改后点击保存按钮
     */
    function saveEdit(){
        var err_id = $('#err_id').val();
        var name = $('#name').val(); //客户名称
        var phone = $('#phone').val(); //手机号
        var certificate_no = $('#certificate_no').val();//身份证
        var address = $('#address').val(); //省市区
        if(err_id == ''){
            alert("参数缺失");
            return false;
        }
        if(certificate_no == ''){
            alert("请填写身份证");
            return false;
        }
        var loading = layer.load();  //加载
        $.ajax({
            data: {"method": "save","err_id":err_id,"name":name,"phone":phone,"certificate_no":certificate_no,"address":address},
            url: 'customer',
            dataType: 'JSON',
            type: "get",
            success: function (res) {
                layer.close(loading);
                if (res.code == 1) {
                    alert("保存成功");
                    layer.close(codeDialog); //关闭弹窗
                    //重新获取异常数据列表
                    getInvalidList();
                } else {
                    var msg = '';
                    if (res.msg != null && res.msg != '') {
                        msg = res.msg;
                    }
                    alert(msg);
                    return false;
                }
            },
            error: function (res) {
                layer.close(loading);
                console.log('请求失败', res);
            }
        })
    }

    /**
     * 溯源（查询身份证治理过程列表）
     */
    function getSuYuanList(){
        $('#pagination').hide(); //隐藏分页
        //正常和异常按钮切换样式显示
        $('#suyuan').css( 'background-color', '#6c757d');
        $('#suyuan').css( 'color', '#ffffff');
        $('#acc').css( 'background-color', '#ffffff');
        $('#acc').css( 'color', '#6c757d');
        $('#err').css( 'background-color', '#ffffff');
        $('#err').css( 'color', '#6c757d');
        //加载
        var loading = layer.load();
        //将表格清空
        var customersList = $('#customersList');
        customersList.html('');
        //表头
        var head = ' <tr><th >治理前</th><th>治理后</th><th>治理人 / 治理时间</th>';
        customersList.append(head);
        $.ajax({
            data: {"method": "suyuan"},
            url: 'customer',
            dataType: 'JSON',
            type: "get",
            success: function (res) {
                layer.close(loading);
                if (res.code == 1) {
                    if (res.data.length > 0) {
                        for (var i = 0; i < res.data.length; i++) {
                            var tr = $('<tr>' +
                                '<td>' +res.data[i].治理前客户名称 + '    |    '+res.data[i].治理前客户编号+'<br>'+res.data[i].治理前省市区+'    |    '+res.data[i].治理前手机号+'</td>' +
                                '<td>' +res.data[i].治理后客户名称 + '    |    '+res.data[i].治理后客户编号+'<br>'+res.data[i].治理前省市区+'    |    '+res.data[i].治理前手机号+'</td>' +
                                '<td style="padding-top: 25px">' +res.data[i].治理人 + ' / '+res.data[i].治理时间+'</td>' +
                                '</tr>');
                            tr.data('item',res.data[i]);
                            customersList.append(tr);
                        }
                    } else {
                        customersList.append('<tr><td colspan="3" style="text-align: center">暂无数据</td></tr>');
                    }
                } else {
                    var msg = '';
                    if (res.msg != null && res.msg != '') {
                        msg = res.msg;
                    }
                    alert(msg);
                    return false;
                }
            },
            error: function (res) {
                layer.close(loading);
                console.log('请求失败', res);
            }
        })
    }
</script>
</body>
</html>

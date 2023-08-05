<%--
  Created by IntelliJ IDEA.
  User: klein
  Date: 2023/7/7
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false"%>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>物流单治理</title>
    <link href="public/js/bootstrap-5.3.0-alpha1-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="public/css/dashboard.css" rel="stylesheet" />
    <script type="text/javascript" charset="UTF-8" src="public/js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" charset="UTF-8" src="public/layer/layer.js"></script>
    <script src="public/js/bootstrap-5.3.0-alpha1-dist/js/bootstrap.bundle.js"></script>
    <script type="text/javascript" charset="UTF-8" src="public/layui/layui.js"></script>
    <link  type="text/css" rel="stylesheet" href="public/layui/css/layui.css">
    <script src="public/js/checkout.js"></script>
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
    </style>
</head>
<body>
<%--导航栏start--%>
<%@include file="main.jsp"%>
<%--导航栏end--%>
<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">物流治理</h1>
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

            <%--治理结果start--%>
            <hr class="my-4">
            <div class="table-responsive">
                <h4 class="mb-3">治理结果</h4>
                <div class="col-sm-6" >
                    <button id="acc"  class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getValidList(1,10)">正常数据</button>
                    <button id="err" class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getInvalidList()">异常数据</button>
                    <button id="suyuan" class="btn btn-sm btn-outline-secondary" style="margin: 10px;" onclick="getSuYuanList()">数据溯源</button>
                </div>
            </div>
            <div class="table-responsive" style="margin-top: 15px">
                <table class="cm_table-striped cm_table Table_tc cm_table-bordered Table table table-striped table-sm"
                       style="...">
                    <tbody id="wuLiuList"></tbody>
                </table>
            </div>
            <%--治理结果end--%>
            <div class="cz" id="pagination"  ></div>
        </main>
    </div>
</div>


<%--物流信息治理弹窗start--%>
<div id="formContainer" style="display:none;">
    <div style="margin-left: 10px;margin-left: 100px">
        <input type="hidden" id="err_id">
        <br>
        <div >货物名称：<input  disabled disabled id="_name" >&nbsp;&nbsp;&nbsp;&nbsp;物流公司：<input  disabled id="company" ></div><br>
        <div >货主名称：<input disabled  id="name" >&nbsp;&nbsp;&nbsp;&nbsp;货主代码：<input  id="certificate_no" ></div><br>
        <div >&nbsp;&nbsp;&nbsp;提单号：<input  id="no" disabled>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;货重：<input disabled  id="weight" ></div><br>
        <div >集装箱箱号：<input disabled  id="xainghao" ></div><br>
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
    //初始化
    $(function () {
        getValidList(1,10);
    })

    /**
     *查询正常物流信息（物流信息里客户在客户数据中）
     */
    function getValidList(page,limit){
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
        var wuLiuList = $('#wuLiuList');
        wuLiuList.html('');
        //表头
        var head = '<tr> <th style="text-align: left;margin-left: 12px">提单号/物流公司</th> <th style="text-align: left;margin-left: 12px">货主名称</th> <th >货主代码</th><th style="text-align: left;margin-left: 12px">集装箱号</th> <th style="text-align: left;margin-left: 12px">货物名称/货重</th></tr>';
        wuLiuList.append(head);
        $.ajax({
            data: {"method":"v_data","page":page,"limit":limit},
            url:'wuliu',
            dataType: 'JSON',
            type:"get",
            success:function (res){
                layer.close(loading);  //关闭加载
                if (res.code == 1){
                    var data = res.data;
                    if(data.length > 0){
                        for(var i = 0; i < res.data.length; i ++) {
                            var tr = $('<tr>' +
                                '<td style="text-align: left;margin-left: 12px">' + data[i].提单号 + '<br>'+data[i].物流公司+'</td>' +
                                '<td style="text-align: left;margin-left: 12px">' + data[i].货主名称 + '</td>' +
                                '<td>' + data[i].货主代码 + '</td>' +
                                '<td style="text-align: left;margin-left: 12px">' + data[i].集装箱号 + '</td>' +
                                '<td style="text-align: left;margin-left: 12px">' + data[i].货物名称 + '/'+data[i].货重+'</td>' +
                                '</tr>');
                            tr.data('item',data[i]);
                            wuLiuList.append(tr);
                        }
                    }else {
                        wuLiuList.append('<tr><td colspan="5" style="text-align: center">暂无数据</td></tr>');
                    }
                }else{
                    var msg = '';
                    if(res.msg != null && res.msg != ''){
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
            error:function (res){
                layer.close(loading);  //关闭加载
                console.log('请求失败',res);
            }
        })
    }

    /**
     * 查询异常物流信息（物流信息里客户不在客户数据中）
     */
    function getInvalidList(){
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
        var wuLiuList = $('#wuLiuList');
        wuLiuList.html('');
        var head = '<tr> <th style="text-align: left;margin-left: 12px">提单号/物流公司</th> <th style="text-align: left;margin-left: 12px">货主名称</th> <th >货主代码</th> <th style="text-align: left;margin-left: 12px">集装箱号</th> <th style="text-align: left;margin-left: 12px">货物名称/货重</th><th >操作</th></tr>';
        wuLiuList.append(head);
        $.ajax({
            data: {"method":"inv_data"},
            url:'wuliu',
            dataType: 'JSON',
            type:"get",
            success:function (res){
                layer.close(loading);  //关闭加载
                if (res.code == 1){
                    var data = res.data;
                    if(data.length > 0){
                        for(var i = 0; i < res.data.length; i ++) {
                            var tr = $('<tr>' +
                                '<td style="text-align: left;margin-left: 12px">' + data[i].提单号 + '<br>'+data[i].物流公司+'</td>' +
                                '<td style="text-align: left;margin-left: 12px">' + data[i].货主名称 + '</td>' +
                                '<td>' + data[i].货主代码 + '</td>' +
                                '<td style="text-align: left;margin-left: 12px">' + data[i].集装箱箱号 + '</td>' +
                                '<td style="text-align: left;margin-left: 12px">' + data[i].货物名称 + '/'+data[i].货重+'</td>' +
                                '<td><button style=" border: 0px;background-color: #adb5bd;color: white;width: 50px;line-height: 30px;border-radius: 10px;" onclick="editWuliu(this)">修改</button></td>'+
                                '</tr>');
                            tr.data('item',data[i]);
                            wuLiuList.append(tr);
                        }
                    }else {
                        wuLiuList.append('<tr><td colspan="6" style="text-align: center">暂无数据</td></tr>');
                    }
                }else{
                    var msg = '';
                    if(res.msg != null && res.msg != ''){
                        msg = res.msg;
                    }
                    alert(msg);
                    return false;
                }
            },
            error:function (res){
                layer.close(loading);  //关闭加载
                console.log('请求失败',res);
            }
        })
    }


    /**
     * 清空修改弹出的内容
     */
    function clearDailog(){
        $('#err_id').val('');
        $('#no').val('');//提单号
        $('#name').val('');//货主名称
        $('#certificate_no').val('');//货主代码
        $('#company').val('');//物流公司
        $('#xainghao').val('');//箱号
        $('#_name').val(''); //货物名称
        $('#weight').val('');  //货重
    }

    /**
     * 打开修改异常物流信息弹窗（修改身份证）
     * @param obj
     */
    var codeDialog = null;
    function editWuliu(obj) {
        //清空弹窗内容
        clearDailog();
        var item = $(obj).parent().parent().data('item');
        if(item){
            $('#err_id').val(item.ID);
            $('#no').val(item.提单号);
            $('#name').val(item.货主名称);
            $('#certificate_no').val(item.货主代码);
            $('#company').val(item.物流公司);
            $('#xainghao').val(item.集装箱箱号);
            $('#_name').val(item.货物名称);
            $('#weight').val(item.货重);
            codeDialog = layer.open({
                type: 1,
                title: '修改',
                area: ['700px', '300px'],
                content: $('#formContainer')
            })
        }
    }

    /**
     * 修改后点击保存按钮
     */
    function saveEdit(){
        var err_id = $('#err_id').val();
        var no = $('#no').val(); //提单号
        var name = $('#name').val(); //货主名称
        var company = $('#company').val(); //物流公司
        var certificate_no = $('#certificate_no').val();//货主代码
        var xainghao = $('#xainghao').val(); //集装箱号
        var _name = $('#_name').val(); //货物名称
        var weight = $('#weight').val(); //货重
        if(err_id == ''){
            alert("参数缺失");
            return false;
        }
        if (certificate_no == '') {
            alert("货主代码");
            return false;
        }
        var loading = layer.load();  //加载
        $.ajax({
            data: {"method": "save","err_id":err_id,"name":name,"no":no,"certificate_no":certificate_no,"xainghao":xainghao,"weight":weight,"_name":_name,"company":company},
            url: 'wuliu',
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
        var wuLiuList = $('#wuLiuList');
        wuLiuList.html('');
        //表头
        var head = ' <tr><th >治理前</th><th>治理后</th><th>治理人 / 治理时间</th>';
        wuLiuList.append(head);
        $.ajax({
            data: {"method": "suyuan"},
            url: 'wuliu',
            dataType: 'JSON',
            type: "get",
            success: function (res) {
                layer.close(loading);
                if (res.code == 1) {
                    if (res.data.length > 0) {
                        for (var i = 0; i < res.data.length; i++) {
                            var tr = $('<tr>' +
                                '<td>' +res.data[i].治理前货主名称 + '    |    '+res.data[i].治理前货主代码+'<br>'+res.data[i].治理前物流公司+'    |    '+res.data[i].治理前集装箱号+'...</td>' +
                                '<td>' +res.data[i].治理后货主名称 + '    |    '+res.data[i].治理后货主代码+'<br>'+res.data[i].治理后物流公司+'    |    '+res.data[i].治理后集装箱号+'...</td>' +
                                '<td style="padding-top: 25px">' +res.data[i].治理人 + ' / '+res.data[i].治理时间+'</td>' +
                                '</tr>');
                            tr.data('item',res.data[i]);
                            wuLiuList.append(tr);
                        }
                    } else {
                        wuLiuList.append('<tr><td colspan="3" style="text-align: center">暂无数据</td></tr>');
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
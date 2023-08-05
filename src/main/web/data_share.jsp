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
    <title>对外数据服务-接口服务</title>
    <link href="public/js/bootstrap-5.3.0-alpha1-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="public/css/function.css" type="text/css" rel="stylesheet">
    <link href="public/css/dashboard.css" rel="stylesheet"/>
    <script type="text/javascript" charset="UTF-8" src="public/js/jquery-1.10.1.min.js"></script>
    <style>
        .cm_left{
            text-align: left;
            margin-left: 50px;
        }
        .cm_label{
            color: #949495;
            font-size: 10px;
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
            <div class="table-responsive">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">接口服务</h1>
                </div>
            </div>
            <%--装货表API start--%>
            <h4 class="mb-3">1、装货表API</h4>
            <div >
                <div class="mb-3 form-check" style="color: red;padding: 5px 0px">注：选择需要获取到的域</div>
                <label><input class="form-check-input" value="1" type="checkbox" name="checkBoxShip">船公司</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="2" type="checkbox" name="checkBoxShip">船名称</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="3" type="checkbox" name="checkBoxShip">作业开始时间</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="4" type="checkbox" name="checkBoxShip">作业结束时间</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="5" type="checkbox" name="checkBoxShip">始发时间</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="6" type="checkbox" name="checkBoxShip">到达时间</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="7" type="checkbox" name="checkBoxShip">作业港口</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="8" type="checkbox" name="checkBoxShip">提单号</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="9" type="checkbox" name="checkBoxShip">集装箱箱号</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="10" type="checkbox" name="checkBoxShip">箱尺寸</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="11" type="checkbox" name="checkBoxShip">启运地</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="12" type="checkbox" name="checkBoxShip">目的地</label>
                <button class="btn btn-secondary" onclick="sure1()" style="margin-left: 30px">确定</button>
            </div>
            <div class="table-responsive">
                <table class="table table-hover " style="width: 1100px;border-radius: 25px; background-color: #c7c7c7; margin-top: 20px;margin-bottom: 20px;">
                    <tr>
                        <th class="cm_left" id="port1"> 接口地址：http://36.140.31.145:30841/softcup-1.0-SNAPSHOT/api_dameng?method=shipment&field=0&page=1&limit=10</th>
                    </tr>
                    <tr>
                        <td class="cm_left">请求参数：<br>
                            method 必填，类型：String<br>
                            field  必填，选择后即可<br>
                            page  必填， 类型：int<br>
                            limit 必填， 类型：int<br>
                            端口如有错误换为登录节点端口
                        </td>
                    </tr>
                    <tr>
                    <tr>
                        <td class="cm_left">
                            返回结果：<br>
                            {<br>
                            "code":"0"，  //<text class="cm_label">参数说明：“1”:数据查找成功. “0”：数据查找失败</text><br>
                            "msg":""，    //<text class="cm_label">处理结果信息</text><br>
                            "data": ""    //<text class="cm_label">接口返回数据</text><br>
                            }
                        </td>
                    </tr>
                    </tr>
                </table>
            </div>
            <%--装货表API  end--%>


            <%--卸货表start--%>
            <h4 class="mb-3" style="margin-top: 20px">2、卸货表API</h4>
            <div >
                <div style="color: red;padding: 5px 0px">注：选择需要获取到的域</div>
                <label><input class="form-check-input" value="1" type="checkbox" name="checkBoxUnload">船公司</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="2" type="checkbox" name="checkBoxUnload">船名称</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="3" type="checkbox" name="checkBoxUnload">作业开始时间</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="4" type="checkbox" name="checkBoxUnload">作业结束时间</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="5" type="checkbox" name="checkBoxUnload">始发时间</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="6" type="checkbox" name="checkBoxUnload">到达时间</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="7" type="checkbox" name="checkBoxUnload">作业港口</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="8" type="checkbox" name="checkBoxUnload">提单号</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="9" type="checkbox" name="checkBoxUnload">集装箱箱号</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="10" type="checkbox" name="checkBoxUnload">箱尺寸</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="11" type="checkbox" name="checkBoxUnload">启运地</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="12" type="checkbox" name="checkBoxUnload">目的地</label>
                <button class="btn btn-secondary" onclick="sure2()" style="margin-left: 30px">确定</button>
            </div>
            <div class="table-responsive">
                <table class="table table-hover" style="width: 1100px;border-radius: 25px; background-color: #c7c7c7; margin-top: 20px;margin-bottom: 20px;">
                    <tr>http://
                        <th class="cm_left" id="port2"> 接口地址：http://36.140.31.145:30841/softcup-1.0-SNAPSHOT/api_dameng?method=unload&field=0&page=1&limit=10</th>
                    </tr>
                    <tr>
                        <td class="cm_left">请求参数：<br>
                            method 必填，类型：String<br>
                            field  必填，选择后即可<br>
                            page  必填， 类型：int<br>
                            limit 必填， 类型：int<br>
                            端口如有错误换为登录节点端口
                        </td>
                    </tr>
                    <tr>
                    <tr>
                        <td class="cm_left">
                            返回结果：<br>
                            {<br>
                            "code":"0"，  //<text class="cm_label">参数说明：“1”:数据查找成功. “0”：数据查找失败</text><br>
                            "msg":""，    //<text class="cm_label">处理结果信息</text><br>
                            "data": ""    //<text class="cm_label">接口返回数据</text><br>
                            }
                        </td>
                    </tr>
                    </tr>
                </table>
            </div>
            <%--卸货表API  end--%>


            <%--物流信息start--%>
            <h4 class="mb-3" style="margin-top: 20px">3、物流信息API</h4>
            <div >
                <div style="color: red;padding: 5px 0px">注：选择需要获取到的域</div>
                <label><input class="form-check-input" value="1" type="checkbox" name="checkBoxLogistics">提单号</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="2" type="checkbox" name="checkBoxLogistics">货主名称</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="3" type="checkbox" name="checkBoxLogistics">货主代码</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="4" type="checkbox" name="checkBoxLogistics">物流公司</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="5" type="checkbox" name="checkBoxLogistics">集装箱号</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="6" type="checkbox" name="checkBoxLogistics">货物名称</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="7" type="checkbox" name="checkBoxLogistics">货重</label>
                <button class="btn btn-secondary" onclick="sure3()" style="margin-left: 30px">确定</button>
            </div>
            <div class="table-responsive">
                <table class="table table-hover " style="width: 1100px;border-radius: 25px; background-color: #c7c7c7; margin-top: 20px;margin-bottom: 20px;">
                    <tr>
                        <th class="cm_left"  id="port3"> 接口地址：http://36.140.31.145:30841/softcup-1.0-SNAPSHOT/api_dameng?method=logistics&field=0&page=1&limit=10</th>
                    </tr>
                    <tr>
                        <td class="cm_left">请求参数：<br>
                            method 必填 ，类型：String<br>
                            field  必填，选择后即可 <br>
                            page  必填， 类型：int<br>
                            limit 必填， 类型：int<br>
                            端口如有错误换为登录节点端口
                        </td>
                    </tr>
                    <tr>
                    <tr>
                        <td class="cm_left">
                            返回结果：<br>
                            {<br>
                            "code":"0"，  //<text class="cm_label">参数说明：“1”:数据查找成功. “0”：数据查找失败</text><br>
                            "msg":""，    //<text class="cm_label">处理结果信息</text><br>
                            "data": ""    //<text class="cm_label">接口返回数据</text><br>
                            }
                        </td>
                    </tr>
                    </tr>
                </table>
            </div>
            <%--物流信息API  end--%>

            <%--集装箱动态start--%>
            <h4 class="mb-3" style="margin-top: 20px">4、集装箱动态API</h4>
            <div >
                <div style="color: red;padding: 5px 0px">注：选择需要获取到的域</div>
                <label><input class="form-check-input" value="1" type="checkbox" name="checkBoxContainer">堆存港口</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="2" type="checkbox" name="checkBoxContainer">集装箱箱号</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="3" type="checkbox" name="checkBoxContainer">箱尺寸</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="4" type="checkbox" name="checkBoxContainer">箱状态</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="5" type="checkbox" name="checkBoxContainer">提单号</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="6" type="checkbox" name="checkBoxContainer">堆场位置</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="7" type="checkbox" name="checkBoxContainer">操作</label>
                <label style="margin-left: 10px"><input class="form-check-input" value="7" type="checkbox" name="checkBoxContainer">操作日期</label>
                <button class="btn btn-secondary" onclick="sure4()" style="margin-left: 30px">确定</button>
            </div>
            <div class="table-responsive"  style="width: 1100px;border-radius: 25px; background-color: #c7c7c7; margin-top: 20px;margin-bottom: 20px;">
                <table class="table table-hover " style="width: 1100px;margin-top: 7px">
                    <tr>
                        <th class="cm_left" id="port4"> 接口地址：http://36.140.31.145:30841/softcup-1.0-SNAPSHOT/api_dameng?method=container&field=0&page=1&limit=10</th>
                    </tr>
                    <tr>
                        <td class="cm_left">请求参数：<br>
                            method 必填， 类型：String<br>
                            field  必填，选择后即可<br>
                            page  必填， 类型：int<br>
                            limit 必填， 类型：int<br>
                            端口如有错误换为登录节点端口
                        </td>
                    </tr>
                    <tr>
                    <tr>
                        <td class="cm_left">
                            返回结果：<br>
                            {<br>
                            "code":"0"，  //<text class="cm_label">参数说明：“1”:数据查找成功. “0”：数据查找失败</text><br>
                            "msg":""，    //<text class="cm_label">处理结果信息</text><br>
                            "data": ""    //<text class="cm_label">接口返回数据</text><br>
                            }
                        </td>
                    </tr>
                    </tr>
                </table>
            </div>
            <%--集装箱动态API  end--%>
        </main>
    </div>
</div>


</body>
</html>

<script type="text/javascript">
    var value1 = '';
    //装货表多选框监听
    $('input:checkbox[name="checkBoxShip"]').on("change", function () {
        var str = '';
        $.each($('input:checkbox[name="checkBoxShip"]'), function () {
            if (this.checked) {
                str += $(this).val() + ",";
            }
        })
        //将最后一个逗号去除
        value1 = str.substring(0,str.length-1);
    })


    var value2 = '';
    //卸货表多选框监听
    $('input:checkbox[name="checkBoxUnload"]').on("change", function () {
        var str = '';
        $.each($('input:checkbox[name="checkBoxUnload"]'), function () {
            if (this.checked) {
                str += $(this).val() + ",";
            }
        })
        //将最后一个逗号去除
        value2 = str.substring(0,str.length-1);
    })

    var value3 = '';
    //物流信息多选框监听
    $('input:checkbox[name="checkBoxLogistics"]').on("change", function () {
        var str = '';
        $.each($('input:checkbox[name="checkBoxLogistics"]'), function () {
            if (this.checked) {
                str += $(this).val() + ",";
            }
        })
        //将最后一个逗号去除
        value3 = str.substring(0,str.length-1);
    })

    var value4 = '';
    //集装箱动态多选框监听
    $('input:checkbox[name="checkBoxContainer"]').on("change", function () {
        var str = '';
        $.each($('input:checkbox[name="checkBoxContainer"]'), function () {
            if (this.checked) {
                str += $(this).val() + ",";
            }
        })
        //将最后一个逗号去除
        value4 = str.substring(0,str.length-1);
    })

    //装货表多选框确定
    function sure1(){
        if(value1 == ''){
            alert("请选择字段");
            return false;
        }
        $('#port1').html('接口地址：http://36.140.31.145:30841/softcup-1.0-SNAPSHOT/api_dameng?method=shipment'+'&field='+value1+'&page=1&limit=10');
    }

    //卸货表多选框确定
    function sure2(){
        if(value2 == ''){
            alert("请选择字段");
            return false;
        }
        $('#port2').html('接口地址：http://36.140.31.145:30841/softcup-1.0-SNAPSHOT/api_dameng?method=unload'+'&field='+value2+'&page=1&limit=10');
    }

    //物流信息多选框确定
    function sure3(){
        if(value3 == ''){
            alert("请选择字段");
            return false;
        }
        $('#port3').html('接口地址：http://36.140.31.145:30841/softcup-1.0-SNAPSHOT/api_dameng?method=logistics'+'&field='+value3+'&page=1&limit=10');
    }


    //集装箱动态多选框确定
    function sure4(){
        if(value4 == ''){
            alert("请选择字段");
            return false;
        }
        $('#port4').html('接口地址：http://36.140.31.145:30841/softcup-1.0-SNAPSHOT/api_dameng?method=container'+'&field='+value4+'&page=1&limit=10');
    }
</script>

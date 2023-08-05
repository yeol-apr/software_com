<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="public/js/bootstrap-5.3.0-alpha1-dist/css/bootstrap.min.css" rel="stylesheet">
    <title>共享数据库</title>
    <script type="text/javascript" charset="UTF-8" src="public/js/jquery-1.10.1.min.js"></script>
    <link href="public/css/function.css" type="text/css" rel="stylesheet">
    <link href="public/css/dashboard.css" rel="stylesheet"/>
</head>
<body>
<%--侧边栏start--%>
<%@include file="main.jsp"%>
<%--侧边栏end--%>
<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="table-responsive">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">共享数据库</h1>
                </div>
            </div>
            <img src="public/images/share_databases.png" style="width: 100px;width: 100px;position:relative;left: 10px;top: 0px">
            <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative" style="font-size:large;position:relative;left: 10px;top: 15px">
                <div class="p-4 p-md-5 mb-4 rounded text-bg-dark" id="content1" style="margin: 20px; width: 1100px">
                    <div>数据库访问地址：36.140.31.145:32372</div><br>
                    <div>角色：管理员</div><br>
                    <div>用户名：admin</div><br>
                    <div>密码：Dameng!@#123</div><br>
                    <div>权限：创建触发器、表、存储过程。插入，修改，删除表，查询视图、表。可查看客户表，物流表，装、卸货表、物流公司表。</div>
                    <hr>
                </div>

                <div class="p-4 p-md-5 mb-4 rounded text-bg-dark" id="content2" style="margin: 20px; width: 1100px">
                    <div>数据库访问地址：36.140.31.145:32372</div><br>
                    <div>角色：工程师</div><br>
                    <div>用户名：ENGINEER</div><br>
                    <div> 密码：Dameng!@#123</div><br>
                    <div>权限： 表：查询，修改，插入，删除。可查看客户表，物流表，装/卸货表，物流公司表</div>
                    <hr>
                </div>
                <div class="p-4 p-md-5 mb-4 rounded text-bg-dark" id="content3" style="margin: 20px; width: 1100px">
                    <div>数据库访问地址：36.140.31.145:32372</div><br>
                    <div>角色：员工</div><br>
                    <div> 用户名：STAFF</div><br>
                    <div> 密码：DamengStaff</div><br>
                    <div> 权限：仅有查询功能</div>

                </div>
            </div>
            <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative" style="position: relative;top: 30px;left: 10px;font-size: large">
                <hr>
                <h3 style="margin-left: 5px">物流信息_正常数据</h3>
                <br>
                <table class="table table-striped">
                    <tr>
                        <td>字段</td>
                        <td>长度</td>
                        <td>是否自增</td>
                        <td>是否为空</td>
                    </tr>
                    <tr>
                        <td>ID</td>
                        <td>INT</td>
                        <td>IDENTITY(1, 1)</td>
                        <td>NOT NULL</td>
                    </tr>
                    <tr>
                        <td>提单号</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>货主名称</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>货主代码</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>物流公司</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>集装箱号</td>
                        <td>CHAR(500)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>货物名称</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>货重</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                </table>
                <br>
                <hr>
                <h3 style="margin-left: 5px" >装货表</h3>
                <br>
                <table class="table table-striped">
                    <tr>
                        <td>字段</td>
                        <td>长度</td>
                        <td>是否自增</td>
                        <td>是否为空</td>
                    </tr>
                    <tr>
                        <td>船公司</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>船名称</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>作业开始时间</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>作业结束时间</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>始发时间</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>到达时间</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>作业港口</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>提单号</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>集装箱箱号</td>
                        <td>VARCHAR(500)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>箱尺寸（TEU）</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>启运地</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr><td>目的地</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr><td>ID </td>
                        <td>INT</td>
                        <td>IDENTITY(1, 1)</td>
                        <td> NOT NUL</td>
                    </tr>
                </table>
                <br>
                <hr>
                <h3 style="margin-left: 5px" >卸货表</h3>
                <br>
                <table class="table table-striped">
                    <tr>
                        <td>字段</td>
                        <td>长度</td>
                        <td>是否自增</td>
                        <td>是否为空</td>
                    </tr>
                    <tr>
                        <td>船公司</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>船名称</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>作业开始时间</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>作业结束时间</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>始发时间</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>到达时间</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>作业港口</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>提单号</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>集装箱箱号</td>
                        <td>VARCHAR(500)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>箱尺寸（TEU）</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>启运地</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr><td>目的地</td>
                        <td>VARCHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr><td>ID </td>
                        <td>INT</td>
                        <td>IDENTITY(1, 1)</td>
                        <td> NOT NUL</td>
                    </tr></table>
                <br>
                <hr>
                <h3 style="margin-left: 5px" >客户数据脱敏表</h3>
                <br>
                <table class="table table-striped">
                    <tr>
                        <td>字段</td>
                        <td>长度</td>
                        <td>是否自增</td>
                        <td>是否为空</td>
                    </tr>
                    <tr>
                        <td>ID</td>
                        <td>INT</td>
                        <td>IDENTITY(1, 1)</td>
                        <td>NOT NULL</td>
                    </tr>
                    <tr>
                        <td>客户名称</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>客户编号</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NOT NULL</td>
                    </tr>
                    <tr>
                        <td>手机号</td>
                        <td>CHAR(50)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>省市区</td>
                        <td>CHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <img src="public/images/kehutuoming.png">
                </table>
                <br>
                <hr>
                <h3 style="margin-left: 5px" >物流公司2021_2022</h3>
                <br>
                <table class="table table-striped">
                    <tr>
                        <td>字段</td>
                        <td>长度</td>
                        <td>是否自增</td>
                        <td>是否为空</td>
                    </tr>
                    <tr>
                        <td>公司名称</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>客户编号</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>联系人</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>电话</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>省市区</td>
                        <td>CHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                </table>

                <br>
                <hr>
                <h3 style="margin-left: 5px" >集装箱动态2021_2022</h3>
                <br>
                <table class="table table-striped">
                    <tr>
                        <td>字段</td>
                        <td>长度</td>
                        <td>是否自增</td>
                        <td>是否为空</td>
                    </tr>
                    <tr>
                        <td>"堆存港口"</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>"集装箱箱号"</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>"箱尺寸（TEU）"</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>"箱状态"</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>"提单号"</td>
                        <td>CHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>"堆场位置"</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>"操作"</td>
                        <td>VARCHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                    <tr>
                        <td>"操作日期"</td>
                        <td>CHAR(255)</td>
                        <td>NO</td>
                        <td>NULL</td>
                    </tr>
                </table>
            </div>
        </main>
    </div>
</div>
</body>
</html>
<script type="text/javascript">
    getdatabase();
    function getdatabase(){
        var aid='${user.GROUP}';
        if (aid == '管理员'){
            $("#content1").show();
            $("#content2").show();
            $("#content3").show();
        }
        if (aid == '工程师'){
            $("#content1").hide();
            $("#content2").show();
            $("#content3").hide();
        }
        if (aid== '普通员工'){
            $("#content1").hide();
            $("#content2").hide();
            $("#content3").show();
        }
    }
</script>
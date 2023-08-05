<%--
  Created by IntelliJ IDEA.
  User: 31450
  Date: 2023-06-30
  Time: 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登入页</title>
    <script type="text/javascript" charset="UTF-8" src="public/js/jquery-1.10.1.min.js"></script>
    <link href="public/css/index.css" type="text/css" rel="stylesheet">
</head>
<body>
<div class="login ">
    <div class="form">
        <h2 style="position: relative;top: -30px">物流信息数据中台系统</h2>
        <input type="text" id="username" placeholder="账号(测试账号为admin或1001001)" >
        <input type="password" id="password" placeholder="密码(上述两个账号密码均为admin)">
        <button onclick="loginMethod()">登录</button>
    </div>
</div>

<%--动画start--%>
<script>
    //获取 login
    let login = document.querySelector('.login')
    let span
    let inTime, outTime
    let isIn = true //默认开关 打开
    let isOut

    //鼠标进入事件
    login.addEventListener('mouseenter', function(e)
    {
        isOut = false //预先关闭，若不进入if语句，则不能进入鼠标离开事件里的 if
        if(isIn)
        {
            inTime = new Date().getTime()

            //生成 span 元素并添加进 login 的末尾
            span = document.createElement('span')
            login.appendChild(span)

            //span 去使用 in动画
            span.style.animation = 'in .5s ease-out forwards'

            //计算 top 和 left 值，跟踪鼠标位置
            let top = e.clientY - e.target.offsetTop
            let left = e.clientX - e.target.offsetLeft

            span.style.top = top + 'px'
            span.style.left = left + 'px'

            isIn = false //当我们执行完程序后，关闭
            isOut = true //当我们执行完里面的程序，再打开
        }

    })
    //鼠标离开事件
    login.addEventListener('mouseleave', function(e)
    {
        if(isOut)
        {
            outTime = new Date().getTime()
            let passTime = outTime - inTime

            if(passTime < 500)
            {
                setTimeout(mouseleave, 500 - passTime) //已经经过的时间就不要了
            }
            else
            {
                mouseleave()
            }
        }

        function mouseleave()
        {
            span.style.animation = 'out .5s ease-out forwards'

            //计算 top 和 left 值，跟踪鼠标位置
            let top = e.clientY - e.target.offsetTop
            let left = e.clientX - e.target.offsetLeft

            span.style.top = top + 'px'
            span.style.left = left + 'px'

            //注意：因为要等到动画结束，所以要给个定时器
            setTimeout(function()
            {
                login.removeChild(span)
                isIn = true //当我们执行完鼠标离开事件里的程序，才再次打开
            }, 500)
        }
    })
</script>
</body>
</html>

<script type="text/javascript">
    /**
     * 登录方法
     */
    function loginMethod() {
        var username = $('#username').val();
        var password = $('#password').val();
        $.ajax({
            type:"POST", // 请求方式
            url:"login",  // 请求地址
            data:{"username":username,"password":password}, // 携带的参数
            dataType:"JSON",
            // 成功后调用的函数
            success:function (res) {
                if(res.code == 1){
                    alert(res.msg);
                    window.location.href="data_introduction.jsp";
                    return;
                }else{
                    alert(res.msg);
                    return false;
                }
            },
            // 失败调用的函数
            error:function (res) {
                console.log('!!!!',res);
                alert("出现了异常情况")

            }
        })
    }
</script>
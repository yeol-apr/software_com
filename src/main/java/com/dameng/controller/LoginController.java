package com.dameng.controller;

import com.dameng.dao.LoginDao;
import com.dameng.model.ResultModel;
import com.dameng.model.UserModel;
import net.sf.json.JSONObject;

import  java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 用户登录业务控制器
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
    LoginDao userDao = new LoginDao();
    ResultModel resultModel = new ResultModel();

    /**
     * 处理 GET 请求
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 登录逻辑
        /**
         * 1. 取值
         * 2. 判断用户和密码是否为空
         * 3. 查询用户
         * 4. 响应前端
         */

        // 1. 取值
        String username = req.getParameter("username");
        String pass = req.getParameter("password");

        // 2. 判断用户和密码是否为空
        if (username.equals("") || pass.equals("")) {
            resp.getWriter().println(1);
            return;
        }

        // 3. 查询用户
        UserModel user = userDao.checkLogin(username);

        if (user == null) {
            JSONObject result = resultModel.response(0, "无此用户", null);
            resp.getWriter().println(result);
            return;
        } else {
            // 4. 验证用户名和密码
            if (user.getPASSWORD().equals(pass)) {
                req.getSession().setAttribute("user", user); // 缓存
                JSONObject result = resultModel.response(1, "登录成功", null);
                resp.getWriter().println(result);
                return;
            } else {
                JSONObject result = resultModel.response(0, "密码错误", null);
                resp.getWriter().println(result);
                return;
            }
        }
    }

    /**
     * 处理 POST 请求
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 响应客户端的类型与防止中文乱码
        resp.setContentType("text/html;charset=utf-8");
        // 跨域问题
        resp.addHeader("Access-Control-Allow-Origin", "*");
        doGet(req, resp);
    }
}

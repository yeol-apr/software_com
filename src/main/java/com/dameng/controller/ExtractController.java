package com.dameng.controller;


import com.dameng.dao.ExtractDao;
import com.dameng.model.ResultModel;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 数据读取业务逻辑控制器
 */

@WebServlet("/extract")
public class ExtractController extends HttpServlet {

    ResultModel resultModel = new ResultModel(); //返回前端的对象
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String extract = request.getParameter("extract");  //标识
        ExtractDao resuit = new ExtractDao();
        List<Map> res = resuit.select(extract);//调用dao层
        JSONObject result = resultModel.response(1, "查询成功", res);
        response.getWriter().print(result);


    }
}


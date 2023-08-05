package com.dameng.controller;

import com.dameng.util.StringUtil;
import com.dameng.dao.APIDao;
import com.dameng.model.ResultModel;
import com.dameng.model.UserModel;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

/***
 * 对外API调用业务逻辑控制器
 */
@WebServlet("/api_dameng")
public class APIController extends HttpServlet {
    /**
     * 应用api
     */
    APIDao apiDao = new APIDao();
    ResultModel resultModel = new ResultModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 跨域问题
        resp.setContentType("text/html;charset=utf-8");
        resp.addHeader("Access-Control-Allow-Origin","*");
        doPost(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        // 跨域问题
        resp.addHeader("Access-Control-Allow-Origin","*");
        resp.setCharacterEncoding("utf-8");
        String method = req.getParameter("method");
        if(StringUtil.isEmpty(method)){
            JSONObject result = resultModel.response(0, "参数缺失", null);
            resp.getWriter().println(result); //接口返回信息
        }
        if(method.equals("shipment")){
            //装货表
            getZhuangHuoList(req,resp);
        }else if(method.equals("unload")){
            //卸货表
            getXieHuoList(req,resp);
        }else if(method.equals("logistics")){
            //物流信息_正常数据
            getwuliuList(req,resp);
        }else  if(method.equals("container")){
            //集装箱动态表
            getjizhuangxList(req,resp);
        }else{
            JSONObject result = resultModel.response(0, "参数不正确", null);
            resp.getWriter().println(result); //接口返回信息
        }
    }


    /**
     * 获取装货表列表
     * @param req
     * @param resp
     */
    private void getZhuangHuoList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        /**
         * 查询装货表返回结果
         */
        String field = req.getParameter("field");
        String page = req.getParameter("page");
        String limit = req.getParameter("limit");
        int page_ = 1;
        int limit_ = 10;
        if(!page.equals("")){
            page_ = Integer.parseInt(page);
        }
        if(!limit.equals("")){
            limit_ = Integer.parseInt(limit);
        }
        int offset = (page_-1)*limit_;
        //将field字符创以逗号分隔存到字符创数组中
        String[] words = new String[0];  //初始化空数组
        if(!field.equals("0")){
            words = field.split(","); // 按照空格分割字符串
        }

        //将字符串数组转为整型数组
        int[] fields = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            fields[i] = Integer.parseInt(words[i]);
        }

        String sql="select *  from DAMENG8.装货表 limit "+offset+","+limit_;
        List<Map> zhuangHuoList = APIDao.getList(sql,fields);
        JSONObject result = resultModel.response(1, "查询成功", zhuangHuoList);
        resp.getWriter().println(result); //接口返回信息
    }

    /**
     * 获取卸货表列表
     * @param req
     * @param resp
     */
    private void getXieHuoList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        /**
         * 查询卸货表返回结果
         */
        String field = req.getParameter("field");
        String page = req.getParameter("page");
        String limit = req.getParameter("limit");
        int page_ = 1;
        int limit_ = 10;
        if(!page.equals("")){
            page_ = Integer.parseInt(page);
        }
        if(!limit.equals("")){
            limit_ = Integer.parseInt(limit);
        }
        int offset = (page_-1)*limit_;
        //将field字符创以逗号分隔存到字符创数组中
        String[] words = new String[0];  //初始化空数组
        if(!field.equals("0")){
            words = field.split(","); // 按照空格分割字符串
        }

        //将字符串数组转为整型数组
        int[] fields = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            fields[i] = Integer.parseInt(words[i]);
        }

        String sql="select *  from DAMENG8.卸货表 limit "+offset+","+limit_;
        List<Map> zhuangHuoList = APIDao.getList(sql,fields);
        JSONObject result = resultModel.response(1, "查询成功", zhuangHuoList);
        resp.getWriter().println(result); //接口返回信息
    }

    /**
     * 获取物流信息列表
     * @param req
     * @param resp
     */
    private void getwuliuList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String field = req.getParameter("field");
        String page = req.getParameter("page");
        String limit = req.getParameter("limit");
        int page_ = 1;
        int limit_ = 10;
        if(!page.equals("")){
            page_ = Integer.parseInt(page);
        }
        if(!limit.equals("")){
            limit_ = Integer.parseInt(limit);
        }
        int offset = (page_-1)*limit_;
        //将field字符创以逗号分隔存到字符创数组中
        String[] words = new String[0];  //初始化空数组
        if(!field.equals("0")){
            words = field.split(","); // 按照空格分割字符串
        }

        //将字符串数组转为整型数组
        int[] fields = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            fields[i] = Integer.parseInt(words[i]);
        }

        String sql="select *  from DAMENG8.物流信息_正常数据 limit "+offset+","+limit_;
        List<Map> zhuangHuoList = APIDao.getList(sql,fields);
        JSONObject result = resultModel.response(1, "查询成功", zhuangHuoList);
        resp.getWriter().println(result); //接口返回信息
    }

    /**
     * 获取集装箱动态表列表
     * @param req
     * @param resp
     */
    private void getjizhuangxList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String field = req.getParameter("field");
        String page = req.getParameter("page");
        String limit = req.getParameter("limit");
        int page_ = 1;
        int limit_ = 10;
        if(!page.equals("")){
            page_ = Integer.parseInt(page);
        }
        if(!limit.equals("")){
            limit_ = Integer.parseInt(limit);
        }
        int offset = (page_-1)*limit_;
        //将field字符创以逗号分隔存到字符创数组中
        String[] words = new String[0];  //初始化空数组
        if(!field.equals("0")){
            words = field.split(","); // 按照空格分割字符串
        }

        //将字符串数组转为整型数组
        int[] fields = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            fields[i] = Integer.parseInt(words[i]);
        }

        String sql="select *  from DAMENG8.集装箱动态2021_2022 limit "+offset+","+limit_;
        List<Map> zhuangHuoList = APIDao.getList(sql,fields);
        JSONObject result = resultModel.response(1, "查询成功", zhuangHuoList);
        resp.getWriter().println(result); //接口返回信息
    }

}

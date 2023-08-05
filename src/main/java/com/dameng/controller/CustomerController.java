package com.dameng.controller;

import com.dameng.dao.CustomerDao;
import com.dameng.model.ResultModel;
import com.dameng.util.IDCardProcessorUtil;
import com.dameng.util.StringUtil;
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
 * 处理客户业务逻辑控制器
 */
@WebServlet("/customer")
public class CustomerController extends HttpServlet {

    CustomerDao customerDao = new CustomerDao();
    ResultModel resultModel = new ResultModel(); //返回前端的对象

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8"); //设置编码
        resp.setContentType("text/html';charset=UTF-8");
        String method = req.getParameter("method");
        if(method.equals("v_data")){
            //查询客户表正常数据（身份证合法客户）
            getValidCustomerList(req,resp);
        }else if(method.equals("inv_data")){
            //查询客户表异常数据（身份证不合法客户）
            getInvalidCustomerList(req,resp);
        }else if(method.equals("suyuan")){
            //查询身份证治理过程列表(溯源)
            getCustomerProList(req,resp);

        }else if(method.equals("save")){
            //保存修改的身份证后
            saveEditCertificateNo(req,resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    /**
     * 查询客户表正常数据列表（身份证合法客户）
     * @param req 请求对象
     * @param resp 响应对象
     * @throws IOException IO异常
     */
    public  void getValidCustomerList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer page = Integer.parseInt(req.getParameter("page"));
        Integer limit = Integer.parseInt(req.getParameter("limit"));
        Integer offset = (page-1)*limit;
        Map<String,Object> map = customerDao.getValidCustomerList(page,limit);//调用dao层的查询方法
        Object validCustomerList = map.get("data"); //数据
        Object allCount = map.get("allCount");  //总条数
        //构造返回前端的json字符串
        String json = "{\"code\":"+1+","; // 返回码
        json += "\"msg\":\"查询成功\","; // 返回消息
        json += "\"data\":"+validCustomerList+","; // 数据
        json += "\"total\":"+allCount+","; // 总条数
        json += "\"limit\":"+limit+","; // 每页显示条数
        json += "\"page\":"+page+","; // 当前页码
        json += "}";
        JSONObject result = JSONObject.fromObject(json);//将json字符串转成json对象
        resp.getWriter().println(result);
        return;
    }


    /**
     * 查询客户表异常数据（身份证不合法客户）
     * @param req 请求对象
     * @param resp 响应对象
     * @throws IOException IO异常
     */
    public void  getInvalidCustomerList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Map> inValidCustomerList = customerDao.getInValidCustomerList();//调用dao层的查询方法
        JSONObject result = resultModel.response(1, "查询成功", inValidCustomerList); //返回前端的json对象
        resp.getWriter().println(result);
        return;
    }


    /**
     * 查询身份证治理过程列表(溯源)
     * @param req 请求对象
     * @param resp 响应对象
     * @throws IOException IO异常
     */
    public void getCustomerProList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Map> list = customerDao.getCustomerProList(); //调用dao层的查询方法
        JSONObject result = resultModel.response(1, "查询成功", list); //返回前端的json对象
        resp.getWriter().println(result);
        return;
    }


    /**
     * 保存修改的身份证
     * @param req 请求对象
     * @param resp 响应对象
     * @throws IOException IO异常
     */
    public void saveEditCertificateNo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String err_id = req.getParameter("err_id"); //处理的异常数据ID
        String name = req.getParameter("name");  //客户名称
        String phone = req.getParameter("phone"); //手机号
        String certificate_no = req.getParameter("certificate_no");  //身份证
        String address = req.getParameter("address");  //省市区
        //判断参数是否为空
        if(StringUtil.isEmpty(err_id)){
            JSONObject result = resultModel.response(0, "参数缺失", null);
            resp.getWriter().println(result);
            return;
        }
        if(StringUtil.isEmpty(certificate_no)){
            JSONObject result = resultModel.response(0, "请填写身份证", null);
            resp.getWriter().println(result);
            return;
        }

        //验证身份证是否合法
        if(!IDCardProcessorUtil.isValidIDCard(certificate_no)){
            JSONObject result = resultModel.response(0, "身份号不合法，请重新填写", null);
            resp.getWriter().println(result);
            return;
        }
        //调用dao层的保存方法
        int i = customerDao.saveEditCertificateNo(err_id, name, phone, certificate_no, address);
        if(i == 1){
            JSONObject result = resultModel.response(1, "保存成功", null);
            resp.getWriter().println(result);
            return;
        }else if(i == 2){
            JSONObject result = resultModel.response(0, "有重复的身份证", null);
            resp.getWriter().println(result);
            return;
        }else if(i == 3){
            JSONObject result = resultModel.response(0, "向正常表插入数据失败", null);
            resp.getWriter().println(result);
            return;
        }else if(i == 4){
            JSONObject result = resultModel.response(0, "未获取到ID", null);
            resp.getWriter().println(result);
            return;
        }else if(i == 5){
            JSONObject result = resultModel.response(0, "修改客户表_异常数据标识字段失败", null);
            resp.getWriter().println(result);
            return;
        }else if(i == 6){
            JSONObject result = resultModel.response(0, "向客户表_治理过程中插入一条新数据失败", null);
            resp.getWriter().println(result);
            return;
        }
    }
}

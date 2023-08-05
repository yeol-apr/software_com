package com.dameng.controller;

import com.dameng.dao.CustomerDao;
import com.dameng.dao.WuLiuDao;
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
 * 处理物流信息业务逻辑控制器
 */
@WebServlet("/wuliu")
public class WuLiuController extends HttpServlet {

    WuLiuDao wuLiuDao = new WuLiuDao();
    ResultModel resultModel = new ResultModel(); //返回前端的对象

    /**
     * 处理 GET 请求
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8"); //设置编码
        resp.setContentType("text/html'charset=UTF-8");
        String method = req.getParameter("method");
        if(method.equals("v_data")){
            //查询正常物流信息（物流信息里客户在客户数据中）
            getValidWuLiuList(req,resp);
        }else if(method.equals("inv_data")){
            //查询异常物流信息（物流信息里客户不在客户数据中）
            getInvalidWuLiuList(req,resp);
        }else if(method.equals("suyuan")){
            //查询身份证治理过程列表(溯源)
            getWuLiuProList(req,resp);

        }else if(method.equals("save")){
            //保存修改的身份证后
            saveEditCertificateNo(req,resp);
        }
    }


    /**
     * 处理 POST 请求
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    /**
     * 查询正常物流信息（物流信息里客户在客户数据中）
     * @param req 请求对象
     * @param resp 响应对象
     * @throws IOException
     */
    public  void getValidWuLiuList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer page = Integer.parseInt(req.getParameter("page"));
        Integer limit = Integer.parseInt(req.getParameter("limit"));
        Integer offset = (page-1)*limit;
        Map<String,Object> map = wuLiuDao.getValidWuLiuList(page,limit);//调用dao层的查询方法
        Object validWuLiuList = map.get("data"); //数据
        Object allCount = map.get("allCount");  //总条数
        //构造返回前端的json字符串
        String json = "{\"code\":"+1+",";
        json += "\"msg\":\"查询成功\",";
        json += "\"data\":"+validWuLiuList+",";
        json += "\"total\":"+allCount+",";
        json += "\"limit\":"+limit+",";
        json += "\"page\":"+page+",";
        json += "}";
        JSONObject result = JSONObject.fromObject(json);//将json字符串转成json对象
        resp.getWriter().println(result);
        return;
    }


    /**
     * 查询异常物流信息（物流信息里客户不在客户数据中）
     * @param req 请求对象
     * @param resp 响应对象
     */
    public void  getInvalidWuLiuList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Map> inValidWuLiuList = wuLiuDao.getInvalidWuLiuList();//调用dao层的查询方法
        JSONObject result = resultModel.response(1, "查询成功", inValidWuLiuList); //返回前端的json对象
        resp.getWriter().println(result);
        return;
    }


    /**
     * 查询身份证治理过程列表(溯源)
     * @param req 请求对象
     * @param resp 响应对象
     */
    public void getWuLiuProList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Map> list = wuLiuDao.getWuLiuProList(); //调用dao层的查询方法
        JSONObject result = resultModel.response(1, "查询成功", list); //返回前端的json对象
        resp.getWriter().println(result);
        return;
    }


    /**
     * 保存修改的身份证
     * @param req 请求对象
     * @param resp 响应对象
     */
    public void saveEditCertificateNo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String err_id = req.getParameter("err_id"); //处理的异常数据ID
        String no = req.getParameter("no");  //提单号
        String name = req.getParameter("name");  //货主名称
        String company = req.getParameter("company");  //物流公司
        String xainghao = req.getParameter("xainghao");  //箱号
        String _name = req.getParameter("_name"); //货物名称
        String certificate_no = req.getParameter("certificate_no");  //货主代码
        String weight = req.getParameter("weight");  //货重
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
        int i = wuLiuDao.saveEditCertificateNo(err_id,no,name,company,xainghao,_name,certificate_no,weight);
        if(i == 1){
            JSONObject result = resultModel.response(1, "保存成功", null);
            resp.getWriter().println(result);
            return;
        }else if(i == 2){
            JSONObject result = resultModel.response(0, "身份证不在客户表中", null);
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
            JSONObject result = resultModel.response(0, "修改物流信息_异常数据标识字段失败", null);
            resp.getWriter().println(result);
            return;
        }else if(i == 6){
            JSONObject result = resultModel.response(0, "向物流信息_治理过程中插入一条新数据失败", null);
            resp.getWriter().println(result);
            return;
        }
    }
}

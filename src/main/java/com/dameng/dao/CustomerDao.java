package com.dameng.dao;

import com.dameng.util.DamengConnUtil;
import com.dameng.util.DateUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 客户处理dao层
 */
public class CustomerDao {

    /**
     * 获取客户正常数据列表（身份证合法客户）
     * @param offset 偏移量
     * @param limit 限制数量
     * @return 客户正常数据列表
     */
    public Map<String,Object> getValidCustomerList(Integer offset,Integer limit){
        List<Map> list = new ArrayList<>();
        Connection conn = DamengConnUtil.getConn();
        Integer allCount = 0;  //总条数
        try {
            Statement statement = conn.createStatement();
            //查询总条数
            String _sql = "select count(*) as total  from DAMENG8.客户表_正常数据";
            ResultSet _rs = statement.executeQuery(_sql);
            if(_rs.next()){
                allCount = _rs.getInt("total");
            }
            //查询正常数据表，分页查询
            String sql = "select * from DAMENG8.客户表_正常数据 limit " +offset+","+limit;
            ResultSet rs = statement.executeQuery(sql);
            // 处理结果集
            ResultSetMetaData metaData = rs.getMetaData();
            int n = metaData.getColumnCount();
            while (rs.next()) {
                // 处理每一行数据
                HashMap<String, String> map = new HashMap<>();
                for(int i = 1; i <= n ; i ++ ){
                    String key = metaData.getColumnName(i);
                    String value = "\"" + rs.getString(key) + "\"";
                    map.put(key,value);
                }
                list.add(map);
            }
            DamengConnUtil.closeAll(rs,statement,conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        Map<String,Object> objectHashMap = new HashMap<String,Object>();
        objectHashMap.put("allCount",allCount);
        objectHashMap.put("data",list);
        return objectHashMap;
    }


    /**
     * 获取客户异常数据列表（身份证不合法客户）
     * @return 客户异常数据列表
     */
    public List<Map> getInValidCustomerList(){
        List<Map> list = new ArrayList<>();
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            //查询异常表中标识为0的数据，代表未被处理过
            String sql = "select * from DAMENG8.客户表_异常数据 where 标识 = 0";
            ResultSet rs = statement.executeQuery(sql);
            // 处理结果集
            ResultSetMetaData metaData = rs.getMetaData();
            int n = metaData.getColumnCount();
            while (rs.next()) {
                // 处理每一行数据
                HashMap<String, String> map = new HashMap<>();
                for(int i = 1; i <= n ; i ++ ){
                    String key = metaData.getColumnName(i);
                    String value = "\"" + rs.getString(key) + "\"";
                    map.put(key,value);
                }
                list.add(map);
            }
            DamengConnUtil.closeAll(rs,statement,conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }


    /**
     *查询身份证治理过程列表(溯源)
     * @return 身份证治理过程列表
     */
    public List<Map> getCustomerProList(){
        List<Map> list = new ArrayList<>();
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            //查询异常表中标识为0的数据，代表未被处理过
            String sql = "select b.客户名称 as 治理后客户名称,b.客户编号 as 治理后客户编号,b.手机号 as 治理后手机号,b.省市区 as 治理后省市区," +
                    "c.客户名称 as 治理前客户名称,c.客户编号 as 治理前客户编号,c.手机号 as 治理前手机号,c.省市区 as 治理前省市区," +
                    "d.NAME as 治理人,a.TIME as  治理时间 from DAMENG8.客户表_治理过程  a left join DAMENG8.客户表_正常数据  b on a.ACC_ID = b.ID  " +
                    "left join DAMENG8.客户表_异常数据 c on a.ERR_ID = c.ID " +
                    "left join DAMENG8.中台系统用户表 d on a.USER_ID = d.ID";
            ResultSet rs = statement.executeQuery(sql);
            // 处理结果集
            ResultSetMetaData metaData = rs.getMetaData();
            int n = metaData.getColumnCount();
            while (rs.next()) {
                // 处理每一行数据
                HashMap<String, String> map = new HashMap<>();
                for(int i = 1; i <= n ; i ++ ){
                    String key = metaData.getColumnName(i);
                    String value = "\"" + rs.getString(key) + "\"";
                    map.put(key,value);
                }
                list.add(map);
            }
            DamengConnUtil.closeAll(rs,statement,conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }


    /**
     * 保存修改的身份证
     * @param err_id  修改的异常数据ID
     * @param name  客户名称
     * @param phone  手机号
     * @param certificate_no  身份证
     * @param address  省市区
     * @return 保存结果：1表示成功，2表示有重复的身份证，3表示向正常表插入数据失败，4表示未获取到ID，5表示修改客户表_异常数据标识字段失败，6表示向客户表_治理过程中插入一条新数据失败
     */
    public int saveEditCertificateNo(String err_id,String name,String phone,String certificate_no,String address){
        int i = 0;
        List<Map> list = new ArrayList<>();
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            //查询客户表_正常数据中是否有重复的身份证号
            String _sql = " select * from DAMENG8.客户表_正常数据 where 客户编号= '"+certificate_no+"'";
            ResultSet rs = statement.executeQuery(_sql);
            if(rs.next()){
                return  2; //有重复的身份证
            }

            //向客户表_正常数据中插入一条新数据
            String sql1 = " insert into DAMENG8.客户表_正常数据(客户名称,客户编号,手机号,省市区) values('"+name+"','"+certificate_no+"','"+phone+"','"+address+"')";
            int i1 = statement.executeUpdate(sql1,Statement.RETURN_GENERATED_KEYS);
            if(i1 <= 0){
                return  3; //向正常表插入数据失败
            }
            int acc_id = 0;
            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()){
                acc_id=generatedKeys.getInt(1);
            }
            if(acc_id == 0){
                return  4; //未获取到ID
            }

            //修改客户表_异常数据的标识字段，代表这条数据已被治理
            String sql2 = "update DAMENG8.客户表_异常数据 set 标识 = 1 where ID = "+err_id;
            int i2 = statement.executeUpdate(sql2);
            if(i2 <= 0){
                return  5; //修改客户表_异常数据标识字段失败
            }

            //向客户表_治理过程中插入一条新数据
            String cur_time = DateUtil.getCurTime();
            String sql3 = " insert into DAMENG8.客户表_治理过程(ACC_ID,ERR_ID,USER_ID,TIME) values('"+acc_id+"','"+err_id+"','"+1+"','"+cur_time+"')";
            int i3 = statement.executeUpdate(sql3);
            if(i3 <= 0){
                return  6; //向客户表_治理过程中插入一条新数据失败
            }
            DamengConnUtil.closeAll(rs,statement,conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 1;
    }
}

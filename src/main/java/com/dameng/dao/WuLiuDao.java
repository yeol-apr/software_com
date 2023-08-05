package com.dameng.dao;

import com.dameng.util.DamengConnUtil;
import com.dameng.util.DateUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 物流信息处理dao层
 */
public class WuLiuDao {

    /**
     * 查询正常物流信息（物流信息里客户在客户数据中）
     * @return
     */
    public Map<String,Object> getValidWuLiuList(Integer offset,Integer limit){
        List<Map> list = new ArrayList<>();
        Connection conn = DamengConnUtil.getConn();
        Integer allCount = 0;  //总条数
        try {
            Statement statement = conn.createStatement();
            //查询总条数
            String _sql = "select count(*) as total  from DAMENG8.物流信息_正常数据";
            ResultSet _rs = statement.executeQuery(_sql);
            if(_rs.next()){
                allCount = _rs.getInt("total");
            }
            //查询正常数据表，分页查询
            String sql = "select * from DAMENG8.物流信息_正常数据  limit " +offset+","+limit;
            ResultSet rs = statement.executeQuery(sql);
            // 处理结果集
            ResultSetMetaData metaData = rs.getMetaData();
            int n = metaData.getColumnCount();
            while (rs.next()) {
                // 处理每一行数据
                HashMap<String, String> map = new HashMap<>();
                for(int i = 1; i <= n ; i ++ ){
                    String key = metaData.getColumnName(i);
                    String value = "\"" + rs.getString(key).trim() + "\"";
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
     * 查询异常物流信息（物流信息里客户不在客户数据中）
     * @return
     */
    public List<Map> getInvalidWuLiuList(){
        List<Map> list = new ArrayList<>();
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            //查询异常表中标识为0的数据，代表未被处理过
            String sql = "select * from DAMENG8.物流信息_异常数据 where 标识 = 0";
            ResultSet rs = statement.executeQuery(sql);
            // 处理结果集
            ResultSetMetaData metaData = rs.getMetaData();
            int n = metaData.getColumnCount();
            while (rs.next()) {
                // 处理每一行数据
                HashMap<String, String> map = new HashMap<>();
                for(int i = 1; i <= n ; i ++ ){
                    String key = metaData.getColumnName(i);
                    String value = "\"" + rs.getString(key).trim() + "\"";
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
     * @return
     */
    public List<Map> getWuLiuProList(){
        List<Map> list = new ArrayList<>();
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            //查询异常表中标识为0的数据，代表未被处理过
            String sql = "select b.提单号 as 治理后提单号,b.货主名称 as 治理后货主名称,b.货主代码 as 治理后货主代码,b.物流公司 as 治理后物流公司,b.集装箱号 as 治理后集装箱号,b.货物名称 as 治理后货物名称,b.货重 as 治理后货重," +
                    "c.提单号 as 治理前提单号,c.货主名称 as 治理前货主名称,c.货主代码 as 治理前货主代码,c.物流公司 as 治理前物流公司,c.集装箱箱号 as 治理前集装箱号,c.货物名称 as 治理前货物名称,c.货重 as 治理前货重," +
                    "d.NAME as 治理人,a.TIME as  治理时间 from DAMENG8.物流信息_治理过程  a left join DAMENG8.物流信息_正常数据  b on a.ACC_ID = b.ID  " +
                    "left join DAMENG8.物流信息_异常数据 c on a.ERR_ID = c.ID " +
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
                    String value = "\"" + rs.getString(key).trim() + "\"";
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
     *  保存修改的身份证
     * @param err_id
     * @param no 提单号
     * @param name 货主名称
     * @param company 物流公司
     * @param xainghao 集装箱号
     * @param _name 货物名称
     * @param certificate_no 货主代码
     * @param weight 货重
     * @return
     */
    public int saveEditCertificateNo(String err_id,String no,String name,String company,String xainghao,String _name,String certificate_no,String weight){
        int i = 0;
        List<Map> list = new ArrayList<>();
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            //检验该身份证是否在客户表_正常数据中存在
            String _sql = " select * from DAMENG8.客户表_正常数据 where 客户编号= '"+certificate_no+"'";
            ResultSet rs = statement.executeQuery(_sql);
            if(rs.next()){
                //向物流信息_正常数据中插入一条新数据
                String sql1 = " insert into DAMENG8.物流信息_正常数据(提单号,货主名称,货主代码,物流公司,集装箱号,货物名称,货重) values('"+no+"','"+name+"','"+certificate_no+"','"+company+"','"+xainghao+"','"+_name+"','"+weight+"')";
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

                //修改物流信息_异常数据的标识字段，代表这条数据已被治理
                String sql2 = "update DAMENG8.物流信息_异常数据 set 标识 = 1 where ID = "+err_id;
                int i2 = statement.executeUpdate(sql2);
                if(i2 <= 0){
                    return  5; //修改物流信息_异常数据标识字段失败
                }

                //向物流信息_治理过程中插入一条新数据
                String cur_time = DateUtil.getCurTime();
                String sql3 = " insert into DAMENG8.物流信息_治理过程(ACC_ID,ERR_ID,USER_ID,TIME) values('"+acc_id+"','"+err_id+"','"+1+"','"+cur_time+"')";
                int i3 = statement.executeUpdate(sql3);
                if(i3 <= 0){
                    return  6; //向物流信息_治理过程中插入一条新数据失败
                }
                DamengConnUtil.closeAll(rs,statement,conn);

            }else{
                return  2; //身份证不在客户表中
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 1;
    }
}

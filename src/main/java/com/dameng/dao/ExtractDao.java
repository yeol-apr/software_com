package com.dameng.dao;
import com.dameng.util.DamengConnUtil;
import java.sql.*;
import java.util.*;

/**
 * 数据提取dao层
 */
public class ExtractDao {

    /**
     * 根据提取条件查询数据
     * @param extract 提取条件
     * @return 查询结果列表
     */
    public List<Map> select(String extract){
        String sql1="";
        if (Objects.equals(extract, "客户表")){
            sql1="select * from DAMENG8.客户表  LIMIT 10";
        }
        if (Objects.equals(extract, "物流信息")){
            sql1="select 提单号,货主名称,货主代码,物流公司,集装箱箱号,货物名称,货重 from DAMENG8.物流信息  LIMIT 10";
        }
        if (Objects.equals(extract, "卸货表")){
            sql1="select 船公司,船名称,到达时间,作业港口,提单号,集装箱箱号,启运地,目的地 from DAMENG8.卸货表  LIMIT 10";
        }
        if (Objects.equals(extract, "装货表")){
            sql1="select 船公司,船名称,到达时间,作业港口,提单号,集装箱箱号,启运地,目的地 from DAMENG8.装货表  LIMIT 10";
        }
        if (Objects.equals(extract, "集装箱动态")){
            sql1="select 堆存港口,集装箱箱号,箱状态,提单号,堆场位置,操作,操作日期 from DAMENG8.集装箱动态2021_2022  LIMIT 10";
        }
        if (Objects.equals(extract, "物流公司")){
            sql1="select 公司名称,客户编号,联系人,电话,省市区 from DAMENG8.物流公司2021_2022  LIMIT 10";
        }

        List<Map> list =  new ArrayList<Map>();
        Connection conn = DamengConnUtil.getConn();
        try{
            Statement statement= conn.createStatement();
            ResultSet rs = statement.executeQuery(sql1);
            ResultSetMetaData metaData = rs.getMetaData();
            int count = metaData.getColumnCount();
            while (rs.next()){
                Map<String ,String> map = new HashMap<>();
                for(int i = 1; i <= count ; i++){
                    String key = metaData.getColumnName(i);
                    String value=rs.getString(key);
                    String replace = value.replaceAll("\"", "'");
                    String s1 = replace.replaceAll("[\b\r\n\t]*", "");
                    String s2="\""+s1+"\"";
                    map.put(key,s2);
                }
                list.add(map);
            }
            DamengConnUtil.closeAll(rs,statement,conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return (ArrayList) list;
    }
}

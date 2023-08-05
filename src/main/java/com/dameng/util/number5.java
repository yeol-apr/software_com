package com.dameng.util;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class number5 {
    public static void main(String[] args) {
        cargoFlow();
    }
    private static Connection conn = null;//连接数据库
    /**
     * 执行数据库查询语句
     * @param sql 查询语句
     * @return 查询结果列表
     */
    private static List<Map> statement(String sql) {
        conn = DamengConnUtil.getConn();
        ArrayList<Map> list = new ArrayList<>();// 定义一个ArrayList对象，用于存储查询
        Statement statement = null;
        try {
            statement = conn.createStatement();
            //物流信息列表
            //System.out.println("sql语句是"+sql);
            ResultSet rs = statement.executeQuery(sql);
            ResultSetMetaData metaData = rs.getMetaData();// 定义一个ArrayList对象，用于存储查询
            int count = metaData.getColumnCount();// 获取结果集中列的数量
            while (rs.next()) {// 遍历结果集中的每一行数据
                Map<String,String> map = new HashMap<>();// 定义一个Map对象，用于存储当前行的数据
                for(int i = 1; i <= count ; i++){//遍历当前行的所有列
                    String key = metaData.getColumnName(i);// 获取当前列的名称
                    String value = rs.getString(key);// 获取当前列的值
                    map.put(key,value);// 将当前列的名称和值添加到Map对象中
                }
                list.add(map);// 将当前行的数据添加到ArrayList对象中
            }
            DamengConnUtil.closeAll(rs,statement,conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
    /**
     * 执行数据库查询语句
     * @param sql 查询语句
     * @return 查询结果是否成功
     */
    private static boolean statement2(String sql) {
        conn = DamengConnUtil.getConn();
        ArrayList<Map> list = new ArrayList<>();// 定义一个ArrayList对象，用于存储查询
        Statement statement = null;
        boolean execute;
        try {
            statement = conn.createStatement();
            //物流信息列表
            //System.out.println("sql语句是"+sql);
            execute = statement.execute(sql);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return execute;
    }
    /**
     * 物流流向分析
     * sql2：提取货物名
     * cargo_list: 货物名list
     * cargo_sql2：按货物名，提取各港口的各货物重量之和
     * cargo_list2：各港口的货物重量
     */
    public static void cargoFlow() {
        //提取货物名
        String sql2 = "SELECT CARGO_NAME " +
                "FROM DAMENG8.LOGISTICS_INFORMATION GROUP BY CARGO_NAME";
        List<Map> cargo_list = new ArrayList<>();
        cargo_list = statement(sql2);
//        System.out.println(cargo_list);
        //按货物名进行遍历
        for (Map<String,String> map_port: cargo_list) {
            String CARGO_NAME = map_port.get("CARGO_NAME");
            String cargo_sql2 = "SELECT CARGO_NAME ,PORT, SUM(DAMENG8.LOGISTICS_INFORMATION.CARGO_WEIGHT) AS Cargo_weight1 " +
                    "FROM DAMENG8.LOGISTICS_INFORMATION " +
                    "LEFT JOIN DAMENG8.CHARGE_INFORMATION ON DAMENG8.LOGISTICS_INFORMATION.BILL_NUMBER = DAMENG8.CHARGE_INFORMATION.BILL_NUMBER " +
                    "WHERE (CARGO_NAME = '"+CARGO_NAME+"') GROUP BY CARGO_NAME, PORT;";

            List<Map> cargo_list2 = new ArrayList<>();
            cargo_list2 = statement(cargo_sql2);
            //System.out.println(cargo_list2);
            //遍历10个港口对应货物的货重，使用map生成“港口=货重”的键值对
            Map<String, Integer> portCountMap = new HashMap<>();
            for(Map<String, String> map: cargo_list2){
                if (map.get("CARGO_NAME").equals(CARGO_NAME)){
                    String key = map.get("PORT");
                    Integer value = Integer.valueOf(map.get("CARGO_WEIGHT1"));
                    portCountMap.put(key,value);
                }
            }
            System.out.println(portCountMap);
            //按货物分类写入数据库
            String INTO = "INSERT INTO DAMENG8.CARGO_FLOW_ANALYSIS(CARGO_NAME,NANTONG,ZHENGJIANG,SUZHOU,HANGZHOU,TAICANG,MAANSHANG,WUHU,TAIZHOU,TONGLIN) VALUES('"+CARGO_NAME+"','"
                    + portCountMap.get("南通港") + "','" + portCountMap.get("镇江港") + "','" + portCountMap.get("苏州港") + "','" + portCountMap.get("杭州港")
                    + "','" + portCountMap.get("太仓港") + "','" + portCountMap.get("马鞍山港") + "','" + portCountMap.get("芜湖港") + "','" + portCountMap.get("泰州港")
                    + "','" + portCountMap.get("铜陵港") + "');";

            System.out.println(INTO);

            statement2(INTO);
        }
    }
}


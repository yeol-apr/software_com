package com.dameng.dao;


import com.dameng.util.DamengConnUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 该类对数据库的各种表进行数据库sql语句，并将其作为数据操作并插入所需表中。
 */
public class InformationProcessing {
    /**
     *数据库数据分析展示类
     */
    private static Connection conn = null;//连接数据库
    private static List<Map> statement(String sql) {
        /**
         * 数据库查询语句
         * @return SqlList
         *
         */
        conn = DamengConnUtil.getConn();
        ArrayList<Map> list = new ArrayList<>();// 定义一个ArrayList对象，用于存储查询
        Statement statement = null;
        try {
            statement = conn.createStatement();
            //物流信息列表
            System.out.println("sql语句是"+sql);
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
            }  DamengConnUtil.closeAll(rs,statement,conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;

    }

    private static int SatatementInto(String sql){

        /**
         * 插入语句
         * @return 返回i的值
         */
        int i= 0;
        System.out.println(sql);
        conn = DamengConnUtil.getConn();
        ArrayList<Map> list = new ArrayList<>();// 定义一个ArrayList对象，用于存储查询
        Statement statement = null;
        try {
            statement = conn.createStatement();
             i = statement.executeUpdate(sql);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
       return i;

    }

    public static void  swallowAndSpit(){
        /**
         * 对数据库装卸货表进行操作，返回的数据，并进行插入
         * 用于对吞吐量分析
         * sql：查询分组，返回港口名作为列表
         * sql1:读取数据库卸货表
         * sql1:读取数据库装货表
         * list:存储sql
         * list1:存储sql1
         * list2：存储sql2
         */

        String sql = "select PORT from DAMENG8.CHARGE_INFORMATION GROUP BY PORT;";
        List<Map> list  = new ArrayList<>();
        list = statement(sql);
        String sql1 = "SELECT DAMENG8.DISCHARGE_INFORMATION.CHARGE_PORT,DAMENG8.LOGISTICS_ACC.CARGO_NAME," +
                "SUM(DAMENG8.LOGISTICS_ACC.CARGO_WEIGHT) AS Cargo_weight2, COUNT(*) AS COUNT2 FROM DAMENG8.LOGISTICS_ACC" +
                " JOIN DAMENG8.DISCHARGE_INFORMATION " +
                "ON DAMENG8.LOGISTICS_ACC.BILL_NUMBER = DAMENG8.DISCHARGE_INFORMATION.BILLNUMBER " +
                "GROUP BY DAMENG8.DISCHARGE_INFORMATION.CHARGE_PORT,DAMENG8.LOGISTICS_ACC.CARGO_NAME";
        List<Map> list1 = new ArrayList<>();
        list1 = statement(sql1);
        //System.out.println(list);
        String sql2 = "SELECT DAMENG8.CHARGE_INFORMATION.PORT, DAMENG8.LOGISTICS_ACC.CARGO_NAME AS NAME," +
                "SUM(DAMENG8.LOGISTICS_ACC.CARGO_WEIGHT) AS Cargo_weight1, COUNT(*) AS COUNT1 " +
                "FROM DAMENG8.LOGISTICS_ACC JOIN  DAMENG8.CHARGE_INFORMATION " +
                "ON DAMENG8.LOGISTICS_ACC.BILL_NUMBER = DAMENG8.CHARGE_INFORMATION.BILL_NUMBER " +
                "GROUP BY DAMENG8.CHARGE_INFORMATION.PORT,DAMENG8.LOGISTICS_ACC.CARGO_NAME,PORT";
        List<Map> list2 = new ArrayList<>();
        list2 = statement(sql2);
        //System.out.println(list2);
        for(Map<String,String> map : list){
            int  count = 0;
            String port_  = map.get("PORT");
            for (Map<String, String> map1 : list1) {
                String CHARGE_PORT = map1.get("CHARGE_PORT");
                if(CHARGE_PORT.equals(port_)){
                    int count1 = Integer.parseInt(map1.get("CARGO_WEIGHT2"));
                    count = count+count1;
                }
                }
            for (Map<String, String> map2 : list2) {
                String CHARGE_PORT = map2.get("PORT");
                if(CHARGE_PORT.equals(port_)){
                    int count1 = Integer.parseInt(map2.get("CARGO_WEIGHT1"));
                    count = count+count1;
                }
            }
            System.out.println("港口"+port_+"总数"+count);
            String INTO ="insert into DATA.TUNTU (PORT,COUNT)values ('"+
                    port_+"','"+count+"')";
            SatatementInto(INTO);
            }
    }

    public static void Cargo_Trend() {
        /**
         * 对港口不同类型货物每季度进行对比
         * sql_port:
         * port_list:
         * one_sql_zhuang:查询第一季度的特定港口的装货不同货物趋势
         * one_list_zhuang:存储查询结果
         * one_sql_xie:查询第一季度不同的卸货趋势
         * one_list_xie:存储查询结果
         */
        String sql_port = "select PORT from DAMENG8.CHARGE_INFORMATION group by PORT;";
        List<Map> port_list = new ArrayList<>();
        port_list = statement(sql_port);
        for (Map<String,String> map_port : port_list) {
            System.out.println(map_port.get("PORT"));
            String Gk = map_port.get("PORT");
            String one_sql_z = "SELECT DAMENG8.LOGISTICS_ACC.CARGO_NAME , SUM(DAMENG8.LOGISTICS_ACC.CARGO_WEIGHT) AS CARGO_WEIGHT2 " +
                    "FROM DAMENG8.LOGISTICS_ACC  " +
                    "JOIN DAMENG8.DISCHARGE_INFORMATION " +
                    "ON DAMENG8.LOGISTICS_ACC.BILL_NUMBER = DAMENG8.DISCHARGE_INFORMATION.BILLNUMBER " +
                    "where (DAMENG8.DISCHARGE_INFORMATION.E_VOYAGE >= '2022-10-01') " +
                    "AND (DAMENG8.DISCHARGE_INFORMATION.E_VOYAGE <= '2022-12-31') " +
                    "AND CHARGE_PORT ='"+Gk+"' GROUP BY DAMENG8.DISCHARGE_INFORMATION.CHARGE_PORT,DAMENG8.LOGISTICS_ACC.CARGO_NAME;";
            List<Map> one_list_z = new ArrayList<>();
            one_list_z = statement(one_sql_z);
            String one_sql_x = "SELECT DAMENG8.LOGISTICS_ACC.CARGO_NAME ,SUM(DAMENG8.LOGISTICS_ACC.CARGO_WEIGHT) AS CARGO_WEIGHT1 " +
                    "FROM DAMENG8.LOGISTICS_ACC " +
                    "JOIN DAMENG8.CHARGE_INFORMATION " +
                    "ON DAMENG8.LOGISTICS_ACC.BILL_NUMBER = DAMENG8.CHARGE_INFORMATION.BILL_NUMBER " +
                    "where (DAMENG8.CHARGE_INFORMATION.E_VOYAGE >= '2022-10-01') " +
                    "AND (DAMENG8.CHARGE_INFORMATION.E_VOYAGE <= '2022-12-31') " +
                    "AND PORT ='"+Gk+"' " +
                    "GROUP BY DAMENG8.CHARGE_INFORMATION.PORT,DAMENG8.LOGISTICS_ACC.CARGO_NAME;";
            List<Map> one_list_x = new ArrayList<>();
            one_list_x = statement(one_sql_x);
            List<Integer> list = new ArrayList<>();
            Map<String, Integer> cargoCountMap = new HashMap<>();
            for (Map<String, String> one_z : one_list_z) {
                int count = 0;
                String cargo_name = one_z.get("CARGO_NAME");
                int count_z = Integer.parseInt(one_z.get("CARGO_WEIGHT2"));
                for (Map<String, String> one_x : one_list_x) {
                    if (cargo_name.equals(one_x.get("CARGO_NAME"))) {
                        int count_x = Integer.parseInt(one_x.get("CARGO_WEIGHT1"));
                        count = count_z + count_x;
                        //list.add(count);
                        //System.out.println(one_x.get("CARGO_NAME") + "数量" + count);
                        cargoCountMap.put(cargo_name.trim(), count);
                    }
                }
            }
            String INTO = "insert into DATA."+Gk+" values ('"
                    + cargoCountMap.get("燕麦") + "','" + cargoCountMap.get("木材") + "','" + cargoCountMap.get("钢材") + "','" + cargoCountMap.get("稻谷")
                    + "','" + cargoCountMap.get("原煤") + "','" + cargoCountMap.get("大豆油") + "','" + cargoCountMap.get("铜") + "','" + cargoCountMap.get("单氟磷酸钠")
                    + "','" + cargoCountMap.get("小牛") + "','" + cargoCountMap.get("活牛") + "','" + cargoCountMap.get("大豆粉") + "','" + cargoCountMap.get("原油") + "','"
                    + cargoCountMap.get("茶叶") + "','" + cargoCountMap.get("天然橡胶") + "','" + cargoCountMap.get("水泥") + "','" + cargoCountMap.get("猪腩") +
                    "','" + cargoCountMap.get("黑麦") + "','" + cargoCountMap.get("大豆") + "','" + cargoCountMap.get("小麦") + "','" +
                    +cargoCountMap.get("大麦") + "','" + cargoCountMap.get("活猪") + "','" + cargoCountMap.get("砂石") + "','" + cargoCountMap.get("铁矿石") + "','" + cargoCountMap.get("三钙") + "','" + "第四季度" +
                    "')";
            //System.out.println(INTO);
            SatatementInto(INTO);
        }
    }

    public static void Throughput(){
        /**
         * 对数据库内容进行不同货物吞吐占比数据进行操作
         */
        String se_sql = "SELECT CARGO_NAME,SUM(CARGO_WEIGHT) FROM DAMENG8.LOGISTICS_INFORMATION  " +
                "GROUP BY(CARGO_NAME) ORDER BY(SUM(CARGO_WEIGHT))";
        List<Map> se_list = new ArrayList<>();
        se_list = statement(se_sql);
        for (Map<String,String> map:se_list){
            System.out.println(map);
            String INTO="insert into DAMENG8.DIFFERENT_LOTS values('"+map.get("CARGO_NAME")+"','"+map.get("SUM(CARGO_WEIGHT)")+"')";
            SatatementInto(INTO);
        }
    }


    public static void Yoy() {
        /**
         * 对港口货物同比环比函数
         * sql_port:查询港口
         * port_list:存储港口
         *one_sql_z:装货表
         */
        String sql_port = "select PORT from DAMENG8.CHARGE_INFORMATION group by PORT;";
        List<Map> port_list = new ArrayList<>();
        port_list = statement(sql_port);
        for (Map<String,String> map_port : port_list) {
            System.out.println(map_port.get("PORT"));
            String Gk = map_port.get("PORT");
            for (int i =1;i<=12;i++) {
                System.out.println(i);
                String sql_2022_z = "SELECT DAMENG8.CHARGE_INFORMATION.PORT, SUM(DAMENG8.LOGISTICS_ACC.CARGO_WEIGHT) AS CARGO_WEIGHT1" +
                        " FROM DAMENG8.LOGISTICS_ACC " +
                        "JOIN  DAMENG8.CHARGE_INFORMATION " +
                        "ON DAMENG8.LOGISTICS_ACC.BILL_NUMBER = DAMENG8.CHARGE_INFORMATION.BILL_NUMBER " +
                        "where YEAR(E_DISCHARGE)= '2022' AND MONTH(E_DISCHARGE)='"+i+"' " +
                        "AND PORT ='"+Gk+"' GROUP BY DAMENG8.CHARGE_INFORMATION.PORT;";
                List<Map> list_2022_z = new ArrayList<>();
                list_2022_z = statement(sql_2022_z);
                String sql_2022_x = "SELECT DAMENG8.DISCHARGE_INFORMATION.CHARGE_PORT, SUM(DAMENG8.LOGISTICS_ACC.CARGO_WEIGHT) AS CARGO_WEIGHT2 " +
                        "FROM DAMENG8.LOGISTICS_ACC JOIN DAMENG8.DISCHARGE_INFORMATION  " +
                        "ON DAMENG8.LOGISTICS_ACC.BILL_NUMBER = DAMENG8.DISCHARGE_INFORMATION.BILLNUMBER " +
                        "where YEAR(S_CHARGE)='2022'AND MONTH(S_CHARGE)='"+i+"'" +
                        "and CHARGE_PORT ='"+Gk+"' GROUP BY DAMENG8.DISCHARGE_INFORMATION.CHARGE_PORT";
                List<Map> list_2022_x = new ArrayList<>();
                list_2022_x = statement(sql_2022_x);
                List<Integer> list = new ArrayList<>();
                Map<String, Integer> cargoCountMap = new HashMap<>();
                int count = 0;
                for (Map<String, String> one_z : list_2022_z) {
                    System.out.println(list_2022_z);
                    int count_z = Integer.parseInt(one_z.get("CARGO_WEIGHT1"));
                    for (Map<String, String> one_x : list_2022_x) {
                        System.out.println(list_2022_x);
                            int count_x = Integer.parseInt(one_x.get("CARGO_WEIGHT2"));
                            count = count_z + count_x;
                            //list.add(count);
                            System.out.println(one_x.get("CHARGE_PORT") + "数量" + count);
                    }
                }


                int count_2021_x =0 ;
                int count_2021_z =0 ;
                int count_2021 =0 ;
                String sql_2021_z = "SELECT DAMENG8.CHARGE_INFORMATION.PORT, SUM(DAMENG8.LOGISTICS_ACC.CARGO_WEIGHT) AS CARGO_WEIGHT1" +
                        " FROM DAMENG8.LOGISTICS_ACC " +
                        "JOIN  DAMENG8.CHARGE_INFORMATION " +
                        "ON DAMENG8.LOGISTICS_ACC.BILL_NUMBER = DAMENG8.CHARGE_INFORMATION.BILL_NUMBER " +
                        "where YEAR(E_DISCHARGE)= '2021' AND MONTH(E_DISCHARGE)='"+i+"' " +
                        "AND PORT ='"+Gk+"' GROUP BY DAMENG8.CHARGE_INFORMATION.PORT;";
                List<Map> list_2021_z = new ArrayList<>();
                list_2021_z = statement(sql_2021_z);
                if (list_2021_z != null && !list_2021_z.isEmpty()) {
                    System.out.println(list_2021_z);
                    for(Map<String,String> likst_2021 : list_2021_z){
                        count_2021_z = Integer.parseInt(likst_2021.get("CARGO_WEIGHT1"));
                    }
                } else {
                    System.out.println("查询结果为空");
                    list_2021_z.add(null);
                }
                System.out.println(list_2021_z);
                String sql_2021_x = "SELECT DAMENG8.DISCHARGE_INFORMATION.CHARGE_PORT, SUM(DAMENG8.LOGISTICS_ACC.CARGO_WEIGHT) AS CARGO_WEIGHT2 " +
                        "FROM DAMENG8.LOGISTICS_ACC JOIN DAMENG8.DISCHARGE_INFORMATION  " +
                        "ON DAMENG8.LOGISTICS_ACC.BILL_NUMBER = DAMENG8.DISCHARGE_INFORMATION.BILLNUMBER " +
                        "where YEAR(S_CHARGE)='2021'AND MONTH(S_CHARGE)='"+i+"'" +
                        "and CHARGE_PORT ='"+Gk+"' GROUP BY DAMENG8.DISCHARGE_INFORMATION.CHARGE_PORT";
                List<Map> list_2021_x = new ArrayList<>();
                list_2021_x = statement(sql_2021_x);
                if (list_2021_x != null && !list_2021_x.isEmpty()) {
                    System.out.println(list_2021_x);
                    for(Map<String,String> likst_2021 : list_2021_x){
                        count_2021_x = Integer.parseInt(likst_2021.get("CARGO_WEIGHT2"));
                    }
                } else {
                    list_2021_z.add(null);
                }
                count_2021=count_2021_z+count_2021_x;
                System.out.println("count2021="+count_2021);
                String INTO = "insert into DATA."+Gk+"S values ('"
                       +i+"','"+count+"','"+count_2021+
                        "')";
                SatatementInto(INTO);
                System.out.println(INTO);
            }

        }
    }
    }



package com.dameng.dao;

//对数据库进行操作,处理物流信息数据

import com.dameng.util.DamengConnUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * 该类用于对数据库查询身份证表，物流公司表，物流信息表，物流信息表中错误数据进行筛选和插入
 */
public class storageDao {
    /**
     * logistics:物流表查询
     * logistics_list： 定义一个ArrayList对象，用于存储查询
     * count：获取结果集
     * * @param conn 数据库连接对象
     * * @throws SQLException 如果连接数据库时发生错误
     */

    private static Connection conn = null;
//BOLN,SHIPOWNER_NAME,OWNER_CODE,LOGISTICS_COMPANY,CONTAINER_NUMBER,GOODS_NAME,CARGO_WEIGHT
         public static void read(){
             /**
              * return null
              */
             conn = DamengConnUtil.getConn();//连接数据库

             Statement statement = null;//执行sql语句
             try {

                 statement = conn.createStatement();//数据库连接对象 conn 来创建 Statement 对象，用于执行 SQL 语句
                 //物流信息列表
                 String logistics = "select * from DAMENG8.LOGISTICS_INFORMATION" ;
                 ResultSet logistics_rs = statement.executeQuery(logistics);
                 ArrayList<Map> logistics_list = new ArrayList<>();// 定义一个ArrayList对象，用于存储查询
                 ResultSetMetaData metaData = logistics_rs.getMetaData();// 定义一个ArrayList对象，用于存储查询
                 int count = metaData.getColumnCount();// 获取结果集中列的数量
                 while (logistics_rs.next()) {// 遍历结果集中的每一行数据
                     Map<String,String> map = new HashMap<>();// 定义一个Map对象，用于存储当前行的数据
                     for(int i = 1; i <= count ; i++){//遍历当前行的所有列
                         String key = metaData.getColumnName(i);// 获取当前列的名称
                         String value = logistics_rs.getString(key);// 获取当前列的值
                         map.put(key,value);// 将当前列的名称和值添加到Map对象中
                     }
                     logistics_list.add(map);// 将当前行的数据添加到ArrayList对象中
                 }

                 //处理物流公司
                 String logistics_company = "select * from DAMENG8.wuliugongsi";
                 ResultSet logistics_company_rs = statement.executeQuery(logistics_company);
                 ArrayList<Map> logistics_company_list = new ArrayList<>();
                 ResultSetMetaData metaData_logistics_company = logistics_company_rs.getMetaData();
                 /*  System.out.println("----metaData1----"+metaData1);*/
                 int count_logistics_company = metaData.getColumnCount();
//                 System.out.println("----count----"+count1);
                 while (logistics_company_rs.next()) {
                     Map<String,String> map = new HashMap<>();
                     for(int i = 1; i <= count_logistics_company ; i++){
                         String key = metaData_logistics_company.getColumnName(i);
                         String value = logistics_company_rs.getString(key);
                         map.put(key,value);
                     }
                     logistics_company_list.add(map);
                 }


                 // 处理结果集(查询正确的客户表)
                 String customers = "select * from DAMENG8.CUSTOMER_ACC" ;
                 ResultSet customers_rs1 = statement.executeQuery(customers);
                 ArrayList<Map> customers_list = new ArrayList<>();
                 ResultSetMetaData metaData1 = customers_rs1.getMetaData();
               /*  System.out.println("----metaData1----"+metaData1);*/
                 int count1 = metaData.getColumnCount();
//                 System.out.println("----count----"+count1);
                 while (customers_rs1.next()) {
                     Map<String,String> map = new HashMap<>();
                     for(int i = 1; i <= 6 ; i++){
                         String key = metaData1.getColumnName(i);
                         String value = customers_rs1.getString(key);
                         map.put(key,value);
                     }
                     customers_list.add(map);
                 }

//                 System.out.println("-----cus_list-----"+customers_list);


                 //System.out.println("-----wuliu_list-----"+logistics_list);
//
                 for (Map<String,String> map:logistics_list) {// 遍历物流信息表中的每一行数据
                     String logistics_no = map.get("OWNER_CODE");// 获取当前行的“货主代码”列的值
                     Boolean flag = true;// 定义一个Boolean对象，用于标记是否存在脏数据
                     for (Map<String,String> map1:customers_list) {// 遍历客户表中的每一行数据
                         String customers_no = map1.get("CERTIFICSTE_NO");// 获取当前行的“CERFIFICATE_NO”列的值
                         if(logistics_no.equals(customers_no)){// 如果“货主代码”列的值等于“CERFIFICATE_NO”列的值，说明存在脏数据
                             flag = false;
                         }
                     }
                     int countaa = 0;
                     if(flag){
//BOLN,SHIPOWNER_NAME,OWNER_CODE,LOGISTICS_COMPANY,CONTAINER_NUMBER,GOODS_NAME,CARGO_WEIGHT
                         //脏数据，插入脏数据表    "提单号","货主名称","货主代码","物流公司（货代）","集装箱箱号","货物名称","货重（吨）"
                         System.out.println("到达----错误");
                         String sql = "insert into DAMENG8.LOGISTICS_ERROR (BOLN,SHIPOWNER_NAME,OWNER_CODE,LOGISTICS_COMPANY,CONTAINER_NUMBER,GOODS_NAME,CARGO_WEIGHT) values ('"+
                                 map.get("BILL_NUMBER")+"','"+ map.get("OWNER_NAME")+"','"
                                 +map.get("OWNER_CODE")+"','"+map.get("LOGISTICS_COMPANY")
                                 + "','"+map.get("CONTAINER_NUMBER")+"','"+map.get("CARGO_NAME") +"','"+map.get("CARGO_WEIGHT")+"')";

                         int i = statement.executeUpdate(sql);
                         countaa = countaa+i;
                         System.out.println("----脏数据结果----"+countaa);
                     }else{
                         //正确数据，插入正确数据表

                         String sql_ = "insert into DAMENG8.LOGISTICS_ACC (BOLN,SHIPOWNER_NAME,OWNER_CODE,LOGISTICS_COMPANY,CONTAINER_NUMBER,GOODS_NAME,CARGO_WEIGHT) values ('"+
                                 map.get("BILL_NUMBER")+"','"+ map.get("OWNER_NAME")+"','"
                                 +map.get("OWNER_CODE")+"','"+map.get("LOGISTICS_COMPANY")
                                 + "','"+map.get("CONTAINER_NUMBER")+"','"+map.get("CARGO_NAME") +"','"+map.get("CARGO_WEIGHT")+"')";
                         System.out.println(sql_);
                         statement.executeUpdate(sql_);
                     }
                 }
                 System.out.println("完成");
                 DamengConnUtil.closeAll(logistics_rs,statement,conn);
             } catch (SQLException e) {
                 throw new RuntimeException(e);
             }
         }


}

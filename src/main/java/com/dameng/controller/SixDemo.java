package com.dameng.controller;

import com.dameng.util.DamengConnUtil;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;

public class SixDemo {
    /**
     * 不同类型货物堆场流转周期分析
     */
    public static List<Map> wuLiuList = null;
    public static List<Map<String,Object>> getCategory_list = null;
    public static List<Map> jiZhuanXiangList = null;
    public static void main(String[] args) {
        /**
         * 主函数入口
         */
        getCategory_list = getCategory();  //获取物品的种类

        for (Map<String,Object> item : getCategory_list){
            String cargoName = item.get("CARGO_NAME").toString();
            wuLiuList = getWuLiuList(cargoName);
            long betweenDay= 0;
            for (int i = 0; i < wuLiuList.size(); i++) {
                Map<String, Object> map = wuLiuList.get(i);

                // 这里的i就是索引
                if( i%2 != 0){
                    Map<String, Object> map1 = wuLiuList.get(i-1);
                    String rtime = map.get("OP_DATETIME").toString();
                    String ctime = map1.get("OP_DATETIME").toString();
                    betweenDay += getBetweenDay(ctime, rtime);
                }

            }
            item.put("Total",betweenDay);
        }

        System.out.println("----"+getCategory_list);
    }

    /**
     * 获取物品的种类
     * @return 物品种类列表
     */
    public static List<Map<String,Object>> getCategory() {
        List<Map<String,Object>> list = new ArrayList<>();

        //分组的到物品种类
        String sql = " SELECT CARGO_NAME FROM DAMENG8.LOGISTICS_ACC GROUP BY CARGO_NAME ";
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("CARGO_NAME", rs.getString("CARGO_NAME").trim());
                //天数
                map.put("Total", 0);
                list.add(map);
            }
            DamengConnUtil.closeAll(rs, statement, conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }


    /**
     * 根据物品种类获取物流动态信息
     * @param name 物品种类
     * @return 物流动态信息列表
     */
    public static List<Map> getWuLiuList(String name) {
        List<Map> list = new ArrayList<>();
        String sql = "SELECT A.CARGO_NAME,B.OPERATE,B.YARD_PORT,B.BILL_NUMBER,B.CONTAINER_NUMBER,B.OP_DATETIME FROM DAMENG8.LOGISTICS_ACC A LEFT JOIN DAMENG8.CONTAINER_MOVEMENT B on A.BILL_NUMBER = B.BILL_NUMBER WHERE  A.CARGO_NAME= '"+name+"'";
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                if(rs.getString("BILL_NUMBER") != null){
                    map.put("BILL_NUMBER", rs.getString("BILL_NUMBER").trim());
                    map.put("CONTAINER_NUMBER", rs.getString("CONTAINER_NUMBER").trim());
                    map.put("OP_DATETIME", rs.getString("OP_DATETIME").trim());
                    map.put("OPERATE", rs.getString("OPERATE").trim());
                    list.add(map);
                }
            }
            DamengConnUtil.closeAll(rs, statement, conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }


    /**
     * 计算两个日期之间的天数
     * @param date1 日期1
     * @param date2 日期2
     * @return 日期之间的天数
     */
    public static long getBetweenDay(String date1,String date2){
//        String date1 = "2023-06-30";
//        String date2 = "2023-07-02";

        // 将日期字符串转换为LocalDate对象
        LocalDate localDate1 = LocalDate.parse(date1);
        LocalDate localDate2 = LocalDate.parse(date2);

        // 计算日期差
        long daysBetween = ChronoUnit.DAYS.between(localDate1, localDate2);
        //System.out.println("日期差：" + daysBetween + "天");
        return  daysBetween;
    }


    /**
     * 向数据库插入数据
     */
    public static void insertData(){
        Connection conn = DamengConnUtil.getConn();
        try {
            Statement statement = conn.createStatement();
            for (Map<String,Object> list :getCategory_list) {
                String CARGO_NAME = list.get("CARGO_NAME").toString();
                int Total = (int)list.get("Total");
                String sql = "INSERT INTO DAMENG8.CYCLE_SIX(TYPE,DAY) VALUES('"+CARGO_NAME+"',"+Total+")";
                int i = statement.executeUpdate(sql);
                System.out.println("-----"+i);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}


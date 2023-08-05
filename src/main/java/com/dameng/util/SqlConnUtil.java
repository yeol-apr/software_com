package com.dameng.util;

import java.sql.*;

public class SqlConnUtil {


    public static Connection conn = null;
    /**
     * 连接数据库
     * @throws ClassNotFoundException
     */
    public static Connection  getConn() {
        String url = "jdbc:mysql://192.168.150.1:3306/dm8?characterEncoding=UTF-8&&serverTimezone=GMT";
        String user = "root";
        String password = "";
        try{
            //1、加载（注册）JDBC驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            //2、获取链接
            conn = DriverManager.getConnection(url,user,password);
            //st = conn.createStatement();
        }catch (SQLException e) {
            System.out.println("数据库连接失败");
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return conn;
    }

    /**
     * 释放资源
     */
    public static void closeAll(ResultSet rs, Statement stmt, Connection conn){
        try{
            if(rs != null){
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }

        }catch (SQLException e){
            e.printStackTrace();
        }
    }

}

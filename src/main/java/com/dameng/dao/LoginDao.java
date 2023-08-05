package com.dameng.dao;

import com.dameng.model.UserModel;
import com.dameng.util.DamengConnUtil;

import java.sql.*;

/**
 * 登录数据访问对象
 */
public class LoginDao {
    private static Connection conn = null;

    /**
     * 实现登录
     *
     * @param usernumber 用户名
     * @return 用户对象
     */
    public UserModel checkLogin(String usernumber) {
        // 1.获取连接
        conn = DamengConnUtil.getConn(); // 连接数据库
        UserModel user = null;
        // sql语句
        String sql = "select * from DAMENG8.中台系统用户表 where USERNAME='" + usernumber + "'";
        System.out.println(sql);
        try {
            Statement statement = conn.createStatement(); // 执行sql语句
            ResultSet rs = statement.executeQuery(sql); // ResultSet是结果集
            System.out.println(rs);
            System.out.println(11111);
            if (rs.next()) {
                user = new UserModel();
                user.setId(rs.getString("ID"));
                user.setNAME(rs.getString("NAME")); // 姓名
                user.setUSERNAME(rs.getString("USERNAME")); // 用户名
                user.setGROUP(rs.getString("GROUP")); // 权限
                user.setPASSWORD(rs.getString("PASSWORD")); // 密码
                user.setNumber(rs.getString("NO")); // 工号
            }
            DamengConnUtil.closeAll(rs, statement, conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }
}
package com.dameng.dao;

import com.dameng.util.DamengConnUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * API数据访问对象
 */
public class APIDao {
    /**
     * 数据库连接对象
     */
    private static Connection conn = null;

    /**
     * 获取查询结果列表
     *
     * @param sql    查询语句
     * @param fields 指定的字段索引数组
     * @return 查询结果列表
     */
    public static List<Map> getList(String sql, int[] fields) {
        conn = DamengConnUtil.getConn();
        ArrayList<Map> list = new ArrayList<>(); // 定义一个ArrayList对象，用于存储查询结果
        Statement statement = null;
        try {
            statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql); // 执行查询语句
            ResultSetMetaData metaData = rs.getMetaData(); // 获取结果集的元数据
            int count = metaData.getColumnCount(); // 获取结果集中列的数量
            int len = fields.length; // 数组长度
            System.out.println("---长度---"+len);
            while (rs.next()) { // 遍历结果集中的每一行数据
                Map<String, String> map = new HashMap<>(); // 定义一个Map对象，用于存储当前行的数据
                if (len == 0) {
                    System.out.println("---获取所有---"+len);
                    // 获取所有字段
                    for (int i = 1; i <= count; i++) { // 遍历当前行的所有列
                        String key = metaData.getColumnName(i); // 获取当前列的名称
                        String value = "\"" + rs.getString(key) + "\""; // 获取当前列的值
                        map.put(key, value); // 将当前列的名称和值添加到Map对象中
                    }
                } else {
                    // 获取指定字段
                    for (int i = 0; i < len; i++) {
                        System.out.println("---获取部分---"+len);
                        String key = metaData.getColumnName(fields[i]); // 获取当前列的名称
                        String value = "\"" + rs.getString(key) + "\""; // 获取当前列的值
                        map.put(key, value); // 将当前列的名称和值添加到Map对象中
                    }
                }
                list.add(map); // 将当前行的数据添加到ArrayList对象中
            }
            DamengConnUtil.closeAll(rs, statement, conn); // 关闭数据库连接
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

}




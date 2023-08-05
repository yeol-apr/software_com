package com.dameng.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 时间工具类
 */
public class DateUtil {

    /**
     * 获取当前时间
     * @return 当前时间的字符串表示，格式为yyyy-MM-dd HH:mm:ss
     */
    public static String getCurTime(){
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = sdf.format(date);
        return format;
    }
}


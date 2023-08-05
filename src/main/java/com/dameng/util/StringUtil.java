package com.dameng.util;

/**
 *字符串工具类
 */
public class StringUtil {

    /**
     * 判断字符串是否为空
     * 为空，返回true
     * 不为空，返回false
     * @param str
     * @return
     */
    public  static boolean isEmpty(String str){
        if(str == null || "".equals(str.trim())){
            return true;
        }
        return false;
    }
}

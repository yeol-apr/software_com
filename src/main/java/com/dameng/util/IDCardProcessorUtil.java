package com.dameng.util;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 处理身份证，检验
 * @return validData 有效数据
 * @return invalidData 无效数据
 */

public class IDCardProcessorUtil {

    /**
     * 验证身份证是否合法
     * @param idCard  输入是身份证号
     * @return true 合法身份证号，false 非法身份证号
     */
    public static boolean isValidIDCard(String IDNumber) {
        // 校验身份证号码长度
        String regularExpression = "(^[1-9]\\d{5}(18|19|20)\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|" +
                "(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}$)";
        boolean matches = IDNumber.matches(regularExpression);
        //判断第18位校验值
        if (matches) {
            if (IDNumber.length() == 18) {
                try {
                    char[] charArray = IDNumber.toCharArray();
                    //前十七位加权因子
                    int[] idCardWi = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
                    //这是除以11后，可能产生的11位余数对应的验证码
                    String[] idCardY = {"1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"};
                    int sum = 0;
                    for (int i = 0; i < idCardWi.length; i++) {
                        int current = Integer.parseInt(String.valueOf(charArray[i]));
                        int count = current * idCardWi[i];
                        sum += count;
                    }
                    char idCardLast = charArray[17];
                    int idCardMod = sum % 11;
                    if (idCardY[idCardMod].toUpperCase().equals(String.valueOf(idCardLast).toUpperCase())) {
                        return true; // 合法身份证号
                    } else {
                        return false; // 非法身份证号
                    }


                } catch (Exception e) {
                    e.printStackTrace();
                    return false; // 非法身份证号
                }
            }

        }
        return matches; // 非法身份证号
    }

}

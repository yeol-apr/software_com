package com.dameng.model;

import net.sf.json.JSONObject;

/**
 * 消息响应实体类
 *  code：状态码，1=成功，0=失败
 *  msg：响应消息 String
 *  data：响应数据 Object
 */
public class ResultModel {
    private Integer code;
    private String msg;
    private Object data;


    /**
     * 将json字符串转化成json对象
     * @param code
     * @param msg
     * @param data
     * @return
     */
    public JSONObject response(Integer code, String msg, Object data) {
        setCode(code);
        setData(data);
        String json = "{\"code\":" + code + ",";
        json += "\"msg\":" + "\"" + msg + "\",";
        json += "\"data\":" + data;
        json += "}";
        JSONObject result = JSONObject.fromObject(json);
        return result;
    }


    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}

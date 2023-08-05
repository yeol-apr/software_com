package com.dameng.model;

/**
 * 用户模型类
 */
public class UserModel {
    /**
     * 姓名
     */
    private String NAME;
    /**
     * 电话号码
     */
    private String number;
    /**
     * ID
     */
    private String id;
    /**
     * 密码
     */
    private String PASSWORD;
    /**
     * 权限/职位
     */
    private String GROUP;
    /**
     * 工号
     */
    private String USERNAME;

    /**
     * 构造函数
     */
    public UserModel() {
    }

    /**
     * 获取姓名
     * @return 姓名
     */
    public String getNAME() {
        return NAME;
    }

    /**
     * 设置姓名
     * @param NAME 姓名
     */
    public void setNAME(String NAME) {
        this.NAME = NAME;
    }

    /**
     * 获取电话号码
     * @return 电话号码
     */
    public String getNumber() {
        return number;
    }

    /**
     * 设置电话号码
     * @param number 电话号码
     */
    public void setNumber(String number) {
        this.number = number;
    }

    /**
     * 获取ID
     * @return ID
     */
    public String getId() {
        return id;
    }

    /**
     * 设置ID
     * @param id ID
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * 获取密码
     * @return 密码
     */
    public String getPASSWORD() {
        return PASSWORD;
    }

    /**
     * 设置密码
     * @param PASSWORD 密码
     */
    public void setPASSWORD(String PASSWORD) {
        this.PASSWORD = PASSWORD;
    }

    /**
     * 获取权限/职位
     * @return 权限/职位
     */
    public String getGROUP() {
        return GROUP;
    }

    /**
     * 设置权限/职位
     * @param GROUP 权限/职位
     */
    public void setGROUP(String GROUP) {
        this.GROUP = GROUP;
    }

    /**
     * 获取工号
     * @return 工号
     */
    public String getUSERNAME() {
        return USERNAME;
    }

    /**
     * 设置工号
     * @param USERNAME 工号
     */
    public void setUSERNAME(String USERNAME) {
        this.USERNAME = USERNAME;
    }
}







package com.jspxcms.common.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.validation.FieldError;

/**
 * 请求消息工具类
 * @author HuangCheng
 *
 */
public class MessageUtils {
    /**
     * 请求成功
     */
    private static final String MSG_SUCESS = "200";
    /**
     * 客户端错误
     */
    private static final String MSG_CLIENT_FAIL = "400";

    /**
     * 401 Unauthorized 
     * 需要通过HTTP认证，或认证失败
     */
    private static final String MSG_UNAUTHORIZED_FAIL = "401";
    /**
     * 403 Forbidden
     *  请求资源被拒绝
     */
    private static final String MSG_FORBIDDEN_FAIL = "403";
    /**
     * 服务器错误
     */
    private static final String MSG_SERVICE_FAIL = "500";
    
    /**
     * 消息构造方法
     * @param showMsg
     * @param msgCode
     * @return
     */
    public static Map<String, Object> buildMsg(String showMsg, String msgCode, Object object, Boolean status){
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", msgCode);
        map.put("msg", showMsg);
        map.put("result", object);
        map.put("status", status);
        map.put("msgType", status? "success" : "error");
        return map;
    }
    
    /**
     * 成功后返回的消息
     * @param showMsg
     * @return
     */
    public static Map<String, Object> sucessMsg(String showMsg){
        return buildMsg(showMsg, MSG_SUCESS, null, true);
    }
    public static Map<String, Object> sucessMsg(String showMsg, Object msgObject){
        return buildMsg(showMsg, MSG_SUCESS, msgObject, true);
    }
    
    public static Map<String, Object> failMsg(List<FieldError> errorList){
        StringBuffer sb = new StringBuffer();
        for(FieldError error : errorList) {
            sb.append(error.getDefaultMessage()).append("<br/>");
        }
        return failMsg(sb.toString());
    }
    /**
     * 客户端业务错误
     * @param showMsg
     * @return
     */
    public static Map<String, Object> failMsg(String showMsg){
        return buildMsg(showMsg, MSG_CLIENT_FAIL, null, false);
    }
    /**
     * 后台错误
     * @param showMsg
     * @return
     */
    public static Map<String, Object> serviceFailMsg(String showMsg){
        return buildMsg(showMsg, MSG_SERVICE_FAIL, null, false);
    }
    /**
     * 授权错误
     * @param showMsg
     * @return
     */
    public static Map<String, Object> unauthorizedFailMsg(String showMsg){
        return buildMsg(showMsg, MSG_UNAUTHORIZED_FAIL, null, false);
    }
}

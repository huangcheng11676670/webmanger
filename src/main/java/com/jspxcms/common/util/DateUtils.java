package com.jspxcms.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils extends org.apache.commons.lang3.time.DateUtils{
    
    public static String getWorkDay(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        // 获得当前日期是一个星期的第几天  
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        int day = cal.get(Calendar.DAY_OF_WEEK);
        cal.add(Calendar.DATE, cal.getFirstDayOfWeek()-day);
        String mondy = new SimpleDateFormat("MM月dd日").format(cal.getTime());
        cal.add(Calendar.DATE, 4);
        mondy += "--";
        mondy+= new SimpleDateFormat("MM月dd日").format(cal.getTime());
        return mondy;
    }
    /**
     * 自定义格式返回日期字符串
     * @param date
     * @param format
     * @return
     */
    public static String getDate(Date date, String format) {
        return new SimpleDateFormat(format).format(date);
    }
    
    /**
     * 获取日期的年份 格式为yyyy
     * @param date
     * @return
     */
    public static String getYearString(Date date) {
        return getDate(date, "yyyy");
    }

    /**
     * 获取日期的月份 格式为MMdd
     * @param date
     * @return
     */
    public static String getMonthString(Date date) {
        return getDate(date, "MMdd");
    }
    /**
     * 获取融云专用日期 格式为yyyyMMddHH
     * @param date
     * @return
     */
    public static String getRongDate(Date date) {
        return getDate(date, "yyyyMMddHH");
    }

    public static String getYearAndMonthString(Date date) {
        return getDate(date, "yyyy/MMdd/");
    }
    
    public static Date getDateString(String dateString) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
        Date date = new Date();
        try {
            date = sdf.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }
    
    public static String getChineseWeekName(Integer weekNum) {
        String[] weekNameList = {"星期一","星期二", "星期三", "星期四", "星期五", "星期六", "星期日"};
        return weekNameList[weekNum -1];
    }
    /**
     * 星期日开始为一周的起点，美国标准
     * @param date
     * @return
     */
    public static int getWeekOfYear(Date date) {
        Calendar calendar = Calendar.getInstance();  
        calendar.setFirstDayOfWeek(Calendar.SUNDAY);  
        calendar.setTime(date);
        return calendar.get(Calendar.WEEK_OF_YEAR); 
    }
    /**
     * 获取当前日期为那一天
     * @param date
     * @return
     */
    public static int getDayOfYear(Date date) {
        Calendar calendar = Calendar.getInstance();  
        calendar.setTime(date);
        return calendar.get(Calendar.DAY_OF_YEAR); 
    }
    public static void main(String[] args) throws ParseException {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        Date d2=sdf.parse("2017-02-02 00:00:00");  
        System.out.println(getDayOfYear(d2));  
    }
    /**
     * 结果>=0是没过期，<0过期了
     * @param smdate
     * @return
     * @throws ParseException
     */
    public static int expireDate(Date smdate) {
        try {
            return daysBetween(new Date(), smdate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**  
     * 计算两个日期之间相差的天数  
     * @param smdate 较小的时间 
     * @param bdate  较大的时间 
     * @return 相差天数 
     * @throws ParseException  
     */    
    public static int daysBetween(Date smdate, Date bdate) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        smdate = sdf.parse(sdf.format(smdate));
        bdate = sdf.parse(sdf.format(bdate));
        Calendar cal = Calendar.getInstance();
        cal.setTime(smdate);
        long time1 = cal.getTimeInMillis();
        cal.setTime(bdate);
        long time2 = cal.getTimeInMillis();
        long between_days = (time2 - time1) / (1000 * 3600 * 24);
        return Integer.parseInt(String.valueOf(between_days));
    }
}
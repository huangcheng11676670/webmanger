package com.jspxcms.common.util;

import java.net.URI;

import org.apache.commons.lang3.StringUtils;

import com.jspxcms.core.domain.Sentiment;
import com.jspxcms.core.domain.SysFavorite;
import com.jspxcms.ext.domain.Collect;

public class HtmlAnalysisUtils {
    private static String agentDefault="Mozilla/5.0";
    private static String charsetDefault="utf-8";

    /**
     * 具体页面分析
     * @param url
     * @param favorite
     * @return
     */
     public static Sentiment analysisDetailPage(String url, SysFavorite favorite) {
         if(StringUtils.isBlank(url)) {
             return null;
         }
         if(StringUtils.isNotBlank(favorite.getCharset())){
             charsetDefault = favorite.getCharset();
         }
         if(StringUtils.isNotBlank(favorite.getAgent())){
             agentDefault = favorite.getAgent();
         }
         Sentiment bean = new Sentiment();
         try {
            String webSiteHtml = Collect.fetchHtml(URI.create(url),  charsetDefault  , agentDefault);
            if(StringUtils.isBlank(webSiteHtml) || webSiteHtml.length() < 10) {
                return null;
            }
            if(StringUtils.isNotBlank(favorite.getTitlePattern())){
                bean.setSentimentTitle(Collect.findFirst(webSiteHtml, favorite.getTitlePattern(), true));
            }
            if(StringUtils.isNotBlank(favorite.getCommentNumPattern())){
                String num = Collect.findFirst(webSiteHtml, favorite.getCommentNumPattern(), true);
                if(StringUtils.isNotBlank(num)) {
                    bean.setCommentNum(Integer.valueOf(num));
                }
            }
            if(StringUtils.isNotBlank(favorite.getSummaryPattern())){
                bean.setSummary(Collect.findFirst(webSiteHtml, favorite.getSummaryPattern(), true));
            }
            if(StringUtils.isNotBlank(favorite.getContentCreateTimePattern())){
                bean.setContentCreateTime(Collect.findFirst(webSiteHtml, favorite.getContentCreateTimePattern(), true));
            }
            
        } catch (Exception e) {
          return null;
        }
         return bean;
     }
}

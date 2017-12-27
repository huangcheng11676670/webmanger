package com.jspxcms.core.service.impl;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.time.DateUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jspxcms.core.AbstractServiceTest;
import com.jspxcms.core.domain.Sentiment;
import com.jspxcms.core.dto.ReportSentimentNumDto;
import com.jspxcms.core.dto.ReportCountAndIdDto;
import com.jspxcms.core.service.SentimentService;

public class SentimentServiceTest extends AbstractServiceTest {

    @Autowired
    SentimentService sentimentService;
    
    //@Test
    public void testreportNumByDateAndUser() {
        Date starDate, endDate;
        try {
            starDate = DateUtils.parseDate("2017-12-21", "yyyy-MM-dd");
            endDate = DateUtils.parseDate("2017-12-21", "yyyy-MM-dd");
            //List<Sentiment> dbList = sentimentService.reportNumByDateAndUser(1, "2017-12-22", "2017-12-23");
            List<ReportSentimentNumDto> dbList = sentimentService.reportSentimentNumNativeQuery(3, "2017-12-22", "2017-12-29");
         //   dbList.forEach(item -> System.out.println(item.getDateString()));
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    @Test
    public void testreportSentimentPieNativeQuery() {
            List<ReportCountAndIdDto> dbList = sentimentService.reportSentimentPieNativeQuery(3, "2017-12-21", "2017-12-29");
    }
}

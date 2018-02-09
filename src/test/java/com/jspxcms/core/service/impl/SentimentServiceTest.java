package com.jspxcms.core.service.impl;

import java.math.BigInteger;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.time.DateUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.jspxcms.common.util.AliyunSMSUtils;
import com.jspxcms.core.AbstractServiceTest;
import com.jspxcms.core.dto.ReportCountAndIdDto;
import com.jspxcms.core.dto.ReportSentimentNumDto;
import com.jspxcms.core.service.ContractService;
import com.jspxcms.core.service.SentimentService;

public class SentimentServiceTest extends AbstractServiceTest {

    @Autowired
    SentimentService sentimentService;

    @Autowired
    ContractService contractService;
    
    @Resource(name="aliyunSMSUtils")
    AliyunSMSUtils aliyunSMSUtils;
    
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
    //@Test
    public void testreportSentimentPieNativeQuery() {
            List<ReportCountAndIdDto> dbList = sentimentService.reportSentimentPieNativeQuery(3, "2017-12-21", "2017-12-29");
    }

    //@Test
    public void reportContractAreaNativeQuery() {
        BigInteger dbList = contractService.reportContractNewNumNativeQuery(14, "2017-12");
        System.out.println(dbList);
    }
    @Test
    public void smsTest() {
        aliyunSMSUtils.sendSMS_125116385("13880554256", "姓名", "华阳中学吧", "请问一下华中的转学考试难不难？http://tieba.baidu.com/p/5541435045");
    }
}

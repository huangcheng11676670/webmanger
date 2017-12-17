package com.jspxcms.ext.collect;

import java.net.URI;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;

import com.jspxcms.common.util.Strings;
import com.jspxcms.core.AbstractServiceTest;
import com.jspxcms.ext.domain.Collect;
import com.jspxcms.ext.repository.CollectDao;

public class CollectorTest extends AbstractServiceTest {

    @Autowired
    Collector collector;

    @Autowired
    CollectDao collectDao;
    
    //@Test
    public void testStart() {
        collector.starttest(1);
    }
    /**
     * 手机端抓取，还是网页端抓取
     */
    public static final String agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1";
    //public static final String agent =  "Mozilla/5.0";
    
    //取外部文章列表的正则
    public static final String item_list_pattern = "<li class=\"tl_shadow\">(.*?)</li>";
    public static final String replay_num_pattern = "<span class=\"btn_icon\">(.*?)</span>";
    public static final String Content_CreateTime_pattern = "<ul class=\"p_tail\"><li><span>1楼</span></li><li><span>(.*?)</span></li></ul>";
    public static void main2(String[] args) throws Exception {
       // String webSiteHtml = Collect.fetchHtml(URI.create("https://tieba.baidu.com/f?kw=%E6%88%90%E9%83%BD%E4%B8%83%E4%B8%AD&ie=utf-8&pn=100&"), "utf-8", agent);
        String webSiteHtml = Collect.fetchHtml(URI.create("http://tieba.baidu.com/p/1100806756"), "utf-8", "Mozilla/5.0");
        System.out.println(Strings.replaceBlank(webSiteHtml));
        System.out.println("--------------------------html------------------------------------");
/*        List<String> itemsList = Collect.findByReg(webSiteHtml, item_list_pattern, 10);
        itemsList.forEach(item -> {
            System.out.println("-----------------------item-------------------");
            System.out.println(item);
            List<String> numList = Collect.findByReg(item,  replay_num_pattern ,1);
            System.out.println(numList.get(0)+"--------------num-----------------");
            });
        itemsList.forEach(System.out::print);*/
        List<String> numList = Collect.findByReg(Strings.replaceBlank(webSiteHtml),  Content_CreateTime_pattern ,1);
        System.out.println(numList.get(0)+"--------------ContentCreateTime-----------------");
    }
    
    public static void main1(String[] args) {
        // 按指定模式在字符串查找
        String line = "<a href=\"//wapp.baidu.com/p/5461739396?lp=5027&amp;mo_device=1&amp;is_jingpost=0&bdid=\"  class=\"j_common ti_item\" tid=\"5461739396\"><div class=\"ti_title\">        <span>高三今年期中考试的理综答案急需！求答案！谢谢！</span></div>        <p class=\"ti_abs\">高三今年期中考试的理综答案急需！求答案！谢谢！</p><div class=\"ti_infos clearfix\"><div class=\"ti_author_time\">                <span class=\"ti_author\">            糖狐鹭还是我</span><span class=\"ti_time\">12-2</span></div><div class=\"ti_zan_reply\">                <div class=\"ti_func_btn btn_reply\"><span class=\"btn_icon\">2</span></div>                </div></div>        </a>";
//        String pattern = "<span class=\"btn_icon\">(.*?)</span>";
        String pattern = "<a href=\"//wapp.baidu.com/p/54(.*?)\\?lp=502";
        // 创建 Pattern 对象
        Pattern r = Pattern.compile(pattern);
        // 现在创建 matcher 对象
        Matcher m = r.matcher(line);
        if (m.find( )) {
            for(int i=0; i<= m.groupCount(); i++) {
                System.out.println("Found value: " + m.group(i) );
            }
        } else {
           System.out.println("NO MATCH");
        }
    }
    
    public static void main(String[] args) {
        String content = "<div class=\"core_reply_tail \">"
                + "<ul class=\"p_reply\"><li>"
                + "<a href=\"#\" class=\"p_reply_first\">回复</a></li></ul><ul class=\"p_tail\">"
                + "<li><span>1楼</span></li><li><span>2011-06-06 12:52</span></li></ul><ul class=\"p_mtail\"><li class=\"j_jb_ele\"><a href=\"#\" onclick=\"window.open('http://tieba.baidu.com/complaint/info?type=0&amp;cid=0&amp;tid=1100806756&amp;pid=12594918704','newwindow', 'height=900, width=800, toolbar =no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');return false;\" class=\"complaint complaint-opened\" data-checkun=\"un\">举报</a>&nbsp;|<span class=\"super_jubao\"><a href=\"#\" onclick=\"window.open('http://tieba.baidu.com/complaint/info?type=1&amp;cid=0&amp;tid=1100806756&amp;pid=12594918704','newwindow', 'height=900, width=800, toolbar =no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');return false;\">个人企业举报</a><a href=\"#\" onclick=\"window.open('http://tieba.baidu.com/complaint/info?type=2&amp;cid=0&amp;tid=1100806756&amp;pid=12594918704','newwindow', 'height=900, width=800, toolbar =no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');return false;\">垃圾信息举报</a></span></li></ul><ul class=\"p_props_tail props_appraise_wrap\"></ul></div>";
        List<String> numList = Collect.findByReg(content,  Content_CreateTime_pattern ,1);
        System.out.println(numList.get(0)+"--------------ContentCreateTime-----------------");
    }

}

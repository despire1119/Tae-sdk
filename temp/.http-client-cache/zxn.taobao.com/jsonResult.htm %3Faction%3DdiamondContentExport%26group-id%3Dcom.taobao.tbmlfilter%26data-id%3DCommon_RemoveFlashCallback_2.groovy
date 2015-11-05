

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils

public class Common_RemoveFlashCallback_2 implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter tbmlFilter, String s, Map<String, String> stringStringMap) {
        if (s) {
            def back = s.toLowerCase()
            if (back.contains(".swf")) {
                return "#"
            }
            //这是一个纠错处理，当小写问题消除之后可以去掉aa
            if (s.contains("/shopbonus/buyer_apply.htm")) {
                return StringUtils.replace(StringUtils.replace(s, "activityid", "activityId"), "sellerid", "sellerId")
            }
            if (s.contains("meal.taobao.com/mealdetail.htm")) {
                return StringUtils.replace(s, "mealdetail.htm", "mealDetail.htm")
            }

            def host = getHostFormURL(s)
            if(host && ("www.taobao.com".equalsIgnoreCase(host)|| host.endsWith(".we.app.jae.m.taobao.com"))){
                return s;
            }
        }
        return removeURLSchema(s)
    }

    /**
     * 类似于new URL().getHost()
     * @param url
     * @return
     */
    public static String getHostFormURL(String url) {
        if(StringUtils.isBlank(url)){
            return "";
        }

        String hostAfter = null;

        if(url.trim().startsWith("//")){
            hostAfter = StringUtils.substringAfter(url,"//");
        }else{
            hostAfter = StringUtils.substringAfter(url,"://");
        }

        String urlHost = StringUtils.substringBefore(hostAfter,"/");
        return urlHost;
    }


    static def removeURLSchema(String url){
        if(StringUtils.isBlank(url)){
            return url;
        }
        url = url.trim();
        if(url.startsWith("//")){
            return url;
        }
        String urlLowerCase = url.toLowerCase();
        if(urlLowerCase.startsWith("http:")){
            return url.substring(5);
        }else if(urlLowerCase.startsWith("https")) {
            return url.substring(6);
        }else{
            return url;
        }
    }
}

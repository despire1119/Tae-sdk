

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory
import com.taobao.top.tbml.util.URLUtil

/**
 * 图片替换的回调类
 *
 * @author shantong
 */
public class sc_OldSdkLazyImageCallback implements AttributeCallback {
    private static final Log logger = LogFactory.getLog("TBMLFilter");


    /**
     * 将相对URL路径映射成为图片服务器地址
     */
    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            if(StringUtils.isBlank(value)){
                return ""
            }
            if (value.startsWith("http://") || value.startsWith("//") || value.startsWith("https://")) {
                if (value.startsWith("http://gdp.alicdn.com/") ||
                        value.startsWith("http://img.alicdn.com/") ||
                        value.startsWith("http://g.alicdn.com/") ||
                        value.startsWith("//gdp.alicdn.com/") ||
                        value.startsWith("//img.alicdn.com/")) {
                    return removeURLSchema(value)
                }else {
                    return Common_ImageLazyLoadUtil_21.filter(value);
                }
            }

        } catch (e) {
            logger.error(e)
        }
        String realPath = "#";
        Map<String, Object> context = filter.getContextMap();
        if (context == null) {
            return realPath;
        }
        StringBuilder sb = new StringBuilder();
        if (!value.startsWith("assets")) {
            int index = value.indexOf("assets");
            if (index > 0) {
                value = value.substring(index);
            }
        }
        sb.append("//gdp.alicdn.com").append("/L1/142/").append(context.get(Common_ImageLazyLoadUtil_21.TEMPLATE_VERSION_ID)).append("/").append(value);
        realPath = sb.toString();
        value = Common_ImageLazyLoadUtil_21.changeToLazyload(filter, realPath);
        return value
    }

    public static String removeURLSchema(String url){
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


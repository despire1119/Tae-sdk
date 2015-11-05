

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * 图片替换的回调类
 *
 * @author shantong
 */
public class ts_OldSdkLazyImageCallback implements AttributeCallback {
    private final static Log logger = LogFactory.getLog("TBMLFilter");

    /**
     * 将相对URL路径映射成为图片服务器地址
     */
    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            if(StringUtils.isBlank(value)){
                return ""
            }
            if (value && (value.startsWith("http://")||value.startsWith("https://")||value.startsWith("//"))) {
                return Common_ImageLazyLoadUtil_21.filter(value);
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
}


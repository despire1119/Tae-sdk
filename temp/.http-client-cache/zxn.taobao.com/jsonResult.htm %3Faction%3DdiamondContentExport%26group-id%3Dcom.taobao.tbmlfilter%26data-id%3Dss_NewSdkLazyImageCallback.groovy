

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
public class ss_NewSdkLazyImageCallback implements AttributeCallback {
    private static final Log logger = LogFactory.getLog("TBMLFilter");

    /**
     * 将相对URL路径映射成为图片服务器地址
     */
    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        def config = filter.getContextMap()
        if (config) {
            //装修市场校验，放行
            if (config.get("market")) {
                return value
            }
            //SDK
            AttributeCallback callback = (AttributeCallback) config.get("_sdk_image_path_callback_");
            if (callback != null) {
                return callback.filterValue(filter, value, attributes);
            }
        }
        try {
            if(StringUtils.isBlank(value)){
                return ""
            }
            if (value && (value.startsWith("http://")||value.startsWith("https://")||value.startsWith("//"))) {
                value = Common_ImageLazyLoadUtil_21.filter(value);
                return Common_ImageLazyLoadUtil_21.changeToLazyload(filter, value);
            }
        } catch (e) {
            logger.error("ss_NewSdkLazyImageCallback,TBMLFilterException,",e)
        }
        String realPath = "#";
        Map<String, Object> context = filter.getContextMap();
        if (context == null) {
            return realPath;
        }
        StringBuilder sb = new StringBuilder();
        sb.append("//gdp.alicdn.com").append("/L1/142/").append(context.get(Common_ImageLazyLoadUtil_21.TEMPLATE_VERSION_ID));
        if (value.startsWith("assets")) {
            sb.append("/modules/").append(context.get(Common_ImageLazyLoadUtil_21.TEMPLATE_MODULE_NAME)).append("/").append(value);
        } else if (value.startsWith("../")) {
            int index = value.indexOf("assets");
            if (index > 0) {
                value = value.substring(index);
            }
            sb.append("/").append(value);
        }
        value = sb.toString()
        return value
    }
}


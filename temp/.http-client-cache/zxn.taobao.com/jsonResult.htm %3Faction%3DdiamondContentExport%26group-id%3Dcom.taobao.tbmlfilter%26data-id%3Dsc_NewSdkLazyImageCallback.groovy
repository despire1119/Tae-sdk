

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * ͼƬ�滻�Ļص���
 *
 * @author shantong
 */
public class sc_NewSdkLazyImageCallback implements AttributeCallback {
    private static final Log logger = LogFactory.getLog("TBMLFilter");


    /**
     * �����URL·��ӳ���ΪͼƬ���������?
     */

    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            if(StringUtils.isBlank(value)){
                return ""
            }
            if (value.startsWith("http://") || value.startsWith("//") || value.startsWith("https://")) {
                value = Common_ImageLazyLoadUtil_21.filter(value);
                return Common_ImageLazyLoadUtil_21.changeToLazyload(filter, value);
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
        realPath = sb.toString();
        value = Common_ImageLazyLoadUtil_21.changeToLazyload(filter, realPath);
        return value
    }
}




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
public class ss_NewSdkImageCallback implements AttributeCallback {

    private static final Log logger = LogFactory.getLog("TBMLFilter");

    private static final String TB_BLACK_URL = "ss-tbml-filter-tbBlackUrl.txt"
    private static final DiamondFile TbUrl = new DiamondFile(TB_BLACK_URL)
    private static String cacheBlack
    private static Map blackMap

    /**
     * �����URL·��ӳ���ΪͼƬ��������ַ
     */
    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            def config = filter.getContextMap()
            //װ���г�У�飬����
            if (config && config.get("market")) {
                return value
            }
            //SDK
            if(null != config){
                AttributeCallback callback = (AttributeCallback) config.get("_sdk_image_path_callback_");
                if (callback != null) {
                    return callback.filterValue(filter, value, attributes);
                }
            }

            if (value.startsWith("http://") || value.startsWith("//") || value.startsWith("https://")) {
                if (value.startsWith("http://gdp.alicdn.com/") ||
                        value.startsWith("http://img.alicdn.com/") ||
                        value.startsWith("http://g.alicdn.com/") ||
                        value.startsWith("//gdp.alicdn.com/") ||
                        value.startsWith("//img.alicdn.com/")) {
                    value = filterBracket(value)
                    return removeURLSchema(value)
                }else {
                    value = filterBracket(value)
                    return Common_ImageLazyLoadUtil_21.filter(value);
                }
            }
        } catch (e) {
            logger.error("ss_NewSdkImageCallback,TBMLFilterException,",e)
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

    private static String filterBracket(String content){
        if(StringUtils.isBlank(content)){
            return content;
        }

        if(content.contains("(") || content.contains(")")){
            content = content.replace("(","");
            content = content.replace(")","");
        }

        return content;
    }

}

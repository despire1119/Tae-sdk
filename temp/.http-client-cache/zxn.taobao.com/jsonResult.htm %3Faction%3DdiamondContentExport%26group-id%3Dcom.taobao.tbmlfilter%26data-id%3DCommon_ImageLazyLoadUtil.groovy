

import com.taobao.top.tbml.filter.TBMLFilter

/**
 * 延迟加载迁移到新系统中来
 *
 * @author wanjian shantong
 */
public class Common_ImageLazyLoadUtil {

    /**
     * 图片懒加载
     * @param filter
     * @param value
     * @return
     */
    public static String filterValue(TBMLFilter filter, String value) {
        if (value.startsWith(HTTP) && !value.equals(KS_PIC)) {
            @SuppressWarnings("unchecked")
            Map<String, String> attributes = filter.getContextMap();
            if (attributes != null && "1".equals(attributes.get(LAZY_IMG))) {
                StringBuffer sb = new StringBuffer();
                sb.append(RICHTEXT_KEYCHAR).append(KS_PIC).append("\"").append(" ").append("data-ks-lazyload=\"").append(value);
                value = sb.toString();
            }
        }
        return value;
    }

    public static String filter(String forbiddenUrl, String value) {
        if (forbiddenUrl != null && value != null) {
            String[] urls = forbiddenUrl.split("\r*\n");
            if (urls != null && urls.length > 0) {
                for (String url : urls) {
                    if (url!=null && url.length()>0){
                        if (value.indexOf(url) > -1) {
                            return "";
                        }
                    }
                }
                // url decode
                String decoded = URLDecoder.decode(value)
                if (!value.equals(decoded)){
                    for (String url : urls) {
                        if (url!=null && url.length()>0){
                            if (decoded.indexOf(url) > -1) {
                                return "";
                            }
                        }
                    }
                }
            }
        }
        return value;
    }


    private static final char RICHTEXT_KEYCHAR = '¤';
    private final static String KS_PIC = "http://a.tbcdn.cn/s.gif";

    public final static String HTTP = "http://";

    public final static String LAZY_IMG = "lazyImg";

    public static final String IMAGE_SERVER = "_tbml_image_server";
    public static final String TEMPLATE_VERSION_ID = "_template_version_id";
    public static final String TEMPLATE_MODULE_NAME = "_template_module_name";
}


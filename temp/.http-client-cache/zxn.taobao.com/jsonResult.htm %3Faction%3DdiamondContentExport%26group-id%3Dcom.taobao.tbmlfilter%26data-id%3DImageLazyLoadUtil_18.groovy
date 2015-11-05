

import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * 延迟加载迁移到新系统中来
 *
 * @author wanjian shantong
 */

public class ImageLazyLoadUtil_18 {
    private final static Log logger = LogFactory.getLog(ImageLazyLoadUtil_18.class);

    static def specialDomain = ["haocai.com.cn"]

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

    public static String filter(Map blackMap, String value) {
        if (blackMap != null && value != null) {
            try {
                if (value.contains("taobaocdn.com") || value.contains("alicdn.com") || value.contains("tbcdn.cn")) {
                    return value
                }
                String host = new URL(value).getHost()
                def split = host.split("\\.")
                String target = host
                /**
                 * 不做截断处理的情况
                 * 1.   xxx.com             //split.length<=2
                 * 2.   special Domain   // 如 haocai.com.cn
                 */
                if (split.length > 2 && !specialDomain.contains(host)) {
                    target = host.replace(split[0] + ".", "")
                }
                if (blackMap.containsKey(target)) {
                    return ""
                }
                //对host做解码
                String decoded = URLDecoder.decode(host)
                if (!host.equals(decoded)) {
                    split = decoded.split("\\.")
                    if (split.length > 2 && !specialDomain.contains(host)) {
                        target = decoded.replace(split[0] + ".", "")
                    }
                    if (blackMap.containsKey(target)) {
                        return ""
                    }
                }
            } catch (e) {
                // 不是绝对路径的url,忽略掉
            }
        }
        return value;
    }

    public static Map getUrlMap(String tbClass) {
        def rs = new HashMap()
        if (tbClass) {
            def split = tbClass.split(",|\r*\n")
            split.each {
                rs.put(it.trim(), true)
            }
        }
        return rs
    }

    private static final char RICHTEXT_KEYCHAR = '¤';
    private final static String KS_PIC = "http://a.tbcdn.cn/kissy/1.0.0/build/imglazyload/spaceball.gif";

    public final static String HTTP = "http://";

    public final static String LAZY_IMG = "lazyImg";

    public static final String IMAGE_SERVER = "_tbml_image_server";
    public static final String TEMPLATE_VERSION_ID = "_template_version_id";
    public static final String TEMPLATE_MODULE_NAME = "_template_module_name";
}


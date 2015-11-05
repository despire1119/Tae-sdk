


import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory
import org.apache.commons.lang.StringUtils

import java.util.regex.Pattern

/**
 * HTML class名称回调接口，主要过滤自定义内容去class 名称中包含.J_TBox,.J_TRegion
 *
 * @author peijian
 * @version 1.0.0
 * @since 11-8-10 下午4:16
 */
public class sc_TaeHtmlClassNameAttributeCallback implements AttributeCallback {
    private static final Log logger = LogFactory.getLog(sc_TaeHtmlClassNameAttributeCallback.class);

    private static final Pattern J_TBOX_PATTERN = Pattern.compile("[\\s]+J_TBox[\\s]+");
    // private static final Pattern J_T= Pattern.compile("\\bJ_T\\w*\\b");
    private static List<String> whiteList = Arrays.asList("J_TWidget", "J_TokenSign", "J_CartPluginTrigger", "tb-module");

    private final String TAOBAO_STYLE = "tshop-";

    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            String[] values = value.split("\\s");
            StringBuffer sb = new StringBuffer();
            for (String v : values) {
                String className = v.trim();
                if ((className.startsWith("J_") || className.startsWith("tb-")) && !whiteList.contains(className)) {
                    v = "";
                }
                if (StringUtils.isNotBlank(v))
                    sb.append(className).append(" ");
            }
            String classNames = sb.toString().trim();
            // 过滤淘宝官方样式
            if (classNames.contains(TAOBAO_STYLE)) {
                classNames = filterTaobaoStyle(classNames);
            }
            return classNames;
        } catch (e) {
            logger.error("sc_TaeHtmlClassNameAttributeCallback,TBMLFilterException,",e)
        }
        return value
    }

    private String filterTaobaoStyle(String value) {
        String[] strs = value.split(" ");
        if (strs != null && strs.length > 0) {
            StringBuilder sb = new StringBuilder();
            for (String item : strs) {
                String temp = item.trim();
                if (StringUtils.isNotBlank(temp) && !temp.startsWith(TAOBAO_STYLE)) {
                    sb.append(temp);
                    sb.append(" ");
                }
            }
            logger.warn("classAttributeFilter: old=" + value + " new=" + sb.toString());
            return sb.toString();
        }
        return value;
    }

    public static void main(String[] args) {
        System.out.println(J_TBOX_PATTERN.matcher(" J_TBox ").replaceAll("haha"));
        System.out.println("A J_TBox ".replaceAll("[\\s]+J_TBox[\\s]+", ""));
        System.out.println(J_TBOX_PATTERN.matcher("A J_TBox ").replaceAll(""));
        System.out.println("A J_TBox".matches("[\\s]+J_TBox[\\s]+"));
    }
}




import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Matcher
import java.util.regex.Pattern

public class ClassUtil_20 {
    private final static Log logger = LogFactory.getLog(ClassUtil_20.class);

    static def defaultWhiteArr = ["tb-module",
            "J_TWidget",
            "J_TokenSign",
            "sns-widget",
            "ks-switchable-content",
            "ks-switchable-nav",
            "ks-active",
            "ks-switchable-trigger",
            "ks-switchable-panel",
            "ks-datalazyload-custom",
            "J_CartPluginTrigger",
            "J_WangWang"]
    static String target = "wj10000"

    public static String filter(Pattern blackPattern, String value, Map<String, String> attributes) {
        return filter(blackPattern, defaultWhiteArr, value, attributes)
    }

    public static String filter(Pattern blackPattern, List<String> whiteList, String value, Map<String, String> attributes) {
        if (!StringUtils.isBlank(value) && blackPattern != null && attributes != null) {
            def  replaceArr = [] as ArrayList
            for (int index = 0; index < whiteList.size(); index++) {
                replaceArr.add(index, target + index)
                value = value.replaceAll(whiteList.get(index), replaceArr.get(index))
            }
            value = filterClass(blackPattern, value);
            //注意，一定要倒过来，最长匹配
            for (int i = whiteList.size() - 1; i >= 0; i--) {
                value = value.replaceAll(replaceArr.get(i), whiteList.get(i))
            }
        }
        return value
    }

    private static String filterClass(Pattern blackPattern, String value) {
        if (!blackPattern) return value
        value = replaceAllIgnoreCase(value, blackPattern, "-_-");
        return value.trim();
    }

    /**
     * 不区分大小写，全部替换
     */
    private static String replaceAllIgnoreCase(String source, Pattern pattern, String newString) {
        Matcher m = pattern.matcher(source)
        while (m.find()) {
            def str = m.group(1)
            source = source.replace(str, newString)
        }
        return source
    }

    public static Pattern getClassPattern(String tbClass) {
        if (tbClass) {
            def reg = "(?:\\s+|^)((?:"
            def parts = tbClass.split(",|\r*\n")
            parts.each {
                it = it.trim()
                if (it) {
                    reg = reg + it + ")|(?:"
                }
            }
            if (reg.endsWith("|(?:")) {
                reg = reg.substring(0, reg.length() - 4)
            }
            reg = reg + ")"
            logger.error("class reg:" + reg)
            return Pattern.compile(reg)
        }
        return null
    }

    public static List<String> getWhite(String whiteClass) {
        def white = []
        def split = whiteClass.split("\r*\n")
        for (String it : split) {
            it = it.trim()
            if (it) {
                white.add(it)
            }
        }
        return white
    }
}


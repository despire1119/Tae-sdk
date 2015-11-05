

import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Matcher
import java.util.regex.Pattern


public class StyleUtil_13 {
    private final static Log logger = LogFactory.getLog(StyleUtil_13.class);

    public static final String TB_SHOP = "\\.tb-shop\\{background";
    public static final String TB_CONTENT = "\\.tb-content\\{background";

    private static final String REG_REPLACE_2 = "position:[\\s]*fixed[\\s]*![\\s]*important";
    private static final String REPLACE_VALUE_2 = "position:fixed";

    public static final String REG_REPLACE = "position:[\\s]*fixed";
    private static final String REPLACE_VALUE = "position:fixed;display:none!important";

    private static final String REG_REPLACE_IMPORTANT = "display[\\s]*:[\\s]*[a-z-]*[\\s]*![\\s]*important";
    private static final String REG_JUST_IMPORTANT = "![\\s]*important";

    private static final String PAGE_CONTENT = "#page #content "
    private static final String PAGE_CONTENT_REPLACEMENT = "@_@ "

    private static final Pattern replace_important_pattern = Pattern.compile(REG_REPLACE_IMPORTANT, Pattern.CASE_INSENSITIVE)

    private static Pattern cachedBlackCssClassPattern = null

    private static String cachedBlackCssClass = ""

    public static String filter(String forbiddenStyle, String value, Map<String, String> attributes) {
        return filter(false, forbiddenStyle, value, attributes);
    }

    public static String filter(boolean checkTag, String forbiddenStyle, String value, Map<String, String> attributes) {
        return filter(checkTag, false, forbiddenStyle, value, attributes);
    }

    public static String filterCssContent(boolean checkTag, String forbiddenStyle, String value) {
        return filterCssContent(checkTag, false, forbiddenStyle, value)
    }


    public static String filter(boolean checkTag, boolean checkTbShop, String forbiddenStyle, String value, Map<String, String> attributes) {
        if (!StringUtils.isBlank(value) && attributes != null) {
            //去悬浮 移除  display中的 !important
            value = filterDisplayImportant(value);
            value = replaceAllIgnoreCase(value, REG_REPLACE_2, REPLACE_VALUE_2);
            value = replaceAllIgnoreCase(value, REG_REPLACE, REPLACE_VALUE);
            if (checkTag) {
                //对于 <style>....</style>特别处理
                if (checkTbShop) {
                    value = value.replaceAll(TB_SHOP, TB_CONTENT);
                }
                value = clearOverideCssII(forbiddenStyle, value);
            }
        }
        return value;
    }

    public static String filterCssContent(boolean checkTag, boolean checkTbShop, String forbiddenStyle, String value) {
        if (!StringUtils.isBlank(value)) {
            value = filterDisplayImportant(value);
            value = replaceAllIgnoreCase(value, REG_REPLACE_2, REPLACE_VALUE_2);
            value = replaceAllIgnoreCase(value, REG_REPLACE, REPLACE_VALUE);
            if (checkTag) {
                //对于 <style>....</style>特别处理
                if (checkTbShop)
                    value = value.replaceAll(TB_SHOP, TB_CONTENT);
                value = clearOverideCssII(forbiddenStyle, value);
            }
        }
        return value
    }

    /**
     * 不区分大小写，全部替换
     * @param source
     * @param oldString
     * @param newString
     * @return
     */
    private static String replaceAllIgnoreCase(String source, String oldString, String newString) {
        Matcher m = Pattern.compile(oldString, Pattern.CASE_INSENSITIVE).matcher(source);
        return m.replaceAll(newString);
    }

    private static String filterDisplayImportant(String toBeDealtString) {
        if (StringUtils.isBlank(toBeDealtString)) return "";

        StringBuffer sb = new StringBuffer();
        int fromIndex = 0;
        Matcher m = replace_important_pattern.matcher(toBeDealtString);
        while (m.find()) {
            int start = m.start();
            int end = m.end();
            sb.append(toBeDealtString.substring(fromIndex, start));
            sb.append(toBeDealtString.substring(start, end).replaceFirst(REG_JUST_IMPORTANT, ""));
            fromIndex = end;
        }
        sb.append(toBeDealtString.substring(fromIndex));
        return sb.toString();
    }


    private static String clearOverideCssII(String tbCss, String toBeDealtString) {
        if (StringUtils.isBlank(toBeDealtString)) return "";
        if (StringUtils.isBlank(tbCss)) return toBeDealtString;

        if (cachedBlackCssClassPattern == null || !cachedBlackCssClass.equals(tbCss)) {
            cachedBlackCssClass = tbCss
            String regex = getRegx(cachedBlackCssClass);
            cachedBlackCssClassPattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        }
        return clearOverideCssRecursive(toBeDealtString, cachedBlackCssClassPattern);
    }

    /**
     * 此方法含有保留 #page #content 的逻辑
     */
    private static String clearOverideCssRecursive(String toBeDealtString, Pattern pattern) {
        toBeDealtString = toBeDealtString.replace(PAGE_CONTENT, PAGE_CONTENT_REPLACEMENT)
        try {
            if (StringUtils.isBlank(toBeDealtString)) return "";

            StringBuffer sb = new StringBuffer();
            int fromIndex = 0;
            int length = toBeDealtString.length();

            Matcher m = pattern.matcher(toBeDealtString);
            while (m.find()) {
                //[start,end)
                int start = m.start();
                int end = m.end();
                if (fromIndex > start) {
                    fromIndex = end;
                    continue;
                }
                //先判断先后字符，前只能是},空格，后面只能是{,空格，是否为全匹配
                //以前面最近的一个}来判断
                //若前面有","后面到","或到"{"（最近优先）直接删除
                //若前面空，后面到","即只部分，到"{"就全部删除
                if (checkFront(toBeDealtString, start, m.group()) && checkBack(toBeDealtString, end, length)) {
                    int latestFrontBraceIdx = toBeDealtString.lastIndexOf('}', start);
                    if (latestFrontBraceIdx == -1) latestFrontBraceIdx = fromIndex - 1;

                    int backCommaIdx = toBeDealtString.indexOf(',', end);
                    int backBraceIdx = toBeDealtString.indexOf('{', end);
                    if (backBraceIdx == -1) {
                       // logger.error("出错了111....");
                        continue;
                    }

                    int frontCommaIdx = toBeDealtString.lastIndexOf(',', start);
                    if (frontCommaIdx > latestFrontBraceIdx) {
                        int backIdx = backCommaIdx > -1 && backCommaIdx < backBraceIdx ? backCommaIdx : backBraceIdx;
                        if (fromIndex < frontCommaIdx) {
                            sb.append(toBeDealtString.substring(fromIndex, frontCommaIdx));
                        }
                        fromIndex = backIdx;
                    } else {
                        if (backCommaIdx > -1 && backCommaIdx < backBraceIdx) {
                            if (fromIndex < latestFrontBraceIdx + 1) {
                                sb.append(toBeDealtString.substring(fromIndex, latestFrontBraceIdx + 1));
                            }
                            fromIndex = backCommaIdx + 1;
                        } else {
                            int backRightBraceIdx = toBeDealtString.indexOf('}', backBraceIdx);
                            if (fromIndex < latestFrontBraceIdx + 1) {
                                sb.append(toBeDealtString.substring(fromIndex, latestFrontBraceIdx + 1));
                            }
                            fromIndex = backRightBraceIdx + 1;
                        }
                    }
                    sb.append(toBeDealtString.substring(fromIndex));
                    return clearOverideCssRecursive(sb.toString(), pattern);
                }
            }
        } catch (Exception e) {
            logger.error("clearOverideCssRecursive", e);
        }
        toBeDealtString = toBeDealtString.replace(PAGE_CONTENT_REPLACEMENT, PAGE_CONTENT)
        return toBeDealtString;
    }

    private static boolean checkFront(String toBeDealtString, int start, String group) {
        if (start > 0) {
            if (group != null && group.charAt(0) == '.') {
                return true;
            }
            char frontChar = toBeDealtString.charAt(start - 1);
            return frontChar == '}' || frontChar == ',' || frontChar == ' ';
        }
        return true;
    }

    private static boolean checkBack(String toBeDealtString, int end, int length) {
        if (end < length) {
            char backChar = toBeDealtString.charAt(end);
            return backChar == '{' || backChar == ',' || backChar == ' ' || backChar == '[' || backChar == '.' || backChar == ':';
        }
        return true;
    }

    private static String getRegx(String tbCss) {
        tbCss = tbCss.replace("\\.", "\\\\.")
        def reg = "("
        if (tbCss) {
            def parts = tbCss.split(",|\r*\n")
            parts.each {
                it = it.trim()
                if (it) {
                    reg = reg + it + ")|("
                }
            }
        }
        if (reg.endsWith("|(")) {
            reg = reg.substring(0, reg.length() - 2)
        }
        return reg
    }




    public static void main(String[] args) {

        println filterCssContent(true, getBlackCss(), "#xxx")

    }

}


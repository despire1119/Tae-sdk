

import com.taobao.top.tbml.config.DiamondFile
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Matcher
import java.util.regex.Pattern


public class Common_StyleUtil {

    private static final String TB_BLACK_CSS = "tbml-filter-tbBlackCss";
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS);

    public static String filter(String value, Map<String, String> attributes) {
        return filter(false, value, attributes);
    }

    public static String filter(boolean checkTag, String value, Map<String, String> attributes) {
        if (!StringUtils.isBlank(value) && attributes != null && "1".equals(attributes.get("b2c"))) {
            //去悬浮
            value = filterDisplayImportant(value);
            value = replaceAllIgnoreCase(value, REG_REPLACE, REPLACE_VALUE);
            if (checkTag) {
                //对于 <style>....</style>特别处理
                value = clearOverideCssII(TbCss.getConfigContent(), value);
            }
        }
        return value;
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
        Matcher m = Pattern.compile(REG_REPLACE_IMPORTANT, Pattern.CASE_INSENSITIVE).matcher(toBeDealtString);
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

    private static Log log = LogFactory.getLog("TBMLFilter");;

    private static String clearOverideCssII(String tbCss, String toBeDealtString) {
        if (StringUtils.isBlank(toBeDealtString)) return "";

        if (StringUtils.isBlank(tbCss)) return toBeDealtString;

        String regx = getRegx(tbCss);
        Pattern pattern = Pattern.compile(regx, Pattern.CASE_INSENSITIVE);
        return clearOverideCssRecursive(toBeDealtString, pattern);
    }

    private static String clearOverideCssRecursive(String toBeDealtString, Pattern pattern) {
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
                        log.error("出错了111....");
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
            log.error("clearOverideCssRecursive", e);
        }
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

    public static final String REG_REPLACE = "position:[\\s]*fixed";

    private static final String REPLACE_VALUE = "position:fixed;display:none!important";

    private static final String REG_REPLACE_IMPORTANT = "display[\\s]*:[\\s]*[a-z-]*[\\s]*![\\s]*important";
    private static final String REG_JUST_IMPORTANT = "![\\s]*important";


    public static void main(String[] args) {

        testClearII();

//		String source2 = "ssssssssdisplay  :   inline--block    !    important;1234";
//		String value2 = filterDisplayImportant(source2);
//		System.out.println(source2+":\r\n"+value2);
//		
//		String source3 = "ssssssssdisplay  :   inline--block    !    important;123456789 display:table-inline!important; eeeee";
//		String value3 = filterDisplayImportant(source3);
//		System.out.println(source3+":\r\n"+value3);
//		
//		String source4 = "1sssssssdisplay  :   inline-block    !    important;123456789 display:table-inline!important; eeeee3";
//		String value4 = filterDisplayImportant(source4);
//		System.out.println(source4+":\r\n"+value4);

    }

    private static void testClearII() {
        String source = ".count{height:143px;position:relative;width:750px;} aaaa{height:200px}";
        String regx = ".count,aaaa";
        String result = "";
        testII(source, regx, result);

        source = ".count 1111,.count 222,.countt,.count 333{height:143px;position:relative;width:750px;}";
        regx = ".count 222,aaaa";
        result = ".count 1111,.countt,.count 333{height:143px;position:relative;width:750px;}";
        testII(source, regx, result);

        source = ".count 222 3,.count 222,.countt,.count 333{height:143px;position:relative;width:750px;}";
        regx = ".count 222 3,aaaa";
        result = ".count 222,.countt,.count 333{height:143px;position:relative;width:750px;}";
        testII(source, regx, result);

        source = ".count 1111,.count 222,.countt,.count 333{height:143px;position:relative;width:750px;} aaa no,aaa,aaaa bb,aaa cc,aaa yes{height:200px}";
        regx = ".count,aaaa";
        result = ".countt{height:143px;position:relative;width:750px;} aaa no,aaa,aaa cc,aaa yes{height:200px}";
        testII(source, regx, result);

        source = ".count 1111,.count aaa,.count 222,.count,.count 333{height:143px;position:relative;width:750px;} aaa no,aaaa bb,aaa cc,aaa yes{height:200px}";
        regx = ".count,aaa";
        result = "aaaa bb{height:200px}";
        testII(source, regx, result);

        source = ".count 1111,.count 222,.count,.count 333{height:143px;position:relative;width:750px;} aaa no,aaa,aaa bb,aaa cc,aaa yes{height:200px}";
        regx = ".count,aaa";
        result = "";
        testII(source, regx, result);

        source = ".tb-shop .tb-tab-anchor em.J_ReviewsCount,aaa{height:143px;position:relative;width:750px;}";
        regx = ".J_ReviewsCount";
        result = "aaa{height:143px;position:relative;width:750px;}";
        testII(source, regx, result);

        source = ".tb-shop .j-nav ul li.nav-font a:hover{border:0;}.tb-shop #hd{width:100%;}.tb-shop .box .item-recommend .hd h3{background:none!important;}.tb-shop .j-nav ul li.nav-font a:hover{border:0;}.tb-shop #hd{width:100%;}.tb-shop .box .item-recommend .hd h3{background:none!important;}.tb-shop .diy{display:none;}.tb-shop .caonidaye3{z-index:99999;position:absolute;_position:absolute;}.tb-shop #bd .tb-tabbar em{color:#FF6600;}.tb-shop .tb-tabbar em.J_TDealCount{background:url(http://img01.taobaocdn.com/imgextra/i1/1013242952/T2TGe_XitXXXXXXXXX_!!1013242952.gif) no-repeat;padding-left:18px;}.tb-shop .tb-tab-anchor em.J_ReviewsCount{background:url(http://img04.taobaocdn.com/imgextra/i4/735663374/T2ih4YXnddXXXXXXXX_!!735663374.gif) no-repeat;padding-left:19px;}.tb-shop .caonidaye1{z-index:99999;position:absolute;_position:absolute;}.tb-shop .caonidaye2{z-index:99999;position:absolute;_position:absolute;}.tb-shop .caonidaye{z-index:99999;position:absolute;width:90px;height:auto;font-size:12px;_position:absolute;}.tb-shop .myb_cart a{text-indent:-999em;height:25px;overflow:hidden;width:90px;background:url(http://img02.taobaocdn.com/imgextra/i2/T2RApOXolXXXXXXXXX-31125926.gif) no-repeat;display:block;}.tb-shop .myb_cart a:hover{background:url(http://img01.taobaocdn.com/imgextra/i1/T2sAlOXoNXXXXXXXXX-31125926.gif) no-repeat;}.tb-shop .myb_buy a{text-indent:-999em;height:25px;overflow:hidden;width:90px;background:url(http://img04.taobaocdn.com/imgextra/i4/T2Y7pOXn8XXXXXXXXX-31125926.gif) no-repeat;display:block;}.tb-shop .myb_buy a:hover{background:url(http://img02.taobaocdn.com/imgextra/i2/T2TQpOXodXXXXXXXXX-31125926.gif) no-repeat;}.tb-shop{background:url(http://img05.taobaocdn.com/bao/uploaded/i5/T1GGLGXmhkXXb1upjX) repeat center!important;background-attachment:fixed!important;}";
        regx = TbCss.getConfigContent();
        result = "aa";
        testII(source, regx, result);
    }

    private static boolean testII(String source, String regx, String result) {
        String value = clearOverideCssII(regx, source);
        boolean ok = value.equals(result);
        if (ok)
            System.out.println("result is ok!");
        else {
            System.out.println(source + "\r\n" + regx + "\r\nvalue:" + value + "\r\n" + "right is:" + result + "\r\n");
        }
        return ok;
    }

}


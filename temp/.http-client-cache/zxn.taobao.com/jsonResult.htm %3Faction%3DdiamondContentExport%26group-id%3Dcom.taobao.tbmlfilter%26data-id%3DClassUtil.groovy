

import com.taobao.top.tbml.config.DiamondFile
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Matcher
import java.util.regex.Pattern

public class ClassUtil {

    private static final String TB_BLACK_CLASS = "tbml-filter-tbBlackClass";
    private static final DiamondFile TbClass = new DiamondFile(TB_BLACK_CLASS);

    private static Log log = LogFactory.getLog(ClassUtil.class);

    public static String filter(String value, Map<String, String> attributes) {
        if (!StringUtils.isBlank(value) && attributes != null && "1".equals(attributes.get("b2c"))) {
            value = filterClass(TbClass.getConfigContent(), value);
        }
        return value;
    }

    private static String filterClass(String tbClass, String value) {
        if (StringUtils.isBlank(tbClass)) return value;
        String regx = getRegx(tbClass);
        value = replaceAllIgnoreCase(value, regx, "");
        return value.trim();
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

    private static String getRegx(String tbClass) {
        def reg = "("
        if (tbClass) {
            def parts = tbClass.split(",|\r*\n")
            parts.each {
                it = it.trim()
                if (it) {
                    reg =  reg + it + ")|("
                }
            }
        }
        if (reg.endsWith("|(")){
            reg = reg.substring(0,reg.length()-2)
        }
        return reg
    }

    public static void main(String[] args) {
        testClearII();
    }

    private static void testClearII() {
        testII("cbu-iframe", "cbu-iframe,tb-shop", "");
        testII("cbu-iframe aaa", "cbu-iframe,tb-shop", "aaa");
        testII("aaa cbu-iframe", "cbu-iframe,tb-shop", "aaa");
        testII("cbu-iframe tb-shop", "cbu-iframe,tb-shop", "");
        testII("a cbu-iframe tb-shop b", "cbu-iframe,tb-shop", "a   b");
        testII("c cbu-iframe tb-shop b", TbClass.getConfigContent(), "c  tb-shop b");
        testII(TbClass.getConfigContent().replaceAll(",", " "), TbClass.getConfigContent(), "");
    }

    private static boolean testII(String source, String regx, String result) {
        String value = filterClass(regx, source);
        boolean ok = value.equals(result);
        if (ok)
            System.out.println("result is ok!");
        else {
            System.out.println(source + "\r\n" + regx + "\r\n" + value + "\r\n" + "right is:" + result + "\r\n");
        }
        return ok;
    }

}


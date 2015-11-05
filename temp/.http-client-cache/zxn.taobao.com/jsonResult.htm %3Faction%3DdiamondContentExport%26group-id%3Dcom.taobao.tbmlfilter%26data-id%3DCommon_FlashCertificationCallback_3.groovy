

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils


public class Common_FlashCertificationCallback_3 implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter tbmlFilter, String s, Map<String, String> stringStringMap) {
        def certification = "scene=taobao_shop"
        if (s) {
            if (isBMFlash(s)) {
                if (!s.contains(certification)) {
                    if (s.contains("?")) {
                        if (s.endsWith("?")) {
                            return s + certification
                        } else {
                            return s + "&" + certification
                        }
                    } else {
                        return s + "?" + certification
                    }
                }
            } else {
                s = StringUtils.replace(s, "?" + certification, "")
                s = StringUtils.replace(s, "&" + certification, "")
            }
        }
        return s
    }

    static boolean isBMFlash(String url) {
        if (url.contains(".uu1001.cn")) {
            return true
        }
        if (url.contains(".tbcdn.cn")) {
            return true
        }
        return false
    }
}

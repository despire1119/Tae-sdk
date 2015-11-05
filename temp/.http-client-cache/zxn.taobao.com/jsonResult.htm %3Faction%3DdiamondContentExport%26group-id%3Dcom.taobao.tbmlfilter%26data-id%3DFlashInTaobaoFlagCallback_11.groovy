

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils

public class FlashInTaobaoFlagCallback_11 implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter tbmlFilter, String s, Map<String, String> stringStringMap) {
        def certification = "scene=taobao_shop"
        if (s) {
            if(s.contains("imglogo") || s.contains("loadinglogo") || s.contains("http")
            || s.contains("//") || StringUtils.containsIgnoreCase(s,"%2f%2f")
            || StringUtils.containsIgnoreCase(s,"&#x2f;&#x2f;")
                    || s.contains("&#47;&#47;")){
                return ""
            }
            def split = s.split("&")
            def combo = []
            for (int i = 0; i < split.length; i++) {
                if(StringUtils.isNotBlank(split[i])){
                    if (split[i].contains("=")) {
                        combo.add(split[i])
                    } else {
                        if (combo.size() > 0) {
                            def str = combo.remove(combo.size() - 1)
                            combo.add(str + "&" + split[i])
                        } else {
                            combo.add("&" + split[i])
                        }
                    }
                }
            }
            for (int i = 0; i < combo.size(); i++) {
                if (combo[i].contains("scene=taobao_shop")) {
                    combo[i] = certification
                }
            }
            s = StringUtils.join(combo, "&")
            def matcher = (s =~ /([^&]*&(amp;)?)*(scene=[^&]*)(&[^&]*)*/)
            if (matcher.matches()) {
                def str = matcher.group(3)
                return s.replace(str, certification)
            }
            if (!s.endsWith("&") && !s.endsWith("&amp;")) {
                s = s + "&"
            }
            s = s + certification
        } else {
            s = certification
        }
        return s
    }
}

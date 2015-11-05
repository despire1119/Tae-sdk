

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter

public class FlashInTaobaoFlagCallback_5 implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter tbmlFilter, String s, Map<String, String> stringStringMap) {
        def certification = "scene=taobao_shop"
        if (s) {
            //防止用户使用此转义符提前终止掉引号
            s = s.replace("&quot;", "")
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

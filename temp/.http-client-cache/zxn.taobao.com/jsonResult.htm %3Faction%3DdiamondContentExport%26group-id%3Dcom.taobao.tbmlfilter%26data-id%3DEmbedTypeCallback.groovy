

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter

public class EmbedTypeCallback implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter tbmlFilter, String s, Map<String, String> stringStringMap) {
        return "application/x-shockwave-flash"
    }
}



import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter

public class FlashPathCallback implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        // 123show preview
        if (value.contains(".123show.com/preview") || value.contains(".show-wise.com/preview")) {
            return ""
        }
        return value
    }
}

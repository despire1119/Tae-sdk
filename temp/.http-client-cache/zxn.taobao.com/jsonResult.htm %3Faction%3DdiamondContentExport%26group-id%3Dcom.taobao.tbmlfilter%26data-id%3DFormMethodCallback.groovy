

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter

/**
 * 所有form表单的提交方式限定为post
 * test1
 */
public class FormMethodCallback implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter tbmlFilter, String s, Map<String, String> stringStringMap) {
        return "post"
    }
}

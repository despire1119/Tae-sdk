

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter

/**
 * ����form�����ύ��ʽ�޶�Ϊpost
 * test1
 */
public class FormMethodCallback implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter tbmlFilter, String s, Map<String, String> stringStringMap) {
        return "post"
    }
}



import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils

public class RemoveFlashCallback_2 implements AttributeCallback {

    @Override
    String filterValue(TBMLFilter tbmlFilter, String s, Map<String, String> stringStringMap) {
        if (s) {
            def back = s.toLowerCase()
            if (back.contains(".swf")) {
                return "#"
            }
            //����һ����������Сд��������֮�����ȥ��
            if (s.contains("/shopbonus/buyer_apply.htm")) {
                return StringUtils.replace(StringUtils.replace(s, "activityid", "activityId"), "sellerid", "sellerId")
            }
            if (s.contains("meal.taobao.com/mealdetail.htm")) {
                return StringUtils.replace(s, "mealdetail.htm", "mealDetail.htm")
            }
        }
        return s
    }
}

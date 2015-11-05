

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
            //这是一个纠错处理，当小写问题消除之后可以去掉
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

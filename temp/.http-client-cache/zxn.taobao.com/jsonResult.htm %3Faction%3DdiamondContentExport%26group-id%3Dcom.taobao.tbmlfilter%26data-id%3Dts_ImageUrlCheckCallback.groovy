

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class ts_ImageUrlCheckCallback implements AttributeCallback {
    private static final Log logger = LogFactory.getLog("TBMLFilter");

    @Override
    String filterValue(TBMLFilter tbmlFilter, String value, Map<String, String> stringStringMap) {
        try {
            if(!value.startsWith("http://") && !value.startsWith("//") && !value.startsWith("https://")) {
                logger.error("ts_ImageUrlCheckCallback.groovy,value=" + value);
            }
            value = Common_ImageLazyLoadUtil_21.filter(value)
        } catch (e) {
            logger.error("ts_ImageUrlCheckCallback,TBMLFilterException,",e)
        }
        return value
    }

}

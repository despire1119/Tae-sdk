

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * 延迟加载迁移到新系统中来
 *
 * @author wanjian shantong
 */
public class ts_SelfDefineImageCallback implements AttributeCallback {
    private final static Log logger = LogFactory.getLog("TBMLFilter");


    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            if(StringUtils.isBlank(value)){
                return ""
            }
            value = Common_ImageLazyLoadUtil_21.filter(value);
            return Common_ImageLazyLoadUtil_21.changeToLazyload(filter, value);
        } catch (e) {
            logger.error(e)
        }
        return value
    }


}


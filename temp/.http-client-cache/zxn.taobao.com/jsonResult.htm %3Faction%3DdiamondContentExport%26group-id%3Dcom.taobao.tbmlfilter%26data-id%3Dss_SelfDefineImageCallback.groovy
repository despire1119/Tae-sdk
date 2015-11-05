

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
public class ss_SelfDefineImageCallback implements AttributeCallback {

    private static final Log logger = LogFactory.getLog("TBMLFilter");
//    private static final String TB_BLACK_URL = "ss-tbml-filter-tbBlackUrl.txt";
//    private static final DiamondFile TbUrl = new DiamondFile(TB_BLACK_URL);
//    private static String cacheBlack
//    private static Map blackMap

    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            if(StringUtils.isBlank(value)){
                return ""
            }

            value = Common_ImageLazyLoadUtil_21.filter(value);
            return Common_ImageLazyLoadUtil_21.changeToLazyload(filter, value);
        } catch (e) {
            logger.error("ss_SelfDefineImageCallback,TBMLFilterException,",e)
        }
        return value
    }


}


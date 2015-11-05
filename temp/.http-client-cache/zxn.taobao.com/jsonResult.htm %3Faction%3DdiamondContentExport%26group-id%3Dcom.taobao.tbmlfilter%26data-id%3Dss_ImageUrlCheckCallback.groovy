

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class ss_ImageUrlCheckCallback implements AttributeCallback {

    private static final Log logger = LogFactory.getLog("TBMLFilter");
//    private static final String TB_BLACK_URL = "ss-tbml-filter-tbBlackUrl.txt"
//    private static final DiamondFile TbUrl = new DiamondFile(TB_BLACK_URL)
//    private static String cacheBlack
//    private static Map blackMap

    @Override
    String filterValue(TBMLFilter tbmlFilter, String value, Map<String, String> stringStringMap) {
        try {

            return Common_ImageLazyLoadUtil_21.filter(value)
        } catch (e) {
            logger.error(e)
        }
        return value
    }

}

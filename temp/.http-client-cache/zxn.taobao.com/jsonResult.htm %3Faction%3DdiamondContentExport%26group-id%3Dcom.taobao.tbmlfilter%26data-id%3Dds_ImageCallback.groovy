

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * ясЁы╪сть
 *
 * @author wanjian 2012.07.03 for shifang
 */
public class ds_ImageCallback implements AttributeCallback {

    private static final Log logger = LogFactory.getLog("TBMLFilter");
    private static final String TB_BLACK_URL = "ds-tbml-filter-tbBlackUrl.txt"
    private static final DiamondFile TbUrl = new DiamondFile(TB_BLACK_URL)
    private static String cacheBlack
    private static Map blackMap

    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            String blackUrl = TbUrl.getConfigContent()
            if (cacheBlack == null || blackMap == null || !blackUrl.equals(cacheBlack)) {
                cacheBlack = blackUrl
                blackMap = Common_ImageLazyLoadUtil_21.getUrlMap(blackUrl)
            }
            return Common_ImageLazyLoadUtil_21.filter(blackMap, value)
        } catch (e) {
            logger.error(e)
        }
        return value
    }
}


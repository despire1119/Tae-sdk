

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class ds_StyleAttributeCallback implements AttributeCallback {

    private static final Log logger = LogFactory.getLog("TBMLFilter");
    private static final String TB_BLACK_CSS = "ds-tbml-filter-tbBlackCss.txt"
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS)
    private static final String TB_BLACK_URL = "ds-tbml-filter-tbBlackUrl.txt"
    private static final DiamondFile TbUrl = new DiamondFile(TB_BLACK_URL)
    private static String cacheBlack
    private static Map blackMap

    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            attributes = filter.getContextMap();
            value = Common_StyleUtil_18.filter(TbCss.getConfigContent(), value, attributes);
            if (value && value.contains("url(")) {
                int start = value.indexOf("url(") + 4
                int end = value.indexOf(")", start)
                if (end > start) {
                    String url = value.substring(start, end)
                    String blackUrl = TbUrl.getConfigContent()
                    if (cacheBlack == null || blackMap == null || !blackUrl.equals(cacheBlack)) {
                        cacheBlack = blackUrl
                        blackMap = Common_ImageLazyLoadUtil_21.getUrlMap(blackUrl)
                    }
                    def filtered = Common_ImageLazyLoadUtil_21.filter(blackMap, url)
                    value = value.substring(0,start) + filtered + value.substring(end);
                }
            }
        } catch (e) {
            logger.error(e)
        }
        return value
    }

}


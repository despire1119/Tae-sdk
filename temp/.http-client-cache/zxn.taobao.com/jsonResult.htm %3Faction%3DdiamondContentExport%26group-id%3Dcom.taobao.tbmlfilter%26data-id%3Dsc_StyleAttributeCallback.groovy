

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class sc_StyleAttributeCallback implements AttributeCallback {
    private static final Log logger = LogFactory.getLog("TBMLFilter");

    private static final String TB_BLACK_CSS = "sc-tbml-filter-tbBlackCss.txt"
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS)


    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            attributes = filter.getContextMap();
            value = Common_StyleUtil_18.filter(TbCss.getConfigContent(), value, attributes);
            if (value && value.contains("url(")) {
                int start = value.indexOf("url(") + 4
                int end = value.indexOf(")", start)
                if (end > start) {
                    String url = value.substring(start, end)

                    def filtered = Common_ImageLazyLoadUtil_21.filter(url)
                    value = value.substring(0,start) + filtered + value.substring(end);
                }
            }
        } catch (e) {
            logger.error("sc_StyleAttributeCallback,TBMLFilterException,",e)
        }
        return value
    }

}




import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class ts_NewSDKStyleTagCallback implements TagCallback {
    private static final Log logger = LogFactory.getLog(ts_NewSDKStyleTagCallback.class)

    public void prepare() {
    }

    public boolean checkTag(String tagName, String childrenText) {
        return true;
    }

    public String filterChildText(TBMLFilter filter, String childrenText) {
        try {
            Map<String, String> attributes = filter.getContextMap();
            return Common_StyleUtil_18.filter(true, TbCss.getConfigContent(), childrenText, attributes);
        } catch (e) {
            logger.error("ts_NewSDKStyleTagCallback,TBMLFilterException,",e)
        }
        return childrenText
    }

    private static final String TB_BLACK_CSS = "ts-sdk-new-blackCss.txt";
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS);
}


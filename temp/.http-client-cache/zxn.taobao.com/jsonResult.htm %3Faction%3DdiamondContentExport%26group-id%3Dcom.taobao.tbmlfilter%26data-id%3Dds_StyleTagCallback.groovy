

import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class ds_StyleTagCallback implements TagCallback {
    private static final Log logger = LogFactory.getLog(ds_StyleTagCallback.class)

    public void prepare() {
    }

    public boolean checkTag(String tagName, String childrenText) {
        return true;
    }

    public String filterChildText(TBMLFilter filter, String childrenText) {
        try {
            Map<String, String> attributes = filter.getContextMap()
            return Common_StyleUtil_18.filter(true, TbCss.getConfigContent(), childrenText, attributes)
        } catch (e) {
            logger.error(e)
        }
        return childrenText
    }

    private static final String TB_BLACK_CSS = "ds-tbml-filter-tbBlackCss.txt";
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS);
}


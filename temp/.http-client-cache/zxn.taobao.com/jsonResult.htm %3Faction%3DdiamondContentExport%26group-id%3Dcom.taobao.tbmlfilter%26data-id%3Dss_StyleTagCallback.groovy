

import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class ss_StyleTagCallback implements TagCallback {
    private static final Log logger = LogFactory.getLog(ss_StyleTagCallback.class);

    public void prepare() {
    }

    /**
     * check HTML/TBML tag
     * @param tagName the UPPERCASE tag name
     * @param childrenText the filtered children text of <script> tag or <style> tag, null for non-text-children tag such as <a>��<form>
     * @return true for ok, false for ignore(filter) this tag
     */
    public boolean checkTag(String tagName, String childrenText) {
        return true;
    }

    public String filterChildText(TBMLFilter filter, String childrenText) {
        try {
            Map<String, String> attributes = filter.getContextMap();
            return Common_StyleUtil_18.filter(true, TbCss.getConfigContent(), childrenText, attributes);
        } catch (e) {
            logger.error("ss_StyleTagCallback,TBMLFilterException,",e)
        }
        return childrenText
    }

    private static final String TB_BLACK_CSS = "ss-tbml-filter-tbBlackCss.txt";
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS);
}


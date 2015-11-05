

import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.logging.LogFactory
import org.apache.commons.logging.Log

public class sc_NewSDKStyleTagCallback implements TagCallback {
    private static final Log logger = LogFactory.getLog(sc_NewSDKStyleTagCallback.class);

    public void prepare() {
    }
    /**
     * check HTML/TBML tag
     * @param tagName  the UPPERCASE tag name
     * @param childrenText the filtered children text of <script> tag or <style> tag, null for non-text-children tag such as <a>、<form>
     * @return true for ok, false for ignore(filter) this tag
     */
    public boolean checkTag(String tagName, String childrenText) {
        return true;
    }

    public String filterChildText(TBMLFilter filter, String childrenText) {
//        logger.error("sc_NewSDKStyleTagCallback,styleChildrenText=" + childrenText);
        //新系统至少detail页面内是不允许有style 标签存在的
        return "";
    }
}


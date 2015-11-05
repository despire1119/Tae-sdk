

import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * 已经废弃，因为禁用了style标签
 * 一起废弃的配置还有 ss-new-newSdkBlackCss.txt
 * 保留是为了以后是否会再次启用
 */
public class ss_New_NewSDKStyleTagCallback implements TagCallback {
    private static final Log logger = LogFactory.getLog(ss_New_NewSDKStyleTagCallback.class)

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

    private static final String TB_BLACK_CSS = "ss-new-newSdkBlackCss.txt";
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS);
}




import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * �Ѿ���������Ϊ������style��ǩ
 * һ����������û��� ss-new-newSdkBlackCss.txt
 * ������Ϊ���Ժ��Ƿ���ٴ�����
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


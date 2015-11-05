

import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Matcher
import java.util.regex.Pattern

public class sc_OldSDKStyleTagCallback implements TagCallback {
    private static final Log logger = LogFactory.getLog(sc_OldSDKStyleTagCallback.class)

    private Pattern staticImportantPattern = Pattern.compile("static!important", Pattern.CASE_INSENSITIVE)

    public void prepare() {
    }

    public boolean checkTag(String tagName, String childrenText) {
        return true;
    }

    public String filterChildText(TBMLFilter filter, String childrenText) {
        try {
            Map<String, String> attributes = filter.getContextMap();
            if (!attributes) {
                attributes = [:]
            }
            //old system  È«½ûÓÃ static!important ÊôÐÔ
            Matcher matcher = staticImportantPattern.matcher(childrenText)
            childrenText = matcher.replaceAll(" ")
            return Common_StyleUtil_18.filter(true, TbCss.getConfigContent(), childrenText, attributes);
        } catch (e) {
            logger.error("sc_OldSDKStyleTagCallback,TBMLFilterException,",e)
        }
        return childrenText
    }

    private static final String TB_BLACK_CSS = "sc-sdk-old-blackCss.txt";
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS);
}


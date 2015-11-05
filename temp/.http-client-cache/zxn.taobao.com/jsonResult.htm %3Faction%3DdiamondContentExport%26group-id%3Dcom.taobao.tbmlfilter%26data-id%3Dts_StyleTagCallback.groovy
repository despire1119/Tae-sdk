

import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Matcher
import java.util.regex.Pattern

public class ts_StyleTagCallback implements TagCallback {
    private final static Log logger = LogFactory.getLog("TBMLFilter");
    def positionInherit = Pattern.compile("position:inherit;?",Pattern.CASE_INSENSITIVE)

    def positionStatic = Pattern.compile("position:static;?", Pattern.CASE_INSENSITIVE)

    public void prepare() {
    }

    public boolean checkTag(String tagName, String childrenText) {
        return true;
    }



    public String filterChildText(TBMLFilter filter, String childrenText) {
        try {
            def matcher = positionInherit.matcher(childrenText)
            childrenText = matcher.replaceAll(" ")
            childrenText = dealPositionStatic(childrenText)
            return Common_StyleUtil_18.filterCssContent(true, TbCss.getConfigContent(), childrenText);
        } catch (e) {
            logger.error("ts_StyleTagCallback,TBMLFilterException,",e)
        }
        return childrenText
    }

    def dealPositionStatic(String value) {
        Matcher matcher = positionStatic.matcher(value)
        def indexes = []
        while (matcher.find()) {
            int start = matcher.start()
            String temp = value.substring(0, start)
            int selectorEnd = temp.lastIndexOf("{")
            int selectorStart = temp.lastIndexOf("}")
            if (selectorStart < 0) {
                selectorStart = 0
            }
            String selector = value.substring(selectorStart, selectorEnd)
            if (selector.contains(".main-wrap") || selector.contains(".sub-wrap")) {
                def ls = [:]
                ls.start = matcher.start()
                ls.end = matcher.end()
                indexes.add(ls)
            }
        }

        for (int i = indexes.size() - 1; i >= 0; i--) {
            Map ls = indexes.get(i)
            value = value.substring(0, ls.start) + value.substring(ls.end)
        }
        return value
    }

    private static final String TB_BLACK_CSS = "ts-tbml-filter-tbBlackCss.txt";
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS);

}




import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import com.taobao.top.tbml.tag.TagCallback
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Matcher
import java.util.regex.Pattern



/**
 * style标签和style属性走同一套过滤逻辑
 * test
 */
public class sc_NewStyleCallback implements TagCallback, AttributeCallback {
    private static final Log logger = LogFactory.getLog("TBMLFilter");

    private static final String TB_BLACK_CSS = "sc-new-blackCss.txt"
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS)


    private importantPattern = Pattern.compile("!important", Pattern.CASE_INSENSITIVE)


    public void prepare() {
    }

    public boolean checkTag(String tagName, String childrenText) {
        return true;
    }

    public String filterChildText(TBMLFilter filter, String childrenText) {
        return filterValue(filter, childrenText, null)
    }

    @Override
    String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            attributes = filter.getContextMap();
            if (!attributes) {
                attributes = new HashMap<>()
            }
            if (StringUtils.isBlank(value)) {
                return value
            }
            //new system  全禁用 !important 属性
            Matcher matcher = importantPattern.matcher(value)
            value = matcher.replaceAll(" ")
            value = Common_StyleUtil_18.filter(true, TbCss.getConfigContent(), value, attributes);
            value = filterStyleUrl(value,1);
        } catch (e) {
            logger.error("sc_NewStyleCallback,TBMLFilterException,",e)
        }
        return value
    }

    /**
     *  过滤url()
     * @param content   将要被过滤的内容
     * @param count    递归深度
     * @return
     */
    private def filterStyleUrl(def content,int count){
        if(!content){
            return content ;
        }

        if(!content.contains("url(")){
            return content;
        }

        if(count > 3){
            logger.error("sc_NewStyleCallback.groovy,badMultipleStyleUrls,content=" + content)
            //return "";
        }

        int start = content.indexOf("url(") + 4
        int end = content.indexOf(")", start)
        if (end > start) {
            String url = content.substring(start, end)
            def filtered
            if(url){
                if(url.contains("&#")||url.contains("\\u")){
                    filtered = "about:blank"
                    logger.error("sc_NewStyleCallback,unescapeHtml="+url)
                }else{
                    filtered = Common_ImageLazyLoadUtil_21.filter(url)
                }
            }
            count++;
            return content.substring(0,start) + filtered + filterStyleUrl(content.substring(end),count);
        }else if(end == start){
            count++;
            return content.substring(0,start) + filterStyleUrl(content.substring(end),count);
        }

        return content;
    }
}


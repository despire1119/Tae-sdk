

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
 */
public class ts_NewStyleCallback implements TagCallback, AttributeCallback {
    private final static Log logger = LogFactory.getLog("TBMLFilter");

    private static final String TB_BLACK_CSS = "ts-new-blackCss.txt";
    private static final DiamondFile TbCss = new DiamondFile(TB_BLACK_CSS);


    private importantPattern = Pattern.compile("!important", Pattern.CASE_INSENSITIVE)

    def positionInherit = Pattern.compile("position:inherit;?", Pattern.CASE_INSENSITIVE)

    def positionStatic = Pattern.compile("position:static;?", Pattern.CASE_INSENSITIVE)

    public void prepare() {
    }

    public boolean checkTag(String tagName, String childrenText) {
        return true;
    }

    /**
     * 新装修完全自定义样式将走这个逻辑，过滤的内容将保存起来， 所以不能注释
     */
    public String filterChildText(TBMLFilter filter, String value) {
        try {
            if (StringUtils.isBlank(value)) {
                return value
            }
            //new system  全禁用 !important 属性
            Matcher matcher = importantPattern.matcher(value)
            value = matcher.replaceAll(" ")
            matcher = positionInherit.matcher(value)
            value = matcher.replaceAll(" ")
            value = dealPositionStatic(value)
            try {
                value = Common_StyleUtil_18.filter(true, TbCss.getConfigContent(), value, [:]);
            } catch (Exception ex) {
                logger.error("ts_NewStyleCallback,filterChildTextExeption,", ex)
            }

            value = filterStyleUrl(value,1);

        } catch (e) {
            logger.error("ts_NewStyleCallback,TBMLFilterException,",e)
        }
        return value
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

    /**
     * 装修可以不做过滤
     */
    String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        /*attributes = filter.getContextMap();
        if (!attributes) {
            attributes = new HashMap<>()
        }

        try {
            value = StyleUtil_18.filter(true, TbCss.getConfigContent(), value, attributes);
        } catch (Exception ex) {
            logger.error("ts_NewStyleCallback,filterChildTextExeption,", ex)
        }
        if (value && value.contains("url(")) {
            int start = value.indexOf("url(") + 4
            int end = value.indexOf(")", start)
            if (end > start) {
                String url = value.substring(start, end)
                String blackUrl = TbUrl.getConfigContent()
                if (cacheBlack == null || blackMap == null || !blackUrl.equals(cacheBlack)) {
                    cacheBlack = blackUrl
                    blackMap = Common_ImageLazyLoadUtil_21.getUrlMap(blackUrl)
                }
                def filtered = Common_ImageLazyLoadUtil_21.filter(blackMap, url)
                if ("".equals(filtered)) {
                    value = ""
                }
            }
        }*/
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
            logger.error("ts_NewStyleCallback.groovy,badMultipleStyleUrls,content=" + content)
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
                    logger.error("ts_NewStyleCallback,unescapeHtml="+url)
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


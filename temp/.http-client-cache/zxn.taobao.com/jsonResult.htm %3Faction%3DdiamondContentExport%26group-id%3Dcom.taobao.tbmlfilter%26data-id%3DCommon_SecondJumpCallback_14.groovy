

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class Common_SecondJumpCallback_14 implements AttributeCallback {
    private final static Log logger = LogFactory.getLog("TBMLFilter");
    def systemPath = ["/index.htm", "/search.htm", "/dongtai.htm", "/p/", "/category-"]
    def wanDomain = ["www.5317wan.com","download.5317wan.com","nnhysj.5317wan.com"]
    def wanPath = ["/game/rgn/nnhy.html","/nnhysj/nnhysj_3.1.0_f04ca.apk","/"]
    @Override
    String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {

        if (value && value.startsWith("/")) {
            boolean isSystem = false
            systemPath.each {
                if (value.startsWith(it)) {
                    isSystem = true
                }
            }
            if (!isSystem) {
                return ""
            }
        }

        if (value != null) {
            int anchorIndex = value.indexOf("#", 7)
            int pathIndex = value.indexOf("/", 7)
            if (anchorIndex > 0 && pathIndex > 0 && anchorIndex < pathIndex) {
                return ""
            }
        }

        def pattern = "((h|%68)(t|%74){2}(p|%70))"
        if (value && value.length() > 4) {
            def prof = value.substring(0, 4)
            def cut = value.substring(4)
            def matcher = (cut =~ /$pattern/)
            if (matcher.find()) {
                def start = matcher.start(1)
                cut = cut.substring(0, start)
            }
            value = prof + cut
        }

        def certification = "scene=taobao_shop"
        if (value) {
            try {
                if(value.contains("&amp;")){
                    value = StringUtils.replace(value,"&amp;","&");
                    //value = value.replaceAll("&amp;","&");
                }
                URL url = new URL(value)
                if(url.getHost().endsWith(".5317wan.com")){
                    if(!wanDomain.contains(url.getHost())) {
                        return ""
                    }else{
                        if(StringUtils.isNotBlank(url.getPath()) && !wanPath.contains(url.getPath())){
                            return ""
                        }
                    }
                }
                value = addQuery(url, certification)
            } catch (e) {

            }
        }


        def filterValue = GaodeUtil.filter(value, filter)
        def host = getHostFormURL(filterValue)
        if(host && ("www.taobao.com".equalsIgnoreCase(host)||host.endsWith(".we.app.jae.m.taobao.com"))){
            return filterValue;
        }
        return removeURLSchema(filterValue)
    }
    /**
     * ¿‡À∆”⁄new URL().getHost()
     * @param url
     * @return
     */
    public static String getHostFormURL(String url) {
        if(StringUtils.isBlank(url)){
            return "";
        }

        String hostAfter = null;

        if(url.trim().startsWith("//")){
            hostAfter = StringUtils.substringAfter(url,"//");
        }else{
            hostAfter = StringUtils.substringAfter(url,"://");
        }

        String urlHost = StringUtils.substringBefore(hostAfter,"/");
        return urlHost;
    }

    static def removeURLSchema(String url){
        if(StringUtils.isBlank(url)){
            return url;
        }
        url = url.trim();
        if(url.startsWith("//")){
            return url;
        }
        String urlLowerCase = url.toLowerCase();
        if(urlLowerCase.startsWith("http:")){
            return url.substring(5);
        }else if(urlLowerCase.startsWith("https")) {
            return url.substring(6);
        }else{
            return url;
        }
    }

    static def addQuery(URL u, String addQuery) {
        def query = addQuery
        if (u.getQuery() != null) {
            String pre = u.getQuery()
            def parts = pre.split("&")
            for (int i = 0; i < parts.length; i++) {
                if (parts[i].contains("scene=")) {
                    parts[i] = ""
                }
            }
            query = StringUtils.join(parts, "&")
            if (query.getAt(query.length() - 1) == '&') {
                query = query + addQuery
            } else {
                query = query + "&" + addQuery
            }
        }
        StringBuffer result = new StringBuffer()
        result.append(u.getProtocol())
        result.append(":")
        if (u.getAuthority() != null && u.getAuthority().length() > 0) {
            result.append("//")
            result.append(u.getAuthority())
        }
        if (u.getPath() != null && u.getPath() != "") {
            result.append(u.getPath())
        } else {
            result.append("/")
        }
        result.append('?')
        result.append(query)
        if (u.getRef() != null) {
            result.append("#")
            result.append(u.getRef())
        }
        return result.toString()
    }

    class GaodeUtil {

        private static final String whitelist = "Common_gaodeWhitelist.txt"
        private static final DiamondFile whiteContent = new DiamondFile(whitelist)

        private static final String gaodeDomain = "detail.amap.com"

        private static String cacheContent = null

        private static List<String> whiteUserList = null;

        /**
         * @param url
         * @return
         */
        public static String filter(String rawUrl, TBMLFilter tbmlFilter) {
            try {
                URL url = new URL(rawUrl)
                String host = url.getHost()
                String userId = tbmlFilter.contextMap?.get("userId")
                if (gaodeDomain.equals(host) && StringUtils.isNotBlank(userId)) {
                    def configContent = whiteContent.getConfigContent()
                    if (configContent != null) {
                        if (cacheContent == null || whiteUserList == null || !cacheContent.equals(configContent)) {
                            cacheContent = configContent
                            whiteUserList = configContent.split("\r?\n")
                        }
                        for (String it : whiteUserList) {
                            if (it.equals(userId)) {
                                return rawUrl
                            }
                        }
                    }
                    return ""
                }
            } catch (e) {

            }
            return rawUrl
        }
    }
}

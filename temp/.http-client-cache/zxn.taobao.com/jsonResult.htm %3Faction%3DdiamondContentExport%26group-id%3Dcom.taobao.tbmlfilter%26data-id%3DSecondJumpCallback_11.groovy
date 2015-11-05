

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils

/**
 * 二次跳转或�??1??7??1??71??1??7??1??77多次跳转的�G�??1??7??1??71??1??7??1??77
 */
 
 
 
 
 
 

public class SecondJumpCallback_11 implements AttributeCallback {

    def systemPath = ["/index.htm", "/search.htm", "/dongtai.htm", "/p/", "/category-"]

    @Override
    String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        //对form的特殊�G�??1??7??1??71??1??7??1??77
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

        //去二�??1??7??1??71??1??7??1??77
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

        //对a标签增加 scene=taobao_shop，防止用户在a标签中放置flash，然后跳�??1??7??1??71??1??7??1??77
        def certification = "scene=taobao_shop"
        if (value) {
            try {
                URL url = new URL(value)
                value = addQuery(url, certification)
            } catch (e) {
                //�??1??7??1??71??1??7??1??77��不�|则的url,比�� #
            }
        }

        //增加高德白名单校�??1??7??1??71??1??7??1??77
        return GaodeUtil.filter(value, filter)
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
            query = query + "&" + addQuery
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

        private static final String whitelist = "gaodeWhitelist.txt"
        private static final DiamondFile whiteContent = new DiamondFile(whitelist)

        private static final String gaodeDomain = "detail.amap.com"

        private static String cacheContent = null

        private static List<String> whiteUserList = null;

        /**
         * 更加白名单过滤�rl
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

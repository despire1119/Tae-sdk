

import com.taobao.security.util.SecurityUtil
import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

public class Common_FlashPathCallback_11 implements AttributeCallback {

    private final static Log logger = LogFactory.getLog("TBMLFilter");
    static def flashWhiteDomainList = ["mall.3dsource.cn",
                                    "t.focosee.com",
                                    "publish.show-wise.com",
                                    "custom.show-wise.com",
                                    "taobao.show-wise.com",
                                    "3dshow.fuwo.com",
                                    "tao360.detuyun.com",
                                    "app.tv.sohu.com",
                                    "yuntv.letv.com",
                                    "player.pps.tv",
                                    "project.t-immersion.com",
                                    "tberp.owyun.com",
                                    "js.tudouui.com",
                                    "www.eyooyoo.cn",
                                    "www.56.com",
                                    "56.com",
                                    "player.youku.com",
                                    "players.youku.com",
                                    ".alimama.cn",
                                    "gbm.alicdn.com",
                                    ".tbcdn.cn",
                                    ".uu1001.cn",
                                    "video1.watone.com.cn",
                                    "proxy.taobao.com",
                                    "vodcdn.alicdn.com",
                                    "yun.taosoft.com.cn",
                                    "cloud.video.taobao.com","media.alicdn.com"]
    static def blackListFlash = ["gbm.alicdn.com/tfscom/TB13YsgGFXXXXaqXXXXeflbFXXX",
            "gbm.alicdn.com/tfscom/TB1mf62GFXXXXXbXVXXeflbFXXX",
            "gbm.alicdn.com/tfscom/TB1qrj0GFXXXXaBXXXXeflbFXXX",
            "gbm.alicdn.com/tfscom/TB1uYn4GFXXXXXqXFXXeflbFXXX",
            "gbm.alicdn.com/tfscom/TB1csfsGFXXXXbbXpXXeflbFXXX",
            "gbm.alicdn.com/tfscom/TB1xD2VGFXXXXcTXpXXeflbFXXX"]

    static def flashShellTransferList = ["video1.watone.com.cn","www.56.com","yuntv.letv.com"
                                            ,"yun.taosoft.com.cn",
                                         "gbm.alicdn.com",
                                         ".uu1001.cn",
                                         "mall.3dsource.cn",
                                         "t.focosee.com",
                                         "publish.show-wise.com",
                                         "custom.show-wise.com",
                                         "taobao.show-wise.com",
                                         "3dshow.fuwo.com",
                                         "tao360.detuyun.com",
                                         "app.tv.sohu.com",
                                         "player.pps.tv",
                                         "project.t-immersion.com",
                                         "tberp.owyun.com",
                                         "js.tudouui.com",
                                         "www.eyooyoo.cn",
                                         "img1.tbcdn.cn",
                                         "img2.tbcdn.cn",
                                         "img3.tbcdn.cn",
                                         "img4.tbcdn.cn"]

    @Override
    String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        if(!value){
            return value;
        }
        value = value.trim();
        //String realValue;
        boolean isTransferFlash = false;
        if(value.startsWith("https://vodcdn.alicdn.com/") || value.startsWith("http://vodcdn.alicdn.com/")){
            value = removeURLSchema(value)
        }
        if(value.startsWith("//vodcdn.alicdn.com/https/playercase0.0.1.swf?playerurl=")
                ||value.startsWith("http://vodcdn.alicdn.com/https/playercase0.0.1.swf?playerurl=")){
            value = value.substring(value.indexOf("?playerurl=")+"?playerurl=".length())
            value = URLDecoder.decode(value,"UTF-8")
            isTransferFlash = true;
        }

        //在编码前做一次解码，因为浏覻器会对html编码做解�?
        value = SecurityUtil.unescapeHtml(value)

        if (value) {
            //123show
            if (containsAtTheSame(value, ".123show.com", "/preview") || containsAtTheSame(value, ".show-wise.com", "/preview")) {
                return ""
            }
            //uu1001
            if (containsAtTheSame(value, ".uu1001.cn", "/bcv3.swf") || containsAtTheSame(value, ".uu1001.cn", "/bc_for_preview.swf")) {
                return ""
            }
            //myc.edmwar.com(临时解决)
            if(containsAtTheSame(value,"myc.edmwar.com")){
                return ""
            }

            //www.56.com/tb_  特殊处理
            if(value.contains("www.56.com") && !value.contains("www.56.com/tb_") && !value.contains("proxy.taobao.com/tb_")){
                return ""
            }

            //bannermaker 污染url特殊处理
            for(def blackFlashUrl : blackListFlash){
                if(value.contains(blackFlashUrl)){
                    return ""
                }
            }

            //将参数棌查抽成方�?
            if(value){
                value = checkRealUrlParam(value);
                if(!value){
                    return ""
                }
            }

        }
        //TODO：暂时注释掉，测试flash视频
        //将正则匹配抽成方�?
        if(value){
            value = checkHttpPattern(value)
        }

        try {
            value = addProxyAndTransfer(value)
        }catch (e){
            logger.error("Common_FlashPathCallback_11.addProxyAndTransfer.exception",e)
        }
        return value
    }

    static boolean containsAtTheSame(String source, String... items) {
        boolean flag = true
        for (String it : items) {
            if (!source.contains(it)) {
                return false
            }
        }
        return flag
    }
    static boolean containsIf(String source,String... items){
        String lowerSrc = source.toLowerCase();
        for(String it : items){
            if(lowerSrc.contains(it.toLowerCase())){
                return true;
            }
        }

        return  false;
    }

    static int findFirstQuestionMark(String source,String... items){
        int index = 10000;
        String lowerSrc = source.toLowerCase();
        for(String it : items){
            int i = lowerSrc.indexOf(it.toLowerCase());
            if(i != -1 && i < index){
                index = i;
            }
        }
        return index;
    }

    static String addProxyAndTransfer(String urlStr) throws MalformedURLException {
        def host = getHostFormURL(urlStr);
        if(!host){
            return removeURLSchema(urlStr);
        }

        if("media.tbcdn.cn".equalsIgnoreCase(host)){
            urlStr = urlStr.replace(host,"media.alicdn.com");
            return removeURLSchema(urlStr);

        }else if("media.alicdn.com".equalsIgnoreCase(host)){
            return removeURLSchema(urlStr);
        }

        def hostParam = getHostParam(urlStr)

        //特殊处理�?��优酷的覹�?
        try{
            if(host.equalsIgnoreCase("proxy.taobao.com")){
                if(urlStr.trim().startsWith("//")){
                    urlStr = "http:"+urlStr;
                }

                URL url = new URL(urlStr);
                def queryStr = url.getQuery();
                def youkuHost = url.getHost();
                def youkuPath = url.getPath()==null?"":url.getPath();
                def youkuRef = url.getRef()==null?"":"#"+url.getRef();
                def youkuQuery = ""
                if(queryStr){
                    def querys = queryStr.split("&")
                    for(def qYouku : querys){
                        if(qYouku.contains("_host="+hostParam)){
                            continue;
                        }else{
                            if(youkuQuery){
                                youkuQuery = youkuQuery + "&" + qYouku;
                            }else{
                                youkuQuery = qYouku;
                            }
                        }
                    }
                }
                if(youkuQuery){
                    if(!hostParam){
                        urlStr = "http://player.youku.com"+youkuPath+"?"+youkuQuery+youkuRef
                    }else{
                        urlStr ="http://"+hostParam+youkuPath+"?"+youkuQuery+youkuRef
                    }
                }else{
                    if(!hostParam){
                        urlStr = "http://player.youku.com"+youkuPath+youkuRef
                    }else{
                        urlStr = "http://"+hostParam+youkuPath+youkuRef
                    }

                }

            }
        }catch (e){
            logger.error("addProxyAndTransferException",e)
        }

        host = getHostFormURL(urlStr);

        if(!isWhiteListFlash(host,flashWhiteDomainList)){
            return ""
        }


        if(isWhiteListFlash(host,flashShellTransferList)){
            def shell = "//vodcdn.alicdn.com/https/playercase0.0.1.swf?playerurl=";
            return shell+URLEncoder.encode(urlStr,"UTF-8");
        }else{
            if("player.youku.com".equalsIgnoreCase(host)){
                urlStr = urlStr.replace("player.youku.com/","players.youku.com/")
            }
            return removeURLSchema(urlStr);
        }
    }

    private static boolean isWhiteListFlash(String host,def whiteList){
        if(!whiteList){
            return false;
        }
        if(whiteList.contains(host)){
            return true;
        }

        for(def hostItem : whiteList){
            if(hostItem.startsWith(".") && host.endsWith(hostItem)){
                return true;
            }
        }

        return false;

    }

    private static String checkHttpPattern(String realUrl){
        def pattern = "((h|%68)(t|%74){2}(p|%70))"
        if (realUrl && realUrl.length() > 4) {
            def prof = realUrl.substring(0, 4)
            def cut = realUrl.substring(4)
            def matcher = (cut =~ /$pattern/)
            if (matcher.find()) {
                def start = matcher.start(1)
                cut = cut.substring(0, start)
            }
            realUrl = prof + cut
        }
        return realUrl
    }

    private static String checkRealUrlParam(String realUrl){
        if(containsIf(realUrl,"?","&#63;","&#x3f;","%3f")){
            int index = findFirstQuestionMark(realUrl,"?","&#63;","&#x3f;","%3f");
            if(index != 10000){
                String sub = StringUtils.substring(realUrl,index) ;
                //TODO:暂时注释掉，为了测试flash
                if(StringUtils.isNotBlank(sub) && (sub.contains("imglogo") || sub.contains("loadinglogo") || sub.contains("http")
                        || sub.contains("//") || StringUtils.containsIgnoreCase(sub,"%2f%2f")
                        || StringUtils.containsIgnoreCase(sub,"&#x2f;&#x2f;")
                        || sub.contains("&#47;&#47;"))){
                    return ""
                }
            }
            if(realUrl.contains("gbm.alicdn.com") && !realUrl.contains("?t=20141106")) {
                realUrl = realUrl+"&t=20141106"
            }
        }else{
            if(realUrl.contains("gbm.alicdn.com") && !realUrl.contains("?t=20141106")) {
                realUrl = realUrl+"?t=20141106"
            }
        }

        return realUrl;
    }


    private static String getHostParam(String urlStr){
        if(urlStr.contains("_host=")){
            def hostAfter = StringUtils.substringAfter(urlStr,"_host=")
            if(hostAfter){
                def hostParam = hostAfter
                if(hostAfter.contains("&")){
                    hostParam = StringUtils.substringBefore(hostAfter,"&");
                }else if(hostAfter.contains("#")){
                    hostParam = StringUtils.substringBefore(hostAfter,"#");
                }
                return hostParam
            }
        }
        return ""
    }

    public static String removeURLSchema(String url){
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

}

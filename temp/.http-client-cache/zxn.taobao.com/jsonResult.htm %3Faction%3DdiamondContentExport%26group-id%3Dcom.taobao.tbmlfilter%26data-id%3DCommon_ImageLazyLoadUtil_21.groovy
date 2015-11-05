

import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.config.GlobalConfig
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * �ӳټ���Ǩ�Ƶ���ϵͳ����
 *
 * @author wanjian shantong
 */

public class Common_ImageLazyLoadUtil_21 {
    private final static Log logger = LogFactory.getLog("TBMLFilter");

    static def specialDomain = ["haocai.com.cn"]
    /**
     * pics.taobao.comȫ��һ��1000�ţ���������С�İ�ť
     * image.taobao.comȫ��һ��57��
     * logo.taobao.comȫ��һ��2328��
     * img.taobao.comȫ��һ��600w��
     * img01.taobao.comȫ��һ��13699��
     * img02.taobao.comȫ��һ��7043��
     * img03.taobao.comȫ��һ��6237��
     * img04.taobao.comȫ��һ��5008��
     * img05.taobao.comȫ��һ��56��
     * lz.taobao.comȫ��һ��7��
     * image.lz.taobao.comȫ��һ��14��
     */
    static def fullMathchTaobaoWhiteDominList = ["logo.taobao.com", "img.taobao.com", "img01.taobao.com", "img02.taobao.com", "img03.taobao.com", "img04.taobao.com"
            , "img05.taobao.com", "image.taobao.com", "pics.taobao.com", "lz.taobao.com", "image.lz.taobao.com"]

    private static final String TB_IMG_WHITE_URL = "Common_imgDomainWhiteList.txt"
    private static final DiamondFile TbUrl = new DiamondFile(TB_IMG_WHITE_URL)
    private static String whiteUrlsCache
    private static Map whiteListMap
    //ww
    static def old_ww_taobaocdnList = ["amos.im.alisoft.com","tbamos.alicdn.com"]
    static def new_ww_taobaocdn= "amos.alicdn.com"
    //ww assets
    static def old_ww_assetsList = ["www.im.alisoft.com","img.im.alisoft.com","img.im.alicdn.com"]
    static def new_ww_assets = "im.alicdn.com"
    //wwc
    static def old_wwc_taobaocdnList = ["wwc.taobaocdn.com"]
    static def new_wwc_taobaocdn = "wwc.alicdn.com"
    //a.tbcdn.cn->assets.alicdn.com
    static def old_assets_taobaocdnList = ["a.tbcdn.cn","l.tbcdn.cn","t.tbcdn.cn","s.tbcdn.cn","t.mmcdn.cn","assets.taobaocdn.com"]
    static def new_assets_tabaocdn = "assets.alicdn.com"
    //g.tbcdn.cn->g.alicdn.com,�ȴ���־������û���������

    //strip.taobaocdn.com
    static def oldStrip_taoabocdnList = ["strip.taobaocdn.com"]
    static def new_strip_taobaocdn = "strip.alicdn.com"

    static def old_img_taobaocdnList = [
            "gdp.alicdn.com",
            "img.alicdn.com",
            "img.taobao.com",
            "img01.taobaocdn.com",
            "img02.taobaocdn.com",
            "img03.taobaocdn.com",
            "img04.taobaocdn.com",
            "img05.taobaocdn.com",
            "img06.taobaocdn.com",
            "img07.taobaocdn.com",
            "img08.taobaocdn.com",
            "img01.taobao.com",
            "img02.taobao.com",
            "img03.taobao.com",
            "img04.taobao.com",
            "img.taobaocdn.com",
            "gtms01.alicdn.com",
            "gtms02.alicdn.com",
            "gtms03.alicdn.com",
            "gtms04.alicdn.com",
            "i.mmcdn.cn",
            "q.i02.wimg.taobao.com",
            "tu.taobaocdn.com","pics.taobao.com","pics.taobaocdn.com","logo.taobaocdn.com",
            "img1.tbcdn.cn","img2.tbcdn.cn","img3.tbcdn.cn","img4.tbcdn.cn","tu.taobaocdn.com",
            "img05.taobao.com","img06.taobao.com","img07.taobao.com","img08.taobao.com",
            "gi1.md.alicdn.com","gi2.md.alicdn.com","gi3.md.alicdn.com","gi4.md.alicdn.com",
            "gtu-c01.m.alicdn.com","gtu-c02.m.alicdn.com","gtu-c03.m.alicdn.com","gtu-c04.m.alicdn.com",
            "gtu-01.m.alicdn.com","gtu-02.m.alicdn.com","gtu-03.m.alicdn.com","gtu-04.m.alicdn.com",
            "gdz01.md.alicdn.com","gdz02.md.alicdn.com","gdz03.md.alicdn.com","gdz04.md.alicdn.com"
            ]
    static def new_img_alicdn = "gdp.alicdn.com"
    //ֻȥschema����������
    static def onlyRemoveSchemaImgDomain = ["amos.alicdn.com","im.alicdn.com","gw.alicdn.com",
                                            "wwc.alicdn.com","assets.alicdn.com",
                                            "gqrcode.alicdn.com","gd1.alicdn.com",
                                            "gd2.alicdn.com","gd3.alicdn.com","gd4.alicdn.com","strip.alicdn.com","img.alicdn.com","gdp.alicdn.com",
                                            "gw1.alicdn.com","gw2.alicdn.com","gw3.alicdn.com","gw4.alicdn.com","gsnapshot.alicdn.com"]

    /**
     * ͼƬ������
     * @param filter
     * @param value
     * @return
     */
    public static String changeToLazyload(TBMLFilter filter, String value) {
        if ((value.startsWith(HTTP) || value.startsWith("//")) && !value.equals(KS_PIC) && !value.equals(KS_PIC_NO_SCHEMA) && !value.equals(KS_PIC_NEW_HAS_SHEMA)) {
            @SuppressWarnings("unchecked")
            Map<String, String> attributes = filter.getContextMap();
            if (attributes != null && "1".equals(attributes.get(LAZY_IMG))) {
                StringBuffer sb = new StringBuffer();
                sb.append(RICHTEXT_KEYCHAR).append(KS_PIC_NO_SCHEMA).append("\"").append(" ").append("data-ks-lazyload=\"")
                        .append(value.startsWith(HTTP)?value.substring(5):value);
                value = sb.toString();
            }
        }
        return value;
    }

    /**
     *
     * @param value
     * @return
     */
    public static String filter(String value) {
        if (StringUtils.isBlank(value)) {
            return value;
        }

        String host = "";
        try {
            //����ǹٷ�CDN·��,����removeSchema��������������
            if (isOfficialUrl(value)) {
                //url fixed
                if(!value.startsWith("http://") && !value.startsWith("&quot;http://") && !value.startsWith("//") && !value.startsWith("https://")){
                    def index = value.indexOf("://");
                    if(index > 0 && index < value.length()){
                        value = "http" + value.substring(value.indexOf("://"));
                        logger.error("Common_ImageLazyLoadUtil_21,filterNotStartHttpUrlAfterRepair=" + value)
                    }
                }

                return removeURLSchema(transferUrl(value))
            }

            //����sdkģ���е����ͼƬ��ַassets/img.....��../../assets/.....
            if (value.equalsIgnoreCase("about:blank")) {
                return value;
            }

            value = value.trim();
            if (!value.startsWith("http") && !value.startsWith("//")) {
                logger.error("Common_ImageLazyLoadUtil_21,filterNotStartHttpUrl=" + value)
            }

            //�����û���װ�޵�ʱ������̨�������
            if (value.toLowerCase().contains(".tw.taobao.com") ||
                    value.toLowerCase().contains(".taiwan.tmall.com") || value.toLowerCase().contains(
                    "//taiwan.tmall.com") || value.toLowerCase().contains("//taiwan.taobao.com")) {
                return ""
            }

            //String host = new URL(value).getHost()
             host = getHostFormURL(value);

            //��������һ��ֻȥschema������������
            if(onlyRemoveSchemaImgDomain.contains(host)){
                return removeURLSchema(value)
            }

            //����taobao.com��׼��
            if (host.endsWith(".taobao.com")) {
                if (fullMathchTaobaoWhiteDominList.contains(host)) {
                    return value;
                } else {
                    return ""
                }
            }

            String currentWhiteList = TbUrl.getConfigContent()
            if (whiteUrlsCache == null || whiteListMap == null || !currentWhiteList.equals(whiteUrlsCache)) {
                whiteUrlsCache = currentWhiteList
                whiteListMap = Common_ImageLazyLoadUtil_21.getUrlMap(currentWhiteList)
            }


            def split = host.split("\\.")
            String target = host

            /**
             * �����ضϴ�������
             * 1.   xxx.com             //split.length<=2
             * 2.   special Domain   // �� haocai.com.cn
             */
            if (split.length > 2 && !specialDomain.contains(host)) {
                target = host.replace(split[0] + ".", "")
            }
            if (!whiteListMap.containsKey(target)) {
                logger.error("Common_ImageLazyLoadUtil21,filter(),outerImg,filter2Blank,value=" + value)
                return "about:blank"
            }
            //��host������
            String decoded = URLDecoder.decode(host)
            if (!host.equals(decoded)) {

                //����taobao.com��׼��
                if (host.endsWith(".taobao.com")) {
                    if (fullMathchTaobaoWhiteDominList.contains(host)) {
                        return value;
                    } else {
                        return ""
                    }
                }

                split = decoded.split("\\.")
                if (split.length > 2 && !specialDomain.contains(host)) {
                    target = decoded.replace(split[0] + ".", "")
                }
                if (!whiteListMap.containsKey(target)) {
                    return "about:blank"
                }
            }
        } catch (e) {
            // ���Ǿ���·����url,���Ե�
            logger.error("Common_ImageLazyLoadUtil_21,TBMLFilterException,", e)
        }

        if (value.startsWith("http://") || value.startsWith("&quot;http://")) {
            if("chart.apis.google.com".equalsIgnoreCase(host)){

            }else {
                logger.error("Common_ImageLazyLoadUtil_21,notRemoveSchema,value=" + value)
            }
            return value;
        } else {
            def index = value.indexOf("://");
            if(index > 0 && index < value.length()){
                value = "http" + value.substring(value.indexOf("://"));
                logger.error("Common_ImageLazyLoadUtil_21,filterNotStartHttpUrlAfterRepair=" + value)
            }
            return value;
        }
    }

    public static String filter(Map blackMap, String value) {
        if (blackMap != null && value != null) {
            try {
                if (value.startsWith("http://img01.taobaocdn.com/") ||
                        value.startsWith("http://img02.taobaocdn.com/") ||
                        value.startsWith("http://img03.taobaocdn.com/") ||
                        value.startsWith("http://img04.taobaocdn.com/") ||
                        value.startsWith("http://img01.taobaocdn.com/") ||
                        value.startsWith("http://a.tbcdn.cn/") ||
                        value.startsWith("http://g.tbcdn.cn/")) {
                    return value
                }
                String host = new URL(value).getHost()
                def split = host.split("\\.")
                String target = host

                /**
                 * �����ضϴ�������
                 * 1.   xxx.com             //split.length<=2
                 * 2.   special Domain   // �� haocai.com.cn
                 */
                if (split.length > 2 && !specialDomain.contains(host)) {
                    target = host.replace(split[0] + ".", "")
                }
                if (blackMap.containsKey(target)) {
                    return "about:blank"
                }
                //��host������
                String decoded = URLDecoder.decode(host)
                if (!host.equals(decoded)) {
                    split = decoded.split("\\.")
                    if (split.length > 2 && !specialDomain.contains(host)) {
                        target = decoded.replace(split[0] + ".", "")
                    }
                    if (blackMap.containsKey(target)) {
                        return "about:blank"
                    }
                }
            } catch (e) {
                // ���Ǿ���·����url,���Ե�
                logger.error("Common_ImageLazyLoadUtil_21,TBMLFilterException,", e)
            }
        }
        return value;
    }

    public static Map getUrlMap(String tbClass) {
        def rs = new HashMap()
        if (tbClass) {
            def split = tbClass.split(",|\r*\n")
            split.each {
                rs.put(it.trim(), true)
            }
        }
        return rs
    }

    private static final char RICHTEXT_KEYCHAR = '��';
    private final static String KS_PIC = "http://a.tbcdn.cn/s.gif";
    private final static String KS_PIC_NO_SCHEMA = "//assets.alicdn.com/s.gif";
    private final static String KS_PIC_NEW_HAS_SHEMA = "http://assets.alicdn.com/s.gif";

    public final static String HTTP = "http://";

    public final static String LAZY_IMG = "lazyImg";

    public static final String IMAGE_SERVER = "_tbml_image_server";
    public static final String TEMPLATE_VERSION_ID = "_template_version_id";
    public static final String TEMPLATE_MODULE_NAME = "_template_module_name";

    public static String transferUrl(String value) {
        if (StringUtils.isBlank(value)) {
            return value;
        }
        //���ݰ汾���������Ƿ��ǵ���

        Set<String> versionSet = GlobalConfig.getVersionSet();
        if (versionSet.contains("ts") || versionSet.contains("ss") || versionSet.contains("sc")) {
            value = value.trim();
            def host = getHostFormURL(value);
            if (new_img_alicdn.equalsIgnoreCase(host) || new_ww_taobaocdn.equalsIgnoreCase(host) || new_wwc_taobaocdn.equalsIgnoreCase(host)
            || new_assets_tabaocdn.equalsIgnoreCase(host) || new_ww_assets.equalsIgnoreCase(host)||
                new_strip_taobaocdn.equalsIgnoreCase(host)) {
                return value;
            }else if(old_img_taobaocdnList.contains(host)){
                return value.replace(host, new_img_alicdn);
            }else if(old_ww_taobaocdnList.contains(host)){
                return value.replace(host,new_ww_taobaocdn);
            }else if(old_assets_taobaocdnList.contains(host)){
                return value.replace(host,new_assets_tabaocdn)
            }else if(old_wwc_taobaocdnList.contains(host)){
                return value.replace(host,new_wwc_taobaocdn)
            }else if(old_ww_assetsList.contains(host)){
                return value.replace(host,new_ww_assets)
            }else if(oldStrip_taoabocdnList.contains(host)){
                return value.replace(host,new_strip_taobaocdn)
            }
        }
        return value
    }

    private static boolean isOfficialUrl(String value) {

        def host = getHostFormURL(value);
        if (old_img_taobaocdnList.contains(host) || old_ww_taobaocdnList.contains(host) ||
                old_assets_taobaocdnList.contains(host) || old_wwc_taobaocdnList.contains(host)
            || old_ww_assetsList.contains(host) || oldStrip_taoabocdnList.contains(host)) {
            return true;
        }else {
            return false;
        }
    }

    /**
     * ������new URL().getHost()
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

    public static String removeURLSchema(String url){
        if(StringUtils.isBlank(url) || url.startsWith("//")){
            return url;
        }
        url = url.trim()
        if(url.startsWith("http:")){
            return url.substring(5);
        }  else {
            String lowerCaseUrl = url.toLowerCase();
            if (lowerCaseUrl.startsWith("http:")){
                return url.substring(5);
            }else if(lowerCaseUrl.startsWith("https:")) {
                return url.substring(6);
            }else{
                return url;
            }
        }
    }
}


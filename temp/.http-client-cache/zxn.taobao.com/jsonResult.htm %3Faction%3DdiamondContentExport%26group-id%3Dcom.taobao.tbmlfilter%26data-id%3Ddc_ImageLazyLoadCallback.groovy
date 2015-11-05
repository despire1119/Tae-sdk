

import com.taobao.designcenter.client.htmlFilterExtend.ImageUtil
import com.taobao.designcenter.client.util.shop.ShopTools
import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

/**
 * 延迟加载
 *
 * @author wanjian 2012.07.03 for shifang
 */
public class dc_ImageLazyLoadCallback implements AttributeCallback {

    private static final Log logger = LogFactory.getLog("TBMLFilter");
    private static final String TB_BLACK_URL = "dc-tbml-filter-tbBlackUrl.txt"
    private static final DiamondFile TbUrl = new DiamondFile(TB_BLACK_URL)
    private static String cacheBlack
    private static Map blackMap

    /**
     * 将相对URL路径映射成为图片服务器地址
     */
    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            if (!value.startsWith("http://")) {
                value = ImageUtil.getRealPath(filter, value);
            }
            String blackUrl = TbUrl.getConfigContent()
            if (cacheBlack == null || blackMap == null || !blackUrl.equals(cacheBlack)) {
                cacheBlack = blackUrl
                blackMap = Common_ImageLazyLoadUtil_21.getUrlMap(blackUrl)
            }
            value = Common_ImageLazyLoadUtil_21.filter(blackMap, value);
        } catch (Exception e) {
            logger.error(e)
        }
        if (value.startsWith("http://") && !value.equals(KS_PIC)) {
            attributes = filter.getContextMap();
            if (attributes != null && "true".equals(attributes.get("shopsystemApp"))) {
                StringBuilder sb = new StringBuilder();
                sb.append(TBMLFilter.RICHTEXT_KEYCHAR).append(KS_PIC);
                String src2 = ShopTools.getQ75Src(value);
                if (src2 != null) {
                    sb.append("\" ").append("src2=\"").append(src2);
                }
                String ww = dealWW(value, attributes);
                if (ww != null) {
                    sb.append("\" ").append(ww);
                } else {
                    sb.append("\" data-ks-lazyload=\"").append(value);
                }
                return sb.toString();
            }
            if (attributes != null && "1".equals(attributes.get(LAZY_IMG))) {
                StringBuffer sb = new StringBuffer();
                sb.append(TBMLFilter.RICHTEXT_KEYCHAR).append(KS_PIC).append("\"").append(" ").append("data-ks-lazyload=\"").append(value);
                value = sb.toString();
            }
        }
        return value;
    }

    private String dealWW(String src, Map<String, String> attributes) {
        if (src != null && (src.contains("/online.aw") || src.contains("/realonline.aw")) && attributes.get("moduleInstanceId") != null) {
            StringBuilder sb = new StringBuilder();
            Map<String, String> params = getParams(src);
            if (params.containsKey("uid")) {
                String nick = params.get("uid");
                String charset = params.get("charset");
                if (StringUtils.isBlank(charset) || "gbk".equalsIgnoreCase(charset)) {
                    try {
                        nick = URLEncoder.encode(URLDecoder.decode(nick, "gbk"), "utf-8");
                    } catch (UnsupportedEncodingException e) {
                    }
                }
                String nicks = attributes.get("nicks");
                if (nicks == null) {
                    nicks = nick;
                } else {
                    nicks = nicks + ";" + nick;
                }
                attributes.put("nicks", nicks);
                String s = stypeStyle.containsKey(params.get("s")) ? params.get("s") : "1";
                sb.append("id=\"").append("wwuid-").append(attributes.get("moduleInstanceId")).append("-").append(nicks.split(";").length).append("\" stype=\"").append(s);
                return sb.toString();
            }
        }
        return null;
    }

    public final static Map<String, String> stypeStyle = new HashMap<String, String>();
    static {
        stypeStyle.put("1", "width:77px;hight:19px");
        stypeStyle.put("2", "width:16px;hight:16px");
        stypeStyle.put("4", "width:80px;hight:20px");
    }

    private static Map<String, String> getParams(String url) {
        Map<String, String> params = new HashMap<String, String>();
        String ps = url.split("\\?")[1];
        String[] v = ps.split("&(amp;)?");// & || &amp;
        for (String p : v) {
            String[] v1 = p.split("=");
            if (v1.length == 2) {
                params.put(v1[0], v1[1]);
            }
        }
        return params;
    }

    private final static String KS_PIC = "http://a.tbcdn.cn/s.gif";

    public final static String LAZY_IMG = "lazyImg";
}


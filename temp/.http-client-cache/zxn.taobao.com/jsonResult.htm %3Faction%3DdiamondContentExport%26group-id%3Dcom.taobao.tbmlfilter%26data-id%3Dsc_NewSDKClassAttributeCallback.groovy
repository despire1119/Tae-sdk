

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Pattern

public class sc_NewSDKClassAttributeCallback implements AttributeCallback {
    private static final Log logger = LogFactory.getLog("TBMLFilter");

    private static final String TB_BLACK_CLASS = "sc-new-sdk-blackClass.txt"
    private static final String TB_WHITE_CLASS = "sc-new-sdk-whiteClass.txt"
    private static final DiamondFile blackClass = new DiamondFile(TB_BLACK_CLASS)
    private static final DiamondFile whiteClass = new DiamondFile(TB_WHITE_CLASS)
    //�߻����߼�
    private static Pattern blackPattern
    private static String cacheBlack
    private static List<String> whiteList
    private static String cacheWhite

    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            attributes = filter.getContextMap()
            def black = blackClass.getConfigContent()
            def white = whiteClass.getConfigContent()
            if (cacheBlack == null || blackPattern == null || !cacheBlack.equals(black)) {
                cacheBlack = black
                blackPattern = Common_ClassUtil_22.getClassPattern(black)
            }
            if (cacheWhite == null || cacheWhite == null || !cacheWhite.equals(white)) {
                cacheWhite = white
                whiteList = Common_ClassUtil_22.getWhite(white)
            }
            if(value.contains("cloud-footer")){
                logger.error("sc_NewSDKClassAttributeCallback.cloud-footer="+value)
            }
            return Common_ClassUtil_22.filter(blackPattern, whiteList, value, attributes)
        } catch (e) {
            logger.error("sc_NewSDKClassAttributeCallback,TBMLFilterException,",e)
        }
        return value
    }
}


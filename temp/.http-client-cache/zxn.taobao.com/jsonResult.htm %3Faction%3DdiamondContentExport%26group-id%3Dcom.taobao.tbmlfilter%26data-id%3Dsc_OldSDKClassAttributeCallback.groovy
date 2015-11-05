

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Pattern

public class sc_OldSDKClassAttributeCallback implements AttributeCallback {
    private static final Log logger = LogFactory.getLog("TBMLFilter");

    private static final String TB_BLACK_CLASS = "sc-sdk-old-blackClass.txt"
    private static final DiamondFile TbClass = new DiamondFile(TB_BLACK_CLASS)
    //×ß»º´æÂß¼­
    private static Pattern blackPattern
    private static String cacheBlack

    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            attributes = filter.getContextMap()
            def blackClass = TbClass.getConfigContent()
            if (cacheBlack == null || blackPattern == null || !cacheBlack.equals(blackClass)) {
                cacheBlack = blackClass
                blackPattern = Common_ClassUtil_22.getClassPattern(blackClass)
            }

            def filterResult = Common_ClassUtil_22.filter(blackPattern, value, attributes)
            return filterResult
        } catch (e) {
            logger.error("sc_OldSDKClassAttributeCallback,TBMLFilterException,",e)
        }
        return value
    }
}


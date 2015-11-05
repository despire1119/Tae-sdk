

import com.taobao.top.tbml.attribute.AttributeCallback
import com.taobao.top.tbml.config.DiamondFile
import com.taobao.top.tbml.filter.TBMLFilter
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory

import java.util.regex.Pattern

public class ss_Old_SDKClassAttributeCallback implements AttributeCallback {

    private static final Log logger = LogFactory.getLog("TBMLFilter");
    private static final String TB_BLACK_CLASS = "ss-old-sdkBlackClass.txt"
    private static final DiamondFile TbClass = new DiamondFile(TB_BLACK_CLASS)
    //×ß»º´æÂß¼­
    private static Pattern blackPattern
    private static String cacheBlack

    public String filterValue(TBMLFilter filter, String value, Map<String, String> attributes) {
        try {
            attributes = filter.getContextMap();
            def blackClass = TbClass.getConfigContent()
            if (cacheBlack == null || blackPattern == null || !cacheBlack.equals(blackClass)) {
                cacheBlack = blackClass
                blackPattern = Common_ClassUtil_22.getClassPattern(blackClass)
            }
            return Common_ClassUtil_22.filter(blackPattern, value, attributes)
        } catch (e) {
            logger.error("ss_Old_SDKClassAttributeCallback,TBMLFilterException,",e)
        }
        return value
    }
}


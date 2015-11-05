

import com.taobao.security.util.SecurityUtil
import groovy.json.JsonException
import groovy.json.JsonOutput
import groovy.json.JsonSlurper
import org.apache.commons.lang.StringUtils
import org.apache.commons.logging.Log
import org.apache.commons.logging.LogFactory
import com.taobao.top.tbml.filter.TBMLFilter


public class Common_ActiveTriggerClsUtil {
    private final static Log logger = LogFactory.getLog("TBMLFilter");
    static final String targetKey = "activeTriggerCls"
    static final String disableBtnCls = "disableBtnCls";
    static final def targetKeyList = ["activeTriggerCls","disableBtnCls"]

    public static Map getConfigMap(String rawContent) {
        def map = [:]
        try{
            if (StringUtils.isNotBlank(rawContent)) {
                rawContent = rawContent.trim()
                def tempContent = SecurityUtil.unescapeHtml(rawContent)
                if (rawContent.contains(targetKey) || tempContent.contains(targetKey)
                    || rawContent.contains(disableBtnCls) || tempContent.contains(disableBtnCls)) {
                    //正常的走html entity 解码aaa
                    rawContent = SecurityUtil.unescapeHtml(rawContent)
                    rawContent = rawContent.replace("'", '"')
                    map = new JsonSlurper().parseText(rawContent)
                    //特殊处理含有点号的kissy容错情况,在这里统一判断就不需要再黑名单中写2遍样式了
                    for(def target : targetKeyList){
                        map= filterSpecialList(map,target,rawContent,null)
                    }
                }else if(tempContent.contains("&#")){
                    logger.error("Common_ActiveTriggerClsUtil,tempContent.contains&#,content="+rawContent)
                    map.put("exception","true")
                }

                if(tempContent.contains("&#")){
                    logger.error("Common_ActiveTriggerClsUtil,tempContent.contains&#123:"+tempContent)
                    map.put("exception","true")
                }
            }
        }catch (JsonException jsone){
            logger.error("Common_ActiveTriggerClsUtil,jsonException,content="+rawContent)
            map.put("exception","true")
        }catch(e){
            logger.error("Common_ActiveTriggerClsUtil,TBMLFilterException,",e)
        }
        return map
    }

    private static def filterSpecialList(def map,def target,def rawContent,TBMLFilter filter){
        if(map != null && map.containsKey(target)){
            def value = map.get(target)
            value = filterSpecialChar(value)
            map.put(target,value)
        }else if(map != null && map.size() > 0){
            def userId = ""
            if(filter != null){
                Map<String, Object> context = filter.getContextMap();
                if(context != null){
                    userId = context.get("userId")
                }
            }

            map.each {it ->
                if(it.value.toString().contains("&#")){
                    map.put(it.key,"")
                    logger.error("ActiveTriggerCls.attributes.combineRemove,value="+rawContent+",userId="+userId)
                }
            }
        }

        return map
    }

    private static String filterSpecialChar(def value){
        if(StringUtils.isNotBlank(value) && value.indexOf(".") != -1){
            value = StringUtils.replace(value,".","")
        }
        value = value.replaceAll("[\u1680|\u180e|\u000C|\u0020|\u00A0|\uFEFF|\u2028|\u2029|\u2000|\u2001|\u2002|\u2003|\u2004|\u2005|\u2006|\u2007|\u2008|\u2009|\u200a|\u200b|\u2028|\u2029|\u3000|\u202f|\u205f]"," ")

        if(value.contains("&#")){
            logger.error("Common_ActiveTriggerClsUtil,htmlEntityEncode="+value)
            value = value.replace("&#","")
        }
        return value;
    }

    public static String getString(map) {
        String content = JsonOutput.toJson(map)
        return content.replace('"', "'")
    }

    public static Map getConfigMapWithFilter(String rawContent,TBMLFilter filter) {
        def map = [:]
        try{
            if (StringUtils.isNotBlank(rawContent)) {
                rawContent = rawContent.trim()
                def tempContent = SecurityUtil.unescapeHtml(rawContent)
                if (rawContent.contains(targetKey) || tempContent.contains(targetKey)
                        || rawContent.contains(disableBtnCls) || tempContent.contains(disableBtnCls)) {
                    //正常的走html entity 解码aaa
                    rawContent = SecurityUtil.unescapeHtml(rawContent)
                    rawContent = rawContent.replace("'", '"')
                    map = new JsonSlurper().parseText(rawContent)
                    //特殊处理含有点号的kissy容错情况,在这里统一判断就不需要再黑名单中写2遍样式了
                    for(def target : targetKeyList){
                        map= filterSpecialList(map,target,rawContent,filter)
                    }
                }else if(tempContent.contains("&#")){
                    logger.error("Common_ActiveTriggerClsUtil,tempContent.contains&#,content="+rawContent)
                    map.put("exception","true")
                }

                if(tempContent.contains("&#")){
                    logger.error("Common_ActiveTriggerClsUtil,tempContent.contains&#123:"+tempContent)
                    map.put("exception","true")
                }

            }
        }catch (JsonException jsone){
            logger.error("Common_ActiveTriggerClsUtil,jsonException,content="+rawContent)
            map.put("exception","true")
        }catch(e){
            logger.error("Common_ActiveTriggerClsUtil,TBMLFilterException,",e)
        }
        return map
    }
}


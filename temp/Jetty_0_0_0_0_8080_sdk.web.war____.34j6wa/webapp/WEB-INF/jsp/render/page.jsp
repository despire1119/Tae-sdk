<c:choose>
    <c:when test="${siteLayout.siteID > 1000}">
        <jsp:directive.include file="/WEB-INF/jsp/microdesign/commons-variables.jspf" />
    </c:when>
    <c:otherwise>
        <jsp:directive.include file="/WEB-INF/jsp/design/commons-variables.jspf" />
    </c:otherwise>
</c:choose>
<!DOCTYPE html>
<html>
<!-- \${siteLayout.siteID} == siteLayout.siteID -->
<c:choose>
    <c:when test="${siteLayout.siteID eq '3'}">
        <jsp:directive.include file="/WEB-INF/jsp/render/tmall/head.jspf"/>
        <jsp:directive.include file="/WEB-INF/jsp/render/tmall/body.jspf"/>
    </c:when>
    <c:when test="${siteLayout.siteID eq '66'}">
        <jsp:directive.include file="/WEB-INF/jsp/render/tmallbrand/head.jspf"/>
        <jsp:directive.include file="/WEB-INF/jsp/render/tmallbrand/body.jspf"/>
    </c:when>
    <c:when test="${siteLayout.siteID > 1000}">
        <jsp:directive.include file="/WEB-INF/jsp/render/microshop/head.jspf"/>
        <jsp:directive.include file="/WEB-INF/jsp/render/microshop/body.jspf"/>
    </c:when>
    <c:when test="${siteLayout.siteID eq '60'}">
        <jsp:directive.include file="/WEB-INF/jsp/render/uz/head.jspf"/>
        <jsp:directive.include file="/WEB-INF/jsp/render/uz/body.jspf"/>
    </c:when>
    <c:otherwise>
        <jsp:directive.include file="/WEB-INF/jsp/render/default/head.jspf"/>
        <jsp:directive.include file="/WEB-INF/jsp/render/default/body.jspf"/>
    </c:otherwise>
</c:choose>

<%--
    此处为何使用硬编码？
    1.由于每个站点的页面渲染方式是有限的
    2.如果采用类似于：head-${siteLayout.siteID}.jspf的方式，如果站点对应的页面没有找到的话，会报错，因此采用以上写法。
--%>
</html>
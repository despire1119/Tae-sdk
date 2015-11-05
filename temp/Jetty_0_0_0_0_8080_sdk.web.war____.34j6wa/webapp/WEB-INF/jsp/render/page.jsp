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
    �˴�Ϊ��ʹ��Ӳ���룿
    1.����ÿ��վ���ҳ����Ⱦ��ʽ�����޵�
    2.������������ڣ�head-${siteLayout.siteID}.jspf�ķ�ʽ�����վ���Ӧ��ҳ��û���ҵ��Ļ����ᱨ����˲�������д����
--%>
</html>
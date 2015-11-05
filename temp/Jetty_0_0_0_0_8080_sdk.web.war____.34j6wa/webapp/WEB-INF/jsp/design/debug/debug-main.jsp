<!doctype html>
<html>
	<head>
        <c:choose>
            <c:when test="${siteLayout.siteID eq '60'}">
                <jsp:directive.include file="/WEB-INF/jsp/design/debug/uz/debug-header.jspf" />
            </c:when>
            <c:otherwise>
                <jsp:directive.include file="/WEB-INF/jsp/design/debug/debug-header.jspf" />
            </c:otherwise>
        </c:choose>
	</head>
	<body>
		<input type="hidden" id="J_TSelectedMenuInfo" value='{"selectedMenu":{"pageId":"189106", "catId": "" , "linkId":""}}'>
        <c:choose>
            <c:when test="${siteLayout.siteID eq '60'}">
                <jsp:directive.include file="/WEB-INF/jsp/design/debug/uz/page.jspf" />
            </c:when>
            <c:otherwise>
                <jsp:directive.include file="/WEB-INF/jsp/design/page.jspf" />
            </c:otherwise>
        </c:choose>

	</body>

    <c:choose>
        <c:when test="${siteLayout.siteID eq '60'}">
            <jsp:directive.include file="/WEB-INF/jsp/design/debug/uz/debug-js.jspf" />
        </c:when>
        <c:otherwise>
            <jsp:directive.include file="/WEB-INF/jsp/design/debug/debug-js.jspf" />
        </c:otherwise>
    </c:choose>


</html>
<jsp:directive.include file="/WEB-INF/jsp/design/commons-variables.jspf" />
<!doctype html>
<html>
<head>
    <c:choose>
        <c:when test="${siteLayout.siteID eq '60'}">
            <jsp:directive.include file="/WEB-INF/jsp/design/layout/uz/layout-header.jspf" />
        </c:when>
        <c:otherwise>
            <jsp:directive.include file="/WEB-INF/jsp/design/layout/layout-header.jspf" />
        </c:otherwise>
    </c:choose>
</head>
<body>
    <c:choose>
        <c:when test="${siteLayout.siteID eq '60'}">
            <jsp:directive.include file="/WEB-INF/jsp/design/debug/uz/page.jspf" />
        </c:when>
        <c:otherwise>
            <jsp:directive.include file="/WEB-INF/jsp/design/page.jspf" />
        </c:otherwise>
    </c:choose>

	<jsp:directive.include file="/WEB-INF/jsp/design/layout/layout-list.jspf" />
	<textarea id="J_TAddMods" class="tb-hidden">
		<jsp:directive.include file="/WEB-INF/jsp/design/module-list.jspf" />
	</textarea>
</body>
<c:choose>
    <c:when test="${siteLayout.siteID eq '60'}">
        <jsp:directive.include file="/WEB-INF/jsp/design/layout/uz/layout-footer.jspf" />
    </c:when>
    <c:otherwise>
        <jsp:directive.include file="/WEB-INF/jsp/design/layout/layout-footer.jspf" />
    </c:otherwise>
</c:choose>
</html>

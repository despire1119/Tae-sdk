<!DOCTYPE html>
<html>

<c:choose>
    <c:when test="${isTaeModule}">
        <jsp:directive.include file="/WEB-INF/jsp/render/default/tae-module-head.jspf" />
    </c:when>
    <c:when test="${isUZSysModule}">
        <jsp:directive.include file="/WEB-INF/jsp/render/uz/head.jspf" />
    </c:when>
    <c:otherwise>
        <jsp:directive.include file="/WEB-INF/jsp/render/default/head.jspf" />
    </c:otherwise>
</c:choose>


<body>
	<div id="page">
		<div id="content">
		    <jsp:directive.include file="/WEB-INF/jsp/render/common/module-part.jspf" />
		</div>
	</div>
</body>

<c:if test="${not empty localModulesCombinedJsURL}">
		<script type="text/javascript">
            KISSY.use('core', function(){
            KISSY.getScript('http://${assetsHost}/apps/taesite/balcony/tools/single_module/adapter-node-min.js?d=3', function(){
                  KISSY.getScript('${localModulesCombinedJsURL}');
               })
            });
        </script>
</c:if>
<jsp:directive.include file="/WEB-INF/jsp/prelude/caja-js.jspf"/>
<!-- Ä£¿éID£º${moduleTemplate.id} -->
</html>
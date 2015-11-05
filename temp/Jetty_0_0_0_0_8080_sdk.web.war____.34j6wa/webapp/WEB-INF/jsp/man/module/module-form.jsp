<c:set var="isSystemModule" value="${moduleForm.type eq 1}" />
<c:set var="isLocalModule" value="${moduleForm.type eq 2}"  />
<c:set var="moduleTypeLabel" value="${isSystemModule ? '系统':'设计师' }" />

<section class="content create-module"> <article class="box">
<div class="title">
	<h2>
		<c:set var="operationLabel" value="${editMode ? '编辑':'创建' }" />
		${operationLabel}${moduleTypeLabel}模块
	</h2>
</div>

    <!-- ${currentMangerNavigationView.matchURIPrefix} -->
<form:form action="${currentMangerNavigationView.matchURIPrefix}module/submit/${templateDirectoryName}/${editMode}" method="POST" commandName="moduleForm">

	<c:set var="lmie" value="${requestScope['local.module.id.error']}" />
	<c:if test="${lmie ne null}">
		<c:set var="lmieSN" value="error" />
	</c:if>

	<c:set var="lmne" value="${requestScope['local.module.name.error']}" />
	<c:if test="${lmne  ne null}">
		<c:set var="lmneSN" value="error" />
	</c:if>

	<c:set var="err" value="error"/>
	<c:set var="jmne" value="${requestScope['js.module.num.error']}" />
	<c:if test="${jmne ne null}">
		<c:set var="jmneSN" value="error"/>
	</c:if>
	
	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-type-controll.jspf" />
	
	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-id-controll.jspf" />
	
	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-name-controll.jspf" />

	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-jsandless-controll.jspf" />

	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-included-app-controll.jspf" />

	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-app-key-controll.jspf" />
	
	<c:if test="${isLocalModule}">
		<jsp:directive.include file="/WEB-INF/jsp/man/module/module-layout-controll.jspf" />
	</c:if>
	
	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-thumbnail-controll.jspf" />
	
	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-description-controll.jspf" />
	
	<jsp:directive.include file="/WEB-INF/jsp/man/module/module-submit-controll.jspf" />
</form:form> 
</article> 
</section>


<!-- 引用尾部JS -->
<jsp:directive.include file="/WEB-INF/jsp/coda/commons-footer-js.jspf" />

<!--   部署到fed的地址个地址 -->
<script type="text/javascript">
	KISSY.use('scripts/sdk/create-module/init');
</script>
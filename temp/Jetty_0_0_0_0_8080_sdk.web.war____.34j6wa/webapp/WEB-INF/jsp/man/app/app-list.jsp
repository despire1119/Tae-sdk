<section class="content"> <article class="box">

<div class="title">
	<h2>我的应用</h2>
	<a href="/man/app/form/" class="radius-btn">
	    <i class="icon-plus"></i>添加新应用
	</a>
</div>
<div class="lists" id="J_lists">
	<c:forEach items="${currentPageItemsList}" var="app">
	    <c:set var="appName" value="${app.name}" />
	    <c:set var="appRootURL" value="http://${appName}.taobaoapps.net:${serverPort}" />
		<dl class="item">
			<dt class="image">
				<c:set var="thumbnail" value="${app.thumbnail}" />
				<c:if test="${not fn:startsWith(thumbnail,'http')}">
					<c:set var="thumbnail" value="${appRootURL}/${thumbnail}" />
				</c:if>
				<a href="/man/app/page/${appName}/">
				    <img src="${thumbnail}" />
				</a>
			</dt>
			<dd class="desc">
				<p class="name">${appName}</p>
				<p class="time">最后编辑时间：${app.lastModifiedDate}</p>
			</dd>
			<dd class="control">
				<a href="${appRootURL}" class="btn">预览</a>
			</dd>
		</dl>
	</c:forEach>
</div>

<c:set var="paginationURIPrefix" value="/man/app/list" />
<jsp:directive.include file="/WEB-INF/jsp/man/commons/pagination.jspf" />
</article>
</section>
<!-- 引用尾部JS -->
<jsp:directive.include file="/WEB-INF/jsp/coda/commons-footer-js.jspf" />

<!--   部署到fed的地址个地址 -->
<script type="text/javascript">
	KISSY.use('scripts/sdk/list/init');
</script>

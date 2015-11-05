<section class="content"> <article class="box">

<div class="title">
	<h2>�ҵ�Ӧ��</h2>
	<a href="/man/app/form/" class="radius-btn">
	    <i class="icon-plus"></i>�����Ӧ��
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
				<p class="time">���༭ʱ�䣺${app.lastModifiedDate}</p>
			</dd>
			<dd class="control">
				<a href="${appRootURL}" class="btn">Ԥ��</a>
			</dd>
		</dl>
	</c:forEach>
</div>

<c:set var="paginationURIPrefix" value="/man/app/list" />
<jsp:directive.include file="/WEB-INF/jsp/man/commons/pagination.jspf" />
</article>
</section>
<!-- ����β��JS -->
<jsp:directive.include file="/WEB-INF/jsp/coda/commons-footer-js.jspf" />

<!--   ����fed�ĵ�ַ����ַ -->
<script type="text/javascript">
	KISSY.use('scripts/sdk/list/init');
</script>

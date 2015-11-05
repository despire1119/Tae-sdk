<section class="content"> <article class="box">
<div class="title">
	<h2>我的微模板</h2>
	<a href="/man/microtemplate/form" class="radius-btn">
	    <i class="icon-plus"></i> 添加新模板
	</a>
</div>
<div class="lists" id="J_lists">
	<c:forEach items="${currentPageItemsList}" var="template">
		<dl class="item">
			<dt class="image">
				<c:set var="thumbnail" value="${template.thumbnail}" />
				<c:if test="${not fn:startsWith(thumbnail,'http')}">
					<c:set var="thumbnail"
						value="/${template.directoryName}/${template.thumbnail}" />
				</c:if>
				<a href="/man/microtemplate/layout/${template.directoryName}"> <img
					src="${thumbnail}" /> </a>
			</dt>
			<dd class="desc">
				<p class="name">${template.applySites}/${template.name}</p>
				<p class="time">最后编辑时间：${template.lastModifiedDate}</p>
			</dd>
			<dd class="control">

				<a href="/htdocs/${template.directoryName}" class="btn">预览</a>
			</dd>
		</dl>
	</c:forEach>
</div>

<c:set var="paginationURIPrefix" value="/man/template/list" />
<jsp:directive.include file="/WEB-INF/jsp/man/commons/pagination.jspf" />
</article>
</section>
<!-- 引用尾部JS -->
<jsp:directive.include file="/WEB-INF/jsp/coda/commons-footer-js.jspf" />

<!--   部署到fed的地址个地址 -->
<script type="text/javascript">
	KISSY.use('scripts/sdk/list/init');
</script>

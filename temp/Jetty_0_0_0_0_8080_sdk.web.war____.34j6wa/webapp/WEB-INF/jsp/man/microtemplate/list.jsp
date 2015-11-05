<section class="content"> <article class="box">
<div class="title">
	<h2>�ҵ�΢ģ��</h2>
	<a href="/man/microtemplate/form" class="radius-btn">
	    <i class="icon-plus"></i> �����ģ��
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
				<p class="time">���༭ʱ�䣺${template.lastModifiedDate}</p>
			</dd>
			<dd class="control">

				<a href="/htdocs/${template.directoryName}" class="btn">Ԥ��</a>
			</dd>
		</dl>
	</c:forEach>
</div>

<c:set var="paginationURIPrefix" value="/man/template/list" />
<jsp:directive.include file="/WEB-INF/jsp/man/commons/pagination.jspf" />
</article>
</section>
<!-- ����β��JS -->
<jsp:directive.include file="/WEB-INF/jsp/coda/commons-footer-js.jspf" />

<!--   ����fed�ĵ�ַ����ַ -->
<script type="text/javascript">
	KISSY.use('scripts/sdk/list/init');
</script>

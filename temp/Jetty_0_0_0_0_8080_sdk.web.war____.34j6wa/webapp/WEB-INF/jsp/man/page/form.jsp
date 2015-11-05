<section class="content create-page"> <article class="box">
<div class="title">
	<h2>
		<c:choose>
			<c:when test="${editMode}">
					编辑
				</c:when>
			<c:otherwise>
					创建
				</c:otherwise>
		</c:choose>
		页面
	</h2>
</div>

<!-- ${currentMangerNavigationView.matchURIPrefix} -->
<form:form method="POST"
	action="${currentMangerNavigationView.matchURIPrefix}page/submit/${templateDirectoryName}/${editMode}/"
	commandName="pageForm">
	<c:set var="pne" value="${requestScope['page.name.error']}" />
	<c:if test="${not empty pne}">
		<c:set var="pneSN" value="error" />
	</c:if>

	<c:set var="fne" value="${requestScope['file.name.error']}" />
	<c:if test="${not empty fne}">
		<c:set var="fneSN" value="error" />
	</c:if>

	<c:set var="pte" value="${requestScope['page.type.error']}" />
	<c:if test="${not empty pte}">
		<c:set var="pteSN" value="error" />
	</c:if>

	<div class="form-group ${pneSN}">
		<label class="form-label">页面名称:</label>
		<div class="form-controls">
			<form:input path="name" cssClass="form-text" />
			<span class="help-inline"> 最长8个中文；表达页面用途，便于卖家识别页面用途 （必填）</span>
		</div>
	</div>

	<div class="form-group ${fneSN}">
		<label class="form-label">页面文件名:</label>
		<div class="form-controls">
			<c:if test="${editMode}">
					<c:set var="disableClass" value="disable" />
					<c:set var="disabled" value="true" />
					<form:hidden path="fileName"/>
			</c:if>
			<form:input path="fileName" cssClass="form-text ${disableClass}"  disabled="${disabled}"/>
			<span class="help-inline"> 必须用".json"为文件扩展名，不支持中文（
				必填，只允许使用英文、数字、横线"-"和下划线"_"的组合）${fne}</span>
		</div>
	</div>

	<div class="form-group  ${not empty thumbnailBlankError ? 'error':'' }">
		<label class="form-label">页面缩略图:</label>
		<div class="form-controls">
			<form:input path="thumbnail" cssClass="form-text" />
			<span class="help-inline"> 180x120，请填写图片相对（模板）路径，如：assets/images/xxx.jpg，仅支持png、jpg和gif格式（必填）</span>
		</div>
	</div>

	<div class="form-group ${pteSN}">
		<label class="form-label">页面类型:</label>
		<div class="form-controls">
			<c:if test="${editMode}">
					<c:set var="disableClass" value="disable" />
					<c:set var="disabled" value="true" />
					<form:hidden path="type"/>
			</c:if>
			<form:select path="type" items="${pageTypesMap}" cssClass="select ${disableClass}" disabled="${disabled}"/>
		</div>
		<span class="help-inline">${pte}</span>
	</div>

	<div class="form-group">
		<label class="form-label">页面描述:</label>
		<div class="form-controls">
			<form:textarea path="description" />
		</div>
	</div>

	<div class="form-group actions">
		<input type="submit" value="保存" class="btn"> 
		<a href="${currentMangerNavigationView.matchURIPrefix}layout/${templateDirectoryName}/">取消</a>
	</div>
</form:form> </article> </section>
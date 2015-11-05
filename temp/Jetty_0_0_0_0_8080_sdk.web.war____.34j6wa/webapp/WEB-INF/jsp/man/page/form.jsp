<section class="content create-page"> <article class="box">
<div class="title">
	<h2>
		<c:choose>
			<c:when test="${editMode}">
					�༭
				</c:when>
			<c:otherwise>
					����
				</c:otherwise>
		</c:choose>
		ҳ��
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
		<label class="form-label">ҳ������:</label>
		<div class="form-controls">
			<form:input path="name" cssClass="form-text" />
			<span class="help-inline"> �8�����ģ����ҳ����;����������ʶ��ҳ����; �����</span>
		</div>
	</div>

	<div class="form-group ${fneSN}">
		<label class="form-label">ҳ���ļ���:</label>
		<div class="form-controls">
			<c:if test="${editMode}">
					<c:set var="disableClass" value="disable" />
					<c:set var="disabled" value="true" />
					<form:hidden path="fileName"/>
			</c:if>
			<form:input path="fileName" cssClass="form-text ${disableClass}"  disabled="${disabled}"/>
			<span class="help-inline"> ������".json"Ϊ�ļ���չ������֧�����ģ�
				���ֻ����ʹ��Ӣ�ġ����֡�����"-"���»���"_"����ϣ�${fne}</span>
		</div>
	</div>

	<div class="form-group  ${not empty thumbnailBlankError ? 'error':'' }">
		<label class="form-label">ҳ������ͼ:</label>
		<div class="form-controls">
			<form:input path="thumbnail" cssClass="form-text" />
			<span class="help-inline"> 180x120������дͼƬ��ԣ�ģ�壩·�����磺assets/images/xxx.jpg����֧��png��jpg��gif��ʽ�����</span>
		</div>
	</div>

	<div class="form-group ${pteSN}">
		<label class="form-label">ҳ������:</label>
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
		<label class="form-label">ҳ������:</label>
		<div class="form-controls">
			<form:textarea path="description" />
		</div>
	</div>

	<div class="form-group actions">
		<input type="submit" value="����" class="btn"> 
		<a href="${currentMangerNavigationView.matchURIPrefix}layout/${templateDirectoryName}/">ȡ��</a>
	</div>
</form:form> </article> </section>
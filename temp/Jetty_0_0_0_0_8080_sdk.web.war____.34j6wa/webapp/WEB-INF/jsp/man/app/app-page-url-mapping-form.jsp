<%-- Appҳ��URLӳ���ҳ�� --%>
<section class="content create-template"> <article class="box">
<div class="title">
	<h2>${editMode ? "�༭" : "����"}ҳ��URLӳ��</h2>
</div>
<form:form action="/man/app/page/url/mapping/save/${appName}/${editMode}/" commandName="urlItem">

    <div class="form-group ${tdmeSN}">
        <c:if test="${editMode}">
            <c:set var="disableClass" value="disable" />
            <c:set var="disabled" value="true" />
            <form:hidden path="url"/>
		</c:if>
        <label class="form-label">URLӳ��:</label>
        <div class="form-controls">
    			<form:input path="url" cssClass="form-text ${disableClass}" disabled="${disabled}" />
    			<span class="help-inline"> * �������գ�URLӳ�����REST���</span>
        </div>
    </div>

	<div class="form-group ${tdmeSN}">
		<label class="form-label">PHPҳ���ļ�·��:</label>
		<div class="form-controls">
			<form:select path="handler" cssClass="select font" items="${handlersList}" />
			<span class="help-inline"> ·�������Ӧ�ø�Ŀ¼</span>
		</div>
	</div>

	<div class="form-group actions">
		<input type="submit" value="${editMode ? '����' : '����' }" class="btn" /> <a href="/">ȡ��</a>
	</div>
</form:form> </article> </section>

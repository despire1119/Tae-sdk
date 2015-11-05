<%-- App页面URL映射表单页面 --%>
<section class="content create-template"> <article class="box">
<div class="title">
	<h2>${editMode ? "编辑" : "创建"}页面URL映射</h2>
</div>
<form:form action="/man/app/page/url/mapping/save/${appName}/${editMode}/" commandName="urlItem">

    <div class="form-group ${tdmeSN}">
        <c:if test="${editMode}">
            <c:set var="disableClass" value="disable" />
            <c:set var="disabled" value="true" />
            <form:hidden path="url"/>
		</c:if>
        <label class="form-label">URL映射:</label>
        <div class="form-controls">
    			<form:input path="url" cssClass="form-text ${disableClass}" disabled="${disabled}" />
    			<span class="help-inline"> * 不能留空，URL映射采用REST风格</span>
        </div>
    </div>

	<div class="form-group ${tdmeSN}">
		<label class="form-label">PHP页面文件路径:</label>
		<div class="form-controls">
			<form:select path="handler" cssClass="select font" items="${handlersList}" />
			<span class="help-inline"> 路径相对于应用根目录</span>
		</div>
	</div>

	<div class="form-group actions">
		<input type="submit" value="${editMode ? '更新' : '创建' }" class="btn" /> <a href="/">取消</a>
	</div>
</form:form> </article> </section>

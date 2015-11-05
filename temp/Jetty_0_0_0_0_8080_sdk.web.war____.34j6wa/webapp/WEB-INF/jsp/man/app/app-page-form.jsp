<%-- App页面URL映射表单页面 --%>
<section class="content create-template"> <article class="box">
<div class="title">
	<h2>${editMode ? "编辑" : "创建"}页面</h2>
</div>
<form:form action="/man/app/page/save/${appName}/">
	<div class="form-group ${tdmeSN}">
		<label class="form-label">PHP页面文件路径:</label>
		<div class="form-controls">
			<input name="phpFilePath" class="form-text ${disableClass}" />
			<span class="help-inline">  * 不能留空，必须以".php"结尾，路径相对于应用根目录(${appDirectory.absolutePath})</span>
		</div>
	</div>
	<div class="form-group actions">
		<input type="submit" value="${editMode ? '更新' : '创建' }" class="btn" /> <a href="/">取消</a>
	</div>
</form:form> </article> </section>

<%-- Appҳ��URLӳ���ҳ�� --%>
<section class="content create-template"> <article class="box">
<div class="title">
	<h2>${editMode ? "�༭" : "����"}ҳ��</h2>
</div>
<form:form action="/man/app/page/save/${appName}/">
	<div class="form-group ${tdmeSN}">
		<label class="form-label">PHPҳ���ļ�·��:</label>
		<div class="form-controls">
			<input name="phpFilePath" class="form-text ${disableClass}" />
			<span class="help-inline">  * �������գ�������".php"��β��·�������Ӧ�ø�Ŀ¼(${appDirectory.absolutePath})</span>
		</div>
	</div>
	<div class="form-group actions">
		<input type="submit" value="${editMode ? '����' : '����' }" class="btn" /> <a href="/">ȡ��</a>
	</div>
</form:form> </article> </section>

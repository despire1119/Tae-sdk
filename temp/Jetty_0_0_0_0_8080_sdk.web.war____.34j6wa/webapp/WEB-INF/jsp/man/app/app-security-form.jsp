<%-- App URI Ȩ�ޱ�ҳ�� --%>
<section class="content create-template"> <article class="box">
<div class="title">
    <h2>${editMode ? "�༭" : "����"}URIȨ��</h2>
</div>
<form:form action="/man/app/security/save/${appName}/${editMode}/" commandName="securityItem">

    <div class="form-group ${tdmeSN}">
	<c:if test="${editMode}">
            <c:set var="disableClass" value="disable" />
            <c:set var="disabled" value="true" />
            <form:hidden path="url"/>
        </c:if>
	<div class="form-group ${tdmeSN}">
	<label class="form-label">��ȨURL:</label>
		<div class="form-controls">
		    <form:input path="url" cssClass="form-text ${disableClass}" disabled="${disabled}" />
		    <span class="help-inline"> ���������URLΪ"/admin"������"/admin"�ַ�����ͷ��URL�������½�ɫȨ��</span>
		</div>
	    </div>
        
        <label class="form-label">Ȩ�޽�ɫ:</label>
        <div class="form-controls">
	    <form:select path="role" cssClass="select font" items="${rolesMap}" />
        <span class="help-inline"> �� ΪURL���÷���Ȩ�޽�ɫ</span>
        </div>
    </div>

    <div class="form-group actions">
        <input type="submit" value="${editMode ? '����' : '����' }" class="btn" /> <a href="/">ȡ��</a>
    </div>
</form:form> </article> </section>
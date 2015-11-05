<%-- App�����ҳ�� --%>
<section class="content create-template"> <article class="box">
<div class="title">
    <h2>${editMode ? "�༭" : "����"}����</h2>
</div>
<form:form action="/man/app/service/save/${appName}/${editMode}/" commandName="serviceItem">

    <div class="form-group ${tdmeSN}">
        <c:if test="${editMode}">
            <c:set var="disableClass" value="disable" />
            <c:set var="disabled" value="true" />
            <form:hidden path="serviceName"/>
        </c:if>
        <label class="form-label">��������:</label>
        <div class="form-controls">
        <form:input path="serviceName" cssClass="form-text ${disableClass}" disabled="${disabled}" />
        <span class="help-inline"> * ���ֻ����ʹ��Ӣ�ġ����֡�����"-"���»���"_"�����</span>
        </div>
    </div>

    <div class="form-group ${tdmeSN}">
        <label class="form-label">����PHPҳ��:</label>
        <div class="form-controls">
            <form:input path="handler" cssClass="form-text"/>
            <span class="help-inline"> ·�������Ӧ�ø�Ŀ¼</span>
        </div>
    </div>

    <div class="form-group actions">
        <input type="submit" value="${editMode ? '����' : '����' }" class="btn" /> <a href="/">ȡ��</a>
    </div>
</form:form> </article> </section>

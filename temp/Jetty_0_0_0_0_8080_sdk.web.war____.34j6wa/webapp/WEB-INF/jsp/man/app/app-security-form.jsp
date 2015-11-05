<%-- App URI 权限表单页面 --%>
<section class="content create-template"> <article class="box">
<div class="title">
    <h2>${editMode ? "编辑" : "创建"}URI权限</h2>
</div>
<form:form action="/man/app/security/save/${appName}/${editMode}/" commandName="securityItem">

    <div class="form-group ${tdmeSN}">
	<c:if test="${editMode}">
            <c:set var="disableClass" value="disable" />
            <c:set var="disabled" value="true" />
            <form:hidden path="url"/>
        </c:if>
	<div class="form-group ${tdmeSN}">
	<label class="form-label">授权URL:</label>
		<div class="form-controls">
		    <form:input path="url" cssClass="form-text ${disableClass}" disabled="${disabled}" />
		    <span class="help-inline"> ＊必填，例如URL为"/admin"，凡是"/admin"字符串开头的URL皆受以下角色权限</span>
		</div>
	    </div>
        
        <label class="form-label">权限角色:</label>
        <div class="form-controls">
	    <form:select path="role" cssClass="select font" items="${rolesMap}" />
        <span class="help-inline"> ＊ 为URL设置访问权限角色</span>
        </div>
    </div>

    <div class="form-group actions">
        <input type="submit" value="${editMode ? '更新' : '创建' }" class="btn" /> <a href="/">取消</a>
    </div>
</form:form> </article> </section>
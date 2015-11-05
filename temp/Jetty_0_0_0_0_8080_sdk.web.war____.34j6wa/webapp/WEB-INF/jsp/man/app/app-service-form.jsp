<%-- App服务表单页面 --%>
<section class="content create-template"> <article class="box">
<div class="title">
    <h2>${editMode ? "编辑" : "创建"}服务</h2>
</div>
<form:form action="/man/app/service/save/${appName}/${editMode}/" commandName="serviceItem">

    <div class="form-group ${tdmeSN}">
        <c:if test="${editMode}">
            <c:set var="disableClass" value="disable" />
            <c:set var="disabled" value="true" />
            <form:hidden path="serviceName"/>
        </c:if>
        <label class="form-label">服务名称:</label>
        <div class="form-controls">
        <form:input path="serviceName" cssClass="form-text ${disableClass}" disabled="${disabled}" />
        <span class="help-inline"> * 必填，只允许使用英文、数字、横线"-"和下划线"_"的组合</span>
        </div>
    </div>

    <div class="form-group ${tdmeSN}">
        <label class="form-label">服务PHP页面:</label>
        <div class="form-controls">
            <form:input path="handler" cssClass="form-text"/>
            <span class="help-inline"> 路径相对于应用根目录</span>
        </div>
    </div>

    <div class="form-group actions">
        <input type="submit" value="${editMode ? '更新' : '创建' }" class="btn" /> <a href="/">取消</a>
    </div>
</form:form> </article> </section>

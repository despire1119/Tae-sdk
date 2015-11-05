<%-- 页面支持的模块列表规则 --%>
<c:set var="siteID" value="${applySite.id}"/>
<c:choose>
    <c:when test="${pageID==-1}">
        <c:set var="pageName" value="页头"/>
    </c:when>
    <c:when test="${pageID==-2}">
        <c:set var="pageName" value="页尾"/>
    </c:when>
    <c:otherwise>
        <c:set var="pageName" value="${pageRule.pageName}"/>
    </c:otherwise>
</c:choose>

<c:set var="indexHelpURI" value="/help/"/>
<c:set var="designRulesHelpURI" value="${indexHelpURI}design-rules/"/>
<c:set var="siteDesignRulesHelpURI" value="${indexHelpURI}design/rules/${siteID}/"/>
<c:set var="pageSupportedModulesHelpURI" value="${indexHelpURI}design/rules/${siteID}/supported/modules/${pageID}/"/>

<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>装修规则参考文档</h2>
        </div>
    </article>

    <div>当前位置：<a href="${indexHelpURI}">帮助文档</a>
        - <a href="${siteDesignRulesHelpURI}">装修参考规则文档（站点：${applySite.title}）</a>
        - <a href="${pageSupportedModulesHelpURI}">页面支持的模块列表（页面名称：${pageName}）</a>
    </div>
    <p/>

    <div>页面规则切换：
        <a href="${indexHelpURI}design/rules/${siteID}/page/-1/supported/modules/">页头</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="${indexHelpURI}design/rules/${siteID}/page/-2/supported/modules/">页尾</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <c:forEach items="${productRule.pageRules}" var="page">
            <c:set var="uri"
                   value="${indexHelpURI}design/rules/${siteID}/page/${page.pagePrototypeId}/supported/modules/"/>
            <a href="${uri}">${page.pageName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <h3>页面（${pageName}）- 模块列表规则列表</h3>
    <br/>

    <div>
        <table border="1" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <th>模块名称</th>
                <th>模块最大添加数量</th>
                <th>模块支持的宽度</th>
                <th>是否可编辑</th>
                <th>是否可移动</th>
                <th>是否可删除</th>
                <th>是否可重命名</th>
                <th>是否必须出现</th>
                <th>模块预览</th>
            </tr>
            </thead>
            <tbody>

            <c:choose>
                <c:when test="${pageID==-1 or pageID==-2}">
                    <c:set var="moduleRulesMap" value="${pageRule.moduleRuleMap}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="moduleRulesMap" value="${pageRule.moduleRulesMap}"/>
                </c:otherwise>
            </c:choose>

            <c:forEach items="${moduleRulesMap}" var="moduleRuleEntry">
                <c:set var="moduleRule" value="${moduleRuleEntry.value}"/>
                <c:set var="moduleName" value="${moduleRule.moduleName}"/>
                <c:set var="modulePrototypeId" value="${moduleRule.modulePrototypeId}"/>
                <c:set var="systemModule" value="${systemModulesMap[modulePrototypeId]}"/>
                <c:set var="cssSelectorName" value="${systemModule.cssSelectorName}"/>
                <tr>
                    <td>${moduleName}</td>
                    <td>${moduleRule.maxAppend}</td>
                    <td>${moduleRule.supportWidthAsString}</td>
                    <td>${moduleRule.editable  ? "可以": "不能"}</td>
                    <td>${moduleRule.movable  ? "可以": "不能"}</td>
                    <td>${moduleRule.deleteable  ? "可以": "不能"}</td>
                    <td>${moduleRule.renamable  ? "可以": "不能"}</td>
                    <td>${moduleRule.required ? "必须":"可选"}</td>
                    <td><a href="/module/render/system-module/${siteID}/${cssSelectorName}/" target="_blank">点击预览</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <p/>


</section>
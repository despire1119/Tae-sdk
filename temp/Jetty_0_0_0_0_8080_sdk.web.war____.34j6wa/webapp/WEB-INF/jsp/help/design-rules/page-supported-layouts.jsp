<%-- 页面支持的布局列表规则 --%>
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
<c:set var="pageSupportedLayoutsHelpURI" value="${indexHelpURI}design/rules/${siteID}/supported/layouts/${pageID}/"/>

<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>装修规则参考文档</h2>
        </div>
    </article>

    <div>当前位置：<a href="${indexHelpURI}">帮助文档</a>
        - <a href="${siteDesignRulesHelpURI}">装修规则参考文档（站点：${applySite.title}）</a>
        - <a href="${pageSupportedLayoutsHelpURI}">页面支持的布局列表（页面名称：${pageName}）</a>
    </div>
    <p/>

    <div>页面规则切换：
        <a href="${indexHelpURI}design/rules/${siteID}/page/-1/supported/layouts/">页头</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="${indexHelpURI}design/rules/${siteID}/page/-2/supported/layouts/">页尾</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <c:forEach items="${productRule.pageRules}" var="page">
            <c:set var="uri"
                   value="${indexHelpURI}design/rules/${siteID}/page/${page.pagePrototypeId}/supported/layouts/"/>
            <a href="${uri}">${page.pageName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <h3>页面（${pageName}）- 布局列表规则列表</h3>
    <br/>

    <div>
        <table border="1" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <th>布局名称</th>
                <th>布局最大添加模块数量</th>
                <th>布局支持的宽度</th>
                <th>是否必须出现</th>
            </tr>
            </thead>
            <tbody>

            <c:choose>
                <c:when test="${pageID==-1 or pageID==-2}">
                    <c:set var="layoutRulesMap" value="${pageRule.layoutRuleMap}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="layoutRulesMap" value="${pageRule.layoutRulesMap}"/>
                </c:otherwise>
            </c:choose>

            <c:forEach items="${layoutRulesMap}" var="layoutRuleEntry">
                <c:set var="layoutRule" value="${layoutRuleEntry.value}"/>
                <c:set var="layoutName" value="${layoutRule.layoutName}"/>
                <c:set var="actualLayoutName" value="${layoutName}"/>
                <c:choose>
                    <c:when test="${actualLayoutName eq '页首布局' or actualLayoutName eq '尾部布局'}">
                        <c:set var="actualLayoutName" value="grid-m"/>
                    </c:when>
                    <c:when test="${actualLayoutName eq 'taobao.layout.grid-s5m0-fordetail'}">
                        <c:set var="actualLayoutName" value="grid-s5m0"/>
                    </c:when>
                </c:choose>

                <c:set var="siteLayoutType" value="${siteLayout.siteLayoutTypesMap[actualLayoutName]}"/>
                <tr>
                    <td>${layoutName}</td>
                    <td>${layoutRule.maxModule}</td>
                    <td>
                        <c:forEach items="${siteLayoutType.siteLayoutColumnsMap}" var="siteLayoutColumnEntry">
                            <c:set var="siteLayoutColumn" value="${siteLayoutColumnEntry.value}"/>
                            ${siteLayoutColumn.name}:${siteLayoutColumn.width}&nbsp;&nbsp;
                        </c:forEach>
                    </td>
                    <td>${moduleRule.required ? "必须":"可选"}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <p/>


</section>
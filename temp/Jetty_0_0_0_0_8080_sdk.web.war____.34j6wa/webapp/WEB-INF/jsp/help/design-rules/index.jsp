<%-- 站点装修规则文档 --%>
<c:set var="siteID" value="${applySite.id}"/>
<c:set var="indexHelpURI" value="/help/"/>
<c:set var="designRulesHelpURI" value="${indexHelpURI}design-rules/"/>
<c:set var="siteDesignRulesHelpURI" value="${indexHelpURI}design/rules/${siteID}/"/>

<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>装修规则参考文档</h2>
        </div>
    </article>

    <div>当前位置：<a href="${indexHelpURI}">帮助文档</a> - <a href="${siteDesignRulesHelpURI}">装修规则文档（站点：${applySite.title}）</a></div>
    <p/>

    <div>站点规则切换：
        <c:forEach items="${applySitesMap}" var="applySiteEntry">
            <a href="${indexHelpURI}design/rules/${applySiteEntry.key}/">${applySiteEntry.value.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <c:if test="${productRule ne null}">
        <h3>页面规则列表</h3>
        <br/>

        <div>
            <table border="1" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th>页面名称</th>
                    <th>页面最大添加数量</th>
                    <th>页面最大模块添加数</th>
                    <th>页面最大布局添加数</th>
                    <th>是否可重命名</th>
                    <th>是否为必须出现</th>
                    <th>支持模块类型列表</th>
                    <th>支持布局类型列表</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>页头</td>
                    <td>1</td>
                    <td>${headerRule.maxModule}</td>
                    <td>${headerRule.maxLayout}</td>
                    <td>不能</td>
                    <td>必须</td>
                    <td><a href="${indexHelpURI}design/rules/${siteID}/page/-1/supported/modules/">点击参考</a></td>
                    <td><a href="${indexHelpURI}design/rules/${siteID}/page/-1/supported/layouts/">点击参考</a></td>
                </tr>
                <tr>
                    <td>页尾</td>
                    <td>1</td>
                    <td>${footerRule.maxModule}</td>
                    <td>${footerRule.maxLayout}</td>
                    <td>不能</td>
                    <td>必须</td>
                    <td><a href="${indexHelpURI}design/rules/${siteID}/page/-2/supported/modules/">点击参考</a></td>
                    <td><a href="${indexHelpURI}design/rules/${siteID}/page/-2/supported/layouts/">点击参考</a></td>
                </tr>
                <c:forEach items="${productRule.pageRules}" var="pageRule">
                    <c:set var="pageName" value="${pageRule.pageName}"/>
                    <c:set var="pageID" value="${pageRule.pagePrototypeId}"/>
                    <tr>
                        <td>${pageName}</td>
                        <td>${pageRule.maxAppend}</td>
                        <td>${pageRule.maxModule}</td>
                        <td>${pageRule.maxLayout}</td>
                        <td>${pageRule.renamable  ? "可以": "不能"}</td>
                        <td>${pageRule.required ? "必须":"可选"}</td>
                        <td><a href="${indexHelpURI}design/rules/${siteID}/page/${pageID}/supported/modules/">点击参考</a></td>
                        <td><a href="${indexHelpURI}design/rules/${siteID}/page/${pageID}/supported/layouts/">点击参考</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <p/>
    </c:if>

</section>
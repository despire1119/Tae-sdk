<%-- 站点前端规范文档 --%>
<c:set var="siteID" value="${applySite.id}"/>
<c:set var="indexHelpURI" value="/help/"/>
<c:set var="frontendIndexHelpURI" value="${indexHelpURI}frontend/"/>
<c:set var="siteTbmlfiterHelpURI" value="${indexHelpURI}frontend/${siteID}/"/>

<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>前端规范参考文档</h2>
        </div>
    </article>

    <div>当前位置：<a href="${indexHelpURI}">帮助文档</a> - <a href="${frontendIndexHelpURI}">前端规范参考文档</a> - <a
            href="${siteTbmlfiterHelpURI}">站点：${applySite.title}</a></div>
    <p/>

    <div>站点切换：
        <c:forEach items="${applySitesMap}" var="applySiteEntry">
            <c:set var="siteID" value="${applySiteEntry.key}"/>
            <a href="${indexHelpURI}frontend/${siteID}/">${applySiteEntry.value.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <c:if test="${tbmlConfig ne null}">
        <h3>HTML元素白名单</h3>
        <br/>

        <div>
            <table border="1" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th>元素名称</th>
                    <th>元素属性白名单</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${tbmlConfig.tagWhitelist}" var="tagInfoEntry">
                    <c:set var="tagName" value="${fn:toLowerCase(tagInfoEntry.key)}"/>
                    <c:set var="tagInfo" value="${tagInfoEntry.value}"/>
                    <c:if test="${fn:length(tagInfo.allowedAttributes) >0}">
                        <tr>
                            <td>${tagName}</td>
                            <td>
                                <c:forEach items="${tagInfo.allowedAttributes}" var="attributeEntry">
                                    ${fn:toLowerCase(attributeEntry.key)}&nbsp;
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <p/>

        <h3>CSS白名单</h3>
        <br/>

        <div>
            <table border="1" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th>CSS 属性名称</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${tbmlConfig.cssConfig.allSupportedAttributes}" var="cssValueEntry">
                    <c:set var="cssPropertyName" value="${cssValueEntry.key}"/>
                    <tr>
                        <td>
                            ${cssPropertyName}
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

</section>
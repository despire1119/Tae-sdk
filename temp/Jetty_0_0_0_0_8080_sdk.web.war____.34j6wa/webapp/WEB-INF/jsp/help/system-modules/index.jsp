<%-- 站点系统模块文档 --%>
<c:set var="siteID" value="${applySite.id}"/>
<c:set var="indexHelpURI" value="/help/"/>
<c:set var="siteSystemModulesHelpURI" value="${indexHelpURI}system/modules/${siteID}/"/>


<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>系统模块参考文档</h2>
        </div>
    </article>

    <div>当前位置：<a href="${indexHelpURI}">帮助文档</a>
        - <a href="${siteSystemModulesHelpURI}">系统模块参考文档（站点：${applySite.title}）</a></div>
    <p/>

    <div>站点切换：
        <c:forEach items="${applySitesMap}" var="applySiteEntry">
            <a href="${indexHelpURI}system/modules/${applySiteEntry.key}/">${applySiteEntry.value.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <c:if test="${not empty systemModulesMap}">
        <h3>系统模块列表</h3>
        <br/>

        <div>
            <table border="1" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th>系统模块名称</th>
                    <th>缩略图</th>
                    <th>CSS类选择器名称</th>
                    <th>最后更新时间</th>
                    <th>模块预览</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${systemModulesMap}" var="systemModuleEntry">
                    <c:set var="systemModule" value="${systemModuleEntry.value}"/>
                    <c:set var="thumbnailURL" value="${systemModule.thumbnailURL}"/>
                    <c:set var="cssURL" value="${systemModule.cssURL}"/>
                    <c:set var="cssSelectorName" value="${systemModule.cssSelectorName}"/>
                    <tr>
                        <td>${systemModule.moduleName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty thumbnailURL}">
                                    <img src="${thumbnailURL}"></img>
                                </c:when>
                                <c:otherwise>
                                    没有系统模块缩略图
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${cssSelectorName}</td>
                        <td>
                            <fmt:parseDate pattern="yyyyy-MM-dd'T'HH:mm:ssZ" timeZone="Asia/Shanghai" parseLocale="zh_CN" var="date" value="${systemModule.lastModified}"/>
                            ${date}
                        </td>
                        <td><a href="/module/render/system-module/${siteID}/${cssSelectorName}/"
                               target="_blank">点击预览</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

</section>
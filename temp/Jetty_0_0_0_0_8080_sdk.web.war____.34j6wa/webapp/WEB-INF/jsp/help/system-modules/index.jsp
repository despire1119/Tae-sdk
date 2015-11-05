<%-- վ��ϵͳģ���ĵ� --%>
<c:set var="siteID" value="${applySite.id}"/>
<c:set var="indexHelpURI" value="/help/"/>
<c:set var="siteSystemModulesHelpURI" value="${indexHelpURI}system/modules/${siteID}/"/>


<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>ϵͳģ��ο��ĵ�</h2>
        </div>
    </article>

    <div>��ǰλ�ã�<a href="${indexHelpURI}">�����ĵ�</a>
        - <a href="${siteSystemModulesHelpURI}">ϵͳģ��ο��ĵ���վ�㣺${applySite.title}��</a></div>
    <p/>

    <div>վ���л���
        <c:forEach items="${applySitesMap}" var="applySiteEntry">
            <a href="${indexHelpURI}system/modules/${applySiteEntry.key}/">${applySiteEntry.value.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <c:if test="${not empty systemModulesMap}">
        <h3>ϵͳģ���б�</h3>
        <br/>

        <div>
            <table border="1" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th>ϵͳģ������</th>
                    <th>����ͼ</th>
                    <th>CSS��ѡ��������</th>
                    <th>������ʱ��</th>
                    <th>ģ��Ԥ��</th>
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
                                    û��ϵͳģ������ͼ
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${cssSelectorName}</td>
                        <td>
                            <fmt:parseDate pattern="yyyyy-MM-dd'T'HH:mm:ssZ" timeZone="Asia/Shanghai" parseLocale="zh_CN" var="date" value="${systemModule.lastModified}"/>
                            ${date}
                        </td>
                        <td><a href="/module/render/system-module/${siteID}/${cssSelectorName}/"
                               target="_blank">���Ԥ��</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

</section>
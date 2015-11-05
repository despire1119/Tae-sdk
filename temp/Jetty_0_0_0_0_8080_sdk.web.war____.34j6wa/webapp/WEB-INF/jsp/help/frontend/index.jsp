<%-- վ��ǰ�˹淶�ĵ� --%>
<c:set var="siteID" value="${applySite.id}"/>
<c:set var="indexHelpURI" value="/help/"/>
<c:set var="frontendIndexHelpURI" value="${indexHelpURI}frontend/"/>
<c:set var="siteTbmlfiterHelpURI" value="${indexHelpURI}frontend/${siteID}/"/>

<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>ǰ�˹淶�ο��ĵ�</h2>
        </div>
    </article>

    <div>��ǰλ�ã�<a href="${indexHelpURI}">�����ĵ�</a> - <a href="${frontendIndexHelpURI}">ǰ�˹淶�ο��ĵ�</a> - <a
            href="${siteTbmlfiterHelpURI}">վ�㣺${applySite.title}</a></div>
    <p/>

    <div>վ���л���
        <c:forEach items="${applySitesMap}" var="applySiteEntry">
            <c:set var="siteID" value="${applySiteEntry.key}"/>
            <a href="${indexHelpURI}frontend/${siteID}/">${applySiteEntry.value.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <c:if test="${tbmlConfig ne null}">
        <h3>HTMLԪ�ذ�����</h3>
        <br/>

        <div>
            <table border="1" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th>Ԫ������</th>
                    <th>Ԫ�����԰�����</th>
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

        <h3>CSS������</h3>
        <br/>

        <div>
            <table border="1" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th>CSS ��������</th>
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
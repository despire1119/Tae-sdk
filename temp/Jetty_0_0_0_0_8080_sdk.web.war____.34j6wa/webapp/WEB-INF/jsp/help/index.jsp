<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>�����ĵ�-Ŀ¼</h2>
        </div>
    </article>

    <div>��ǰλ�ã�<a href="${indexHelpURI}">�����ĵ�</a></div>
    <p/>

    <h3 id="frontend">�ĵ��б�</h3>

    <p/>

    <div>
        <table border="1" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <th>վ������</th>
                <th>ǰ�˹淶�ο��ĵ�</th>
                <th>װ�޹���ο��ĵ�</th>
                <th>ϵͳģ��ο��ĵ�</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${applySitesMap}" var="applySiteEntry">
                <c:set var="siteID" value="${applySiteEntry.key}"/>
                <c:set var="applySite" value="${applySiteEntry.value}"/>
                <tr>
                    <td>${applySite.title}</td>
                    <td><a href="/help/frontend/${siteID}/">����ο�</a></td>
                    <td><a href="/help/design/rules/${siteID}/">����ο�</a></td>
                    <td><a href="/help/system/modules/${siteID}/">����ο�</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>


</section>
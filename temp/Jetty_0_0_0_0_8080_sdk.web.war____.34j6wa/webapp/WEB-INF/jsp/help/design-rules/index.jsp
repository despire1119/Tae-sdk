<%-- վ��װ�޹����ĵ� --%>
<c:set var="siteID" value="${applySite.id}"/>
<c:set var="indexHelpURI" value="/help/"/>
<c:set var="designRulesHelpURI" value="${indexHelpURI}design-rules/"/>
<c:set var="siteDesignRulesHelpURI" value="${indexHelpURI}design/rules/${siteID}/"/>

<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>װ�޹���ο��ĵ�</h2>
        </div>
    </article>

    <div>��ǰλ�ã�<a href="${indexHelpURI}">�����ĵ�</a> - <a href="${siteDesignRulesHelpURI}">װ�޹����ĵ���վ�㣺${applySite.title}��</a></div>
    <p/>

    <div>վ������л���
        <c:forEach items="${applySitesMap}" var="applySiteEntry">
            <a href="${indexHelpURI}design/rules/${applySiteEntry.key}/">${applySiteEntry.value.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <c:if test="${productRule ne null}">
        <h3>ҳ������б�</h3>
        <br/>

        <div>
            <table border="1" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                    <th>ҳ������</th>
                    <th>ҳ������������</th>
                    <th>ҳ�����ģ�������</th>
                    <th>ҳ����󲼾������</th>
                    <th>�Ƿ��������</th>
                    <th>�Ƿ�Ϊ�������</th>
                    <th>֧��ģ�������б�</th>
                    <th>֧�ֲ��������б�</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>ҳͷ</td>
                    <td>1</td>
                    <td>${headerRule.maxModule}</td>
                    <td>${headerRule.maxLayout}</td>
                    <td>����</td>
                    <td>����</td>
                    <td><a href="${indexHelpURI}design/rules/${siteID}/page/-1/supported/modules/">����ο�</a></td>
                    <td><a href="${indexHelpURI}design/rules/${siteID}/page/-1/supported/layouts/">����ο�</a></td>
                </tr>
                <tr>
                    <td>ҳβ</td>
                    <td>1</td>
                    <td>${footerRule.maxModule}</td>
                    <td>${footerRule.maxLayout}</td>
                    <td>����</td>
                    <td>����</td>
                    <td><a href="${indexHelpURI}design/rules/${siteID}/page/-2/supported/modules/">����ο�</a></td>
                    <td><a href="${indexHelpURI}design/rules/${siteID}/page/-2/supported/layouts/">����ο�</a></td>
                </tr>
                <c:forEach items="${productRule.pageRules}" var="pageRule">
                    <c:set var="pageName" value="${pageRule.pageName}"/>
                    <c:set var="pageID" value="${pageRule.pagePrototypeId}"/>
                    <tr>
                        <td>${pageName}</td>
                        <td>${pageRule.maxAppend}</td>
                        <td>${pageRule.maxModule}</td>
                        <td>${pageRule.maxLayout}</td>
                        <td>${pageRule.renamable  ? "����": "����"}</td>
                        <td>${pageRule.required ? "����":"��ѡ"}</td>
                        <td><a href="${indexHelpURI}design/rules/${siteID}/page/${pageID}/supported/modules/">����ο�</a></td>
                        <td><a href="${indexHelpURI}design/rules/${siteID}/page/${pageID}/supported/layouts/">����ο�</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <p/>
    </c:if>

</section>
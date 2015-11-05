<%-- ҳ��֧�ֵ�ģ���б���� --%>
<c:set var="siteID" value="${applySite.id}"/>
<c:choose>
    <c:when test="${pageID==-1}">
        <c:set var="pageName" value="ҳͷ"/>
    </c:when>
    <c:when test="${pageID==-2}">
        <c:set var="pageName" value="ҳβ"/>
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
            <h2>װ�޹���ο��ĵ�</h2>
        </div>
    </article>

    <div>��ǰλ�ã�<a href="${indexHelpURI}">�����ĵ�</a>
        - <a href="${siteDesignRulesHelpURI}">װ�޲ο������ĵ���վ�㣺${applySite.title}��</a>
        - <a href="${pageSupportedModulesHelpURI}">ҳ��֧�ֵ�ģ���б�ҳ�����ƣ�${pageName}��</a>
    </div>
    <p/>

    <div>ҳ������л���
        <a href="${indexHelpURI}design/rules/${siteID}/page/-1/supported/modules/">ҳͷ</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="${indexHelpURI}design/rules/${siteID}/page/-2/supported/modules/">ҳβ</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <c:forEach items="${productRule.pageRules}" var="page">
            <c:set var="uri"
                   value="${indexHelpURI}design/rules/${siteID}/page/${page.pagePrototypeId}/supported/modules/"/>
            <a href="${uri}">${page.pageName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <h3>ҳ�棨${pageName}��- ģ���б�����б�</h3>
    <br/>

    <div>
        <table border="1" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <th>ģ������</th>
                <th>ģ������������</th>
                <th>ģ��֧�ֵĿ��</th>
                <th>�Ƿ�ɱ༭</th>
                <th>�Ƿ���ƶ�</th>
                <th>�Ƿ��ɾ��</th>
                <th>�Ƿ��������</th>
                <th>�Ƿ�������</th>
                <th>ģ��Ԥ��</th>
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
                    <td>${moduleRule.editable  ? "����": "����"}</td>
                    <td>${moduleRule.movable  ? "����": "����"}</td>
                    <td>${moduleRule.deleteable  ? "����": "����"}</td>
                    <td>${moduleRule.renamable  ? "����": "����"}</td>
                    <td>${moduleRule.required ? "����":"��ѡ"}</td>
                    <td><a href="/module/render/system-module/${siteID}/${cssSelectorName}/" target="_blank">���Ԥ��</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <p/>


</section>
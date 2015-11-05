<%-- ҳ��֧�ֵĲ����б���� --%>
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
<c:set var="pageSupportedLayoutsHelpURI" value="${indexHelpURI}design/rules/${siteID}/supported/layouts/${pageID}/"/>

<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>װ�޹���ο��ĵ�</h2>
        </div>
    </article>

    <div>��ǰλ�ã�<a href="${indexHelpURI}">�����ĵ�</a>
        - <a href="${siteDesignRulesHelpURI}">װ�޹���ο��ĵ���վ�㣺${applySite.title}��</a>
        - <a href="${pageSupportedLayoutsHelpURI}">ҳ��֧�ֵĲ����б�ҳ�����ƣ�${pageName}��</a>
    </div>
    <p/>

    <div>ҳ������л���
        <a href="${indexHelpURI}design/rules/${siteID}/page/-1/supported/layouts/">ҳͷ</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="${indexHelpURI}design/rules/${siteID}/page/-2/supported/layouts/">ҳβ</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <c:forEach items="${productRule.pageRules}" var="page">
            <c:set var="uri"
                   value="${indexHelpURI}design/rules/${siteID}/page/${page.pagePrototypeId}/supported/layouts/"/>
            <a href="${uri}">${page.pageName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <p/>

    <h3>ҳ�棨${pageName}��- �����б�����б�</h3>
    <br/>

    <div>
        <table border="1" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <th>��������</th>
                <th>����������ģ������</th>
                <th>����֧�ֵĿ��</th>
                <th>�Ƿ�������</th>
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
                    <c:when test="${actualLayoutName eq 'ҳ�ײ���' or actualLayoutName eq 'β������'}">
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
                    <td>${moduleRule.required ? "����":"��ѡ"}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <p/>


</section>
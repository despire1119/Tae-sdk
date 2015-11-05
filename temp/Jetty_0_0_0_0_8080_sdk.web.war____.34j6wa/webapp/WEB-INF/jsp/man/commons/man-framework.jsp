<%-- ������ҳ�� --%>
<%-- ��׺·�� --%>
<%-- ��Լ·��
 ���磬����URI == "/man/template/publish/test/"������$suffixPath =="/test"��
 ��ô�����ҳ��Ƭ��·��$manPageFragmentPath == "/WEB-INF/jsp/man/template/publish.jspf"
 --%>
<c:forEach items="${managerViewUIList}" var="managerViewUI" >
    <c:set var="sectionURIPrefix" value="${managerViewUI.sectionURIPrefix}" />
    <c:if test="${fn:contains(sectionURIPrefix,currentMangerNavigationView.matchURIPrefix)}">
       <c:if test="${fn:startsWith(requestForwardedURI,sectionURIPrefix)}">
           <c:set var="currentManagerViewUI" value="${managerViewUI}" />
       </c:if>
    </c:if>
</c:forEach>
<%-- ��ӹ���ҳ��Ƭ�� --%>
<c:if test="${not empty currentManagerViewUI.commonPageFragmentPath}">
    <jsp:include page="${currentManagerViewUI.commonPageFragmentPath}" />
</c:if>
<c:set var="sectionMainPageFragmentPath" value="${currentManagerViewUI.sectionMainPageFragmentPath}" />
<section class="content develop ${currentManagerViewUI.sectionClassName}">
    <article class="main">
        <div class="wrap">
            <jsp:directive.include file="/WEB-INF/jsp/man/commons/tab.jspf" />
            <div class="items">
                <div class="wraper">
                    <%-- ��������ҳ��URI --%>
                    <jsp:include page="${sectionMainPageFragmentPath}" />
                </div>
            </div>
        </div>
    </article>
    <jsp:directive.include file="/WEB-INF/jsp/man/commons/sidebar.jspf" />
</section>
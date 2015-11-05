<%-- 管理框架页面 --%>
<%-- 后缀路径 --%>
<%-- 规约路径
 例如，请求URI == "/man/template/publish/test/"，其中$suffixPath =="/test"，
 那么管理的页面片段路径$manPageFragmentPath == "/WEB-INF/jsp/man/template/publish.jspf"
 --%>
<c:forEach items="${managerViewUIList}" var="managerViewUI" >
    <c:set var="sectionURIPrefix" value="${managerViewUI.sectionURIPrefix}" />
    <c:if test="${fn:contains(sectionURIPrefix,currentMangerNavigationView.matchURIPrefix)}">
       <c:if test="${fn:startsWith(requestForwardedURI,sectionURIPrefix)}">
           <c:set var="currentManagerViewUI" value="${managerViewUI}" />
       </c:if>
    </c:if>
</c:forEach>
<%-- 添加公用页面片段 --%>
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
                    <%-- 管理内容页面URI --%>
                    <jsp:include page="${sectionMainPageFragmentPath}" />
                </div>
            </div>
        </div>
    </article>
    <jsp:directive.include file="/WEB-INF/jsp/man/commons/sidebar.jspf" />
</section>
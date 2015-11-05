<section class="content system-setting">
    <article class="box">
        <div class="title">
            <h2>帮助文档-目录</h2>
        </div>
    </article>

    <div>当前位置：<a href="${indexHelpURI}">帮助文档</a></div>
    <p/>

    <h3 id="frontend">文档列表</h3>

    <p/>

    <div>
        <table border="1" cellspacing="0" cellpadding="0">
            <thead>
            <tr>
                <th>站点名称</th>
                <th>前端规范参考文档</th>
                <th>装修规则参考文档</th>
                <th>系统模块参考文档</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${applySitesMap}" var="applySiteEntry">
                <c:set var="siteID" value="${applySiteEntry.key}"/>
                <c:set var="applySite" value="${applySiteEntry.value}"/>
                <tr>
                    <td>${applySite.title}</td>
                    <td><a href="/help/frontend/${siteID}/">点击参看</a></td>
                    <td><a href="/help/design/rules/${siteID}/">点击参看</a></td>
                    <td><a href="/help/system/modules/${siteID}/">点击参看</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>


</section>
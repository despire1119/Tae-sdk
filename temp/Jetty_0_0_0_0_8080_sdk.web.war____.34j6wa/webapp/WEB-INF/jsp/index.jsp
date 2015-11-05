
<section class="content"> 
<article class="box">
<div class="title">
	<h2>�����Ƶ�ģ��</h2>
</div>
<div class="latest">
	<c:forEach var="template" items="${templatesList}">
        <c:set var="siteTemplate" value="${template.siteTemplate}"/>
        <c:set var="applySites" value="${siteTemplate.applySites}"/>
        <c:choose>
            <c:when test="${applySites > 1000}">
                <c:set var="previewURI" value="/microshop/htdocs/preview/${template.directoryName}/"/>
                <c:set var="debugURI" value="/man/microtemplate/layout/${template.directoryName}/"/>
            </c:when>
            <c:otherwise>
                <c:set var="previewURI" value="/htdocs/${template.directoryName}/"/>
                <c:set var="debugURI" value="/man/template/layout/${template.directoryName}/"/>
            </c:otherwise>
        </c:choose>

		<dl class="template">
			<dt class="image">
				<a href="${previewURI}" target="_blank" title="">
					<c:set var="thumbnail" value="${template.thumbnail}" /> 
					<c:if test="${not fn:startsWith(thumbnail,'http:')}">
						<c:set var="thumbnail" value="/${template.directoryName}/${template.thumbnail}" />
					</c:if>
					 <img src="${thumbnail}" alt="ģ������ͼ" />
				</a>
			</dt>
			<dd class="name">
				<a href="${debugURI}" title="">${template.applySites}/${template.name}</a>
			</dd>
			<dd class="time">���༭ʱ�䣺${template.lastModifiedDate}</dd>
		</dl>
	</c:forEach>
	<dl class="template">
		<dt class="image add">
			<a href="/man/template/form" title=""> <img
				src="http://img04.taobaocdn.com/tps/i4/T1ZtblXmNaXXXf1Lo7-240-160.png" alt="mobanming">
			</a>
		</dt>
		<dd class="name">
			<a href="/man/template/form" title="">������ģ��</a>
		</dd>
	</dl>
</div>
</article> 

<article class="box">
<div class="title">
	<h2>���������Ӧ��</h2>
</div>
<div class="latest">
	<c:forEach var="yamlConfigFileLocator" items="${appYamlConfigFileLocatorList}">
	    <c:set var="yamlConfig" value="${yamlConfigFileLocator.yamlConfig}" />
	    <c:set var="appName" value="${yamlConfigFileLocator.appDirectory.name}" />
		<dl class="template">
			<dt class="image">
				<a href="http://${appName}.taobaoapps.net:${serverPort}/" title="">
					<c:set var="thumbnail" value="${yamlConfig.thumbnail}" />
					<c:if test="${not fn:startsWith(thumbnail,'http:')}">
						<c:set var="thumbnail" value="http://${appName}.taobaoapps.net:${serverPort}/${thumbnail}" />
					</c:if>
					 <img src="${thumbnail}" alt="���������󶨣�${appName}.taobaoapps.net����Ӧ��YAML�ļ��е�thumbnail����" />
				</a>
			</dt>
			<dd class="name">
				<a href="/man/app/page/${appName}" title="">${yamlConfig.description}</a>
			</dd>
			<dd class="time">���༭ʱ�䣺</dd>
		</dl>
	</c:forEach>
	<dl class="template">
		<dt class="image add">
			<a href="/man/app/form" title=""> <img
				src="http://img04.taobaocdn.com/tps/i4/T1ZtblXmNaXXXf1Lo7-240-160.png" alt="mobanming">
			</a>
		</dt>
		<dd class="name">
			<a href="/man/app/form" title="">�����¿���</a>
		</dd>
	</dl>
</div>
</article>

<article class="box">
<div class="title">
	<h2>������ָ��</h2>
</div>
<div class="help">
	<dl>
		<dt>
			�� <a href="http://newwiki.zx.taobao.com/index.php?title=%E6%A8%A1%E6%9D%BF%E7%AE%80%E4%BB%8B"
				 target="_blank" title="��������">��������</a>
		</dt>
		<dd>���������פ���ʦ�����̵���ƽ̨�������ܼ�ģ�忪������˵��</dd>
	</dl>
	<dl>
		<dt>
			�� <a href="http://tae-sdk-2.googlecode.com/svn/trunk/%E6%9B%B4%E6%96%B0%E6%97%A5%E5%BF%97.txt"  target="_blank" title="������־">������־</a>
		</dt>
		<dd>SDK�汾������������־</dd>
	</dl>
	<dl>
		<dt>
			�� <a href="http://newwiki.zx.taobao.com/index.php?title=SDK_DEV_REF" target="_blank" title="SDKģ�忪��ָ��">SDKģ�忪��ָ��</a>
		</dt>
		<dd>�����˽�SDKģ����װ��ģ�鿪����������ȿ�������</dd>
	</dl>
	<dl>
		<dt>
			�� <a
				href="http://newwiki.zx.taobao.com/index.php?title=TAE_PHP%E5%BA%94%E7%94%A8%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97"
				target="_blank"
				class="external text"
				title="TAE PHPӦ�ÿ���ָ��"
				rel="nofollow">TAE PHPӦ�ÿ���ָ��</a>
		</dt>
		<dd>TAE PHPӦ�õĿ��Žӿڡ�PHP�����������ݿ�PDO������ǰ�˹淶��</dd>
	</dl>
	<dl>
		<dt>
			�� <a
				href="http://wiki.zx.taobao.com/index.php/%E6%A0%B7%E4%BE%8B%E5%BA%93"
				class="external text"
				target="_blank"
				title="������"
				rel="nofollow">������</a>
		</dt>
		<dd>�߼�ģ�������⣬��Ч����ȫ����</dd>
	</dl>
	<dl>
		<dt>
			�� <a
				href="http://bbs.zx.taobao.com/"
				class="external text"
				target="_blank"
				title="������̳"
				rel="nofollow">������̳</a>
		</dt>
		<dd>�߼�ģ�忪������̳�</dd>
	</dl>
</div>
</article> </section>

<html>
<head>
<jsp:directive.include file="/WEB-INF/jsp/prelude/no-cache-header.jspf" />
<meta charset="gbk" />
<link rel="stylesheet" type="text/css"
	href="http://${assetsHost}/apps/taesite/platinum/stylesheet/sdk/debug.css" />
<style type="text/css">
	.editpanel {
		overflow: auto;
	}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${not empty parameterGroupsList}">
			<div class="editPanel">
				<form
					action="/design/module/params/${templateDirectoryName}/${pageFileName}/${moduleID}/${moduleInstanceID}/"
					class="auto-rec-form form-default" name="moduleSetForm"
					method="POST">
					<div class="tab">
						<c:set var="groupsList" value="${parameterGroupsList}" />
						<ul class="nav clear-fix">
							<c:forEach items="${groupsList}" var="group"
								varStatus="loopStatus">
								<c:choose>
									<c:when test="${loopStatus.index==0}">
										<li class="selected first"><span>${group.title}</span>
										</li>
									</c:when>
									<c:otherwise>
										<li><span>${group.title}</span>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>

						<div class="panels">

							<c:forEach items="${groupsList}" var="group"
								varStatus="loopStatus">
								<c:choose>
									<c:when test="${loopStatus.index==0}">
										<div class="panel item-set">
											<div class="auto-rec-content">
												<jsp:directive.include
													file="/WEB-INF/jsp/render/module/group-render.jspf" />
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="panel display-set hidden">
											<jsp:directive.include
												file="/WEB-INF/jsp/render/module/group-render.jspf" />
										</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>

						</div>
						<div class="opt-footer">
							<input class="btn-ok" type="submit" value="保存" />
						</div>
					</div>
				</form>
			</div>

		</c:when>
		<c:otherwise>
			<span> 模块[ID：${moduleID}]没有定义模块参数！请关闭！ </span>
		</c:otherwise>

	</c:choose>
	<c:choose>
    	<c:when test="${siteLayout.siteID eq '60'}">
    		<%-- 内容分类选择器(优站)  --%>
        	<jsp:directive.include file="/WEB-INF/jsp/render/contentClass-chooser.jspf" />
        
        	<%-- 内容选择器(优站)  --%>
        	<jsp:directive.include file="/WEB-INF/jsp/render/content-chooser.jspf" />
        </c:when>
        <c:otherwise>
    		<%-- 分类选择器  --%>
        	<jsp:directive.include file="/WEB-INF/jsp/render/category-chooser.jspf" />
        
        	<%-- 宝贝选择器  --%>
        	<jsp:directive.include file="/WEB-INF/jsp/render/item-chooser.jspf" />
        </c:otherwise>
	</c:choose>
    <%-- 宝贝评价选择器 --%>
    <jsp:directive.include file="/WEB-INF/jsp/render/itemRate-chooser.jspf"/>

    <%-- 优惠券选择器 --%>
    <jsp:directive.include file="/WEB-INF/jsp/render/coupon-chooser.jspf"/>

	<!--部署到assets里面-->
	<script src="http://${assetsHost}${kissyURI}" charset="utf-8"></script>
	<jsp:directive.include file="/WEB-INF/jsp/coda/commons-footer-js.jspf" />
	<!--   部署到assets里面 -->
	<script type="text/javascript">
		KISSY.use('scripts/sdk/widget/init');
	</script>
</body>
</html>

<c:if test="${moduleParamsSaveSuccess}">
	<script>
	(function() {
		var forms = document.getElementsByTagName('form'), len = forms.length, i = 0, form;
		for (; i < len; ++i) {
			form = forms[i];
			var newInput = document.createElement("input");
			newInput.type = "hidden";
			newInput.name = "widgetId";
			newInput.value = "${moduleInstanceID}";
			form.appendChild(newInput);
			var input_SiteInstanceId = document.createElement("input");
			input_SiteInstanceId.type = "hidden";
			input_SiteInstanceId.name = "sid";
			input_SiteInstanceId.value = "13203";
			form.appendChild(input_SiteInstanceId);
			var input_tbToken = document.createElement("input");
			input_tbToken.type = "hidden";
			input_tbToken.name = "_tb_token_";
			input_tbToken.value = "0NTCZdBl";
			form.appendChild(input_tbToken);
		}
	})();
</script>
<script>
	(function() {
		top.DShop.IF.renderMod("/module/preview/${templateDirectoryName}/${moduleID}/${moduleInstanceID}/");
	})();
</script>
</c:if>


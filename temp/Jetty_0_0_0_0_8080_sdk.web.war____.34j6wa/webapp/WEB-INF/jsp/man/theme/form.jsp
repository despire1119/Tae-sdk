<section class="content create-style"> <article class="box">
<div class="title">
	<h2>创建/编辑风格</h2>
</div>
<form:form
	action="/man/template/theme/submit/${templateDirectoryName}/${editMode}/"
	commandName="themeForm" method="POST">

	<div
		class="form-group <c:if test=" ${themeNameError ne null}">error</c:if>">
		<label class="form-label">风格名称:</label>
		<div class="form-controls">
			 <c:if test="${editMode}">
					<form:hidden path="themeNameBeforeModify"/>
			</c:if> 
			<form:input path="themeName" cssClass="form-text" />
			<span class="help-inline"> 支持中文(必填)</span>			
		</div>
	</div>
	<div
		class="form-group">
		<label class="form-label">风格ID:</label>
		<div class="form-controls">
			<%-- <c:if test="${editMode}">
					<c:set var="disableClass" value="disable" />
					<c:set var="disabled" value="true" />
					<form:hidden path="themeID"/>
			</c:if> --%>
			<form:input path="themeID" cssClass="form-text" />
			<span class="help-inline"> 仅支持英文、数字、横线"-"和下划线"_"的组合(必填，用于样式文件名或目录名)</span>
		</div>
	</div>
	<div class="form-group ${not empty thumbnailBlankError ? 'error' : '' }">
		<label class="form-label">缩略图:</label>
		<div class="form-controls">
			<form:input path="thumbnail" cssClass="form-text" />  <span class="help-inline"> 384x600，请填写相对路径(相对于模板目录，如：assets/images/xxx.jpg)，仅支持png、jpg和gif</span>
		</div>
		<div class="form-controls">
			<a href="#" class="colorblock"></a> <span class="help-inline"> 本套模板的主色调，便于卖家识别模板风格</span>
		</div>
	</div>

    <div class="form-group">
        <label class="form-label">页头下边距10像素:</label>
        <div class="form-controls">
            <label class="inlineblock">
                <form:radiobutton path="enableHeaderMarginBottom" value="true" cssClass="radio"/>
                开启
            </label>
            <label class="inlineblock">
                <form:radiobutton path="enableHeaderMarginBottom" value="false" cssClass="radio"/>
                关闭
            </label>
        </div>
    </div>

	<div class="form-group">
		<label class="form-label">设置模板背景:</label>
		<div class="form-controls">
			<div class="setting-box">
				<a href="#" class="J_showBtn">收起设置</a>
				<div class="setting-content J_showContent" style="">
					<h4>
						<span>背景颜色：</span>
						<div class="checkbox">
							<label><form:checkbox
									path="enableTemplateBackgroundColor" />是否生效</label>
						</div>
					</h4>
					<div class="control-content">
						<form:input path="templateBackgroundColor" cssClass="form-text" />
						<span>请填入颜色值，如#000000</span>
					</div>
					<h4>
						背景图片：
						<div class="checkbox">
							<label> <form:checkbox
									path="enableTemplateBackgroundImage" /> 是否生效 </label>
						</div>
					</h4>
					<div class="image-content">
						<div class="image">
							<c:set var="tbImagePath"
								value="http://img04.taobaocdn.com/tps/i4/T1xSjbXX8sXXXf1Lo7-240-160.png" />
							<c:if test="${not empty themeForm.templateBackgroundImage}">
								<c:choose>
									<c:when test="${fn:startsWith(themeForm.templateBackgroundImage,'/') }">
										<c:set var="tbImagePath" value="${themeForm.templateBackgroundImage}" />
									</c:when>
									<c:otherwise>
										<c:set var="tbImagePath" value="/${templateDirectoryName}/${themeForm.templateBackgroundImage}" />
									</c:otherwise>
								</c:choose>
							</c:if>
							<img src="${tbImagePath}">
						</div>
						<div class="control-content">
							<form:input path="templateBackgroundImage" cssClass="form-text" />
							<p>请填写相对路径(如：assets/images/x.jpg)，仅支持png、jpg和gif</p>
							<div class="form-group">
								<label class="form-label">背景图片:</label>
								<div class="form-controls">
									<form:select path="templateBackgroundRepeat" cssClass="select"
										items="${cssBackgroundRepeatMap}" />
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">对齐方式:</label>
								<div class="form-controls">
									<%-- <form:select path="templateBackgroundPosition"
										cssClass="select" items="${cssBackgroundPositionMap}" /> --%>
										<select name="templateBackgroundPosition" class="select font">                                			
			                                	<c:forEach items="${cssBackgroundPositionMap}" var="position">
				                               		<option value="${position.key}" <c:if test="${themeForm.templateBackgroundPosition eq position.key}">selected</c:if>>${position.value}</option> 
			                               		</c:forEach>
                            			</select>
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">横向坐标(x):</label>
								<div class="form-controls">
									<form:input path="templateBackgroundPositionX"
										cssClass="form-text position-x" />
									比如：10px
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">纵向坐标(y):</label>
								<div class="form-controls">
									<form:input path="templateBackgroundPositionY"
										cssClass="form-text position-y" />
									比如：10px
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label class="form-label">设置页头背景:</label>
		<div class="form-controls">
			<div class="setting-box">
				<a href="#" class="J_showBtn">收起设置</a>
				<div class="setting-content J_showContent" style="">
					<h4>
						<span>背景颜色：</span>
						<div class="checkbox">
							<label> <form:checkbox path="enableHeaderBackgroundColor" />是否生效
							</label>
						</div>
					</h4>
					<!--<span class="colorblock"></span>-->
					<div class="control-content">
						<form:input path="headerBackgroundColor" cssClass="form-text" />
						<span>  请填入颜色值，如#000000</span>
					</div>
					<h4>
						背景图片：
						<div class="checkbox">
							<label><form:checkbox path="enableHeaderBackgroundImage" />是否生效
							</label>
						</div>
					</h4>
					<div class="image-content">
						<div class="image">
							<c:set var="hbImagePath"
								value="http://img04.taobaocdn.com/tps/i4/T1xSjbXX8sXXXf1Lo7-240-160.png" />
							<c:if test="${not empty themeForm.headerBackgroundImage}">
								<c:choose>
									<c:when test="${fn:startsWith(themeForm.headerBackgroundImage,'/') }">
										<c:set var="hbImagePath" value="${themeForm.headerBackgroundImage}" />
									</c:when>
									<c:otherwise>
										<c:set var="hbImagePath" value="/${templateDirectoryName}/${themeForm.headerBackgroundImage}" />
									</c:otherwise>
								</c:choose>
							</c:if>
							<img src="${hbImagePath}" />
						</div>
						<div class="control-content">
							<form:input path="headerBackgroundImage" cssClass="form-text" />
							<p>请填写相对路径(如：assets/images/x.jpg)，仅支持png、jpg和gif</p>
							<div class="form-group">
								<label class="form-label">背景图片:</label>
								<div class="form-controls">
									<form:select path="headerBackgroundRepeat" cssClass="select"
										items="${cssBackgroundRepeatMap}" />
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">对齐方式:</label>
								<div class="form-controls">
									<%-- <form:select path="headerBackgroundPosition" cssClass="select"
										items="${cssBackgroundPositionMap}" /> --%>
										<select name="headerBackgroundPosition" class="select font">                                			
			                                	<c:forEach items="${cssBackgroundPositionMap}" var="position">
				                               		<option value="${position.key}" <c:if test="${themeForm.headerBackgroundPosition eq position.key}">selected</c:if>>${position.value}</option> 
			                               		</c:forEach>
                            			</select>
								</div>
							</div>

							<div class="form-group">
								<label class="form-label">横向坐标(x):</label>
								<div class="form-controls">
									<form:input path="headerBackgroundPositionX"
										cssClass="form-text position-x" />
									比如：10px
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">纵向坐标(y):</label>
								<div class="form-controls">
									<form:input path="headerBackgroundPositionY"
										cssClass="form-text position-y" />
									比如：10px
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group">
				<label class="form-label">设置模块(必填):</label>
				<div class="form-controls">
					<div class="setting-box">
						<a href="#" class="J_showBtn">展开设置</a>
						<div class="setting-content J_showContent" style="display: none">
                            <div style="background: #FBFBE7;border: 1px dashed #ccc; padding:10px;">
                                <p>说明：此项必填原因为卖家会在店铺中引入一些非系统模块&非设计师的模块，为了让这些模块的风格不影响您模板的风格，请大侠一定按照自己模板的风格认真填写以下内容，以免造成不必要的麻烦。</p>
                            </div>
                            <h4>
                                <span>标题字体：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderFont" />
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content clearfix">  <!--  clearfix -->
                                <%-- <form:select path="moduleHeaderFontFamily" cssClass="select font"
                                	items="${cssFontFamiliesMap}"/>  --%>
                                <select name="moduleHeaderFontFamily" class="select font">                                			
                                	<c:forEach items="${cssFontFamiliesMap}" var="fontFamily">
	                               		<option value="${fontFamily.key}" <c:if test="${themeForm.moduleHeaderFontFamily eq fn:toLowerCase(fontFamily.key)}">selected</c:if>>${fontFamily.value}</option> 
                               		</c:forEach>
                            	</select>
                                <form:select path="moduleHeaderFontSize" cssClass="select font"
										items="${cssFontSizesList}"/>

                                <form:select path="moduleHeaderFontWeight" cssClass="select font"
                                		items="${cssFontWeightList}"/>
                            </div>

                            <h4>
                                <span>模块头部标题颜色：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderFontColor" />
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderFontColor" cssClass="form-text" />
                                <span>请填入颜色值，如#333333</span>
                            </div>
                            <h4>
                                <span>模块头部标题左边距：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderMarginLeft" />
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderMarginLeft" cssClass="form-text"/>
                                <span>请填入像素值，如5px</span>
                            </div>
                            <h4>
                                <span>模块头部高度：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderHeight" />
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderHeight" cssClass="form-text" />
                                <span>请填入像素值，如28px</span>
                            </div>
                            <h4>
                                <span>模块头部边框粗细：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderBorderWidth" />
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderBorderWidth" cssClass="form-text"/>
                                <span>请填入像素值，如1px</span>
                            </div>

                            <h4>
                                <span>模块头部边框颜色：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderBorderColor" />
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <!--<span class="colorblock"></span>-->
                            <div class="control-content">
                                <form:input path="moduleHeaderBorderColor" cssClass="form-text"/>
                                <span>请填入颜色值，如#000000</span>
                            </div>

                            <h4>
                                <span>模块头部背景颜色：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderBackgroundColor"/>
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderBackgroundColor" cssClass="form-text"/>
                                <span>请填入颜色值，如#000000</span>
                            </div>


                            <h4>
                                标题背景填充图片：
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderBackgroundImage"/>
                                        是否生效
                                    </label>
                                </div>
                            </h4>
							<div class="image-content">
								<div class="image">
							<c:set var="mhbImagePath"
								value="http://img04.taobaocdn.com/tps/i4/T1xSjbXX8sXXXf1Lo7-240-160.png" />
							<c:if test="${not empty themeForm.moduleHeaderBackgroundImage}">
								<c:choose>
									<c:when test="${fn:startsWith(themeForm.moduleHeaderBackgroundImage,'/') }">
										<c:set var="mhbImagePath" value="${themeForm.moduleHeaderBackgroundImage}" />
									</c:when>
									<c:otherwise>
										<c:set var="mhbImagePath" value="/${templateDirectoryName}/${themeForm.moduleHeaderBackgroundImage}" />
									</c:otherwise>
								</c:choose>
							</c:if>
							<img src="${mhbImagePath}" />
							</div>
								<div class="control-content">
									<form:input path="moduleHeaderBackgroundImage" cssClass="form-text"/>
									<p>请填写图片相对路径，文件格式GIF、JPG、PNG</p>
									<div class="form-group">
										<label class="form-label">背景图片:</label>
										<div class="form-controls">
											<form:select path="moduleHeaderBackgroundRepeat" cssClass="select"
										items="${cssBackgroundRepeatMap}" />
										</div>
									</div>
									<div class="form-group">
										<label class="form-label">对齐方式:</label>
										<div class="form-controls">
											<%-- <form:select path="moduleHeaderBackgroundPosition"
										cssClass="select" items="${cssBackgroundPositionMap}" /> --%>
											<select name="moduleHeaderBackgroundPosition" class="select font">                                			
			                                	<c:forEach items="${cssBackgroundPositionMap}" var="position">
				                               		<option value="${position.key}" <c:if test="${themeForm.moduleHeaderBackgroundPosition eq position.key}">selected</c:if>>${position.value}</option> 
			                               		</c:forEach>
                            				</select>
										</div>
									</div>
								</div>
							</div>
                            <h4>
                                <span>模块主体边框粗细：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleBodyBorderWidth"/>
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleBodyBorderWidth" cssClass="form-text"/>
                                <span>请填入像素值，如1px</span>
                            </div>
                            <h4>
                                <span>模块主体边框颜色：</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleBodyBorderColor"/>
                                        是否生效
                                    </label>
                                </div>
                            </h4>
                            <!--<span class="colorblock"></span>-->
                            <div class="control-content">
                                <form:input path="moduleBodyBorderColor" cssClass="form-text"/>
                                <span>请填入颜色值，如#000000</span>
                            </div>


						</div>
					</div>
				</div>
			</div>
	<div class="form-group actions">
		<input type="submit" value="保存" class="btn">
		<a href="/man/template/theme/${templateDirectoryName}/">取消</a>
	</div>
</form:form> </article> </section>

<jsp:directive.include file="/WEB-INF/jsp/coda/commons-footer-js.jspf" />

<script type="text/javascript">
	KISSY.use('scripts/sdk/create-style/init');
</script>
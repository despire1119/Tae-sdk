<section class="content create-style"> <article class="box">
<div class="title">
	<h2>����/�༭���</h2>
</div>
<form:form
	action="/man/template/theme/submit/${templateDirectoryName}/${editMode}/"
	commandName="themeForm" method="POST">

	<div
		class="form-group <c:if test=" ${themeNameError ne null}">error</c:if>">
		<label class="form-label">�������:</label>
		<div class="form-controls">
			 <c:if test="${editMode}">
					<form:hidden path="themeNameBeforeModify"/>
			</c:if> 
			<form:input path="themeName" cssClass="form-text" />
			<span class="help-inline"> ֧������(����)</span>			
		</div>
	</div>
	<div
		class="form-group">
		<label class="form-label">���ID:</label>
		<div class="form-controls">
			<%-- <c:if test="${editMode}">
					<c:set var="disableClass" value="disable" />
					<c:set var="disabled" value="true" />
					<form:hidden path="themeID"/>
			</c:if> --%>
			<form:input path="themeID" cssClass="form-text" />
			<span class="help-inline"> ��֧��Ӣ�ġ����֡�����"-"���»���"_"�����(���������ʽ�ļ�����Ŀ¼��)</span>
		</div>
	</div>
	<div class="form-group ${not empty thumbnailBlankError ? 'error' : '' }">
		<label class="form-label">����ͼ:</label>
		<div class="form-controls">
			<form:input path="thumbnail" cssClass="form-text" />  <span class="help-inline"> 384x600������д���·��(�����ģ��Ŀ¼���磺assets/images/xxx.jpg)����֧��png��jpg��gif</span>
		</div>
		<div class="form-controls">
			<a href="#" class="colorblock"></a> <span class="help-inline"> ����ģ�����ɫ������������ʶ��ģ����</span>
		</div>
	</div>

    <div class="form-group">
        <label class="form-label">ҳͷ�±߾�10����:</label>
        <div class="form-controls">
            <label class="inlineblock">
                <form:radiobutton path="enableHeaderMarginBottom" value="true" cssClass="radio"/>
                ����
            </label>
            <label class="inlineblock">
                <form:radiobutton path="enableHeaderMarginBottom" value="false" cssClass="radio"/>
                �ر�
            </label>
        </div>
    </div>

	<div class="form-group">
		<label class="form-label">����ģ�屳��:</label>
		<div class="form-controls">
			<div class="setting-box">
				<a href="#" class="J_showBtn">��������</a>
				<div class="setting-content J_showContent" style="">
					<h4>
						<span>������ɫ��</span>
						<div class="checkbox">
							<label><form:checkbox
									path="enableTemplateBackgroundColor" />�Ƿ���Ч</label>
						</div>
					</h4>
					<div class="control-content">
						<form:input path="templateBackgroundColor" cssClass="form-text" />
						<span>��������ɫֵ����#000000</span>
					</div>
					<h4>
						����ͼƬ��
						<div class="checkbox">
							<label> <form:checkbox
									path="enableTemplateBackgroundImage" /> �Ƿ���Ч </label>
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
							<p>����д���·��(�磺assets/images/x.jpg)����֧��png��jpg��gif</p>
							<div class="form-group">
								<label class="form-label">����ͼƬ:</label>
								<div class="form-controls">
									<form:select path="templateBackgroundRepeat" cssClass="select"
										items="${cssBackgroundRepeatMap}" />
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">���뷽ʽ:</label>
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
								<label class="form-label">��������(x):</label>
								<div class="form-controls">
									<form:input path="templateBackgroundPositionX"
										cssClass="form-text position-x" />
									���磺10px
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">��������(y):</label>
								<div class="form-controls">
									<form:input path="templateBackgroundPositionY"
										cssClass="form-text position-y" />
									���磺10px
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label class="form-label">����ҳͷ����:</label>
		<div class="form-controls">
			<div class="setting-box">
				<a href="#" class="J_showBtn">��������</a>
				<div class="setting-content J_showContent" style="">
					<h4>
						<span>������ɫ��</span>
						<div class="checkbox">
							<label> <form:checkbox path="enableHeaderBackgroundColor" />�Ƿ���Ч
							</label>
						</div>
					</h4>
					<!--<span class="colorblock"></span>-->
					<div class="control-content">
						<form:input path="headerBackgroundColor" cssClass="form-text" />
						<span>  ��������ɫֵ����#000000</span>
					</div>
					<h4>
						����ͼƬ��
						<div class="checkbox">
							<label><form:checkbox path="enableHeaderBackgroundImage" />�Ƿ���Ч
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
							<p>����д���·��(�磺assets/images/x.jpg)����֧��png��jpg��gif</p>
							<div class="form-group">
								<label class="form-label">����ͼƬ:</label>
								<div class="form-controls">
									<form:select path="headerBackgroundRepeat" cssClass="select"
										items="${cssBackgroundRepeatMap}" />
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">���뷽ʽ:</label>
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
								<label class="form-label">��������(x):</label>
								<div class="form-controls">
									<form:input path="headerBackgroundPositionX"
										cssClass="form-text position-x" />
									���磺10px
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">��������(y):</label>
								<div class="form-controls">
									<form:input path="headerBackgroundPositionY"
										cssClass="form-text position-y" />
									���磺10px
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group">
				<label class="form-label">����ģ��(����):</label>
				<div class="form-controls">
					<div class="setting-box">
						<a href="#" class="J_showBtn">չ������</a>
						<div class="setting-content J_showContent" style="display: none">
                            <div style="background: #FBFBE7;border: 1px dashed #ccc; padding:10px;">
                                <p>˵�����������ԭ��Ϊ���һ��ڵ���������һЩ��ϵͳģ��&�����ʦ��ģ�飬Ϊ������Щģ��ķ��Ӱ����ģ��ķ�������һ�������Լ�ģ��ķ��������д�������ݣ�������ɲ���Ҫ���鷳��</p>
                            </div>
                            <h4>
                                <span>�������壺</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderFont" />
                                        �Ƿ���Ч
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
                                <span>ģ��ͷ��������ɫ��</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderFontColor" />
                                        �Ƿ���Ч
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderFontColor" cssClass="form-text" />
                                <span>��������ɫֵ����#333333</span>
                            </div>
                            <h4>
                                <span>ģ��ͷ��������߾ࣺ</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderMarginLeft" />
                                        �Ƿ���Ч
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderMarginLeft" cssClass="form-text"/>
                                <span>����������ֵ����5px</span>
                            </div>
                            <h4>
                                <span>ģ��ͷ���߶ȣ�</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderHeight" />
                                        �Ƿ���Ч
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderHeight" cssClass="form-text" />
                                <span>����������ֵ����28px</span>
                            </div>
                            <h4>
                                <span>ģ��ͷ���߿��ϸ��</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderBorderWidth" />
                                        �Ƿ���Ч
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderBorderWidth" cssClass="form-text"/>
                                <span>����������ֵ����1px</span>
                            </div>

                            <h4>
                                <span>ģ��ͷ���߿���ɫ��</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderBorderColor" />
                                        �Ƿ���Ч
                                    </label>
                                </div>
                            </h4>
                            <!--<span class="colorblock"></span>-->
                            <div class="control-content">
                                <form:input path="moduleHeaderBorderColor" cssClass="form-text"/>
                                <span>��������ɫֵ����#000000</span>
                            </div>

                            <h4>
                                <span>ģ��ͷ��������ɫ��</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderBackgroundColor"/>
                                        �Ƿ���Ч
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleHeaderBackgroundColor" cssClass="form-text"/>
                                <span>��������ɫֵ����#000000</span>
                            </div>


                            <h4>
                                ���ⱳ�����ͼƬ��
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleHeaderBackgroundImage"/>
                                        �Ƿ���Ч
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
									<p>����дͼƬ���·�����ļ���ʽGIF��JPG��PNG</p>
									<div class="form-group">
										<label class="form-label">����ͼƬ:</label>
										<div class="form-controls">
											<form:select path="moduleHeaderBackgroundRepeat" cssClass="select"
										items="${cssBackgroundRepeatMap}" />
										</div>
									</div>
									<div class="form-group">
										<label class="form-label">���뷽ʽ:</label>
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
                                <span>ģ������߿��ϸ��</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleBodyBorderWidth"/>
                                        �Ƿ���Ч
                                    </label>
                                </div>
                            </h4>
                            <div class="control-content">
                                <form:input path="moduleBodyBorderWidth" cssClass="form-text"/>
                                <span>����������ֵ����1px</span>
                            </div>
                            <h4>
                                <span>ģ������߿���ɫ��</span>
                                <div class="checkbox">
                                    <label>
                                        <form:checkbox path="enableModuleBodyBorderColor"/>
                                        �Ƿ���Ч
                                    </label>
                                </div>
                            </h4>
                            <!--<span class="colorblock"></span>-->
                            <div class="control-content">
                                <form:input path="moduleBodyBorderColor" cssClass="form-text"/>
                                <span>��������ɫֵ����#000000</span>
                            </div>


						</div>
					</div>
				</div>
			</div>
	<div class="form-group actions">
		<input type="submit" value="����" class="btn">
		<a href="/man/template/theme/${templateDirectoryName}/">ȡ��</a>
	</div>
</form:form> </article> </section>

<jsp:directive.include file="/WEB-INF/jsp/coda/commons-footer-js.jspf" />

<script type="text/javascript">
	KISSY.use('scripts/sdk/create-style/init');
</script>
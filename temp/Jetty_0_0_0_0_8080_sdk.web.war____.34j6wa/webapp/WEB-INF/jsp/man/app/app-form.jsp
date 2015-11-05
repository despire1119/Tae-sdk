<section class="content create-template"> <article class="box">
<div class="title">
	<h2>
		<c:choose>
			<c:when test="${editMode}">
					编辑
		    </c:when>
			<c:otherwise>
					创建
			</c:otherwise>
		</c:choose>应用</h2>
</div>
<form:form action="/man/app/submit/${editMode}/"
	commandName="appForm">

	<div class="form-group ${not empty appNameErrorMessage ? 'error':''}">
		<label class="form-label">应用名称:</label>
		<div class="form-controls">
			<c:if test="${editMode}">
					<c:set var="disableClass" value="disable" />
					<c:set var="disabled" value="true" />
					<form:hidden path="name"/>
			</c:if>
			<form:input path="name" cssClass="form-text ${disableClass}" disabled="${disabled}" />
			<span class="help-inline">  作为应用文件夹名称(必填，不支持中文 ${appNameErrorMessage})</span>
		</div>
	</div>

	<div class="form-group">
    		<label class="form-label">适用类型:</label>
    		<div class="form-controls radio-fix">
                <select id="type" name="type" class="select font ${disableClass}" <c:if test="${disabled}">disabled="true"</c:if>>
                    <c:forEach var="taeAppTypesEntry" items="${taeAppTypesMap}" >
                        <c:set var="type" value="${taeAppTypesEntry.key}" />
                        <c:set var="currentType" value="${appForm.type}" />
                        <c:set var="selected" value="${currentType eq type}" />
                        <option value="${type}" <c:if test="${selected}">selected="selected"</c:if>>&nbsp;&nbsp;${taeAppTypesEntry.value}&nbsp;&nbsp;</option>
                    </c:forEach>
                </select>
    		</div>
    </div>



    <div class="form-group" id="form-biz-type" >
        <label class="form-label">业务类型:</label>
        <div class="form-controls">
            <c:if test="${editMode}">
                <form:hidden path="bizType"/>
            </c:if>
            <select id="biz-type" name="bizType" class="select font ${disableClass}" <c:if test="${disabled}">disabled="true"</c:if>>
            </select>
            <label class="form-label">
                <a target="_blank" href="http://newwiki.zx.taobao.com/index.php?title=%E6%A8%A1%E6%9D%BF%E7%AE%80%E4%BB%8B">业务类型的区别</a>
            </label>
        </div>
    </div>

    <div class="form-group">
          <label class="form-label">语言类型:</label>
    		<div class="form-controls">
    			<c:if test="${editMode}">
    					<c:set var="disableClass" value="disable" />
    					<c:set var="disabled" value="true" />
    					<form:hidden path="language"/>
    			</c:if>
    			<form:select path="language" cssClass="select font ${disableClass}" disabled="${disabled}" items="${taeSupportedLanguagesList}" />
    		</div>
    	</div>

	<div class="form-group ${tneSN}">
		<label class="form-label">应用名称标题:</label>
		<div class="form-controls">
			<form:input path="title" cssClass="form-text"  />
			<span class="help-inline">  应用显示名称，可支持中文（必填）</span>
		</div>
	</div>
	<div class="form-group ${tveSN}">
		<label class="form-label">应用作者:</label>
		<div class="form-controls">
			<form:input path="author" cssClass="form-text" />
			<span class="help-inline">  应用作者（必填）</span>
		</div>
	</div>

	<div class="form-group">
		<label class="form-label">首页:</label>
		<div class="form-controls">
		    <form:input path="index" cssClass="form-text" />
			<span class="help-inline">  首页页面相对（应用根目录）路径，如:/index.php，仅支持PHP文件（必填）</span>
		</div>
	</div>

	<div class="form-group  ${not empty thumbnailBlankError ? 'error':'' }">
    		<label class="form-label">应用缩略图:</label>
    		<div class="form-controls">
    			<form:input path="thumbnail" cssClass="form-text" />
    			<span class="help-inline">  请填写图片相对（应用根目录）路径，如:assets/images/xxx.jpg，仅支持png、jpg和gif格式（必填）</span>
    		</div>
    </div>

	<div class="form-group">
		<label class="form-label">全局CSS:</label>
		<div class="form-controls">
			<form:input path="css" cssClass="form-text" />
            <span class="help-inline">  全局CSS文件相对（应用根目录）路径，如:/assets/stylesheets/global.css，仅支持CSS文件（必填）</span>
		</div>
	</div>

	<div class="form-group">
		<label class="form-label">应用描述:</label>
		<div class="form-controls">
			<form:textarea path="description" cssClass="textarea" />
		</div>
	</div>
	<div class="form-group actions">
		<input type="submit" value="${editMode ? '更新' : '创建' }" class="btn" /> <a href="/">取消</a>
	</div>
</form:form> </article> </section>


<script type="text/javascript">
    var editMode="${editMode}" == "true";
    <c:set var="taeAppTypesMapSize" value="${fn:length(taeAppTypesMap)}" />
    <c:set var="taeAppBizTypesMapSize" value="${fn:length(taeAppBizTypesMap)}" />
    <c:set var="bizTypesMapSize" value="${fn:length(bizTypesMap)}" />

    var taeAppTypes={<c:forEach var="taeAppTypesMapEntry" items="${taeAppTypesMap}" varStatus="loop">"${taeAppTypesMapEntry.key}":"${taeAppTypesMapEntry.value}"<c:if test="${loop.index<taeAppTypesMapSize-1}">,</c:if></c:forEach>};
    var taeAppBizTypes={<c:forEach var="taeAppBizTypesEntry" items="${taeAppBizTypesMap}" varStatus="loop">"${taeAppBizTypesEntry.key}":"${taeAppBizTypesEntry.value}"<c:if test="${loop.index<taeAppBizTypesMapSize-1}">,</c:if></c:forEach>};
    var bizTypes={<c:forEach var="bizTypesEntry" items="${bizTypesMap}" varStatus="loop">"${bizTypesEntry.key}":"${bizTypesEntry.value}"<c:if test="${loop.index<bizTypesMapSize-1}">,</c:if></c:forEach>};

    KISSY.use("node",function(S,Node){
        var $=Node.all;
        var E=S.Event;
        var D=S.DOM;
        var typeSelector=$("#type");
        var currentType="1";
        onTypeChange(currentType);
        typeSelector.on("change",function(){
            var opt = this.options[this.selectedIndex];
            var type= opt.value;
            onTypeChange(type);
            changeBizType(type);
        });

        function onTypeChange(type){
            if(!editMode){
                var typeInput =$("#biz-type");
                typeInput.attr("value",type);
            }
            var tTypesCSV=taeAppBizTypes[type];
            var tTypeSelect=$("#biz-type");
            var bizType = $("#bizType")? $("#bizType").attr("value") : -1;
            tTypeSelect.empty();
            //TODO 判断是否为空，为空，隐藏整个业务类型选择框
            if(tTypesCSV == null){
                D.hide('#form-biz-type');
                return;
            }
            var tTypesArray =tTypesCSV.split(",");
            for(var i=0;i<tTypesArray.length;i++){
                var tTypeId=tTypesArray[i];
                var selected= bizType == tTypeId;
                var tTypeLabel=bizTypes[tTypeId];
                var tTypeOpt=D.create("<option value=\""+tTypeId+"\">&nbsp;&nbsp;"+tTypeLabel+"&nbsp;&nbsp;</option>");
                if(editMode && !selected ){
                    continue;
                }
                tTypeSelect.append(tTypeOpt);
            }
            if(tTypeSelect.children().length <= 0 ){
                D.hide('#form-biz-type');
                return;
            }
        }

        function changeBizType(type){
            if(type == 1){
                D.show('#form-biz-type');
            }else{
                D.hide('#form-biz-type');
            }
        }
    });
</script>

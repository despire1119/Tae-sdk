<section class="content create-template"> <article class="box">
<c:set var="opLabel" value="����" />
<c:if test="${editMode}">
	    <c:set var="disableClass" value="disable" />
        <c:set var="disabled" value="true" />
        <c:set var="opLabel" value="�༭" />
</c:if>
<div class="title">
	<h2>${opLabel}ģ��</h2>
</div>
<form:form action="/man/microtemplate/submit/${editMode}/" commandName="templateForm">

    <c:set var="tdme" value="${requestScope['template.dir.name.error']}" />
    <c:if test="${not empty tdme}">
        <c:set var="tdmeSN" value="error" />
    </c:if>

    <c:set var="tne" value="${requestScope['template.name.error']}" />
    <c:if test="${not empty tne}">
        <c:set var="tneSN" value="error" />
    </c:if>

    <c:set var="tve" value="${requestScope['template.version.error']}" />
    <c:if test="${not empty tve}">
        <c:set var="tveSN" value="error" />
    </c:if>

    <div class="form-group">
        <label class="form-label">���õ���:</label>
        <div class="form-controls">
            <c:if test="${editMode}">
                <form:hidden path="applySite"/>
            </c:if>
            <select id="apply-site" name="applySite" class="select font ${disableClass}" <c:if test="${disabled}">disabled="true"</c:if>>
                <c:forEach var="applySiteEntry" items="${appSitesMap}" >
                    <c:set var="siteID" value="${applySiteEntry.key}" />
                    <c:set var="currentSiteID" value="${templateForm.applySite}" />
                    <c:set var="selected" value="${currentSiteID eq siteID}" />
                    <option value="${siteID}" <c:if test="${selected}">selected="selected"</c:if>>&nbsp;&nbsp;${applySiteEntry.value.title}&nbsp;&nbsp;</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="form-label">ģ������:</label>
        <div class="form-controls">
            <c:if test="${editMode}">
                <form:hidden path="templateTypeValue"/>
            </c:if>
            <select id="template-type" name="templateTypeValue" class="select font ${disableClass}" <c:if test="${disabled}">disabled="true"</c:if>>
            </select>
            <label class="form-label">
                <a target="_blank" href="http://newwiki.zx.taobao.com/index.php?title=%E6%A8%A1%E6%9D%BF%E7%AE%80%E4%BB%8B">ģ�����͵�����</a>
            </label>
        </div>
    </div>

    <div class="form-group">
        <label class="form-label">��������:</label>
        <div class="form-controls">
            <c:if test="${editMode}">
                <form:hidden path="saleType"/>
            </c:if>
            <select id="sale-type" name="saleType" class="select font ${disableClass}" <c:if test="${disabled}">disabled="true"</c:if>>
            </select>
            <label class="form-label">
                <a target="_blank" href="http://newwiki.zx.taobao.com/index.php?title=%E6%A8%A1%E6%9D%BF%E7%AE%80%E4%BB%8B">�������͵�����</a>
            </label>
        </div>
    </div>

    <div class="form-group ${tdmeSN}">
        <label class="form-label">Ŀ¼����:</label>
        <div class="form-controls">
            <c:if test="${editMode}">
                <form:hidden path="directoryName"/>
            </c:if>
            <form:input path="directoryName" cssClass="form-text ${disableClass}" disabled="${disabled}" />
            <span class="help-inline">  ��Ϊģ���ļ������ƣ���֧������(���ֻ����ʹ��Ӣ�ġ����֡�����"-"���»���"_"�����)</span>
        </div>
    </div>
    <div class="form-group ${tneSN}">
        <label class="form-label">ģ������:</label>
        <div class="form-controls">
            <form:input path="name" cssClass="form-text"  />
            <span class="help-inline">  ģ����ʾ���ƣ���֧�����ģ����</span>
        </div>
    </div>
    <div class="form-group ${tveSN}">
        <label class="form-label">ģ��汾:</label>
        <div class="form-controls">
            <form:input path="version" cssClass="form-text" />
            <span class="help-inline">  ��ʽX.Y.Z�������1.0.0��</span>
        </div>
    </div>

    <div class="form-group  ${not empty thumbnailBlankError ? 'error':'' }">
        <label class="form-label">ģ������ͼ:</label>
        <div class="form-controls">
            <form:input path="thumbnail" cssClass="form-text" />
            <span class="help-inline">  384x600������дͼƬ��ԣ�ģ�壩·������:assets/images/xxx.jpg����֧��png��jpg��gif��ʽ�����</span>
        </div>
    </div>
    <div class="form-group">
        <label class="form-label">������������:</label>
        <div class="form-controls">
            <form:select path="shopID" cssClass="select">
                <form:options items="${allShopsList}" itemLabel="title"	itemValue="id" />
            </form:select>
        </div>
    </div>
    <div class="form-group" id="USER_NICK">
        <label class="form-label">ģ�������û�:</label>
        <div class="form-controls">
            <form:input path="applyUser" cssClass="form-text" id="applyUser" />
            <span class="help-inline">
			<c:choose>
                <c:when test="${editMode}">
                    ����<a href="/man/template/sync/${templateDirectoryName}/">ͬ����������</a>
                </c:when>
                <c:otherwise>
                    ��д�Ա����ҵ����û�������
                </c:otherwise>
            </c:choose>
			��ѡ�</span>
        </div>
    </div>
    <div class="form-group">
        <label class="form-label">ģ�屸ע:</label>
        <div class="form-controls">
            <form:textarea path="description" cssClass="textarea" />
        </div>
    </div>
    <div class="form-group actions">
        <input type="submit" value="����" class="btn" /> <a href="/">ȡ��</a>
    </div>
</form:form>
</article>
</section>
<script type="text/javascript">
    var editMode="${editMode}" == "true";
    <c:set var="templateTypeMapSize" value="${fn:length(templateTypeMap)}" />
    <c:set var="siteTemplateTypesMapSize" value="${fn:length(siteTemplateTypesMap)}" />

    var templateTypes={<c:forEach var="templateTypeEntry" items="${templateTypeMap}" varStatus="loop">"${templateTypeEntry.key}":"${templateTypeEntry.value}"<c:if test="${loop.index<templateTypeMapSize-1}">,</c:if></c:forEach>};
    var siteTemplateTypes={<c:forEach var="siteTemplateTypeEntry" items="${siteTemplateTypesMap}" varStatus="loop">"${siteTemplateTypeEntry.key}":"${siteTemplateTypeEntry.value.supportedTemplateTypes}"<c:if test="${loop.index<siteTemplateTypesMapSize-1}">,</c:if></c:forEach>};
    <%--var siteTemplateUserNicks={<c:forEach var="entry" items="${siteTemplateDefaultUserNicksMap}" varStatus="loop">"${entry.key}":"${entry.value}"<c:if test="${loop.index<siteTemplateTypesMapSize-1}">,</c:if></c:forEach>};--%>

    <c:set var="saleTypesMapSize" value="${fn:length(saleTypesMap)}" />
    var saleTypes={<c:forEach var="entry" items="${saleTypesMap}" varStatus="loop">"${entry.key}":"${entry.value.name}"<c:if test="${loop.index<saleTypesMapSize-1}">,</c:if></c:forEach>};

    <c:set var="siteSaleTypesMapSize" value="${fn:length(siteSaleTypesMap)}" />
    var siteSaleTypes={<c:forEach var="entry" items="${siteSaleTypesMap}" varStatus="loop">"${entry.key}":${entry.value.supportedSaleTypesSet}<c:if test="${loop.index<siteSaleTypesMapSize-1}">,</c:if></c:forEach>};

    KISSY.use("node",function(S,Node){
        var $=Node.all;
        var E=S.Event;
        var D=S.DOM;
        var applySiteSelector=$("#apply-site");
        var currentSiteID="${templateForm.applySite}";
        onApplySiteChange(currentSiteID);
        applySiteSelector.on("change",function(){
            var opt = this.options[this.selectedIndex];
            var siteID= opt.value;
            onApplySiteChange(siteID);
        });

        function onApplySiteChange(siteID){
//            if(!editMode){
//                var userNick = siteTemplateUserNicks[siteID];
//                var applyUserInput =$("#applyUser");
//                applyUserInput.attr("value",userNick);
//                $("#tipsDefaultUserNick").html(userNick);
//            }
            var tTypesCSV=siteTemplateTypes[siteID];
            var tTypeSelect=$("#template-type");
            var templateType = $("#templateTypeValue")? $("#templateTypeValue").attr("value") : -1;
            tTypeSelect.empty();
            var tTypesArray =tTypesCSV.split(",");
            for(var i=0;i<tTypesArray.length;i++){
                var tTypeId=tTypesArray[i];
                var selected= templateType == tTypeId;
                var tTypeLabel=templateTypes[tTypeId];
                var tTypeOpt=D.create("<option value=\""+tTypeId+"\">&nbsp;&nbsp;"+tTypeLabel+"&nbsp;&nbsp;</option>");
                if(editMode && !selected ){
                    continue;
                }
                tTypeSelect.append(tTypeOpt);
            }

            var saleTypeSelect=$("#sale-type");
            var saleTypeHidden=$("#saleType");
            var saleTypeValue = saleTypeHidden ? saleTypeHidden.attr("value") : -1;
            saleTypeSelect.empty();
            var saleTypesArray=siteSaleTypes[siteID];

            for(var i=0;i<saleTypesArray.length;i++){
                var saleTypeID=saleTypesArray[i];
                var saleTypeLabel=saleTypes[saleTypeID];
                var selected= saleTypeValue == saleTypeID;
                var option=D.create("<option value=\""+saleTypeID+"\">&nbsp;&nbsp;"+saleTypeLabel+"&nbsp;&nbsp;</option>");
                if(editMode && !selected ){
                    continue;
                }
                saleTypeSelect.append(option);
            }
        }
    });
</script>
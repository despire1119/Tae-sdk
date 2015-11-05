{
"hasError":false,
"content":[
<c:forEach items="${modules}" var="module" varStatus="status">
    <jsp:directive.include file="/WEB-INF/jsp/microdesign/debug/module-part.jspf" />
</c:forEach>
]
}
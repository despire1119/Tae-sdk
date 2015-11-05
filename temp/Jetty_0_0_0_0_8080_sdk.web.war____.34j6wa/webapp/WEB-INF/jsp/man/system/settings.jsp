<section class="content system-setting"> <article class="box">
<div class="title">
	<h2>系统设置操作</h2>
</div>
<a id="ENABLE_PROD_MODE" href="/man/system/enable/production/mode/" class="btn" style="width:200px;">激活产品模式</a>
<br />
<br />
<a id="ENABLE_DEBUG_MODE" href="/man/system/enable/debug/mode/" class="btn" style="width:200px;">激活调试模式</a>
<br />
<br />
<a id="ENABLE_SYNC_COMPILE" href="/man/system/enable/synchronize/compilation/" class="btn" style="width:200px;">同步编译</a>
<br />
<br />
<a id="ENABLE_ASYNC_COMPILE" href="/man/system/disable/synchronize/compilation/" class="btn" style="width:200px;">异步编译</a>
<br />
<br />
<c:if test="${not empty message}">
	<div>
		<span>操作提示：${message}</span>
	</div>
</c:if> </article> </section>
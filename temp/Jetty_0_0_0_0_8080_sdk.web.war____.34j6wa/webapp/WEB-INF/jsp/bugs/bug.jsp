<section class="content"> <article class="box">
    <div class="title">
        <h2>缺陷反馈说明</h2>
        <c:choose>
            <c:when test="${active}"><h2 style="margin-left:40%;color:#990000">缺陷反馈功能已开启</h2></c:when>
            <c:otherwise><h2 style="margin-left:40%;color:#990000">缺陷反馈功能未开启</h2></c:otherwise>
        </c:choose>
    </div>
    <div class="guide-module">
        <h3>如何开启缺陷反馈功能</h3>
        <div class="steps">
            <dl class="step layout" style="height: 100%">
                <a target="_blank" href="http://zh.wikipedia.org/wiki/Hosts%E6%96%87%E4%BB%B6">
                    <dt></dt>
                    <dd>
                        <h4>1. 打开hosts文件添加域名绑定信息</h4>
                        <p style="margin-bottom:10px;color:#990000">添加信息二者选其一：127.0.0.1 tae-sdk.taobao.com </p>
                        <p style="color:#990000">或者 本机ip地址 tae-sdk.taobao.com</p>
                    </dd>
                </a>
            </dl>

            <dl class="step layout" style="height: 100%">
                <a href="#">
                    <dt></dt>
                    <dd>
                        <h4>2. 关闭SDK，重新启动；</h4>
                        <p>目的：完全激活反馈功能;</p>
                    </dd>
                </a>
            </dl>

            <dl class="step layout" style="height: 100%">
                <a href="https://login.taobao.com/member/login.jhtml?redirectURL=${hostAddress}:${port}">
                    <dt></dt>
                    <dd>
                        <h4>3. 登录淘宝</h4>
                        <p>目的：便于让设计师关注自己反馈的缺陷</p>
                    </dd> </a>
            </dl>

            <dl class="step layout" style="height: 100%">
                <a href="http://${hostAddress}:${port}">
                    <dt></dt>
                    <dd>
                        <h4>4. 通过tae-sdk.taobao.com访问</h4>
                    </dd> </a>
            </dl>

        </div>
    </div>
    <div class="guide-module">
        <h3>注意事项说明</h3>
        <div class="steps">
            <dl class="step layout" style="height: 100%">
                <dt></dt>
                <dd>
                    <h4>1. 二种登录方式</h4>
                    <p style="margin-bottom:10px;"><a target="_blank" href="https://login.taobao.com/member/login.jhtml?redirectURL=${hostAddress}:${port}">系统默认从淘宝登录页面登录</a></p>
                    <p><a target="_blank" href="https://oauth.taobao.com/authorize?client_id=12632866&redirect_uri=${hostAddress}:${port}&response_type=token&state=taobao.com.12632866">系统也允许从“https://oauth.taobao.com/authorize”登录</a></p>
                </dd>
            </dl>
        </div>
    </div>
</article> </section>
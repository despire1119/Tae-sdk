<section class="content"> <article class="box">
    <div class="title">
        <h2>ȱ�ݷ���˵��</h2>
        <c:choose>
            <c:when test="${active}"><h2 style="margin-left:40%;color:#990000">ȱ�ݷ��������ѿ���</h2></c:when>
            <c:otherwise><h2 style="margin-left:40%;color:#990000">ȱ�ݷ�������δ����</h2></c:otherwise>
        </c:choose>
    </div>
    <div class="guide-module">
        <h3>��ο���ȱ�ݷ�������</h3>
        <div class="steps">
            <dl class="step layout" style="height: 100%">
                <a target="_blank" href="http://zh.wikipedia.org/wiki/Hosts%E6%96%87%E4%BB%B6">
                    <dt></dt>
                    <dd>
                        <h4>1. ��hosts�ļ������������Ϣ</h4>
                        <p style="margin-bottom:10px;color:#990000">�����Ϣ����ѡ��һ��127.0.0.1 tae-sdk.taobao.com </p>
                        <p style="color:#990000">���� ����ip��ַ tae-sdk.taobao.com</p>
                    </dd>
                </a>
            </dl>

            <dl class="step layout" style="height: 100%">
                <a href="#">
                    <dt></dt>
                    <dd>
                        <h4>2. �ر�SDK������������</h4>
                        <p>Ŀ�ģ���ȫ���������;</p>
                    </dd>
                </a>
            </dl>

            <dl class="step layout" style="height: 100%">
                <a href="https://login.taobao.com/member/login.jhtml?redirectURL=${hostAddress}:${port}">
                    <dt></dt>
                    <dd>
                        <h4>3. ��¼�Ա�</h4>
                        <p>Ŀ�ģ����������ʦ��ע�Լ�������ȱ��</p>
                    </dd> </a>
            </dl>

            <dl class="step layout" style="height: 100%">
                <a href="http://${hostAddress}:${port}">
                    <dt></dt>
                    <dd>
                        <h4>4. ͨ��tae-sdk.taobao.com����</h4>
                    </dd> </a>
            </dl>

        </div>
    </div>
    <div class="guide-module">
        <h3>ע������˵��</h3>
        <div class="steps">
            <dl class="step layout" style="height: 100%">
                <dt></dt>
                <dd>
                    <h4>1. ���ֵ�¼��ʽ</h4>
                    <p style="margin-bottom:10px;"><a target="_blank" href="https://login.taobao.com/member/login.jhtml?redirectURL=${hostAddress}:${port}">ϵͳĬ�ϴ��Ա���¼ҳ���¼</a></p>
                    <p><a target="_blank" href="https://oauth.taobao.com/authorize?client_id=12632866&redirect_uri=${hostAddress}:${port}&response_type=token&state=taobao.com.12632866">ϵͳҲ����ӡ�https://oauth.taobao.com/authorize����¼</a></p>
                </dd>
            </dl>
        </div>
    </div>
</article> </section>
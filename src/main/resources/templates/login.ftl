<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <remove scope="session" var="SPRING_SECURITY_LAST_EXCEPTION"/>
        <@l.login "/login" false true />
    <#else>
        <@l.login "/login" false false />
    </#if>
</@c.page>
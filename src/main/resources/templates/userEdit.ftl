<#import "parts/common.ftl" as c>
<@c.page>
    User Editor
    <form action="/user" method="post">
        <input type="text" name="username" value="${user.username}">
        <#list roles as role>
            <div class="custom-control custom-checkbox custom-control-inline mt-1">
                <label>
                <input type="checkbox" class="form-check-input" id="materialChecked2" ${user.roles?seq_contains(role)?string("checked", "")}>
                ${role}
                </label>
            </div>
            <#--<div>-->
                <#--<label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>-->
            <#--</div>-->
        </#list>
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit">Save</button>
    </form>
</@c.page>
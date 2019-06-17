<#import "parts/common.ftl" as c>
<@c.page>
    <div class="card bg-light" style="width: 40rem; left: 50%; margin-left: -320px;">
        <div class="card-body">
            <h2>Редактировать данные пользователя ${user.username}</h2>
        </div>
    </div>
    <div class="card card-block mt-3" style="width: 40rem; left: 50%; margin-left: -320px">
        <div class="card-body">
            <form action="/user" method="post">
                <div class="md-form">
                    <input type="text" name="username"
                           value="${user.username}" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Имя пользователя</label>
                </div>
                <#list roles as role>
                    <div class="form-check mb-3">
                            <input type="checkbox" name="${role}" class="form-check-input" id="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                            <label class="custom-control-label" for="${role}">${role}</label>
                    </div>
                </#list>
                <input type="hidden" value="${user.id}" name="userId">
                <input type="hidden" value="${_csrf.token}" name="_csrf">
                <button type="submit" class="btn btn-primary btn-block z-depth-2">Сохранить</button>
            </form>
        </div>
    </div>
</@c.page>
<#import "parts/common.ftl" as c>
<@c.page>
    <div class="card bg-light">
        <div class="card-body">
            <h2>Пользователи</h2>
        </div>
    </div>
    <div class="card mt-3">
    <div class="card-body">
        <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th scope="col" style="width: 30%">Имя пользователя</th>
            <th scope="col">Роль</th>
            <th scope="col" style="width: 10%">Редактировать</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td><#list user.roles as role>${role}<#sep>, </#list></td>
                <td style="text-align: center"><a href="/user/${user.id}"><i class="fas fa-pen-square mx-1"></i></a> </td>
            </tr>
        </#list>
        </tbody>
    </table>
    </div>
    </div>
</@c.page>


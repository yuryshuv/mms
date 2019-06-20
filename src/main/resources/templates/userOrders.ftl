<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <div class="card bg-light">
        <div class="card-header">
            <h2>Наряды пользователя ${user.getUsername()}</h2>
        </div>
    </div>
    <div class="card mt-3">
        <div class="card-body">
            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th class="col" style="width: 10%">Название</th>
                    <th class="col" style="width: 10%">Описание</th>
                    <th class="col" style="width: 10%">Узел</th>
                    <th class="col" style="width: 15%">Ответственные</th>
                    <th class="col" style="width: 15%">Дата выдачи</th>
                    <th class="col" style="width: 15%">Дата выполнения</th>
                    <th class="col" style="width: 15%">Дата завершения</th>
                    <th class="col" style="width: 10%"><#if isAdmin>Редактировать<#else>Завершить</#if></th>
                </tr>
                </thead>
                <#list orders as order>
                    <tr>
                        <th scope="row">
                            ${order.orderName}
                        </th>
                        <td>${order.orderDescription}</td>
                        <td>${order.getUnit()}</td>
                        <td>
                            <#list order.getEmployees() as employee>
                                ${employee.getUsername()}
                                <#sep>,
                            </#list>
                        </td>
                        <td>${order.getStartTime()}</td>
                        <td>${order.getExpectedTime()}</td>
                        <td>${order.getEndTime()}</td>
                        <td style="text-align: center">
                            <form method="post" action="/orders/${order.orderId}/finish">
                                <input type="hidden" value="${order.orderId}" name="order">
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                <button type="submit" class="btn btn-flat btn-sm"><i class="fas fa-check"></i></button>
                            </form>
                            <#if isAdmin>
                                <form method="post" action="/orders/${order.orderId}/remove">
                                    <a href="/orders/${order.orderId}"><i class="fas fa-pen-square"></i></a>
                                    <input type="hidden" value="${order.orderId}" name="order">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-flat btn-sm"><i class="fas fa-times"></i></button>
                                </form>
                            </#if>
                        </td>
                    </tr>
                </#list>
            </table>
        </div>
    </div>
</@c.page>
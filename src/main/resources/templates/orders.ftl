<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <div class="card bg-light">
        <div class="card-body">
            <h2>Наряды</h2>
        </div>
    </div>
    <#if isAdmin>
        <div class="card mt-3">
            <div class="card-body">
                <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                    Добавить наряд
                </a>
                <div class="collapse <#if order??>show</#if>" id="collapseExample">
                    <div class="form-group mt-3">
                        <form method="post" action="/orders" enctype="multipart/form-data">
                            <div class="md-form">
                                <input type="text" class="form-control ${(orderNameError??)?string('is-invalid','')}"
                                       value="<#if order??>${order.orderName}</#if>" name="orderName" id="orderNameInput">
                                <#if orderNameError??>
                                    <div class="invalid-feedback">
                                        ${orderNameError}
                                    </div>
                                </#if>
                                <label for="orderNameInput">Название наряда</label>
                            </div>
                            <div class="md-form">
                                <input type="text" class="form-control ${(orderDescriptionError??)?string('is-invalid','')}"
                                       value="<#if order??>${order.orderDescription}</#if>" name="orderDescription" id="orderDescriptionInput">
                                <#if orderDescriptionError??>
                                    <div class="invalid-feedback">
                                        ${orderDescriptionError}
                                    </div>
                                </#if>
                                <label for="orderDescriptionInput">Описание наряда</label>
                            </div>
                            <select class="mdb-select md-form colorful-select dropdown-primary" name="unit" searchable="Поиск">
                                <option value="" disabled selected><#if unit??>${unit}<#else>Выберите узел</#if></option>
                                <#list modules as module>
                                    <#if module.units?size != 0>
                                        <optgroup label=${module.moduleName}>
                                            <#list module.units as unit>
                                                <option value="${unit.unitId}">${unit.unitName}</option>
                                            </#list>
                                        </optgroup>
                                    <#else>
                                    </#if>

                                </#list>
                            </select>
                            <select class="mdb-select md-form colorful-select dropdown-primary" name="userArray" multiple searchable="Поиск">
                                <option value="" disabled selected>Ответственные за выполнение</option>
                                <#list users as user>
                                    <option value="${user.id}">${user.username}</option>
                                </#list>
                            </select>
                            <div class="card mt-3">
                                <div class="card-header">
                                    Дата и время наряда
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col">
                                            <div class="md-form">
                                                <input placeholder="" type="text" name="expectedDate" id="date-picker-example" class="form-control datepicker">
                                                <label for="date-picker-example">Дата</label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="md-form">
                                                <input placeholder="" type="text" name="expectedTime" id="input_starttime" class="form-control timepicker">
                                                <label for="input_starttime">Время</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-primary mt-3">Добавить</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </#if>
    <div class="card mt-3">
        <div class="card-body">
            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th class="col" style="width: 5%">Статус</th>
                    <th class="col" style="width: 10%">Название</th>
                    <th class="col" style="width: 10%">Описание</th>
                    <th class="col" style="width: 10%">Узел</th>
                    <th class="col" style="width: 10%">Ответственные</th>
                    <th class="col" style="width: 15%">Дата выдачи</th>
                    <th class="col" style="width: 15%">Дата выполнения</th>
                    <th class="col" style="width: 15%">Дата завершения</th>
                    <th class="col" style="width: 10%"><#if isAdmin>Редактировать<#else>Завершить</#if></th>
                </tr>
                </thead>
                <#list orders as order>
                    <tr>
                        <td>
                            <#if order.isFinished()>
                                Завершен
                                <#else>
                                Выполняется
                            </#if>
                        </td>
                        <th scope="row">
                            ${order.orderName}
                        </th>
                        <td>${order.orderDescription}</td>
                        <td>${order.getUnit()}</td>
                        <td>
                            <#list order.getEmployees() as employee>
                                ${employee.getUsername()}
                                <#sep>,
                                <#else>
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
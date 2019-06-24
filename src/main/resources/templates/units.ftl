<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <div class="card bg-light">
        <div class="card-header">
            <h5>${unit.unitName}</h5>
        </div>
        <div class="card-body">
            ${unit.unitDescription}
        </div>
    </div>
    <ul class="nav nav-tabs mt-3 md-tabs light-blue" id="myTabMD" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="home-tab-md" data-toggle="tab" href="#home-md" role="tab" aria-controls="home-md"
               aria-selected="true">Наряды</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="profile-tab-md" data-toggle="tab" href="#profile-md" role="tab" aria-controls="profile-md"
               aria-selected="false">Запчасти</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="contact-tab-md" data-toggle="tab" href="#contact-md" role="tab" aria-controls="contact-md"
               aria-selected="false">Файлы</a>
        </li>
    </ul>
    <div class="tab-content card pt-5" id="myTabContentMD">
        <div class="tab-pane fade show active" id="home-md" role="tabpanel" aria-labelledby="home-tab-md">
            <#if isAdmin>
                <div class="card mt-3">
                    <div class="card-body">
                        <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                            Добавить наряд
                        </a>
                        <div class="collapse <#if order??>show</#if>" id="collapseExample">
                            <div class="form-group mt-3">
                                <form method="post" action="/units/${unit.unitId}/addOrder" enctype="multipart/form-data">
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
                                    <#if !order.isFinished()>
                                        <form method="post" action="/orders/${order.orderId}/finish">
                                            <input type="hidden" value="${order.orderId}" name="order">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                            <button type="submit" class="btn btn-flat btn-sm"><i class="fas fa-check"></i></button>
                                        </form>
                                    </#if>
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
        </div>
        <div class="tab-pane fade" id="profile-md" role="tabpanel" aria-labelledby="profile-tab-md">
            <#if isAdmin>
                <div class="card">
                    <div class="card-body">
                        <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                            Добавить запчасть
                        </a>

                        <div class="collapse" id="collapseExample">
                            <div class="form-group mt-3">
                                <form method="post" enctype="multipart/form-data">
                                    <div class="md-form">
                                        <input type="text" class="form-control" name="partName" id="partNameInput">
                                        <label for="partNameInput">Название запчасти</label>
                                    </div>
                                    <div class="md-form">
                                        <input type="text" class="form-control" name="partDescription" id="partDescriptionInput">
                                        <label for="partDescriptionInput">Описание запчасти</label>
                                    </div>
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-primary" name="btn" value="addPart">Добавить</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </#if>
            <div class="card mt-3">
                <div class="card-body">
                    <table id="dtBasicExample1" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 30%">Название</th>
                            <th scope="col">Описание</th>
                            <#if isAdmin>
                                <th scope="col" style="width: 10%">Редактировать</th>
                            </#if>
                        </tr>
                        </thead>
                        <#list parts as part>
                            <tr>
                                <th scope="row">${part.partName}</th>
                                <td>${part.partDescription}</td>
                                <#if isAdmin>
                                    <form method="post" action="/units/${unit.unitId}/removePart">
                                        <td style="text-align: center">
                                            <a href="/parts/${part.partId}"><i class="fas fa-pen-square"></i></a>
                                            <input type="hidden" value="${part.partId}" name="part">
                                            <input type="hidden" value="${unit.unitId}" name="unit">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                            <button type="submit" class="btn btn-flat btn-sm"><i class="fas fa-times"></i></button>
                                        </td>
                                    </form>
                                </#if>
                            </tr>
                        </#list>
                    </table>
                </div>
            </div>


        </div>
        <div class="tab-pane fade" id="contact-md" role="tabpanel" aria-labelledby="contact-tab-md">
            <#if isAdmin>
                <div class="card">
                    <div class="card-body">
                        <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                            Добавить файл
                        </a>
                        <div class="collapse" id="collapseExample">
                            <div class="form-group mt-3">
                                <form method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <div class="form-group">
                                        <div class="custom-file">
                                            <input type="file" name="file" id="customFile">
                                            <label class="custom-file-label" for="customFile">Выберите файл</label>
                                        </div>
                                    </div>
                                    <div class="md-form">
                                        <input type="text" class="form-control" name="documentDescription" id="documentDescriptionInput">
                                        <label for="documentDescriptionInput">Описание файла</label>
                                    </div>
                                    <button type="submit" class="btn btn-primary" name="btn" value="addDocument">Добавить</button>
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
                            <th scope="col" style="width: 30%">Файл</th>
                            <th scope="col">Описание</th>
                            <#if isAdmin>
                                <th scope="col" style="width: 10%">Удалить</th>
                            </#if>
                        </tr>
                        </thead>
                        <#list documents as document>
                            <tr>
                                <th scope="row">
                                    <#if document.documentName??>
                                        <a href="/doc/${document.documentName}">${document.documentName}</a>
                                    </#if>
                                </th>
                                <td>${document.documentDescription}</td>
                                <#if isAdmin>
                                    <form method="post" action="/units/${unit.unitId}/removeDocument">
                                        <td style="text-align: center">
                                            <input type="hidden" value="${document.documentId}" name="document">
                                            <input type="hidden" value="${unit.unitId}" name="unit">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                            <button type="submit" class="btn btn-flat btn-sm"><i class="fas fa-times"></i></button>
                                        </td>
                                    </form>
                                </#if>

                            </tr>
                        </#list>
                    </table>
                </div>
            </div>
        </div>
    </div>

</@c.page>

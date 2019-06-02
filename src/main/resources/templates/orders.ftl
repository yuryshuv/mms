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
                <div class="collapse" id="collapseExample">
                    <div class="form-group mt-3">
                        <form method="post" enctype="multipart/form-data">
                            <div class="md-form">
                                <input type="text" class="form-control" name="orderName" id="orderNameInput">
                                <label for="orderNameInput">Название наряда</label>
                            </div>
                            <div class="md-form">
                                <input type="text" class="form-control" name="orderDescription" id="orderDescriptionInput">
                                <label for="orderDescriptionInput">Описание наряда</label>
                            </div>
                            <select class="mdb-select md-form colorful-select dropdown-primary" multiple searchable="Поиск">
                                <option value="" disabled selected>Выберите узел/узлы</option>
                                <#list modules as module>
                                    <#if module.units?size != 0>
                                        <optgroup label=${module.moduleName}>
                                            <#list module.units as unit>
                                                <option value="">${unit.unitName}</option>
                                            </#list>
                                        </optgroup>
                                    </#if>
                                </#list>
                            </select>
                            <select class="mdb-select md-form colorful-select dropdown-primary" multiple searchable="Поиск">
                                <option value="" disabled selected>Ответственные за выполнение</option>
                                <#list users as user>
                                    <option value="">${user.username}</option>
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
    <#--<div class="card mt-3">-->
        <#--<div class="card-body">-->
            <#--<table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">-->
                <#--<thead>-->
                <#--<tr>-->
                    <#--<th class="col" style="width: 30%">Наряд</th>-->
                    <#--<th class="col">Описание</th>-->
                    <#--<th class="col" style="width: 10%">Узел</th>-->
                    <#--<#if isAdmin>-->
                        <#--<th class="col" style="width: 10%">Редактировать</th>-->
                    <#--</#if>-->
                <#--</tr>-->
                <#--</thead>-->
                <#--<#list parts as part>-->
                    <#--<tr>-->
                        <#--<th scope="row">${part.partName}</th>-->
                        <#--<td>${part.partDescription}</td>-->
                        <#--<td>${part.unit}</td>-->
                        <#--<#if isAdmin>-->
                            <#--<td style="text-align: center">-->
                                <#--<a><i class="fas fa-pen-square mx-1"></i></a>-->
                                <#--<a><i class="fas fa-times mx-1"></i></a>-->
                            <#--</td>-->
                        <#--</#if>-->
                    <#--</tr>-->
                <#--</#list>-->
            <#--</table>-->
        <#--</div>-->
    <#--</div>-->
</@c.page>
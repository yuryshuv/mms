<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <div class="card bg-light">
        <div class="card-body">
            <h2>Запчасти</h2>
        </div>
    </div>
    <#if isAdmin>
        <div class="card mt-3">
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

                            <select class="mdb-select md-form colorful-select dropdown-primary" name="unitName" searchable="Поиск">
                                <option value="" disabled selected>Выберите узел</option>
                                <#list modules as module>
                                    <#if module.units?size != 0>
                                        <optgroup label=${module.moduleName}>
                                            <#list module.units as unit>
                                                <option>${unit.unitName}</option>
                                            </#list>
                                        </optgroup>
                                    <#else>
                                    </#if>

                                </#list>
                            </select>
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-primary">Добавить</button>
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
                    <th class="col" style="width: 30%">Название</th>
                    <th class="col">Описание</th>
                    <th class="col" style="width: 10%">Узел</th>
                    <#if isAdmin>
                        <th class="col" style="width: 10%">Редактировать</th>
                    </#if>
                </tr>
                </thead>
                <#list parts as part>
                    <tr>
                        <th scope="row">${part.partName}</th>
                        <td>${part.partDescription}</td>
                        <td>${part.unit}</td>
                        <#if isAdmin>
                            <td style="text-align: center">
                                <a><i class="fas fa-pen-square mx-1"></i></a>
                                <a><i class="fas fa-times mx-1"></i></a>
                            </td>
                        </#if>
                    </tr>
                </#list>
            </table>
        </div>
    </div>
</@c.page>
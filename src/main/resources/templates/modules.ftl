<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <div class="card bg-light">
        <div class="card-header">
            <h2>${module.moduleName}</h2>
        </div>
        <div class="card-body">
            ${module.moduleDescription}
        </div>
    </div>
    <#if isAdmin>
        <div class="card mt-3">
            <div class="card-body">
                <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                    Добавить новый узел
                </a>

                <div class="collapse <#if unit??>show</#if>" id="collapseExample">
                    <div class="mt-3">
                        <form action="/modules/${module.moduleId}" method="post" class="needs-validation" enctype="multipart/form-data">
                            <div class="md-form">
                                <input type="text" class="form-control ${(unitNameError??)?string('is-invalid','')}"
                                       value="<#if unit??>${unit.unitName}</#if>" name="unitName" id="unitNameInput">
                                <#if unitNameError??>
                                    <div class="invalid-feedback">
                                        ${unitNameError}
                                    </div>
                                </#if>
                                <label for="unitNameInput">Название узла</label>
                            </div>
                            <div class="md-form">
                                <input type="text" class="form-control ${(unitDescriptionError??)?string('is-invalid','')}"
                                       value="<#if unit??>${unit.unitDescription}</#if>" name="unitDescription" id="unitDescriptionInput">
                                <#if unitDescriptionError??>
                                    <div class="invalid-feedback">
                                        ${unitDescriptionError}
                                    </div>
                                </#if>
                                <label for="unitDescriptionInput">Описание узла</label>
                            </div>
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
                    <th scope="col" style="width: 30%">Узел</th>
                    <th scope="col">Описание</th>
                    <#if isAdmin>
                        <th scope="col" style="width: 10%">Редактировать</th>
                    </#if>
                </tr>
                </thead>
                <#list units as unit>
                    <tr>
                        <th scope="row">
                            <a href="/units/${unit.unitId}">${unit.unitName}</a>
                        </th>
                        <td>${unit.unitDescription}</td>
                        <#if isAdmin>
                            <form method="post" action="/modules/${module.moduleId}/remove">
                                <td style="text-align: center">
                                    <a href="/modules/${module.moduleId}/${unit.unitId}"><i class="fas fa-pen-square"></i></a>
                                    <input type="hidden" value="${module.moduleId}" name="module">
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
</@c.page>
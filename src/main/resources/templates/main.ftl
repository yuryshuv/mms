<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <div class="card bg-light" xmlns="http://www.w3.org/1999/html">
        <div class="card-body">
            <h2>Объекты</h2>
        </div>
    </div>
    <#if isAdmin>
        <div class="card mt-3">
            <div class="card-body">
                <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                    Добавить объект
                </a>

                <div class="collapse <#if module??>show</#if>" id="collapseExample" >
                    <div class="form-group mt-3">
                        <form action="/main" class="needs-validation" method="post" enctype="multipart/form-data">
                            <div class="md-form">
                                <input type="text" class="form-control ${(moduleNameError??)?string('is-invalid','')}"
                                       value="<#if module??>${module.moduleName}</#if>" id="moduleNameInput" name="moduleName" />
                                <#if moduleNameError??>
                                    <div class="invalid-feedback">
                                        ${moduleNameError}
                                    </div>
                                </#if>
                                <label for="moduleNameInput">Название объекта</label>
                            </div>
                            <div class="md-form">
                                <input type="text" class="form-control ${(moduleDescriptionError??)?string('is-invalid','')}"
                                       value="<#if module??>${module.moduleDescription}</#if>" id="moduleDescriptionInput" name="moduleDescription" />
                                <#if moduleDescriptionError??>
                                    <div class="invalid-feedback">
                                        ${moduleDescriptionError}
                                    </div>
                                </#if>
                                <label for="moduleDescriptionInput">Описание объекта</label>
                            </div>
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-primary" name="btn" value="add">Добавить</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </#if>
    <div class="card mt-3">
        <form class="card-body">
            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th class="col" style="width: 30%">Название</th>
                    <th class="col">Описание</th>
                    <#if isAdmin>
                        <th class="col" style="width: 10%">Редактировать</th>
                    </#if>
                </tr>
                </thead>
                <#list modules as module>
                    <tr data-id="${module.moduleId}">
                        <th scope="row">
                            <a href="/modules/${module.moduleId}">${module.moduleName}</a>
                        </th>
                        <td>${module.moduleDescription}</td>
                        <#if isAdmin>
                            <form method="post" action="/main/remove">
                                <td style="text-align: center">
                                    <a href="/main/${module.moduleId}"><i class="fas fa-pen-square"></i></a>
                                    <input type="hidden" value="${module.moduleId}" name="module" />
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-flat btn-sm"><i class="fas fa-times"></i></button>
                                </td>
                            </form>
                        </#if>
                    </tr>
                </#list>
            </table>
        </form>
    </div>
</@c.page>
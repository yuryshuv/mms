<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <div class="form-row">
        <div class="form-group col-md-6">
            <form method="get" action="/documents" class="form-inline">
                <input type="text" name="filter" class="form-control" value="${filter?ifExists}" placeholder="Search by name">
                <button type="submit" class="btn btn-primary ml-2">Найти</button>
            </form>
        </div>
    </div>
    <#if isAdmin>
        <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
            Add new document
        </a>
    </#if>
    <div class="collapse" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <#--<div class="form-group">-->
                    <#--<input type="text" class="form-control" name="unitId" placeholder="ID модуля" />-->
                <#--</div>-->
                <#--<div class="form-group">-->
                    <#--<input type="text" class="form-control" name="unitName" placeholder="Имя модуля" />-->
                <#--</div>-->

                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" name="file" id="customFile">
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="documentDescription" placeholder="Описание документа">
                </div>
                <button type="submit" class="btn btn-primary">Добавить</button>
            </form>
        </div>
    </div>
    <table class="table mt-3">
        <thead>
        <tr>
            <#--<th scope="col">ID</th>-->
            <#--<th scope="col">Unit</th>-->
            <th scope="col">Document</th>
            <th scope="col">Description</th>
            <#if isAdmin>
                <th scope="col">Редактировать</th>
            </#if>
        </tr>
        </thead>
        <#list documents as document>
            <tr>
                <#--<th scope="row">${unit.unitId}</th>-->
                <#--<td>${document.documentName}</td>-->

                <th scope="row">
                    <#if document.documentName??>
                        <a href="/img/${document.documentName}">${document.documentName}</a>
                    <#--<img src="/img/${unit.filename}" class="img-fluid" alt="Responsive image">-->
                    </#if>
                </th>
                <td>${document.documentDescription}</td>
                <td>${document.authorName}</td>
            </tr>
        <#else>
            No documents
        </#list>
    </table>
</@c.page>
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
            <p></p>
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
                                        <a href="/img/${document.documentName}">${document.documentName}</a>
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

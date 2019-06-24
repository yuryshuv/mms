<#import "parts/common.ftl" as c>

<@c.page>
    <div class="card bg-light" style="width: 40rem; left: 50%; margin-left: -320px;">
        <div class="card-body">
            <h2>Запчасть: ${part.partName}</h2>
        </div>
    </div>
    <div class="card card-block mt-3" style="width: 40rem; left: 50%; margin-left: -320px">
        <div class="card-body">
            <form method="post">
                <div class="md-form">
                    <input type="text" name="partName"
                           value="${part.partName}" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Название запчасти</label>
                </div>
                <div class="md-form">
                    <input type="text" name="partDescription"
                           value="${part.partDescription}" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Описание запчасти</label>
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
                <div class="text-center pt-3 mb-4">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type="submit" class="btn btn-primary btn-block z-depth-2">Сохранить</button>
                </div>
            </form>
        </div>
    </div>
</@c.page>
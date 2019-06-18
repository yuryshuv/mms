<#import "parts/common.ftl" as c>

<@c.page>
    <div class="card bg-light" style="width: 40rem; left: 50%; margin-left: -320px;">
        <div class="card-body">
            <h2>Наряд: ${orderName}</h2>
        </div>
    </div>
    <div class="card card-block mt-3" style="width: 40rem; left: 50%; margin-left: -320px">
        <div class="card-body">
            <form method="post">
                <div class="md-form">
                    <input type="text" name="orderName"
                           value="${orderName}" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Название наряда</label>
                </div>
                <div class="md-form">
                    <input type="text" name="orderDescription"
                           value="${orderDescription}" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Описание наряда</label>
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
                    <option value="" disabled selected>
                        <#list order.getEmployees() as employee>
                            ${employee.getUsername()}
                            <#sep>,
                        </#list>
                    </option>
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
                <div class="text-center pt-3 mb-4">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type="submit" class="btn btn-primary btn-block z-depth-2">Сохранить</button>
                </div>
            </form>
        </div>
    </div>
</@c.page>
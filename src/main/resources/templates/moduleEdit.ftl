<#import "parts/common.ftl" as c>

<@c.page>
    <div class="card bg-light" style="width: 40rem; left: 50%; margin-left: -320px;">
        <div class="card-body">
            <h2>Объект: ${moduleName}</h2>
        </div>
    </div>
    <div class="card card-block mt-3" style="width: 40rem; left: 50%; margin-left: -320px">
        <div class="card-body">
            <form method="post">
                <div class="md-form">
                    <input type="text" name="moduleName"
                           value="${moduleName}" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Название объекта</label>
                </div>
                <div class="md-form">
                    <input type="text" name="moduleDescription"
                           value="${moduleDescription}" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Описание объекта</label>
                </div>
                <div class="text-center pt-3 mb-4">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type="submit" class="btn btn-primary btn-block z-depth-2">Сохранить</button>
                </div>
            </form>
        </div>
    </div>
</@c.page>
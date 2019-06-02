<#import "parts/common.ftl" as c>

<@c.page>
    <div class="card bg-light" style="width: 40rem; left: 50%; margin-left: -320px;">
        <div class="card-body">
            <h2>${username}</h2>
        </div>
    </div>
    <div class="card card-block mt-3" style="width: 40rem; left: 50%; margin-left: -320px">
        <div class="card-body">
            <form method="post">
                <div class="md-form">
                    <input type="password" name="oldPassword" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Введите пароль</label>
                </div>
                <div class="md-form">
                    <input type="password" name="password" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Новый пароль</label>
                </div>
                <div class="md-form">
                    <input type="password" name="password2" id="Form-pass5" class="form-control">
                    <label for="Form-pass5">Повторите новый пароль</label>
                </div>
                <div class="md-form">
                    <input type="text" name="email" id="Form-email4"
                           value="${email!''}" class="form-control">
                    <label for="Form-email4">Электронная почта</label>
                </div>
                <div class="text-center pt-3 mb-4">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type="submit" class="btn btn-primary btn-block z-depth-2">Сохранить</button>
                </div>
            </form>
        </div>
    </div>
</@c.page>
<#import "parts/common.ftl" as c>

<@c.page>
    <div class="card card-block mt-3" style="width: 40rem; left: 50%; margin-left: -320px">
        <div class="header pt-3 blue-gradient">
            <div class="row d-flex justify-content-start">
                <h3 class="white-text mt-3 mb-4 pb-1 mx-5">
                    Восстановление пароля
                </h3>
            </div>
        </div>
        <div class="card-body">
            <form action="/passwordRecovery" method="post">
                <div class="md-form">
                    <input type="text" name="username" id="Form-pass4" class="form-control">
                    <label for="Form-pass4">Введите имя пользователя</label>
                </div>
                <p class="font-small grey-text d-flex justify-content-end">Вернуться на форму <a href="/login" class="dark-grey-text font-weight-bold ml-1">входа</a></p>
                <div class="text-center pt-3 mb-4">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type="submit" class="btn btn-primary btn-block z-depth-2">Восстановить</button>
                </div>
            </form>
        </div>
    </div>
</@c.page>
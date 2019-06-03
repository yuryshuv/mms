<#macro login path isRegisterForm isBadCredentials>
    <section class="form-simple mt-3">
        <div class="card card-block" style="width: 40rem; left: 50%; margin-left: -320px;">
            <div class="header pt-3 blue-gradient">
                <div class="row d-flex justify-content-start">
                    <h3 class="white-text mt-3 mb-4 pb-1 mx-5"><#if isRegisterForm>Регистрация<#else>Вход</#if></h3>
                </div>
            </div>
            <div class="card-body mx-4 mt-4">
                <form action="${path}" method="post">
                    <div class="md-form">
                        <input type="text" name="username" id="Form-username"
                               value="<#if user??>${user.username}</#if>"
                               class="form-control ${(usernameError?? || isBadCredentials)?string('is-invalid','')}">
                        <#if usernameError??>
                            <div class="invalid-feedback">
                                ${usernameError}
                            </div>
                            <#else>
                                <div class="invalid-feedback">
                                    Неверное имя пользователя или пароль
                                </div>
                        </#if>
                        <label for="Form-username">Имя пользователя</label>
                    </div>
                    <div class="md-form">
                        <input type="password" name="password" id="Form-pass4"
                               class="form-control ${(passwordError??)?string('is-invalid','')}">
                        <#if passwordError??>
                            <div class="invalid-feedback">
                                ${passwordError}
                            </div>
                        </#if>
                        <label for="Form-pass4">Пароль</label>
                        <#if !isRegisterForm>
                            <p class="font-small grey-text d-flex justify-content-end">
                                Забыли
                                <a href="#" class="dark-grey-text font-weight-bold ml-1">
                                    пароль?
                                </a>
                            </p>
                        </#if>
                    </div>
                    <#if isRegisterForm>
                        <div class="md-form">
                            <input type="password" name="password2" id="Form-pass5"
                                   class="form-control ${(password2Error??)?string('is-invalid','')}">
                            <#if password2Error??>
                                <div class="invalid-feedback">
                                    ${password2Error}
                                </div>
                            </#if>
                            <label for="Form-pass5">Повторите пароль</label>
                        </div>
                        <div class="md-form">
                            <input type="text" name="email" id="Form-email4"
                                   value="<#if user??>${user.email}</#if>"
                                   class="form-control ${(emailError??)?string('is-invalid','')}">
                            <#if emailError??>
                                <div class="invalid-feedback">
                                    ${emailError}
                                </div>
                            </#if>
                            <label for="Form-email4">Электронная почта</label>
                        </div>
                    </#if>
                    <div class="text-center pt-3 mb-4">
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <button type="submit" class="btn btn-primary btn-block z-depth-2"><#if isRegisterForm>Создать<#else>Войти</#if></button>
                    </div>
                    <#if !isRegisterForm>
                        <p class="font-small grey-text d-flex justify-content-center">Не зарегистрированы? <a href="/registration" class="dark-grey-text font-weight-bold ml-1">Регистрация</a></p>
                    </#if>
                    <#if isRegisterForm>
                        <p class="font-small grey-text d-flex justify-content-center">Уже зарегистрированы? <a href="/login" class="dark-grey-text font-weight-bold ml-1">Войти</a></p>
                    </#if>
            </div>
        </div>
    </section>
</#macro>

<#macro logout>
    <form action="/logout" method="post" id="myForm">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <div onclick="submitform()">Выйти</div>
    </form>
</#macro>


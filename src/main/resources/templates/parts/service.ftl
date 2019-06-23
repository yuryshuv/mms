<#macro service path message>
    <section class="form-simple mt-3">
        <div class="card card-block" style="width: 40rem; left: 50%; margin-left: -320px;">
            <div class="header pt-3 <#if message == "Код активации не найден">red<#else>blue-gradient</#if>">
                <div class="row d-flex justify-content-start">
                    <h3 class="white-text mt-3 mb-4 pb-1 mx-5">
                        <#if message == "Код активации не найден">
                            Ошибка
                        <#else>
                            <#if message == "Пароль выслан на регистрационный email">
                                Восстановление пароля
                            <#else>
                                Благодарим за регистрацию!
                            </#if>
                        </#if>
                    </h3>
                </div>
            </div>
            <div class="card-body mx-4 mt-4">
                ${message}
                <br>
                <p class="font-small grey-text d-flex justify-content-end">
                    Вернуться на форму
                    <a href="/login" class="dark-grey-text font-weight-bold ml-1">
                        входа
                    </a>
                </p>
            </div>
        </div>
        <script language="JavaScript" type="text/javascript">
            function redirectToLogin(){
                location="/login";
            }
            setTimeout( 'redirectToLogin()', 3000 );
        </script>
    </section>
</#macro>
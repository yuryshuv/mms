<#include "security.ftl">
<#import "login.ftl" as l>

<#if name != "guest">
    <header>
        <!-- Navbar -->
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark blue-gradient scrolling-navbar">
            <!-- Breadcrumb-->
            <a class="navbar-brand" href="/main"><strong>Система управления обслуживанием</strong></a>
            <ul class="nav navbar-nav nav-flex-icons ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/main"><i class="fas fa-building"></i> <span class="clearfix d-none d-sm-inline-block">Объекты</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/parts"><i class="fas fa-tools mdb-gallery-view-icon"></i> <span class="clearfix d-none d-sm-inline-block">Запчасти</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/orders"><i class="fas fa-wrench"></i> <span class="clearfix d-none d-sm-inline-block">Наряды</span></a>
                </li>
                <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" href="/user"><i class="fas fa-users"></i> <span class="clearfix d-none d-sm-inline-block">Список пользователей</span></a>
                    </li>
                </#if>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-user"></i> <span class="clearfix d-none d-sm-inline-block">${name}</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="/user/profile">Мой профиль</a>
                        <a class="dropdown-item" href="/user/${user.id}/orders">Мои наряды</a>
                        <a class="dropdown-item"><@l.logout /></a>
                    </div>
                </li>
            </ul>
        </nav>
        <!-- /.Navbar -->
    </header>
</#if>
<#import "parts/common.ftl" as c>
<@c.page>
    <script language="JavaScript" type="text/javascript">
        function redirectToMain(){
            location="/main";
        }
        setTimeout( 'redirectToMain()', 10 );
    </script>
</@c.page>
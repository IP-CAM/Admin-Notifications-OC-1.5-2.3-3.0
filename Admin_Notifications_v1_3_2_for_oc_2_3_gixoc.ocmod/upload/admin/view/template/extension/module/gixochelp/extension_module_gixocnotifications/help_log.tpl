<div class="h4">
<div class="form-group">
Модуль использует отдельный файл логов для каждого из месседжеров.
</div>
<div class="form-group">
<label>Уровни логирования:</label>
<div class="page-header">
1. Выключены - логи не пишутся<a style="color: green;"> - рекомендуемый режим!</a>
</div>
<div class="page-header">
2. Только ошибки - в логи пишутся только ошибки соединения (ошибки cURL или ответ с ошибкой от сервера месседжера)
</div>
<div class="page-header">
3. Полные - в логи пишутся все запросы: успешные и ошибочные, также пишется тест уведомлений.<a style="color: red;"> Не рекомендуется использовать, только в режиме отладки!</a>
</div>
<img src="view/image/gixochelp/extension_module_gixocnotifications/logs.jpg" alt="logs" title="logs" style="max-width: 100%;"/>
</div>
<div class="form-group">
<div class="page-header">
Также Вы можете очистить файл логов или скачать его для дальнейшего анализа.
</div>
</div>
</div>
<?php if (isset($help_thanks)) echo $help_thanks; ?>
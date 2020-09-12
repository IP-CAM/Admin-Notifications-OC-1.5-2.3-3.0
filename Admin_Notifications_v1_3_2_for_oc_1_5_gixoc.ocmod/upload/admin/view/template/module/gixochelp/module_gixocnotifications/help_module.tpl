<div class="h3">
Вкладка <i class="fa fa-cog"></i> <?php echo $tab_general; ?>
</div>
<div class="h4">
<div class="form-group">
<label>Шаг 1.</label>
<div class="page-header">Статус: общий выключатель для всего модуля.</div>
<img src="view/image/gixochelp/module_gixocnotifications/status.jpg" alt="status" title="status" style="max-width: 100%;"/>
</div>
<div class="form-group">
<label>Шаг 2.</label>
<div class="page-header">Bot Ключ (токен): для работы модуля необходим токен каждого месседжера.</div>
<a href="#help_bot_telegram" data-toggle="collapse" class="btn btn-primary"><?php echo $entry_get_token_telegram; ?></a>
<div class="collapse" id="help_bot_telegram">
<div class="well">
<?php echo $help_bot_telegram; ?>
</div>
</div>
<a href="#help_bot_viber" data-toggle="collapse" class="btn btn-primary"><?php echo $entry_get_token_viber; ?></a>
<div class="collapse" id="help_bot_viber">
<div class="well">
<?php echo $help_bot_viber; ?>
</div>
</div>
</div>
<div class="form-group">
<label>Шаг 3.</label>
<div class="page-header">Полученный на предыдущем шаге токен введите в соответствующее поле.</div>
<img src="view/image/gixochelp/module_gixocnotifications/telegram_token.jpg" alt="telegram_token" title="telegram_token" style="max-width: 100%;"/>
<img src="view/image/gixochelp/module_gixocnotifications/viber_token.jpg" alt="viber_token" title="viber_token" style="max-width: 100%;"/>
<div class="page-header"><label>Другие настройки</label></div>
<?php echo $help_trim_messages; ?>
<?php echo $help_timeout; ?>
<?php echo $help_proxy; ?>
</div>
<div class="form-group">
<label>Шаг 4.</label>
<div class="page-header" style="color:red;">Обязательно (!) нажмите на кнопку <a class="btn btn-primary"><i class="fa fa-retweet"></i> Применить</a></div>
<div class="page-header">В случае успешной проверки появится сообщение</div>
<img src="view/image/gixochelp/module_gixocnotifications/success_token.jpg" alt="success_token" title="success_token" style="max-width: 100%;"/>
<div class="page-header">В случае ошибки подключения появится сообщение</div>
<img src="view/image/gixochelp/module_gixocnotifications/error_token.jpg" alt="error_token" title="error_token" style="max-width: 100%;"/>
</div>
</div>
<div class="h3">
Вкладка <i class="fa fa-users"></i> <?php echo $tab_users; ?>
</div>
<div class="h4">
<div class="page-header">Далее настраиваем уведомления для каждого администратора магазина.</div>
<div class="page-header">Обращаем ваше внимание на следущее: на этой и последующих вкладках указаны настройки для каждого месседжера отдельными вкладками! Учитывайте это при настройке.</div>
<img src="view/image/gixochelp/module_gixocnotifications/tab.jpg" alt="tab" title="tab" style="max-width: 100%;"/>
<div class="form-group">
<label>Шаг 5.</label>
<div class="page-header">Для получения уведомлений конкретным администратором необходимо <u>указать его ID</u> из месседжера</div>
<a href="#help_id_telegram" data-toggle="collapse" class="btn btn-primary"><?php echo $entry_id_telegram; ?></a>
<div class="collapse" id="help_id_telegram">
<div class="well">
<?php echo $help_id_telegram; ?>
</div>
</div>
<a href="#help_id_viber" data-toggle="collapse" class="btn btn-primary"><?php echo $entry_id_viber; ?></a>
<div class="collapse" id="help_id_viber">
<div class="well">
<?php echo $help_id_viber; ?>
</div>
</div>
</div>
<div class="form-group">
<label>Шаг 6.</label>
<div class="page-header">Полученный на предыдущем шаге ID введите в соответствующее поле.</div>
<img src="view/image/gixochelp/module_gixocnotifications/telegram_id.jpg" alt="telegram_token" title="telegram_token" style="max-width: 100%;"/>
<img src="view/image/gixochelp/module_gixocnotifications/viber_id.jpg" alt="viber_token" title="viber_token" style="max-width: 100%;"/>
</div>
<div class="form-group">
<label>Шаг 7.</label>
<div class="page-header">На данный момент реализованы уведомления о новых: заказе, покупателе, партнере, отзыве и возврате.</div>
<img src="view/image/gixochelp/module_gixocnotifications/users.jpg" alt="users" title="users" style="max-width: 100%;"/>
<div class="page-header">Так же добавлены уведомления о смене статуса заказа. Можно для каждого заказа указать свое уведомление. Уведомления приходят при: редактировании заказа в админке, смене статуса платежным модулем (если он использует стандартный функционал Opencart) и при новом заказе (возможно дублирование уведомлений). </div>
<img src="view/image/gixochelp/module_gixocnotifications/orders.jpg" alt="orders" title="orders" style="max-width: 100%;"/>
</div>
</div>
<div class="h3">
Вкладка <i class="fa fa-envelope"></i> <?php echo $tab_template; ?>
</div>
<div class="h4">
<div class="form-group">
<label>Шаг 8.</label>
<div class="page-header">Далее Вы можете настроить шаблон для каждого типа уведомления. Справа от каждого поля расположен блок поддерживаемых переменных. HTML разметка не поддерживается!</div>
<img src="view/image/gixochelp/module_gixocnotifications/template.jpg" alt="template" title="template" style="max-width: 100%;"/>
</div>
</div>
<div class="h3">
Вкладка <i class="fa fa-book"></i> <?php echo $tab_logs; ?>
</div>
<div class="h4">
<div class="form-group">
<label>Шаг 9.</label>
<div class="page-header">
<u>Настройка логов</u>
</div>
<?php echo $help_log; ?>
</div>
</div>
<?php if (isset($help_thanks)) echo $help_thanks; ?>
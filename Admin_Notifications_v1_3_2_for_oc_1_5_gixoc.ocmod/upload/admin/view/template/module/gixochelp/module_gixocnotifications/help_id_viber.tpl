<?php if (empty($webhook)) { ?>
<div class="h3" style="color: red;">
Для получения ID необходимо сначала:
</div> 
<div class="h4" style="color: red;">
<div class="page-header">
1. Получить Viber Bot Ключ (токен) по инструкции
</div>
<div class="page-header">
2. Ввести его в приложение
</div>
<div class="page-header">
3. Нажать кнопку <a class="btn btn-primary"><i class="fa fa-retweet"></i> Применить</a><br>
</div>
Затем Вы можете получить ID
</div> 
<div class="checkbox"></div>
<?php } ?>
<div class="h3">
С помощью вашего бота:
</div>
<div class="h4">
<div class="page-header">
1. <b>Откройте ваш бот.</b><?php if (!empty($webhook)) { ?> Для этого перейдите по ссылке <a href="<?php echo $webhook; ?>"><?php echo $webhook; ?></a>. Или отсканируйте этот QR-код на вашем приложении Viber.<?php } ?>
</div>
<?php if (!empty($webhook)) { ?></b><img src="<?php echo $qr; ?>" alt="id telegram" title="id telegram" style="max-width: 100%;"/><?php } ?>
<div class="page-header">
2. <b>Отправьте боту команду</b> /start . Или нажмите "Начать".
</div>
<div class="page-header">
3. В ответ Вам <b>бот пришлет ID</b> вида 1234567890ABcde=-. Скопируйте его в поле viber ID.
</div>
</div>
<?php if (isset($help_thanks)) echo $help_thanks; ?>
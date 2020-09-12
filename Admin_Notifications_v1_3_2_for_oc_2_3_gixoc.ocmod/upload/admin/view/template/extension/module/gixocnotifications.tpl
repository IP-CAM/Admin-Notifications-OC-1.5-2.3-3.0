<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button onclick="$('#content form #apply').attr('value', '1'); $('#' + $('#content form').attr('id')).submit();" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-success"><i class="fa fa-check"></i></button>
        <button type="submit" form="form-gixocnotifications" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
          <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($text_old_version) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $text_old_version; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($text_new_version) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $text_new_version; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i><?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-gixocnotifications" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><i class="fa fa-cog"></i> <?php echo $tab_general; ?></a></li>
            <li><a href="#tab-users" data-toggle="tab"><i class="fa fa-users"></i> <?php echo $tab_users; ?></a></li>
            <li><a href="#tab-template" data-toggle="tab"><i class="fa fa-envelope"></i> <?php echo $tab_template; ?></a></li>
            <li><a href="#tab-logs" data-toggle="tab"><i class="fa fa-book"></i> <?php echo $tab_logs; ?></a></li>
            <li><a href="#tab-help" data-toggle="tab" class="btn btn-info" style="color: #424242;"><b><i class="fa fa-life-ring"></i> <?php echo $tab_support; ?></b></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-general">
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
                <div class="col-sm-5">
                  <select name="gixocnotifications_status" id="input-status" class="form-control">
                  <?php if ($gixocnotifications_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                  </select>
                </div>
                <div class="col-sm-5">
                    <a class="btn btn-success" onclick="help('help_thanks');"><i class="fa fa-money"></i> <?php echo $help_thanks; ?></a>&nbsp;&nbsp;
                    <a class="btn btn-warning" onclick="help('help_module');"><i class="fa fa-life-ring"></i> <?php echo $help_module; ?></a>
                </div>
              </div>
              <fieldset>
                <legend>Telegram</legend>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="gixocnotifications_telegram_key"><?php echo $entry_telegram_key; ?></label>
                  <div class="col-sm-8">
                    <input type="text" name="gixocnotifications_telegram_key" value="<?php echo $gixocnotifications_telegram_key; ?>" placeholder="<?php echo $entry_telegram_key; ?>" id="telegram_key" class="form-control" />
                    <a onclick="help('help_bot_telegram');"><div style="text-align:center;font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i> <?php echo $entry_get_token_telegram; ?></div></a>
                  </div>
                  <div class="col-sm-2" id="telegram_webhook">
                    <a class="btn btn-primary" onclick="webhook('telegram');"><i class="fa fa-retweet"></i> <?php echo $button_verify; ?></a>
                  </div>
                </div>
                <div class="form-group">
                  <input type="hidden" name="gixocnotifications_telegram_webhook" value="<?php echo (!empty($gixocnotifications_telegram_webhook) ? $gixocnotifications_telegram_webhook : 'false') ?>" />
                  <label class="col-sm-2 control-label"><?php echo $help_trim_messages; ?> <a onclick="help('help_trim_messages');" style="font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i></a></label>
                  <div class="col-sm-3">
                    <label class="radio-inline">
                      <?php if ($gixocnotifications_telegram_trim_messages) { ?>
                      <input type="radio" name="gixocnotifications_telegram_trim_messages" value="1" checked="checked" />
                      <?php echo $text_cut; ?>
                      <?php } else { ?>
                      <input type="radio" name="gixocnotifications_telegram_trim_messages" value="1" />
                      <?php echo $text_cut; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$gixocnotifications_telegram_trim_messages) { ?>
                      <input type="radio" name="gixocnotifications_telegram_trim_messages" value="0" checked="checked" />
                      <?php echo $text_split; ?>
                      <?php } else { ?>
                      <input type="radio" name="gixocnotifications_telegram_trim_messages" value="0" />
                      <?php echo $text_split; ?>
                      <?php } ?>
                    </label>
                  </div>
                  <label class="col-sm-2 control-label"><?php echo $help_timeout; ?> <a onclick="help('help_timeout');" style="font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i></a></label>
                  <div class="col-sm-1">
                    <input type="text" name="gixocnotifications_telegram_timeout" value="<?php echo (!empty($gixocnotifications_telegram_timeout) ? $gixocnotifications_telegram_timeout : '5') ?>" placeholder="<?php echo $help_timeout; ?>"  class="form-control" />
                  </div>
                  <label class="col-sm-2 control-label"><?php echo $entry_proxy_status; ?> <a onclick="help('help_proxy');" style="font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i></a></label>
                  <div class="col-sm-2">
                    <label class="radio-inline">
                      <?php if ($gixocnotifications_telegram_proxy) { ?>
                      <input type="radio" name="gixocnotifications_telegram_proxy" value="1" checked="checked" onChange="show()" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="gixocnotifications_telegram_proxy" value="1" onChange="show()" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$gixocnotifications_telegram_proxy) { ?>
                      <input type="radio" name="gixocnotifications_telegram_proxy" value="0" checked="checked" onChange="hide()" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="gixocnotifications_telegram_proxy" value="0" onChange="hide()" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group" id="proxy" style="display: <?php echo ($gixocnotifications_telegram_proxy) ? 'block;' : 'none;' ?>">
                  <label class="col-sm-2 control-label" for="gixocnotifications_telegram_proxydata"><?php echo $entry_proxy; ?></label>
                  <div class="col-sm-8 required">
                  <table class="table table-bordered table-hover" id="proxy">
                    <thead>
                      <tr>
                        <td class="text-right"><?php echo $column_use; ?></td>
                        <td class="text-right control-label"><?php echo $column_ip; ?></td>
                        <td class="text-right control-label"><?php echo $column_port; ?></td>
                        <td class="text-right"><?php echo $column_login; ?></td>
                        <td class="text-right"><?php echo $column_password; ?></td>
                        <td class="text-right"><?php echo $button_delete; ?></td>
                      </tr>
                    </thead>
                    <tbody>
                      <?php if (!empty($gixocnotifications_telegram_proxydata)) { ?>
                      <?php foreach ($gixocnotifications_telegram_proxydata as $key => $proxy) { ?>
                      <tr id="proxy<?php echo $key; ?>">
                        <?php if (isset($proxy['status'])) { ?>
                        <td class="text-center"><input name="gixocnotifications_telegram_proxydata[<?php echo $key; ?>][status]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_telegram_proxydata[<?php echo $key; ?>][status]" type="checkbox"></td>
                        <?php } ?>
                        <td><input type="text" name="gixocnotifications_telegram_proxydata[<?php echo $key; ?>][ip]" value="<?php echo !empty($proxy['ip']) ? $proxy['ip'] : '' ?>" placeholder="<?php echo $column_ip; ?>"  class="form-control" /></td>
                        <td><input type="text" name="gixocnotifications_telegram_proxydata[<?php echo $key; ?>][port]" value="<?php echo !empty($proxy['port']) ? $proxy['port'] : '' ?>" placeholder="<?php echo $column_port; ?>"  class="form-control" /></td>
                        <td><input type="text" name="gixocnotifications_telegram_proxydata[<?php echo $key; ?>][login]" value="<?php echo !empty($proxy['login']) ? $proxy['login'] : '' ?>" placeholder="<?php echo $column_login; ?>"  class="form-control" /></td>
                        <td><input type="text" name="gixocnotifications_telegram_proxydata[<?php echo $key; ?>][password]" value="<?php echo !empty($proxy['password']) ? $proxy['password'] : '' ?>" placeholder="<?php echo $column_password; ?>"  class="form-control" /></td>
                        <td><button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger pull-right" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#proxy<?php echo $key; ?>').remove() : false;"><i class="fa fa-trash-o"></i></button></td>
                      </tr>
                      <?php } ?>
                      <?php } ?>
                    </tbody>
                  </table>
                  </div>
                  <div class="col-sm-2">
                    <button type="button" onclick="addProxy();" data-toggle="tooltip" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_proxy_add; ?></button>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend>Viber</legend>
                <?php if (!$ssl) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>  <?php echo $error_viber; ?></div>
                <?php } else { ?>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-viber"><?php echo $entry_viber_key; ?></label>
                  <div class="col-sm-8">
                    <input type="text" name="gixocnotifications_viber_key" value="<?php echo $gixocnotifications_viber_key; ?>" placeholder="<?php echo $entry_viber_key; ?>" id="viber_key" class="form-control" />
                    <a onclick="help('help_bot_viber');"><div style="text-align:center;font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i> <?php echo $entry_get_token_viber; ?></div></a>
                  </div>
                  <div class="col-sm-2" id="viber_webhook">
                    <a class="btn btn-primary" onclick="webhook('viber');"><i class="fa fa-retweet"></i> <?php echo $button_verify; ?></a>
                  </div>
                </div>
                <div class="form-group">
                <input type="hidden" name="gixocnotifications_viber_webhook" value="<?php echo !empty($gixocnotifications_viber_webhook) ? $gixocnotifications_viber_webhook : 'false' ?>" />
                  <label class="col-sm-2 control-label"><?php echo $help_trim_messages; ?> <a onclick="help('help_trim_messages');" style="font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i></a></label>
                  <div class="col-sm-3">
                    <label class="radio-inline">
                      <?php if ($gixocnotifications_viber_trim_messages) { ?>
                      <input type="radio" name="gixocnotifications_viber_trim_messages" value="1" checked="checked" />
                      <?php echo $text_cut; ?>
                      <?php } else { ?>
                      <input type="radio" name="gixocnotifications_viber_trim_messages" value="1" />
                      <?php echo $text_cut; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$gixocnotifications_viber_trim_messages) { ?>
                      <input type="radio" name="gixocnotifications_viber_trim_messages" value="0" checked="checked" />
                      <?php echo $text_split; ?>
                      <?php } else { ?>
                      <input type="radio" name="gixocnotifications_viber_trim_messages" value="0" />
                      <?php echo $text_split; ?>
                      <?php } ?>
                    </label>
                  </div>
                  <label class="col-sm-2 control-label"><?php echo $help_timeout; ?> <a onclick="help('help_timeout');" style="font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i></a></label>
                  <div class="col-sm-1">
                    <input type="text" name="gixocnotifications_viber_timeout" value="<?php echo !empty($gixocnotifications_viber_timeout) ? $gixocnotifications_viber_timeout : '5' ?>" placeholder="<?php echo $help_timeout; ?>"  class="form-control" />
                  </div>
                </div>
                <?php } ?>
              </fieldset>
            </div>
            <div class="tab-pane" id="tab-users">
              <ul class="nav nav-tabs">
              <?php foreach ($messengers as $keys => $messenger) { ?>
                <li <?php if ($keys == '1') { ?> class="active"<?php } ?>><a href="#tab-<?php echo $messenger; ?>_users" data-toggle="tab"><?php echo $messengers_text[$keys]; ?></a></li>
              <?php } ?>
              </ul>
              <div class="tab-content">
              <?php foreach ($messengers as $keys => $messenger) { ?>
                <div class="tab-pane <?php if ($keys == '1') { ?> active <?php } ?>required table-responsive" id="tab-<?php echo $messenger; ?>_users">
                  <table class="table table-bordered table-hover">
                    <thead>
                      <tr>
                        <td rowspan="2" class="text-right"><?php echo $column_user; ?></td>
                        <td rowspan="2" class="text-right control-label"><?php echo $messenger; ?><?php echo $column_id; ?> <a onclick="help_id('<?php echo $messenger; ?>');" style="font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i></a></td>
                        <td colspan="5" class="text-center"><?php echo $column_new; ?></td>
                        <td rowspan="2" class="text-right"><?php echo $tab_action; ?></td>
                      </tr>
                      <tr>
                        <td class="text-center"><?php echo $column_new_order; ?></td>
                        <td class="text-center"><?php echo $column_new_customer; ?></td>
                        <td class="text-center"><?php echo $column_new_affiliate; ?></td>
                        <td class="text-center"><?php echo $column_new_review; ?></td>
                        <td class="text-center"><?php echo $column_new_return; ?></td>
                      </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($users as $user) { ?>
                      <tr>
                        <td class="text-left"><?php echo $user['username']; ?></td>
                        <td><input type="text" name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][id_<?php echo $messenger; ?>]" value="<?php echo !empty($gixocnotifications_userdata[$messenger][$user['user_id']]['id_' . $messenger]) ? $gixocnotifications_userdata[$messenger][$user['user_id']]['id_' . $messenger] : '' ?>" placeholder="<?php echo $messenger; ?><?php echo $column_id; ?>" class="form-control" />
                        </td>
                        <?php if (isset($gixocnotifications_userdata[$messenger][$user['user_id']]['new_order_' . $messenger])) { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_order_<?php echo $messenger; ?>]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_order_<?php echo $messenger; ?>]" type="checkbox"></td>
                        <?php } ?>
                        <?php if (isset($gixocnotifications_userdata[$messenger][$user['user_id']]['new_customer_' . $messenger])) { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_customer_<?php echo $messenger; ?>]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_customer_<?php echo $messenger; ?>]" type="checkbox"></td>
                        <?php } ?>
                        <?php if (isset($gixocnotifications_userdata[$messenger][$user['user_id']]['new_affiliate_' . $messenger])) { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_affiliate_<?php echo $messenger; ?>]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_affiliate_<?php echo $messenger; ?>]" type="checkbox"></td>
                        <?php } ?>
                        <?php if (isset($gixocnotifications_userdata[$messenger][$user['user_id']]['new_review_' . $messenger])) { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_review_<?php echo $messenger; ?>]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_review_<?php echo $messenger; ?>]" type="checkbox"></td>
                        <?php } ?>
                        <?php if (isset($gixocnotifications_userdata[$messenger][$user['user_id']]['new_return_' . $messenger])) { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_return_<?php echo $messenger; ?>]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']; ?>][new_return_<?php echo $messenger; ?>]" type="checkbox"></td>
                        <?php } ?><td></td>
                      </tr>
                    <?php } ?>
                    <?php if (isset($gixocnotifications_groupdata[$messenger])) { ?>
                    <?php foreach ($gixocnotifications_groupdata[$messenger] as $id_group => $group) { ?>
                      <tr id="group_<?php echo $messenger; ?>_new_<?php echo $id_group; ?>">
                        <td><input type="text" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][name]" value="<?php echo $group['name'] ? $group['name'] : '' ?>" placeholder="<?php echo $text_comment; ?>"  class="form-control"  onKeyUp="ChangeOnFly(this, <?php echo $id_group; ?>,'<?php echo $messenger; ?>');" />
                        </td>
                        <td><input type="text" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][id]" value="<?php echo $group['id'] ? $group['id'] : '' ?>" placeholder="<?php echo $messenger; ?><?php echo $column_id; ?>"  class="form-control" />
                        </td>
                        <?php if (isset($group['new_order'])) { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_order]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_order]" type="checkbox"></td>
                        <?php } ?>
                        <?php if (isset($group['new_customer'])) { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_customer]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_customer]" type="checkbox"></td>
                        <?php } ?>
                        <?php if (isset($group['new_affiliate'])) { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_affiliate]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_affiliate]" type="checkbox"></td>
                        <?php } ?>
                        <?php if (isset($group['new_review'])) { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_review]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_review]" type="checkbox"></td>
                        <?php } ?>
                        <?php if (isset($group['new_return'])) { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_return]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][new_return]" type="checkbox"></td>
                        <?php } ?>
                        <td><button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger pull-right" onclick="confirm('<?php echo $text_confirm; ?>') ? delGroup('<?php echo $messenger; ?>', <?php echo $id_group; ?>) : false;"><i class="fa fa-trash-o"></i></button></td>
                      </tr>
                    <?php } ?>
                    <?php } ?>
                      <tr id="add_new_<?php echo $messenger; ?>">
                        <td colspan="8">
                          <button type="button" onclick="addGroup<?php echo $messenger; ?>();" data-toggle="tooltip" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                  <table class="table table-bordered table-hover table-condensed" id="add_orders_<?php echo $messenger; ?>">
                    <thead>
                      <tr>
                        <td rowspan="2" class="text-left"><?php echo $column_user; ?></td>
                        <td colspan="<?php echo count($order_statuses); ?>" class="text-center"><?php echo $column_orders; ?></td>
                      </tr>
                      <tr>
                        <?php foreach ($order_statuses as $order_status) { ?>
                        <td class="text-center"><?php echo $order_status['name']; ?></td>
                        <?php } ?>
                      </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($users as $user) { ?>
                      <tr>
                        <td class="text-left"><?php echo $user['username']; ?></td>
                        <?php foreach ($order_statuses as $order_status) { ?>
                        <?php if (isset($gixocnotifications_userdata[$messenger][$user['user_id']]['orders_' . $messenger][$order_status['order_status_id']])) { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']?>][orders_<?php echo $messenger; ?>][<?php echo $order_status['order_status_id']; ?>]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_userdata[<?php echo $messenger; ?>][<?php echo $user['user_id']?>][orders_<?php echo $messenger; ?>][<?php echo $order_status['order_status_id']; ?>]" type="checkbox"></td>
                        <?php } ?> 
                        <?php } ?>
                      </tr>
                    <?php } ?>
                    <?php if (isset($gixocnotifications_groupdata[$messenger])) { ?>
                    <?php foreach ($gixocnotifications_groupdata[$messenger] as $id_group => $group) { ?>
                      <tr id="group_<?php echo $messenger; ?>_orders_<?php echo $id_group; ?>">
                        <td class="text-left" id="group_<?php echo $messenger; ?>_orders_<?php echo $id_group; ?>_name" ><?php echo $group['name'] ? $group['name'] : '' ?></td>
                        <?php foreach ($order_statuses as $order_status) { ?>
                        <?php if (isset($group['orders'][$order_status['order_status_id']])) { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][orders][<?php echo $order_status['order_status_id']; ?>]" type="checkbox" checked></td>
                        <?php } else { ?>
                        <td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][<?php echo $id_group; ?>][orders][<?php echo $order_status['order_status_id']; ?>]" type="checkbox"></td>
                        <?php } ?>
                        <?php } ?>
                      </tr>
                    <?php } ?>
                    <?php } ?>
                    </tbody>
                  </table>
                </div>
              <?php } ?>
              </div>
            </div>
            <div class="tab-pane" id="tab-template">
              <ul class="nav nav-tabs">
              <?php foreach ($messengers as $keys => $messenger) { ?>
                <li <?php if ($keys == '1') { ?> class="active"<?php } ?>><a href="#tab-<?php echo $messenger; ?>_template" data-toggle="tab"><?php echo $messengers_text[$keys]; ?></a></li>
              <?php } ?>
              </ul>
              <div class="tab-content">
              <?php foreach ($messengers as $keys => $messenger) { ?>
                <div class="tab-pane <?php if ($keys == '1') { ?> active <?php } ?>" id="tab-<?php echo $messenger; ?>_template">
                  <fieldset>
                    <legend><?php echo $legend_new_order; ?> (<?php echo $messengers_text[$keys]; ?>)</legend>
                    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $help_new_order; ?></div>
                    <div class="form-group required">
                      <div class="col-sm-8">
                        <?php foreach ($languages as $language) { ?>
                        <div class="input-group">
                          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                          <textarea name="gixocnotifications_langdata[<?php echo $language['language_id']; ?>][new_order_<?php echo $messenger; ?>]" rows="7" placeholder="<?php echo $help_new_order_ex; ?>" class="form-control"><?php echo !empty($gixocnotifications_langdata[$language['language_id']]['new_order_' . $messenger]) ? $gixocnotifications_langdata[$language['language_id']]['new_order_' . $messenger] : $help_new_order_ex; ?></textarea>
                        </div>
                        <?php } ?>
                      </div>
                      <div class="col-sm-4">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTable1<?php echo $messenger; ?>" class="btn btn-primary collapsed"><?php echo $text_variables; ?></a>
                        <div id="collapseTable1<?php echo $messenger; ?>" class="panel-collapse collapse">
                         <table class="table table-bordered table-hover">
                          <tbody>
                            <?php foreach ($ordervar as $key => $list) { ?>
                            <tr>
                              <td class="text-left"><?php echo $key; ?></td>
                              <td class="text-left"><?php echo $list; ?></td>
                            </tr>
                            <?php } ?>
                            <?php foreach ($simplevar as $id => $value) { ?>
                            <tr>
                              <td class="text-left"><?php echo $id; ?></td>
                              <td class="text-left"><?php echo $value['label'][$langcode]; ?></td>
                            </tr>
                            <?php } ?>
                          </tbody>
                         </table>
                        </div>
                      </div>
                    </div>
                  </fieldset>
                  <fieldset>
                    <legend><?php echo $legend_new_customer; ?> (<?php echo $messengers_text[$keys]; ?>)</legend>
                    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $help_new_customer; ?></div>
                    <div class="form-group required">
                      <div class="col-sm-8">
                        <?php foreach ($languages as $language) { ?>
                        <div class="input-group">
                          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                          <textarea name="gixocnotifications_langdata[<?php echo $language['language_id']; ?>][new_customer_<?php echo $messenger; ?>]" rows="7" placeholder="<?php echo $help_new_customer_ex; ?>" class="form-control"><?php echo !empty($gixocnotifications_langdata[$language['language_id']]['new_customer_' . $messenger]) ? $gixocnotifications_langdata[$language['language_id']]['new_customer_' . $messenger] : $help_new_customer_ex; ?></textarea>
                        </div>
                        <?php } ?>
                      </div>
                      <div class="col-sm-4">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTable2<?php echo $messenger; ?>" class="btn btn-primary collapsed"><?php echo $text_variables; ?></a>
                        <div id="collapseTable2<?php echo $messenger; ?>" class="panel-collapse collapse">
                         <table class="table table-bordered table-hover">
                          <tbody>
                            <?php foreach ($customervar as $key => $list) { ?>
                            <tr>
                              <td class="text-left"><?php echo $key; ?></td>
                              <td class="text-left"><?php echo $list; ?></td>
                            </tr>
                            <?php } ?>
                            <?php foreach ($simplevar as $id => $value) { ?>
                            <?php if (($value['object'] == 'customer') || ($value['object'] == 'address')) { ?>
                            <tr>
                              <td class="text-left"><?php echo $id; ?></td>
                              <td class="text-left"><?php echo $value['label'][$langcode]; ?></td>
                            </tr>
                            <?php } ?>
                            <?php } ?>
                          </tbody>
                         </table>
                        </div>
                      </div>
                    </div>
                  </fieldset>
                  <fieldset>
                    <legend><?php echo $legend_new_affiliate; ?> (<?php echo $messengers_text[$keys]; ?>)</legend>
                    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $help_new_affiliate; ?></div>
                    <div class="form-group required">
                      <div class="col-sm-8">
                        <?php foreach ($languages as $language) { ?>
                        <div class="input-group">
                          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                          <textarea name="gixocnotifications_langdata[<?php echo $language['language_id']; ?>][new_affiliate_<?php echo $messenger; ?>]" rows="7" placeholder="<?php echo $help_new_affiliate_ex; ?>" class="form-control"><?php echo !empty($gixocnotifications_langdata[$language['language_id']]['new_affiliate_' . $messenger]) ? $gixocnotifications_langdata[$language['language_id']]['new_affiliate_' . $messenger] : $help_new_affiliate_ex; ?></textarea>
                        </div>
                        <?php } ?>
                      </div>
                      <div class="col-sm-4">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTable3<?php echo $messenger; ?>" class="btn btn-primary collapsed"><?php echo $text_variables; ?></a>
                        <div id="collapseTable3<?php echo $messenger; ?>" class="panel-collapse collapse">
                         <table class="table table-bordered table-hover">
                          <tbody>
                            <?php foreach ($affiliatevar as $key => $list) { ?>
                            <tr>
                              <td class="text-left"><?php echo $key; ?></td>
                              <td class="text-left"><?php echo $list; ?></td>
                            </tr>
                            <?php } ?>
                          </tbody>
                         </table>
                        </div>
                      </div>
                    </div>
                  </fieldset>
                  <fieldset>
                    <legend><?php echo $legend_new_review; ?> (<?php echo $messengers_text[$keys]; ?>)</legend>
                    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $help_new_review; ?></div>
                    <div class="form-group required">
                      <div class="col-sm-8">
                        <?php foreach ($languages as $language) { ?>
                        <div class="input-group">
                          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                          <textarea name="gixocnotifications_langdata[<?php echo $language['language_id']; ?>][new_review_<?php echo $messenger; ?>]" rows="7" placeholder="<?php echo $help_new_review_ex; ?>" class="form-control"><?php echo !empty($gixocnotifications_langdata[$language['language_id']]['new_review_' . $messenger]) ? $gixocnotifications_langdata[$language['language_id']]['new_review_' . $messenger] : $help_new_review_ex; ?></textarea>
                        </div>
                        <?php } ?>
                      </div>
                      <div class="col-sm-4">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTable4<?php echo $messenger; ?>" class="btn btn-primary collapsed"><?php echo $text_variables; ?></a>
                        <div id="collapseTable4<?php echo $messenger; ?>" class="panel-collapse collapse">
                         <table class="table table-bordered table-hover">
                          <tbody>
                            <?php foreach ($reviewvar as $key => $list) { ?>
                            <tr>
                              <td class="text-left"><?php echo $key; ?></td>
                              <td class="text-left"><?php echo $list; ?></td>
                            </tr>
                            <?php } ?>
                          </tbody>
                         </table>
                        </div>
                      </div>
                    </div>
                  </fieldset>
                  <fieldset>
                    <legend><?php echo $legend_new_return; ?> (<?php echo $messengers_text[$keys]; ?>)</legend>
                    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $help_new_return; ?></div>
                    <div class="form-group required">
                      <div class="col-sm-8">
                        <?php foreach ($languages as $language) { ?>
                        <div class="input-group">
                          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                          <textarea name="gixocnotifications_langdata[<?php echo $language['language_id']; ?>][new_return_<?php echo $messenger; ?>]" rows="7" placeholder="<?php echo $help_new_return_ex; ?>" class="form-control"><?php echo !empty($gixocnotifications_langdata[$language['language_id']]['new_return_' . $messenger]) ? $gixocnotifications_langdata[$language['language_id']]['new_return_' . $messenger] : $help_new_return_ex; ?></textarea>
                        </div>
                        <?php } ?>
                      </div>
                      <div class="col-sm-4">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTable5<?php echo $messenger; ?>" class="btn btn-primary collapsed"><?php echo $text_variables; ?></a>
                        <div id="collapseTable5<?php echo $messenger; ?>" class="panel-collapse collapse">
                         <table class="table table-bordered table-hover">
                          <tbody>
                            <?php foreach ($returnvar as $key => $list) { ?>
                            <tr>
                              <td class="text-left"><?php echo $key; ?></td>
                              <td class="text-left"><?php echo $list; ?></td>
                            </tr>
                            <?php } ?>
                          </tbody>
                         </table>
                        </div>
                      </div>
                    </div>
                  </fieldset>
                  <fieldset>
                    <legend><?php echo $legend_orders; ?> (<?php echo $messengers_text[$keys]; ?>)</legend>
                    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $help_orders; ?></div>
                    <?php foreach ($order_statuses as $order_status) { ?>
                      <div class="form-group required">
                        <div class="col-sm-2">
                          <label><?php echo $order_status['name']; ?></label>
                        </div>
                        <div class="col-sm-6">
                          <?php foreach ($languages as $language) { ?>
                          <div class="input-group">
                            <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                            <textarea name="gixocnotifications_langdata[<?php echo $language['language_id']; ?>][orders_<?php echo $messenger; ?>][<?php echo $order_status['order_status_id']; ?>]" rows="7" placeholder="<?php echo $help_orders_ex; ?>" class="form-control"><?php echo !empty($gixocnotifications_langdata[$language['language_id']]['orders_' . $messenger][$order_status['order_status_id']]) ? $gixocnotifications_langdata[$language['language_id']]['orders_' . $messenger][$order_status['order_status_id']] : $help_orders_ex; ?></textarea>
                          </div>
                          <?php } ?>
                        </div>
                        <div class="col-sm-4">
                          <a data-toggle="collapse" data-parent="#accordion" href="#collapseOrders<?php echo $order_status['order_status_id']; ?><?php echo $messenger; ?>" class="btn btn-primary collapsed"><?php echo $text_variables; ?></a>
                          <div id="collapseOrders<?php echo $order_status['order_status_id']; ?><?php echo $messenger; ?>" class="panel-collapse collapse">
                           <table class="table table-bordered table-hover">
                            <tbody>
                              <?php foreach ($ordervar as $key => $list) { ?>
                              <tr>
                                <td class="text-left"><?php echo $key; ?></td>
                                <td class="text-left"><?php echo $list; ?></td>
                              </tr>
                              <?php } ?>
                              <?php foreach ($simplevar as $id => $value) { ?>
                              <tr>
                                <td class="text-left"><?php echo $id; ?></td>
                                <td class="text-left"><?php echo $value['label'][$langcode]; ?></td>
                              </tr>
                              <?php } ?>
                            </tbody>
                           </table>
                          </div>
                        </div>
                      </div>
                    <?php } ?>
                  </fieldset>
                </div>
             <?php } ?>
           </div>
           </div>
            <div class="tab-pane" id="tab-logs">
              <ul class="nav nav-tabs">
              <?php foreach ($messengers as $keys => $messenger) { ?>
                <li <?php if ($keys == '1') { ?> class="active"<?php } ?>><a href="#tab-<?php echo $messenger; ?>_logs" data-toggle="tab"><?php echo $messengers_text[$keys]; ?></a></li>
              <?php } ?>
              </ul>
              <div class="tab-content">
              <?php foreach ($messengers as $keys => $messenger) { ?>
                <div class="tab-pane <?php if ($keys == '1') { ?> active <?php } ?>" id="tab-<?php echo $messenger; ?>_logs">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_status; ?> <a onclick="help('help_log');" style="font-size:15px;cursor: pointer;"><i class="fa fa-life-ring"></i></a></label>
                    <div class="col-sm-7">
                      <select name="gixocnotifications_logs[<?php echo $messenger; ?>]" id="input-status" class="form-control">
                      <?php foreach ($logs as $key => $value) { ?>
                        <?php if ($key == $gixocnotifications_logs[$messenger]) { ?>
                        <option value="<?php echo $key; ?>" selected="selected"><?php echo $value; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $key; ?>"><?php echo $value; ?></option>
                        <?php } ?>
                      <?php } ?>
                      </select>
                    </div>
                    <div class="col-sm-3">
                      <a class="btn btn-danger" onclick="clearLog('<?php echo $messenger; ?>');"><i class="fa fa-download"></i> <?php echo $button_delete; ?></a>
                      <a class="btn btn-primary" onclick="downloadLog('<?php echo $messenger; ?>');"><i class="fa fa-download"></i> <?php echo $button_download; ?></a>
                    </div>
                  </div>
                  <div class="form-group">
                    <textarea id="log_<?php echo $messenger; ?>" wrap="on" rows="15" readonly class="form-control"><?php echo $logs_file[$messenger]; ?></textarea>
                  </div>
                </div>
              <?php } ?>
              </div>
            </div>
            <div class="tab-pane" id="tab-help">
              <div class="well">
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $tab_support; ?></label>
                  <div class="col-sm-8">
                    <a class="btn btn-warning" onclick="help('help_faq');"><i class="fa fa-question-circle"></i> <?php echo $help_faq; ?></a>&nbsp;&nbsp;
                    <a class="btn btn-info" onclick="help('help_support');"><i class="fa fa-life-ring"></i> <?php echo $tab_support; ?></a>&nbsp;&nbsp;
                    <a class="btn btn-success" onclick="help('help_thanks');"><i class="fa fa-money"></i> <?php echo $help_thanks; ?></a>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_developer; ?></label>
                <div class="col-sm-10">GixOC: <a target="_blank" href="https://gixoc.ru" class="btn btn-link"><i class="fa fa-globe"></i> GixOC.ru</a>|<a target="_blank" href="tg://resolve?domain=GixOC_NotificationsBot" class="btn btn-link"><i class="fa fa-paper-plane"></i> @GixOC_NotificationsBot</a>|<a target="_blank" href="viber://pa/info?uri=GixOC_NotificationsBot" class="btn btn-link"><i class="fa fa-phone"></i> @GixOC_NotificationsBot</a></div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $help_license; ?></label>
                <div class="col-sm-10"><a onclick="help('help_license');" class="btn btn-link">GNU General Public License version 3 (GPLv3)</a></div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $button_download; ?></label>
                <div class="col-sm-10">
                  <?php echo $text_url_download; ?><br>
                  <li class="page-header"><a target="_blank" href="https://github.com/gixoc/AdminNotifications">GitHub.com</a></li>
                  <li class="page-header"><a target="_blank" href="https://opencartforum.com/files/file/7109-admin-notifications-uvedomleniya-administratora-telegram-viber/">OpenCartForum.com</a></li>
                  <li class="page-header"><a target="_blank" href="http://forum.opencart-russia.ru/threads/admin-notifications-uvedomlenija-administratora-telegram-viber.8186/">OpenCart-Russia.ru</a></li>
                  <li class="page-header"><a target="_blank" href="https://liveopencart.ru/opencart-moduli-shablony/moduli/mail-sms/admin-notifications-uvedomleniya-administratora-telegram-viber">LiveOpenCart.ru</a></li>
                  <li class="page-header"><a target="_blank" href="https://prodelo.biz/moduli-opencart/pisma-pochta-sms/admin-notifications-uvedomleniya-administratora-telegram-viber">ProDelo.biz</a></li>
                  <li class="page-header">Telegram Bot - <a target="_blank" href="tg://resolve?domain=GixOC_NotificationsBot">@GixOC_NotificationsBot</a></li>
                  <li class="page-header">Viber Bot - <a target="_blank" href="viber://pa/info?uri=GixOC_NotificationsBot">@GixOC_NotificationsBot</a></li>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_sources; ?></label>
                <div class="col-sm-10">
                  <ul>
                    <li><a target="_blank" href="https://www.opencart.com/" class="btn btn-link">Opencart</a></li>
                    <li><a target="_blank" href="https://core.telegram.org/bots/api" class="btn btn-link">Telegram Bot API</a></li>
                    <li><a target="_blank" href="https://viber.github.io/docs/api/rest-bot-api/" class="btn btn-link">Viber API Documentation</a></li>
                    <li><a target="_blank" href="https://github.com/gixoc/Smart_Customer_Dashboard" class="btn btn-link">GixOC: Smart Customer Dashboard / Настройка Личного кабинета покупателя и партнера</a></li>
                    <li><a target="_blank" href="https://opencartforum.com/files/file/4335-yandekskassa-dengi/" class="btn btn-link">Shoputils: Яндекс.Касса + Деньги</a></li>
                    <li><a target="_blank" href="https://github.com/TelegramBot/Api" class="btn btn-link">PHP Telegram Bot Api</a></li>
                    <li><a target="_blank" href="https://github.com/t0k4rt/phpqrcode" class="btn btn-link">PHP QR Code encoder</a></li>
                    <li><a target="_blank" href="https://php.net/" class="btn btn-link">PHP.NET</a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        <input type="hidden" name="apply" id="apply" value="0"></form>
      </div>
    </div>
  </div>
</div>
<div data-backdrop="true" data-keyboard="true" id="ModalBox" class="modal fade">
  <div class="modal-dialog modal-dialog-centered" style="width: 90%;">
    <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal">&times;</button>
      <h3 class="modal-title"><?php echo $entry_wait; ?></h3>
    </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_close; ?></button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function show() {
  document.getElementById('proxy').style.display='block';
}
function hide() {
  document.getElementById('proxy').style.display='none';
}
//--></script>
<script type="text/javascript"><!--
<?php if (empty($gixocnotifications_telegram_proxydata)) { ?>
$(document).ready(function() {
    addProxy();
});
var proxy_row = 0;
<?php } else { ?>
var proxy_row = <?php echo (count($gixocnotifications_telegram_proxydata)); ?>;
<?php } ?>
function addProxy() {
html = '                      <tr id="proxy' + proxy_row + '">';
html += '                        <td class="text-center"><input name="gixocnotifications_telegram_proxydata[' + proxy_row + '][status]" type="checkbox"></td>';
html += '                        <td><input type="text" name="gixocnotifications_telegram_proxydata[' + proxy_row + '][ip]" value="" placeholder="<?php echo $column_ip; ?>"  class="form-control" /></td>';
html += '                        <td><input type="text" name="gixocnotifications_telegram_proxydata[' + proxy_row + '][port]" value="" placeholder="<?php echo $column_port; ?>"  class="form-control" /></td>';
html += '                        <td><input type="text" name="gixocnotifications_telegram_proxydata[' + proxy_row + '][login]" value="" placeholder="<?php echo $column_login; ?>"  class="form-control" /></td>';
html += '                        <td><input type="text" name="gixocnotifications_telegram_proxydata[' + proxy_row + '][password]" value="" placeholder="<?php echo $column_password; ?>"  class="form-control" /></td>';
html += '                        <td><button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger pull-right" onclick="confirm(\'<?php echo $text_confirm; ?>\') ? $(\'#proxy' + proxy_row + '\').remove() : false;"><i class="fa fa-trash-o"></i></button></td>';
html += '                      </tr>';

    $('#proxy tbody').append(html);
    proxy_row++;
}
//--></script>
<script type="text/javascript"><!--
<?php foreach ($messengers as $keys => $messenger) { ?>
<?php if (isset($gixocnotifications_groupdata[$messenger])) { ?>
var group_row_<?php echo $messenger; ?> = <?php echo array_keys($gixocnotifications_groupdata[$messenger])[count($gixocnotifications_groupdata[$messenger]) - 1]; ?> + 1;
<?php } else { ?>
var group_row_<?php echo $messenger; ?> = 0;
<?php } ?>

function addGroup<?php echo $messenger; ?>() {
	html = '<tr id="group_<?php echo $messenger; ?>_new_' + group_row_<?php echo $messenger; ?> + '">';
	html += '<td><input type="text" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][' + group_row_<?php echo $messenger; ?> + '][name]" value="" placeholder="<?php echo $text_comment; ?>"  class="form-control" onKeyUp="ChangeOnFly(this, ' + group_row_<?php echo $messenger; ?> + ',\'<?php echo $messenger; ?>\');" /></td>';
	html += '<td><input type="text" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][' + group_row_<?php echo $messenger; ?> + '][id]" value="" placeholder="<?php echo $messenger; ?> ID"  class="form-control" /></td>';
	html += '<td class="text-center"><input type="checkbox" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][' + group_row_<?php echo $messenger; ?> + '][new_order]"></td>';
	html += '<td class="text-center"><input type="checkbox" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][' + group_row_<?php echo $messenger; ?> + '][new_customer]"></td>';
	html += '<td class="text-center"><input type="checkbox" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][' + group_row_<?php echo $messenger; ?> + '][new_affiliate]"></td>';
	html += '<td class="text-center"><input type="checkbox" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][' + group_row_<?php echo $messenger; ?> + '][new_review]"></td>';
	html += '<td class="text-center"><input type="checkbox" name="gixocnotifications_groupdata[<?php echo $messenger; ?>][' + group_row_<?php echo $messenger; ?> + '][new_return]"></td>';
	html += '<td><button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger pull-right" onclick="confirm(\'<?php echo $text_confirm; ?>\') ? delGroup(\'<?php echo $messenger; ?>\', ' + group_row_<?php echo $messenger; ?> + ') : false;"><i class="fa fa-trash-o"></i></button></td>';
	html += '</tr>';

    $('#add_new_<?php echo $messenger; ?>').before(html);

	html = '<tr id="group_<?php echo $messenger; ?>_orders_' + group_row_<?php echo $messenger; ?> + '">';
	html += '<td class="text-left" id="group_<?php echo $messenger; ?>_orders_' + group_row_<?php echo $messenger; ?> + '_name" ></td>';
	<?php foreach ($order_statuses as $order_status) { ?>
	order_status_id = <?php echo $order_status['order_status_id']; ?>;
	html += '<td class="text-center"><input name="gixocnotifications_groupdata[<?php echo $messenger; ?>][' + group_row_<?php echo $messenger; ?> + '][orders][' + order_status_id + ']" type="checkbox"></td>';
	<?php } ?> 
	html += '</tr>';

    $('#add_orders_<?php echo $messenger; ?> tbody').append(html);

    group_row_<?php echo $messenger; ?>++;
}
<?php } ?>

function ChangeOnFly(e, id, messenger) {
	$('#group_' + messenger + '_orders_' + id + '_name').html(e.value);
}

function delGroup(messenger, id) {
	$('#group_' + messenger + '_new_' + id).remove(); 
	$('#group_' + messenger + '_orders_' + id).remove()
}
//--></script>
<script type="text/javascript"><!--
function webhook(key) {
  $(".modal-body").html('');
  $(".modal-title").html('<?php echo $entry_wait; ?>');
  $("#ModalBox").modal('show');
  bot_key = $('#' + key + '_key').val();
  proxy = $("input[name='gixocnotifications_" + key + "_proxy']:checked").val();
  proxydata = '';
  if (proxy == '1'){
    for (var i=0; i<proxy_row; i++) {
      if (($('input[name="gixocnotifications_telegram_proxydata[' + i + '][status]"]').is(':checked')) && ($('input[name="gixocnotifications_telegram_proxydata[' + i + '][ip]"]').val() !== '') && ($('input[name="gixocnotifications_telegram_proxydata[' + i + '][port]"]').val() !== '')) {
        proxydata += $('input[name="gixocnotifications_telegram_proxydata[' + i + '][ip]"]').val() + ':' + $('input[name="gixocnotifications_telegram_proxydata[' + i + '][port]"]').val();
      if (($('input[name="gixocnotifications_telegram_proxydata[' + i + '][login]"]').val() !== '') || ($('input[name="gixocnotifications_telegram_proxydata[' + i + '][password]"]').val() !== '')) {
          proxydata += '@' + $('input[name="gixocnotifications_telegram_proxydata[' + i + '][login]"]').val() + ':' + $('input[name="gixocnotifications_telegram_proxydata[' + i + '][password]"]').val();
      };
      proxydata += ';';
    }
    }
  };

  timeout = $('input[name="gixocnotifications_' + key + '_timeout"]').val();

  $.ajax({
    url: 'index.php?route=extension/module/gixocnotifications/set_webhook&token=<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'key=' + key + '&bot_key=' + bot_key + '&timeout=' + timeout + '&proxy=' + proxy + '&proxydata=' + proxydata,
    success: function(json) {
    if (json['error']) {
        $(".modal-title").html('Error!');
        $(".modal-body").html('<div class="h4" style="color:red;text-align:center;">' + json['error'] + '</div>');
    }

    if (json['success']) {
        $(".modal-title").html('Success!');
        $(".modal-body").html('<div class="h4" style="color:green;text-align:center;">' + json['success'] + '</div>');
    }

    if (json['webhook']) {
        $('input[name="gixocnotifications_' + key + '_webhook"]').val(json['webhook']);
    }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      $("#ModalBox").modal('hide');
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}
//--></script>
<script type="text/javascript"><!--
function clearLog(key) {
  $(".modal-body").html('');
  $("#ModalBox").modal('show');
  $.ajax({
    url: 'index.php?route=extension/module/gixocnotifications/clearLog&token=<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'key=' + key,
    success: function(json) {
    if (json['error']) {
        $(".modal-title").html('Error!');
        $(".modal-body").html('<div class="h4" style="color:red;text-align:center;">' + json['error'] + '</div>');
    }

    if (json['success']) {
      $('#log_' + key).val('');
        $(".modal-title").html('Success!');
        $(".modal-body").html('<div class="h4" style="color:green;text-align:center;">' + json['success'] + '</div>');
    }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}
//--></script>
<script type="text/javascript"><!--
function downloadLog(key) {
  $(".modal-body").html('');
  $("#ModalBox").modal('show');
  $.ajax({
    url: 'index.php?route=extension/module/gixocnotifications/downloadLog&token=<?php echo $token; ?>' + '&key=' + key,
    type: 'GET',
    success: function(json) {
      if (json['error']) {
        $(".modal-title").html('Error!');
        $(".modal-body").html('<div class="h4" style="color:red;text-align:center;">' + json['error'] + '</div>');
      }
      else {
        $("#ModalBox").modal('hide');
        window.location = 'index.php?route=extension/module/gixocnotifications/downloadLog&token=<?php echo $token; ?>' + '&key=' + key;
      }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    } 
  });
}
//--></script>
<script type="text/javascript"><!--
function help(key) {
  $("#ModalBox").modal('show');
  $.ajax({
    url: 'index.php?route=extension/module/gixocnotifications/help&token=' + '<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'key=' + key,
    success: function(json) {
    if (json['error']) {
        $(".modal-title").html('Error!');
        $(".modal-body").html('<div class="h4" style="color:red;text-align:center;">' + json['error'] + '</div>');
    }

    if (json['success']) {
        $(".modal-title").html(json['header']);
        $(".modal-body").html(json['success']);
    }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      $("#ModalBox").modal('hide');
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}
//--></script>
<script type="text/javascript"><!--
function help_id(key) {
  $(".modal-body").html('');
  $(".modal-title").html('<?php echo $entry_wait; ?>');
  $("#ModalBox").modal('show');
  webhook = $('input[name="gixocnotifications_' + key + '_webhook"]').val();
  $.ajax({
    url: 'index.php?route=extension/module/gixocnotifications/help&token=' + '<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'key=' + key + '&webhook=' + webhook,
    success: function(json) {
    if (json['error']) {
        $(".modal-title").html('Error!');
        $(".modal-body").html('<div class="h4" style="color:red;text-align:center;">' + json['error'] + '</div>');
    }

    if (json['success']) {
        $(".modal-title").html(json['header']);
        $(".modal-body").html(json['success']);
    }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      $("#ModalBox").modal('hide');
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}
//--></script>
<?php echo $footer; ?>
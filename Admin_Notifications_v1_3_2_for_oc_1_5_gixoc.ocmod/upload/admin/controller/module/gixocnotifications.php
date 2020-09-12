<?php
class ControllerModuleGixOCNotifications extends Controller {
	private $error = array();
	private $ssl = false;
	private $messengers = array();
	private $messengers_text = array();
	private $version = '1.3.2';

	public function __construct($registry) {
		parent::__construct($registry);
		$this->language->load('module/gixocnotifications');

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->ssl = true;
		} else {
			$this->ssl = false;
		}

		$this->ssl = ($this->config->get('config_seo_url') && $this->ssl);

		$this->messengers = array(
			'1' => 'telegram',
			'2' => 'viber'
		);

		$this->messengers_text = array(
			'1' => '<i class="fa fa-paper-plane"></i> Telegram',
			'2' => '<i class="fa fa-phone"></i> Viber'
		);
	}

	public function index() {
		$this->document->setTitle($this->language->get('text_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('gixocnotifications', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['apply']) {
				$this->redirect($this->url->link('module/gixocnotifications', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->data = array();
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_title'] = $this->language->get('text_title');
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_orders_status'] = $this->language->get('text_orders_status');
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		$this->data['text_cut'] = $this->language->get('text_cut');
		$this->data['text_split'] = $this->language->get('text_split');
		$this->data['text_developer'] = $this->language->get('text_developer');
		$this->data['text_url_download'] = $this->language->get('text_url_download');
		$this->data['text_sources'] = $this->language->get('text_sources');
		$this->data['text_variables'] = $this->language->get('text_variables');
		$this->data['text_comment'] = $this->language->get('text_comment');

		$this->data['button_verify'] = $this->language->get('button_verify');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_close'] = $this->language->get('button_close');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_approve'] = $this->language->get('button_approve');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_download'] = $this->language->get('button_download');
		$this->data['button_proxy_add'] = $this->language->get('button_proxy_add');
		$this->data['button_apply'] = $this->language->get('button_apply');

		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_template'] = $this->language->get('tab_template');
		$this->data['tab_users'] = $this->language->get('tab_users');
		$this->data['tab_logs'] = $this->language->get('tab_logs');
		$this->data['tab_support'] = $this->language->get('tab_support');
		$this->data['tab_action'] = $this->language->get('tab_action');

		//Legend
		$this->data['legend_new_order'] = $this->language->get('legend_new_order');
		$this->data['legend_new_customer'] = $this->language->get('legend_new_customer');
		$this->data['legend_new_affiliate'] = $this->language->get('legend_new_affiliate');
		$this->data['legend_new_review'] = $this->language->get('legend_new_review');
		$this->data['legend_new_return'] = $this->language->get('legend_new_return');
		$this->data['legend_orders'] = $this->language->get('legend_orders');

		// Column
		$this->data['column_use'] = $this->language->get('column_use');
		$this->data['column_ip'] = $this->language->get('column_ip');
		$this->data['column_port'] = $this->language->get('column_port');
		$this->data['column_login'] = $this->language->get('column_login');
		$this->data['column_password'] = $this->language->get('column_password');
		$this->data['column_user'] = $this->language->get('column_user');
		$this->data['column_id'] = $this->language->get('column_id');
		$this->data['column_orders'] = $this->language->get('column_orders');
		$this->data['column_new'] = $this->language->get('column_new');
		$this->data['column_new_order'] = $this->language->get('column_new_order');
		$this->data['column_new_customer'] = $this->language->get('column_new_customer');
		$this->data['column_new_affiliate'] = $this->language->get('column_new_affiliate');
		$this->data['column_new_review'] = $this->language->get('column_new_review');
		$this->data['column_new_return'] = $this->language->get('column_new_return');

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_auto'] = $this->language->get('entry_auto');
		$this->data['entry_wait'] = $this->language->get('entry_wait');
		$this->data['entry_proxy'] = $this->language->get('entry_proxy');
		$this->data['entry_proxy_status'] = $this->language->get('entry_proxy_status');

		$this->data['help_timeout'] = $this->language->get('help_timeout');
		$this->data['help_trim_messages'] = $this->language->get('help_trim_messages');
		$this->data['help_license'] = $this->language->get('help_license');
		$this->data['help_new_order'] = sprintf($this->language->get('help_new_order'), HTTPS_CATALOG);
		$this->data['help_new_order_ex'] = $this->language->get('help_new_order_ex');
		$this->data['help_orders'] = $this->language->get('help_orders');
		$this->data['help_orders_ex'] = $this->language->get('help_orders_ex');
		$this->data['help_new_customer'] = $this->language->get('help_new_customer');
		$this->data['help_new_customer_ex'] = $this->language->get('help_new_customer_ex');
		$this->data['help_new_affiliate'] = $this->language->get('help_new_affiliate');
		$this->data['help_new_affiliate_ex'] = $this->language->get('help_new_affiliate_ex');
		$this->data['help_new_review'] = $this->language->get('help_new_review');
		$this->data['help_new_review_ex'] = $this->language->get('help_new_review_ex');
		$this->data['help_new_return'] = $this->language->get('help_new_return');
		$this->data['help_new_return_ex'] = $this->language->get('help_new_return_ex');
		$this->data['help_module'] = $this->language->get('help_module');
		$this->data['help_thanks'] = $this->language->get('help_thanks');
		$this->data['help_faq'] = $this->language->get('help_faq');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/gixocnotifications', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('module/gixocnotifications', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['gixocnotifications_status'])) {
			$this->data['gixocnotifications_status'] = $this->request->post['gixocnotifications_status'];
		} else {
			$this->data['gixocnotifications_status'] = $this->config->get('gixocnotifications_status');
		}

		if (isset($this->request->post['gixocnotifications_langdata'])) {
			$this->data['gixocnotifications_langdata'] = $this->request->post['gixocnotifications_langdata'];
		} else {
			$this->data['gixocnotifications_langdata'] = $this->config->get('gixocnotifications_langdata');
		}

		if (isset($this->request->post['gixocnotifications_userdata'])) {
			$this->data['gixocnotifications_userdata'] = $this->request->post['gixocnotifications_userdata'];
		} else {
			$this->data['gixocnotifications_userdata'] = $this->config->get('gixocnotifications_userdata');
		}

		if (isset($this->request->post['gixocnotifications_groupdata'])) {
			$this->data['gixocnotifications_groupdata'] = $this->request->post['gixocnotifications_groupdata'];
		} else {
			$this->data['gixocnotifications_groupdata'] = $this->config->get('gixocnotifications_groupdata');
		}

		if (isset($this->request->post['gixocnotifications_telegram_proxy'])) {
			$this->data['gixocnotifications_telegram_proxy'] = $this->request->post['gixocnotifications_telegram_proxy'];
		} else {
			$this->data['gixocnotifications_telegram_proxy'] = $this->config->get('gixocnotifications_telegram_proxy');
		}

		if (isset($this->request->post['gixocnotifications_telegram_proxydata'])) {
			$this->data['gixocnotifications_telegram_proxydata'] = $this->request->post['gixocnotifications_telegram_proxydata'];
		} else {
			$this->data['gixocnotifications_telegram_proxydata'] = $this->config->get('gixocnotifications_telegram_proxydata');
		}

		$this->data['messengers'] = $this->messengers;

		$this->data['messengers_text'] = $this->messengers_text;

		//logs
		if (isset($this->request->post['gixocnotifications_logs'])) {
			$this->data['gixocnotifications_logs'] = $this->request->post['gixocnotifications_logs'];
		} else {
			$this->data['gixocnotifications_logs'] = $this->config->get('gixocnotifications_logs');
		}

		foreach ($this->data['messengers'] as $messenger) {
			$this->data['entry_' . $messenger . '_key'] = $this->language->get('entry_' . $messenger . '_key');
			$this->data['entry_get_token_' . $messenger] = $this->language->get('entry_get_token_' . $messenger);
			$this->data['error_' . $messenger] = $this->language->get('error_' . $messenger);

			if (isset($this->request->post['gixocnotifications_' . $messenger . '_key'])) {
				$this->data['gixocnotifications_' . $messenger . '_key'] = $this->request->post['gixocnotifications_' . $messenger . '_key'];
			} else {
				$this->data['gixocnotifications_' . $messenger . '_key'] = $this->config->get('gixocnotifications_' . $messenger . '_key');
			}

			if (isset($this->request->post['gixocnotifications_' . $messenger . '_webhook'])) {
				$this->data['gixocnotifications_' . $messenger . '_webhook'] = $this->request->post['gixocnotifications_' . $messenger . '_webhook'];
			} else {
				$this->data['gixocnotifications_' . $messenger . '_webhook'] = $this->config->get('gixocnotifications_' . $messenger . '_webhook');
			}

			if (isset($this->request->post['gixocnotifications_' . $messenger . '_timeout'])) {
				$this->data['gixocnotifications_' . $messenger . '_timeout'] = $this->request->post['gixocnotifications_' . $messenger . '_timeout'];
			} else {
				$this->data['gixocnotifications_' . $messenger . '_timeout'] = $this->config->get('gixocnotifications_' . $messenger . '_timeout');
			}

			if (isset($this->request->post['gixocnotifications_' . $messenger . '_trim_messages'])) {
				$this->data['gixocnotifications_' . $messenger . '_trim_messages'] = $this->request->post['gixocnotifications_' . $messenger . '_trim_messages'];
			} else {
				$this->data['gixocnotifications_' . $messenger . '_trim_messages'] = $this->config->get('gixocnotifications_' . $messenger . '_trim_messages');
			}

			$this->data['logs_file'][$messenger] = $this->readlogs('gixocnotifications_' . $messenger . '.log');
		}

		$this->data['token'] = $this->session->data['token'];
		
		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		$this->data['ordervar'] = $this->ordervar();
		$this->data['customervar'] = $this->customervar();
		$this->data['affiliatevar'] = $this->affiliatevar();
		$this->data['reviewvar'] = $this->reviewvar();
		$this->data['returnvar'] = $this->returnvar();
		//Simple
		$this->data['simplevar'] = $this->simplevar();

		$this->data['langcode'] = trim(str_replace('-', '_', strtolower($this->config->get('config_admin_language'))), '.');
		//end Simple

		if ($this->checking() != $this->version) {
			$this->data['text_old_version'] = sprintf($this->language->get('text_old_version'), $this->version, $this->checking());
			$this->data['text_new_version'] = '';
		} else {
			$this->data['text_new_version'] = sprintf($this->language->get('text_new_version'), $this->version);
			$this->data['text_old_version'] = '';
		}

		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('user/user');
		$this->data['users'] = $this->model_user_user->getUsers(array());

		$this->data['ssl'] = $this->ssl;

		$this->data['logs'] = array(
			'0' => $this->language->get('text_log_off'),
			'1' => $this->language->get('text_log_small'),
			'2' => $this->language->get('text_log_all')
		);


		$this->template = 'module/gixocnotifications.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	public function set_webhook(){
		$json = array();

		// Check user has permission
		if ((!$this->user->hasPermission('modify', 'module/gixocnotifications')) || (!isset($this->request->post['key'])) || (!isset($this->request->post['bot_key']))) {
			$json['error'] = $this->language->get('error_permission');
		}

		if (!$json) {
			if ((!empty($this->request->post['key'])) && (!empty($this->request->post['bot_key']))) {
				if (($this->request->post['key']) == 'telegram') {
					$timeout = !empty($this->request->post['timeout']) ? $this->request->post['timeout'] : '5';
					$telegram = new Telegram($this->request->post['bot_key'], $timeout);
					$telegram->setLog( new \Log('gixocnotifications_telegram.log'), 2);

					if ($this->ssl) {
						$telegram->setWebhook(HTTPS_CATALOG . 'gixocnotifications-webhook-telegram');
					}

					$response = $telegram->getWebhookInfo();

					if (!$response) {
						if (($this->request->post['proxy'] == '1') && (!empty($this->request->post['proxydata']))) {
							$results = explode(';', $this->request->post['proxydata']);

							foreach ($results as $proxy) {
								if (!$response) {
									$telegram->setProxy($proxy);
									$response = $telegram->getBotInfo();

									if ($response) {
										$json['webhook'] = 'potential';
										$json['success'] = $this->language->get('text_token');
										$this->load->model('module/gixocnotifications');
										$this->model_module_gixocnotifications->editSettingValue('gixocnotifications', 'gixocnotifications_telegram_key', $this->request->post['bot_key']);
										$this->model_module_gixocnotifications->editSettingValue('gixocnotifications', 'gixocnotifications_telegram_webhook', false);
									}
								}
							};
						}
					} else {
						if ((isset($response['url'])) && (($response['url']) == (HTTPS_CATALOG . 'gixocnotifications-webhook-telegram'))) {
							$json['webhook'] = 'tg://resolve?domain=' . $telegram->getBotInfo()['username'];
							$json['success'] = $this->language->get('text_token');
							$this->load->model('module/gixocnotifications');
							$this->model_module_gixocnotifications->editSettingValue('gixocnotifications', 'gixocnotifications_telegram_key', $this->request->post['bot_key']);
							$this->model_module_gixocnotifications->editSettingValue('gixocnotifications', 'gixocnotifications_telegram_webhook', $json['webhook']);
						} else {
							$json['webhook'] = 'potential';
							$json['success'] = $this->language->get('text_token');
							$this->load->model('module/gixocnotifications');
							$this->model_module_gixocnotifications->editSettingValue('gixocnotifications', 'gixocnotifications_telegram_key', $this->request->post['bot_key']);
							$this->model_module_gixocnotifications->editSettingValue('gixocnotifications', 'gixocnotifications_telegram_webhook', false);
						}
					}
				} elseif (($this->request->post['key']) == 'viber') {
					if ($this->ssl) {
						$timeout = !empty($this->request->post['timeout']) ? $this->request->post['timeout'] : '5';
						$viber = new Viber($this->request->post['bot_key'], $timeout);
						$viber->setWebhook(HTTPS_CATALOG . 'gixocnotifications-webhook-viber');
						$viber->setLog( new \Log('gixocnotifications_viber.log'), 2);
						$response = $viber->getWebhookInfo();

						if ((isset($response['webhook'])) && (($response['webhook']) == (HTTPS_CATALOG . 'gixocnotifications-webhook-viber'))) {
							$json['webhook'] = 'viber://pa/info?uri=' . $response['uri'];
							$json['success'] = $this->language->get('text_token');
							$this->load->model('module/gixocnotifications');
							$this->model_module_gixocnotifications->editSettingValue('gixocnotifications', 'gixocnotifications_viber_key', $this->request->post['bot_key']);
							$this->model_module_gixocnotifications->editSettingValue('gixocnotifications', 'gixocnotifications_viber_webhook', $json['webhook']);
						}
					}
				}
			}
		}

		if (!isset($json['success'])) {
			$json['error'] = $this->language->get('error_token');
		}

		if (!isset($json['webhook'])) {
			$json['webhook'] = 'no';
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	private function ordervar() {
		$temp = array();
		$temp['{order_id}'] = $this->language->get('text_order_id'); 
		$temp['{store_name}'] = $this->language->get('text_store_name');
		$temp['{customer_firstname}'] = $this->language->get('text_firstname');
		$temp['{customer_lastname}'] = $this->language->get('text_lastname');
		$temp['{customer_email}'] = $this->language->get('text_email');
		$temp['{customer_telephone}'] = $this->language->get('text_telephone');
		$temp['{customer_group}'] = $this->language->get('text_customer_groups');
		$temp['{payment_address}'] = $this->language->get('text_payment_address');
		$temp['{payment_method}'] = $this->language->get('text_payment_method');
		$temp['{shipping_address}'] = $this->language->get('text_shipping_address');
		$temp['{shipping_method}'] = $this->language->get('text_shipping_method');
		$temp['{total}'] = $this->language->get('text_total');
		$temp['{comment}'] = $this->language->get('text_comment');
		$temp['{order_status}'] = $this->language->get('text_orders_status');
		$temp['{date_added}'] = $this->language->get('text_date_added');
		$temp['{date_modified}'] = $this->language->get('text_date_modified');
		$temp['{cart_start}'] = $this->language->get('text_cart_start');
		$temp['{product_name}'] = $this->language->get('text_product_name');
		$temp['{product_url}'] = $this->language->get('text_product_url');
		$temp['{product_model}'] = $this->language->get('text_product_model');
		$temp['{product_sku}'] = $this->language->get('text_product_sku');
		$temp['{product_price}'] = $this->language->get('text_product_price');
		$temp['{product_quantity}'] = $this->language->get('text_product_quantity');
		$temp['{product_total}'] = $this->language->get('text_product_total');
		$temp['{cart_finish}'] = $this->language->get('text_cart_finish');

		return $temp;
	}

	private function customervar() {
		$temp = array();
		$temp['{store_name}'] = $this->language->get('text_store_name');
		$temp['{customer_firstname}'] = $this->language->get('text_firstname');
		$temp['{customer_lastname}'] = $this->language->get('text_lastname');
		$temp['{customer_group}'] = $this->language->get('text_customer_groups');
		$temp['{customer_email}'] = $this->language->get('text_email');
		$temp['{customer_telephone}'] = $this->language->get('text_telephone');
		$temp['{date_added}'] = $this->language->get('text_date_added');

		return $temp;
	}

	private function affiliatevar() {
		$temp = array();
		$temp['{store_name}'] = $this->language->get('text_store_name');
		$temp['{affiliate_firstname}'] = $this->language->get('text_firstname');
		$temp['{affiliate_lastname}'] = $this->language->get('text_lastname');
		$temp['{affiliate_email}'] = $this->language->get('text_email');
		$temp['{affiliate_telephone}'] = $this->language->get('text_telephone');
		$temp['{affiliate_website}'] = $this->language->get('text_website');
		$temp['{affiliate_company}'] = $this->language->get('text_company');
		$temp['{date_added}'] = $this->language->get('text_date_added');

		return $temp;
	}

	private function reviewvar() {
		$temp = array();
		$temp['{store_name}'] = $this->language->get('text_store_name');
		$temp['{name}'] = $this->language->get('text_firstname');
		$temp['{review}'] = $this->language->get('text_review');
		$temp['{rating}'] = $this->language->get('text_rating');
		$temp['{product_name}'] = $this->language->get('text_product_name');
		$temp['{product_model}'] = $this->language->get('text_product_model');
		$temp['{product_sku}'] = $this->language->get('text_product_sku');
		$temp['{date_added}'] = $this->language->get('text_date_added');

		return $temp;
	}

	private function returnvar() {
		$temp = array();
		$temp['{store_name}'] = $this->language->get('text_store_name');
		$temp['{customer_firstname}'] = $this->language->get('text_firstname');
		$temp['{customer_lastname}'] = $this->language->get('text_lastname');
		$temp['{customer_email}'] = $this->language->get('text_email');
		$temp['{customer_telephone}'] = $this->language->get('text_telephone');
		$temp['{order_id}'] = $this->language->get('text_order_id'); 
		$temp['{date_ordered}'] = $this->language->get('text_date_ordered');
		$temp['{product_name}'] = $this->language->get('text_product_name');
		$temp['{product_model}'] = $this->language->get('text_product_model');
		$temp['{product_quantity}'] = $this->language->get('text_product_quantity');
		$temp['{return_reason}'] = $this->language->get('text_return_reason');
		$temp['{opened}'] = $this->language->get('text_return_opened');
		$temp['{comment}'] = $this->language->get('text_comment');
		$temp['{date_added}'] = $this->language->get('text_date_added');

		return $temp;
	}

	//Simple
	private function simplevar() {
		$this->load->model('module/gixocnotifications');

		if ($this->model_module_gixocnotifications->getModule('simple')) {
            $settings = @json_decode($this->config->get('simple_settings'), 'SSL');

            $result = array();

			if (!empty($settings['fields'])) {
                foreach ($settings['fields'] as $fieldSettings) {
                    if ($fieldSettings['custom']) {
                        $result['{' . $fieldSettings['id'] . '}'] = $fieldSettings;
                    }
                }
            }

            return $result;
		} else {
			return array();
		}
	}
	//end Simple

	private function readlogs($filename) {
		$file = DIR_LOGS . $filename;

		if (!is_file($file)) {
			return '';
		}

		if (file_exists($file)) {
			return htmlentities(file_get_contents($file, FILE_USE_INCLUDE_PATH, null));
		} else {
			return '';
		}
	}

	public function clearLog() {
		$json = array();

		// Check user has permission
		if ((!$this->user->hasPermission('modify', 'module/gixocnotifications')) || (!isset($this->request->post['key']))) {
			$json['error'] = $this->language->get('error_permission');
		}

		if (!$json) {
			$key = $this->request->post['key'];

			if ($key == 'telegram') {
				$file = DIR_LOGS . 'gixocnotifications_telegram.log';
			} elseif ($key == 'viber') {
				$file = DIR_LOGS . 'gixocnotifications_viber.log';
			} else {
				$file = false;
			}

			if ($file) {
				$handle = @fopen($file, 'w+');

				fclose($handle);

				$json['success'] = $this->language->get('text_clear_log_success');
			} else {
				$json['error'] = $this->language->get('error_permission');
			}
		}

		if (!$json) {
			$json['error'] = $this->language->get('error_permission');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function downloadLog() {
		$json = array();

		// Check user has permission
		if ((!$this->user->hasPermission('modify', 'module/gixocnotifications')) || (!isset($this->request->get['key']))) {
			$json['error'] = $this->language->get('error_permission');
		}

		if (!$json) {
			$key = $this->request->get['key'];

			if ($key == 'telegram') {
				$file = DIR_LOGS . 'gixocnotifications_telegram.log';
			} elseif ($key == 'viber') {
				$file = DIR_LOGS . 'gixocnotifications_viber.log';
			} else {
				$file = false;
			}

			if (file_exists($file) && filesize($file) > 0) {
				$json['success'] = 'ok';
			} else {
				$json['error'] = sprintf($this->language->get('error_warning'), basename($file), '0B');
			}
		}

		if (isset($json['success'])) {
			$this->response->addHeader('Pragma: public');
			$this->response->addHeader('Expires: 0');
			$this->response->addHeader('Content-Description: File Transfer');
			$this->response->addHeader('Content-Type: application/octet-stream');
			$this->response->addHeader('Content-Disposition: attachment; filename="gixocnotifications_' . $key . '_error_' . date('Y-m-d_H-i-s', time()) . '.log"');
			$this->response->addheader('Content-Transfer-Encoding: binary');

			$this->response->setOutput(file_get_contents($file, FILE_USE_INCLUDE_PATH, null));
		}

		if (!$json) {
			$json['error'] = sprintf($this->language->get('error_warning'), basename($file), '0B');
		}

		if (!isset($json['success'])) {
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}
	}

	public function help() {
		$json = array();

		// Check user has permission
		if ((!$this->user->hasPermission('modify', 'module/gixocnotifications')) || (!isset($this->request->post['key']))) {
			$json['error'] = $this->language->get('error_permission');
		}

		if (!$json) {
			if (isset($this->request->post['key']) && !empty($this->request->post['key'])) {
				if ($this->request->post['key'] == 'help_module') {
					$this->data['tab_general'] = $this->language->get('tab_general');
					$this->data['tab_template'] = $this->language->get('tab_template');
					$this->data['tab_users'] = $this->language->get('tab_users');
					$this->data['tab_logs'] = $this->language->get('tab_logs');
					$webhook = array();

					foreach ($this->messengers as $messenger) {
						$this->data['entry_get_token_' . $messenger] = $this->language->get('entry_get_token_' . $messenger);
						$this->data['entry_id_' . $messenger] = $this->language->get('help_id_' . $messenger);
						$this->template = 'module/gixochelp/module_gixocnotifications/help_bot_' . $messenger . '.tpl';
						$this->data['help_bot_' . $messenger] = $this->render();
						$this->template = 'module/gixochelp/module_gixocnotifications/help_id_' . $messenger . '.tpl';
						$this->data['help_id_' . $messenger] = $this->render();
					}

					$this->template = 'module/gixochelp/module_gixocnotifications/help_trim_messages.tpl';
					$this->data['help_trim_messages'] = $this->render();
					$this->template = 'module/gixochelp/module_gixocnotifications/help_timeout.tpl';
					$this->data['help_timeout'] = $this->render();
					$this->template = 'module/gixochelp/module_gixocnotifications/help_proxy.tpl';
					$this->data['help_proxy'] = $this->render();
					$this->template = 'module/gixochelp/module_gixocnotifications/help_log.tpl';
					$this->data['help_log'] = $this->render();
					$this->template = 'module/gixochelp/module_gixocnotifications/help_thanks.tpl';
					$this->data['help_thanks'] = $this->render();

					$json['header'] = $this->language->get($this->request->post['key']);
					$this->template = 'module/gixochelp/module_gixocnotifications/' . $this->request->post['key'] . '.tpl';
					$json['success'] = $this->render();
				} elseif (isset($this->request->post['webhook'])) {
					if (($this->request->post['webhook'] != 'no') && ($this->request->post['webhook'] != 'potential') && (strripos($this->request->post['webhook'], 'resolve?domain=') || strripos($this->request->post['webhook'], 'info?uri='))) {
						$this->data['webhook'] = $this->request->post['webhook'];

						$image_qr = md5($this->data['webhook']) . '.png';

						if (!is_dir(DIR_IMAGE . 'cache/qr/')) {
							@mkdir(DIR_IMAGE . 'cache/qr/', 0777);
						}

						if (!is_file(DIR_IMAGE . 'cache/qr/' . $image_qr)) {
							$qr = new QRcode();
							$qr->png($this->data['webhook'], DIR_IMAGE . 'cache/qr/' . $image_qr, QR_ECLEVEL_L, 4, 0); 
						}

						if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
							$this->data['qr'] = HTTPS_CATALOG . 'image/cache/qr/' . $image_qr;
						} else {
							$this->data['qr'] = HTTP_CATALOG . 'image/cache/qr/' . $image_qr;
						}
					} else {
						$this->data['webhook'] = '';
						$this->data['qr'] = '';
					}

					$this->template = 'module/gixochelp/module_gixocnotifications/help_thanks.tpl';
					$this->data['help_thanks'] = $this->render();
					$json['header'] = $this->language->get('help_id_' . $this->request->post['key']);
					$this->template = 'module/gixochelp/module_gixocnotifications/help_id_' . $this->request->post['key'] . '.tpl';
					$json['success'] = $this->render();
				} else {
					$this->template = 'module/gixochelp/module_gixocnotifications/help_thanks.tpl';
					$this->data['help_thanks'] = $this->render();
					$this->data['email'] = $this->config->get('config_email');
					$json['header'] = $this->language->get($this->request->post['key']);
					$this->template = 'module/gixochelp/module_gixocnotifications/' . $this->request->post['key'] . '.tpl';
					$json['success'] = $this->render();
				}
			} else {
				$json['error'] = $this->language->get('error_permission'); 
			}
	}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	private function checking() {
		$curl = curl_init();

		curl_setopt($curl, CURLOPT_URL, 'https://gixoc.ru/index.php?route=api/version&domain=' . HTTP_SERVER . '&module=notifications&version=' . $this->version . '&oc_version=' . VERSION);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($curl, CURLOPT_HEADER, false);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt($curl, CURLOPT_TIMEOUT, 5);

		$response = curl_exec($curl);

		curl_close($curl);

		if ($response) {
			$result = json_decode($this->db->escape(htmlspecialchars($response)), true);

			if (isset($result['version'])) {
				return $result['version'];
			}
		}

		return $this->version;
	}

	public function install() {
		$this->load->model('module/gixocnotifications');

		$data = array();

		foreach ($this->messengers as $messenger) {
			$url_alias_info = $this->model_module_gixocnotifications->getSeoUrl('webhook_' . $messenger);
			if (empty($url_alias_info) || (isset($url_alias_info['query']) && ($url_alias_info['query'] != 'module/gixocnotifications/webhook_' . $messenger))) {
				$data['module/gixocnotifications/webhook_' . $messenger] = 'gixocnotifications-webhook-' . $messenger;
			}
		}
		
		$this->model_module_gixocnotifications->addSeoUrl($data);
	}

	public function uninstall() {
		$this->load->model('setting/setting');
		$this->model_setting_setting->deleteSetting('gixocnotifications');
	}	

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/gixocnotifications')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
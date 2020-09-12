<?php
class ControllerModuleGixOCNotifications extends Controller {
	private $error = array();
	private $language_id;
	private $langdata;

	public function __construct($registry) {
		parent::__construct($registry);
		$this->language_id = $this->config->get('config_language_id');
		$this->langdata = $this->config->get('gixocnotifications_langdata');
	}

	public function webhook_telegram() {
		$sapi_type = php_sapi_name();
		if (substr($sapi_type, 0, 3) == 'cgi') {
			header("Status: 200 Ok'");
		} else {
			header("HTTP/1.0 200 OK");
		}

		$request = file_get_contents('php://input');

		$input = json_decode($request, true);

		if (isset($input['message']/* ['text'] */)/*  && $input['message']['text'] == '/start' */) {
			$key = $this->config->get('gixocnotifications_telegram_key');
			$webhook = $this->config->get('gixocnotifications_telegram_webhook');

			if (!empty($key) && ($webhook != 'no')) {
				$telegram = new \Telegram($key, $this->config->get('gixocnotifications_telegram_timeout'));
				$telegram->setLog( new \Log('gixocnotifications_telegram.log'), $this->config->get('gixocnotifications_logs')['telegram']);
				$last_name = isset($input['message']['from']['last_name']) ? $input['message']['from']['last_name'] : '';
				$first_name = isset($input['message']['from']['first_name']) ? $input['message']['from']['first_name'] : '';
				$id = $input['message']['from']['id'] ? $input['message']['from']['id'] : '';
				$language_code = isset($input['message']['from']['language_code']) ? $input['message']['from']['language_code'] : '';
				$id_chat = isset($input['message']['chat']['id']) ? $input['message']['chat']['id'] : '';
				$name_chat = isset($input['message']['chat']['name']) ? $input['message']['chat']['name'] : '';
				$new_chat_member = isset($input['message']['new_chat_member']) ? $input['message']['new_chat_member'] : '';

				if ($id_chat && $new_chat_member) {
					$message = 'Здравствуйте, ' . $last_name . ' ' . $first_name . '!' . chr(10) . 'ID группы ' . $name_chat . ': ' . $id_chat . ' (копировать со знаком минус в начале!)';
				} else {
					$message = 'Здравствуйте, ' . $last_name . ' ' . $first_name . '!' . chr(10) . 'Ваш ID: ' . $id . chr(10) . 'Язык: ' . $language_code;
				}

				$telegram->setTo($id);
				$telegram->sendMessage($message, $this->config->get('gixocnotifications_telegram_trim'));
			}
		}
	}

	public function webhook_viber() {
		$request = file_get_contents("php://input");
		$input = json_decode($request, true);

		if (isset($input['event'])) {
			$key = $this->config->get('gixocnotifications_viber_key');
			$webhook = $this->config->get('gixocnotifications_viber_webhook');
			if (!empty($key) && ($webhook != 'no')) {
				$viber = new \Viber($key, $this->config->get('gixocnotifications_viber_timeout'));
				$viber->setLog( new \Log('gixocnotifications_viber.log'), $this->config->get('gixocnotifications_logs')['viber']);

				if ($input['event'] == 'webhook') {
					$webhook_response['status'] = 0;
					$webhook_response['status_message'] = "ok";
					$webhook_response['event_types'] = 'delivered';
					echo json_encode($webhook_response);
					die;
				} elseif ($input['event'] == 'conversation_started'){
					$user_id = $input['user']['id'];
					$user_name = $input['user']['name'];
					$viber_message = 'Здравствуйте, ' . $user_name .  '! Ваш ID - ' . $user_id;

					$viber->setTo($user_id);
					$viber->sendMessage($viber_message, $this->config->get('gixocnotifications_viber_trim'));
				} elseif ($input['event'] == 'message') {
					$sender_id = $input['sender']['id'];
					$sender_name = $input['sender']['name'];
					$viber_message = 'Здравствуйте, ' . $sender_name .  '! Ваш ID - ' . $sender_id;

					$viber->setTo($sender_id);
					$viber->sendMessage($viber_message, $this->config->get('gixocnotifications_viber_trim'));
				}
			}
		}
	}
}
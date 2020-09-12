<?php
class ModelModuleGixOCNotifications extends Model {
	public function __construct($registry) {
		parent::__construct($registry);
		$this->language_id = $this->config->get('config_language_id');
		$this->langdata = $this->config->get('gixocnotifications_langdata');
	}

	public function getSeoUrl($keyword) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($keyword) . "'");

		return $query->row;
	}

	public function addSeoUrl($data) {
		foreach ($data as $key=>$value){
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias (`query`, `keyword`) VALUES ('" . $this->db->escape($key) . "', '" . $this->db->escape($value) . "')");
		}

		$this->cache->delete('seo_pro');
		$this->cache->delete('seo_url');

		return true;
	}

	public function deleteSeoUrl($keyword) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE `keyword` = '" . $this->db->escape($keyword) . "'");

		$this->cache->delete('seo_pro');
		$this->cache->delete('seo_url');
	}

	public function editSettingValue($group = '', $key = '', $value = '', $store_id = 0) {
		$query = $this->db->query("SELECT value FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `key` = '" . $this->db->escape($key) . "'");

		if ($query->num_rows) {
			if (!is_array($value)) {
				$this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape($value) . "', serialized = '0'  WHERE `group` = '" . $this->db->escape($group) . "' AND `key` = '" . $this->db->escape($key) . "' AND store_id = '" . (int)$store_id . "'");
			} else {
				$this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape(json_encode($value)) . "', serialized = '1' WHERE `group` = '" . $this->db->escape($group) . "' AND `key` = '" . $this->db->escape($key) . "' AND store_id = '" . (int)$store_id . "'");
			}
		} else {
			if (!is_array($value)) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `group` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
			} else {
				$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `group` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape(json_encode($value, true)) . "', serialized = '1'");
			}
		}
	}

	public function getModule($code) {
		$extension_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `code` = '" . $this->db->escape($code) . "' ORDER BY code");

		if ($query->rows) {
			return true;
		} else {
			return false;
		}
	}

	public function getOrder($order_id) {
		$order_query = $this->db->query("SELECT *, (SELECT os.name FROM `" . DB_PREFIX . "order_status` os WHERE os.order_status_id = o.order_status_id AND os.language_id = o.language_id) AS order_status FROM `" . DB_PREFIX . "order` o WHERE o.order_id = '" . (int)$order_id . "'");

		if ($order_query->num_rows) {
			$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$order_query->row['payment_zone_id'] . "'");

			if ($zone_query->num_rows) {
				$payment_zone_code = $zone_query->row['code'];
			} else {
				$payment_zone_code = '';
			}

			$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$order_query->row['shipping_zone_id'] . "'");

			if ($zone_query->num_rows) {
				$shipping_zone_code = $zone_query->row['code'];
			} else {
				$shipping_zone_code = '';
			}

			$customer_group = $this->getCustomerGroup($order_query->row['customer_group_id']);

			return array(
				'order_id'                => $order_query->row['order_id'],
				'store_name'              => $order_query->row['store_name'],
				'customer_group'          => $customer_group['name'],
				'firstname'               => $order_query->row['firstname'],
				'lastname'                => $order_query->row['lastname'],
				'email'                   => $order_query->row['email'],
				'telephone'               => $order_query->row['telephone'],
				'payment_firstname'       => $order_query->row['payment_firstname'],
				'payment_lastname'        => $order_query->row['payment_lastname'],
				'payment_company'         => $order_query->row['payment_company'],
				'payment_address_1'       => $order_query->row['payment_address_1'],
				'payment_address_2'       => $order_query->row['payment_address_2'],
				'payment_postcode'        => $order_query->row['payment_postcode'],
				'payment_city'            => $order_query->row['payment_city'],
				'payment_zone'            => $order_query->row['payment_zone'],
				'payment_zone_code'       => $payment_zone_code,
				'payment_country'         => $order_query->row['payment_country'],
				'payment_address_format'  => $order_query->row['payment_address_format'],
				'payment_method'          => $order_query->row['payment_method'],
				'shipping_firstname'      => $order_query->row['shipping_firstname'],
				'shipping_lastname'       => $order_query->row['shipping_lastname'],
				'shipping_company'        => $order_query->row['shipping_company'],
				'shipping_address_1'      => $order_query->row['shipping_address_1'],
				'shipping_address_2'      => $order_query->row['shipping_address_2'],
				'shipping_postcode'       => $order_query->row['shipping_postcode'],
				'shipping_city'           => $order_query->row['shipping_city'],
				'shipping_zone'           => $order_query->row['shipping_zone'],
				'shipping_zone_code'      => $shipping_zone_code,
				'shipping_country'        => $order_query->row['shipping_country'],
				'shipping_address_format' => $order_query->row['shipping_address_format'],
				'shipping_method'         => $order_query->row['shipping_method'],
				'comment'                 => $order_query->row['comment'],
				'total'                   => $order_query->row['total'],
				'order_status'            => $order_query->row['order_status'],
				'date_added'              => $order_query->row['date_added'],
				'date_modified'           => $order_query->row['date_modified']
			);
		} else {
			return false;
		}
	}

 	public function getCustomerGroup($customer_group_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_group cg LEFT JOIN " . DB_PREFIX . "customer_group_description cgd ON (cg.customer_group_id = cgd.customer_group_id) WHERE cg.customer_group_id = '" . (int)$customer_group_id . "' AND cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	}

	public function getReturnReason($return_reason_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "return_reason WHERE language_id = '" . (int)$this->config->get('config_language_id') . "' AND return_reason_id = '" . $return_reason_id . "' ORDER BY name");
		return $query->row;
	}

	public function orders($data) {
		if (isset($data[0]) && !empty($data[0]) && isset($data[1]) && !empty($data[1]) && ($this->config->get('gixocnotifications_status'))) {
			$this->options('orders_', $data);
		}
	}

	private function options($option, $info) {
		$userdata = $this->config->get('gixocnotifications_userdata');
		$groupdata = $this->config->get('gixocnotifications_groupdata');
		$options = rtrim($option, '_');

		$messengers = array(
			'1' => 'telegram',
			'2' => 'viber'
		);

		foreach ($messengers as $messenger) {
			$key = $this->config->get('gixocnotifications_' . $messenger . '_key');
			$webhook = $this->config->get('gixocnotifications_' . $messenger . '_webhook');

			if (!empty($key)) {
				$message = new $messenger($key, $this->config->get('gixocnotifications_' . $messenger . '_timeout'));
				$message->setLog( new \Log('gixocnotifications_' . $messenger . '.log'), $this->config->get('gixocnotifications_logs')[$messenger]);

				if (isset($userdata[$messenger])) {
					foreach ($userdata[$messenger] as $user_id => $user) {

						if (isset($user[$option . $messenger]) && (($user[$option . $messenger] == 'on') || ((isset($info[1])) && (isset($user[$option . $messenger][$info[1]])) && ($user[$option . $messenger][$info[1]] == 'on'))) && !empty($user['id_' . $messenger]) && ($this->config->get('gixocnotifications_' . $messenger . '_key'))) {
							$dr = $option . 'template';
							$text = htmlspecialchars_decode($this->$dr($info, $messenger));

							$message->setTo($user['id_' . $messenger]);
							$send = false;
							if (empty($webhook) || ($webhook == 'no')) {
								$send = false;
							} else {
								$send = $message->sendMessage($text, $this->config->get('gixocnotifications_' . $messenger . '_trim_messages'));
							}

							if ((!$send) && ($this->config->get('gixocnotifications_' . $messenger . '_proxy') == '1') && !empty($this->config->get('gixocnotifications_' . $messenger . '_proxydata'))) {
								foreach ($this->config->get('gixocnotifications_' . $messenger . '_proxydata') as $key => $proxy) {
									if ((!$send) && isset($proxy['status']) && !empty($proxy['ip']) && !empty($proxy['port'])) {
										$proxydata = $proxy['ip'] . ':' . $proxy['port'];
										if (!empty($proxy['login']) || !empty($proxy['password'])) {
											$proxydata .= '@' . $proxy['login'] . ':' . $proxy['password'];
										}

										$message->setProxy($proxydata);
										$proxydata = '';
										$send = $message->sendMessage($text, $this->config->get('gixocnotifications_' . $messenger . '_trim_messages'));
									}
								}
							}
						}
					}
				}

				if (isset($groupdata[$messenger])) {
					foreach ($groupdata[$messenger] as $user_id => $user) {
						if (isset($user[$options]) && (($user[$options] == 'on') || ((isset($info[1])) && (isset($user[$options][$info[1]])) && ($user[$options ][$info[1]] == 'on'))) && !empty($user['id']) && ($this->config->get('gixocnotifications_' . $messenger . '_key'))) {
							$dr = $options . '_template';
							$text = htmlspecialchars_decode($this->$dr($info, $messenger));
							$message->setTo($user['id']);
							$send = false;
							if (empty($webhook) || ($webhook == 'no')) {
								$send = false;
							} else {
								$send = $message->sendMessage($text, $this->config->get('gixocnotifications_' . $messenger . '_trim_messages'));
							}
							if ((!$send) && ($this->config->get('gixocnotifications_' . $messenger . '_proxy') == '1') && !empty($this->config->get('gixocnotifications_' . $messenger . '_proxydata'))) {
								foreach ($this->config->get('gixocnotifications_' . $messenger . '_proxydata') as $key => $proxy) {
									if ((!$send) && isset($proxy['status']) && !empty($proxy['ip']) && !empty($proxy['port'])) {
										$proxydata = $proxy['ip'] . ':' . $proxy['port'];
										if (!empty($proxy['login']) || !empty($proxy['password'])) {
											$proxydata .= '@' . $proxy['login'] . ':' . $proxy['password'];
										}

										$message->setProxy($proxydata);
										$proxydata = '';
										$send = $message->sendMessage($text, $this->config->get('gixocnotifications_' . $messenger . '_trim_messages'));
									}
								}
							}
						}
					}
				}
			}
		}
	}

	private function orders_template($data, $messenger) {
		return $this->order_template($data[0], $this->langdata[$this->language_id]['orders_' . $messenger][$data[1]]);
	}

	private function order_template($order_id, $message) {
		$order_info = $this->getOrder($order_id);

		//Simple
		$simple = $this->getModule('simple');

		if ($simple) {
			$this->load->model('module/simplecustom');

			$customInfo = $this->model_module_simplecustom->getCustomFields('order', $order_id, '');
		}
		//end Simple

		if ($order_info['payment_address_format']) {
			$format = $order_info['payment_address_format'];
		} else {
			$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
		}

		$find = array(
			'{firstname}',
			'{lastname}',
			'{company}',
			'{address_1}',
			'{address_2}',
			'{city}',
			'{postcode}',
			'{zone}',
			'{zone_code}',
			'{country}'
		);

		$replace = array(
			'firstname' => $order_info['payment_firstname'],
			'lastname'  => $order_info['payment_lastname'],
			'company'   => $order_info['payment_company'],
			'address_1' => $order_info['payment_address_1'],
			'address_2' => $order_info['payment_address_2'],
			'city'      => $order_info['payment_city'],
			'postcode'  => $order_info['payment_postcode'],
			'zone'      => $order_info['payment_zone'],
			'zone_code' => $order_info['payment_zone_code'],
			'country'   => $order_info['payment_country']
		);

		$payment_address = str_replace(array("\r\n", "\r", "\n"), ' ', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), ' ', trim(str_replace($find, $replace, $format))));

		if ($order_info['shipping_address_format']) {
			$format = $order_info['shipping_address_format'];
		} else {
			$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
		}

		$find = array(
			'{firstname}',
			'{lastname}',
			'{company}',
			'{address_1}',
			'{address_2}',
			'{city}',
			'{postcode}',
			'{zone}',
			'{zone_code}',
			'{country}'
		);

		$replace = array(
			'firstname' => $order_info['shipping_firstname'],
			'lastname'  => $order_info['shipping_lastname'],
			'company'   => $order_info['shipping_company'],
			'address_1' => $order_info['shipping_address_1'],
			'address_2' => $order_info['shipping_address_2'],
			'city'      => $order_info['shipping_city'],
			'postcode'  => $order_info['shipping_postcode'],
			'zone'      => $order_info['shipping_zone'],
			'zone_code' => $order_info['shipping_zone_code'],
			'country'   => $order_info['shipping_country']
		);

		$shipping_address = str_replace(array("\r\n", "\r", "\n"), ' ', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), ' ', trim(str_replace($find, $replace, $format))));

		$find = array(
			'{order_id}',
			'{store_name}',
			'{customer_firstname}',
			'{customer_lastname}',
			'{customer_email}',
			'{customer_telephone}',
			'{customer_group}',
			'{payment_address}',
			'{payment_method}',
			'{shipping_address}',
			'{shipping_method}',
			'{total}',
			'{comment}',
			'{order_status}',
			'{date_added}',
			'{date_modified}'
		);

		$replace = array(
			'{order_id}'           => isset($order_info['order_id']) ? $order_info['order_id'] : '',
			'{store_name}'         => isset($order_info['store_name']) ? $order_info['store_name'] : '',
			'{customer_firstname}' => isset($order_info['firstname']) ? $order_info['firstname'] : '',
			'{customer_lastname}'  => isset($order_info['lastname']) ? $order_info['lastname'] : '',
			'{customer_email}'     => isset($order_info['email']) ? $order_info['email'] : '',
			'{customer_telephone}' => isset($order_info['telephone']) ? $order_info['telephone'] : '',
			'{customer_group}'     => isset($order_info['customer_group']) ? $order_info['customer_group'] : '',
			'{payment_address}'    => isset($payment_address) ? $payment_address : '',
			'{payment_method}'     => isset($order_info['payment_method']) ? $order_info['payment_method'] : '',
			'{shipping_address}'   => isset($shipping_address) ? $shipping_address : '',
			'{shipping_method}'    => isset($order_info['shipping_method']) ? $order_info['shipping_method'] : '',
			'{total}'              => isset($order_info['total']) ? $order_info['total'] : '',
			'{comment}'            => isset($order_info['comment']) ? $order_info['comment'] : '',
			'{order_status}'       => isset($order_info['order_status']) ? $order_info['order_status'] : '',
			'{date_added}'         => isset($order_info['date_added']) ? $order_info['date_added'] : '',
			'{date_modified}'      => isset($order_info['date_modified']) ? $order_info['date_modified'] : '',
		);

		//Simple
		if ($simple) {         
			foreach($customInfo as $id => $value) {
				if (!empty($value)) {
					if (strpos($id, 'payment_') === 0) {
						$id = '{' . str_replace('payment_', '', $id) . '}';
						if (in_array($id, $find) === false) {
							$find[] = $id;
							$replace[$id] = $value;
						}
					} elseif (strpos($id, 'shipping_') === 0) {
						$id = str_replace('shipping_', '', $id);
						if (in_array($id, $find) === false) {
							$find[] = $id;
							$replace[$id] = $value;
						}
					} elseif ((strpos($id, 'payment_') === false) && (strpos($id, 'shipping_') === false)) {
						$id = '{' . $id . '}';
						if (in_array($id, $find) === false) {
							$find[] = $id;
							$replace[$id] = $value;
						}
					}
				}
			}
		}
		//end Simple

		return str_replace(array("\r\n", "\r", "\n"), chr(10), preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), chr(10), trim(str_replace($find, $replace, $message))));
	}
}
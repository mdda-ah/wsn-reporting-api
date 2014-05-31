<?php

class Controller {
	protected
		$db;

	function __construct() {
		$f3 = \Base::instance();

		try {
			// Try to create the database object and connection
			$db = new \DB\SQL(
				$f3->get('db.host'),
				$f3->get('db.user'),
				$f3->get('db.pass'),
				array(\PDO::ATTR_ERRMODE => \PDO::ERRMODE_WARNING)
			);
			$this->db = $db;
		} catch (\PDOException $e) {
			$this->db = null;
		}
	}

	function check_database_is_up($f3) {
		if (!$this->db) {
			$f3->set(
				'wsn.message',
				$f3->get('message_database_is_down')
			);
			$f3->status(500);
			$this->afterroute($f3);
			die;
		}
	}

	function beforeroute($f3) {
	}

	function afterroute($f3) {
	 	$tmp = array();

	 	$tmp["message"] = $f3->get('wsn.message');
	 	if ($f3->get('wsn.data') != null) {$tmp["data"] = $f3->get('wsn.data');}

	 	header('Content-Type: application/json');
		echo json_encode($tmp, JSON_NUMERIC_CHECK);

		unset($tmp);
	}

}

?>
<?php

class Reading extends Controller {
	protected
		$messages = array();

	function post($f3) {
		$this->check_database_is_up($f3);

		//	Basic validation
		$this->check_device_id_provided($f3);
		$this->check_sensor_id_provided($f3);
		$this->check_reading_provided($f3);
		$this->check_sensor_id_numeric($f3);
		$this->checkpoint($f3);

		//	Passed basic validation check
		$this->prepare_data_for_saving($f3,$this->db);

		//	The POSTed data is now ready for saving to the database, so let's do that, if required
		$this->save_to_database($f3,$this->db);

		//	Push data to Xively
		$xively = new xively($f3,$this->db);
	}

	function save_to_database($f3,$db) {
		if (!$f3->devoid('POST.test')) {
			$f3->set('wsn.message',$f3->get('message_test_ok'));
			return;
		}

		$record = new DB\SQL\Mapper($db, 'readings');

		$record->device_id = 							$f3->get('wsn_reading.device_id');
		$record->sensor_id = 							$f3->get('wsn_reading.sensor_id');
		$record->datetime = 							$f3->get('wsn_reading.datetime');
		$record->reading = 								$f3->get('wsn_reading.reading');
		$record->minreading = 						$f3->get('wsn_reading.minreading');
		$record->maxreading = 						$f3->get('wsn_reading.maxreading');
		$record->nodecounter = 						$f3->get('wsn_reading.nodecounter');
		$record->coordcounter = 					$f3->get('wsn_reading.coordcounter');
		$record->value = 									$f3->get('wsn_reading.value');
		$record->bounds_flag = 						$f3->get('wsn_reading.bounds_flag');
		$record->latitude = 							$f3->get('wsn_reading.latitude');
		$record->longitude = 							$f3->get('wsn_reading.longitude');
		$record->elevation_above_ground = $f3->get('wsn_reading.elevation_above_ground');

		$record->save();

		$logger = new \Log('posted.log');
		$logger->write(sprintf(
			'[%s] [%s] [Success! POSTed data saved to database.]',
			$f3->get('SERVER.REQUEST_URI'),
			$this->pretty_print_request_data($f3)
		));
		unset($logger);

		$f3->set('wsn.message',$f3->get('message_ok'));
	}

	function pretty_print_request_data($f3) {
		$out = array();
		foreach ($f3->get('REQUEST') as $key => $value) {
			$out[] = "$key=$value";
		}
		return implode('&', $out);
	}

	function prepare_data_for_saving($f3,$db) {
		date_default_timezone_set('UTC');
		$dt = new DateTime();

		$f3->set('wsn_reading.device_id',	$f3->get('POST.d_id'));
		$f3->set('wsn_reading.sensor_id',	$f3->get('POST.s_id'));
		$f3->set('wsn_reading.datetime',	$dt->format('Y-m-d H:i:s'));
		$f3->set('wsn_reading.reading',	$f3->get('POST.r'));
		if (!$f3->devoid('POST.minr')) {
			$f3->set('wsn_reading.minreading',	$f3->get('POST.minr'));
		}
		if (!$f3->devoid('POST.minr')) {
			$f3->set('wsn_reading.maxreading',	$f3->get('POST.maxr'));
		}
		if (!$f3->devoid('POST.ncount')) {
			$f3->set('wsn_reading.nodecounter',	$f3->get('POST.ncount'));
		}
		if (!$f3->devoid('POST.ccount')) {
			$f3->set('wsn_reading.coordcounter',	$f3->get('POST.ccount'));
		}

		$conversion = new conversion;
		$conversion->convert_reading($f3,$db);
		unset($conversion);

		$bounds = new bounds($f3,$db);
		$bounds->set_out_of_bounds_check($f3);
		unset($bounds);

		$location = new location($f3,$db);
		$location->get_location_information($f3);
		unset($location);
	}

	function check_device_id_provided($f3) {
		if ($f3->devoid('POST.d_id')) {
			$this->messages['device_id'] = $f3->get('message_validation_device_id_not_provided');
		}
	}

	function check_sensor_id_provided($f3) {
		if ($f3->devoid('POST.s_id')) {
			$this->messages['sensor_id'] = $f3->get('message_validation_sensor_id_not_provided');
		}
	}

	function check_reading_provided($f3) {
		if ($f3->devoid('POST.r')) {
			$this->messages['reading'] = $f3->get('message_validation_reading_not_provided');
		}
	}

	function check_sensor_id_numeric($f3) {
		$sensor_id = $f3->get('POST.s_id');

		if (is_numeric($sensor_id) && $sensor_id < 1) {
			$this->messages['sensor_id'] = $f3->get('message_validation_sensor_id_not_valid');
		}

		if(!is_numeric($sensor_id)) {
			$this->messages['sensor_id'] = $f3->get('message_reading_sensor_id_not_valid');
		}
	}

	function checkpoint($f3) {
		if (count($this->messages) > 0) {
			$f3->set('wsn.message',implode(' ', $this->messages));
			$f3->status(400);
			$this->afterroute($f3);
			die;
		}
	}
}

?>
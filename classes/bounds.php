<?php

class bounds {
	function __construct($f3,$db) {
		$f3->set(
			'sensor_type_information',
			$db->exec(
				'select * from sensor_types where sensor_type_id=:sensor_id',
				array (
					':sensor_id' => $f3->get('wsn_reading.sensor_id')
				)
			)
		);
	}

	function set_out_of_bounds_check($f3) {
		if ($f3->get('sensor_type_information') != true || $f3->get('wsn_reading.value') === null) {
			$f3->set(
				'wsn_reading.bounds_flag',
				null
			);
			return;
		}

		//	Too high?
		if ($f3->get('wsn_reading.value') > $f3->get('sensor_type_information.0.bounds_high')) {
			$f3->set(
				'wsn_reading.bounds_flag',
				1
			);
			return;
		}

		//	Too low?
		if ($f3->get('wsn_reading.value') < $f3->get('sensor_type_information.0.bounds_low')) {
			$f3->set(
				'wsn_reading.bounds_flag',
				-1
			);
			return;
		}

		//	Just right
		$f3->set(
			'wsn_reading.bounds_flag',
			0
		);
	}
}

?>
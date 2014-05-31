<?php

class location {
	function __construct($f3,$db) {
		$f3->set(
			'sensor_location_information',
			$db->exec(
				'select * from devices where device_id=:device_id',
				array (
					':device_id' => $f3->get('wsn_reading.device_id')
				)
			)
		);
	}

	function get_location_information($f3) {
		if ($f3->get('sensor_location_information') != true) {
			return;
		}

		$f3->set(
			'wsn_reading.longitude',
			$f3->get('sensor_location_information.0.longitude')
		);

		$f3->set(
			'wsn_reading.latitude',
			$f3->get('sensor_location_information.0.latitude')
		);

		$f3->set(
			'wsn_reading.elevation_above_ground',
			$f3->get('sensor_location_information.0.elevation_above_ground')
		);
	}
}

?>
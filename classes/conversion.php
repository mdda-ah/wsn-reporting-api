<?php

class conversion {
	function convert_reading($f3,$db) {
		//	Get information for this sensor
		$this->get_sensor_information($f3,$db);

		//	If there is no sensor information then set value to null and return
		if (!$f3->get('sensor_information')) {
			$this->set_converted_value($f3,null);
			return;
		}

		//	If there is no conversion required, just copy the reading field to the value field and return
		if (!$f3->get('sensor_information.0.convert_reading_to_value') == 1) {
			$this->copy_reading_to_value($f3);
			return;
		}

		//	Get the current calibration data for this sensor
		$this->get_current_calibration_data($f3,$db);

		//	Do conversions as required
		switch ($f3->get('wsn_reading.sensor_id')) {

			//	Temperature! Centigrade
			case 1:
				$this->set_converted_value(
					$f3,
					(($f3->get('wsn_reading.reading') - 0.5) * 100.0)
				);
				break;

			//	Carbon dioxide! PPM
			case 4:
				$this->set_converted_value(
					$f3,
					pow (10.0, (($f3->get('wsn_reading.reading') - $f3->get('current_calibration_data.0.intercept')) / $f3->get('current_calibration_data.0.gradient'))
					)
				);
				break;

			//	Nitrogen dioxide! PPM
			case 5:
				$deployed_sensor_resistance = $f3->get('current_calibration_data.0.resistance') * ( $f3->get('current_calibration_data.0.gain') * $f3->get('current_calibration_data.0.supply_voltage') /  $f3->get('reading') - 1);
				$this->set_converted_value(
					$f3,
					pow (10.0,(log($deployed_sensor_resistance / $f3->get('current_calibration_data.0.reference_resistance'), 10) - $f3->get('current_calibration_data.0.intercept')) / $f3->get('current_calibration_data.0.gradient'))
				);
				break;

			//	If anything gets to here then the database has data missing - e.g. an entry in the calibration table for this sensor
			default:
				break;
		}
	}

	function get_sensor_information($f3,$db) {
		$f3->set(
			'sensor_information',
			$db->exec(
				'select * from sensors where device_id=:device_id and sensor_type_id=:sensor_id',
				array (
					':device_id' => $f3->get('wsn_reading.device_id'),
					':sensor_id' => $f3->get('wsn_reading.sensor_id')
				)
			)
		);
	}

	function get_current_calibration_data($f3,$db) {
		$f3->set(
			'current_calibration_data',
			$db->exec(
				'select * from calibration where calibration.id=:calibration_id',
				array (
					':calibration_id' => $f3->get('sensor_information.0.calibration_id')
				)
			)
		);
	}

	function set_converted_value($f3,$value) {
		$f3->set(
			'wsn_reading.value',
			$value
		);
	}

	function copy_reading_to_value($f3) {
		$f3->set(
			'wsn_reading.value',
			$f3->get('wsn_reading.reading')
		);
	}
}

?>